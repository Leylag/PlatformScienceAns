class requestObject {
    createRequestObject(roomSize=[],coords=[],patches=[],instructions=null){ 
        let obj          = new Object();

        obj.roomSize     = JSON.parse(roomSize);
        obj.coords       = JSON.parse(coords);
        obj.patches      = JSON.parse(patches);
        obj.instructions = instructions;
        let jsonString   = JSON.stringify(obj);
        console.log("Json = "+jsonString);
        return jsonString;
    }
}
module.exports = requestObject;

