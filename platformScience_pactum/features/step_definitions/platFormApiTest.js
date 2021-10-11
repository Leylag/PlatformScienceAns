const requestObject = require("../support/requestObject");

const pactum = require('pactum');
const assert = require('assert');

const { Given, When, Then, Before, After} = require('@cucumber/cucumber');
let myRequestObject = new requestObject();

let spec = pactum.spec();

Before(()=> {
    spec = pactum.spec();
})


Given(/^I make a POST request to pltsci-sdet-assignment with (.*)$/, function (endpoint) {
    spec.post(endpoint);
});

Given(/^the request body includes roomSize (.*), patches (.*), hoover location (.*), and the instruction (.*)$/, function (dimension,patches,coords,instructions){
    const requestBody =  myRequestObject.createRequestObject(dimension,coords,patches,instructions);
    console.log("My request body"+requestBody);
    spec.withBody(JSON.parse(requestBody));
});

When('I receive a response', async function(){
    await spec.toss();
});

Then('I expect response should have a status {int}',function(code){
    console.log("code = "+code);
    console.log(spec.response.status);
    spec.response().should.have.status(code);
});

Then(/^I expect response to include json (.*)$/, function (value){
    spec.response().should.have.json(JSON.parse(value));

});

After(() => {
    spec.end();
  });
