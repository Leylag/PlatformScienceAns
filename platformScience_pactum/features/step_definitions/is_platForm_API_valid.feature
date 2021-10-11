Feature: API Validations
Scenario: API Returns the correct coordinantes
  Given I make a POST request to pltsci-sdet-assignment with http://localhost:8080/v1/cleaning-sessions
  And   the request body includes roomSize <dimension>, patches <patches>, hoover location <coords>, and the instruction <instructions>
  When I receive a response
  Then I expect response should have a status 200
  And I expect response to include json <responseBody> 

  Examples: 
    |dimension    |coords       |patches              |instructions    |coordinates      |cleanedPatches   |responseBody                         |
    |[5,5]        |[1,2]        |[[1,0],[2,2],[2,3]]  |NNESEESWNWW     |[1,3]            | 1               | {"coords":[1,3],"patches":1}        |
    |[5,5]        |[2,1]        |[[1,0],[2,2],[2,3]]  |NNESEESWNWW     |[1,2]            | 2               | {"coords":[1,2],"patches":2}        |
    |[5,5]        |[2,1]        |[[1,0],[2,2],[2,3]]  |NNESEESWNWW     |[1,2]            | 2               | {"coords":[1,2],"patches":2}        |


Scenario: API Returns the correct status code for invalid inputs
  Given I make a POST request to pltsci-sdet-assignment with http://localhost:8080/v1/cleaning-sessions
  And   the request body includes roomSize <dimension>, patches <patches>, hoover location <coords>, and the instruction <instructions>
  When  I receive a response
  Then  I expect response should have a status 400

    Examples: 
    |dimension    |coords       |patches              |instructions    |coordinates      |cleanedPatches   |responseBody                         |
    |[1,1]        |[1,2]        |[[1,0],[2,2],[2,3]]  |NNESEESWNWW     |                 |                 |                                     |


Scenario: API Returns the correct status code (200), coords and number of clean patchs for when the hoover runs along the parameter of the room
  Given I make a POST request to pltsci-sdet-assignment with http://localhost:8080/v1/cleaning-sessions
  And   the request body includes roomSize <dimension>, patches <patches>, hoover location <coords>, and the instruction <instructions>
  When  I receive a response
  Then  I expect response should have a status 200
  And I expect response to include json <responseBody> 
 
  Examples: 
    |dimension    |coords       |patches              |instructions    |coordinates      |cleanedPatches   |responseBody                         |
    |[2,2]        |[0,0]        |[[0,1]]              |NN              |[0,2]            |1                | {"coords":[0,2],"patches":1}        |                                  
    |[2,2]        |[0,0]        |[[1,0]]              |EE              |[2,0]            |1                | {"coords":[2,0],"patches":1}        | 
    |[2,2]        |[0,0]        |[[0,2]]              |NN              |[0,2]            |1                | {"coords":[0,2],"patches":1}        |   
    |[2,2]        |[0,0]        |[[2,0]]              |EE              |[2,0]            |1                | {"coords":[2,0],"patches":1}        |  

    
Scenario: API returns the correct Status code (200), coords and number of clean patchs for when the hoover runs in the middle of the room
  Given I make a POST request to pltsci-sdet-assignment with http://localhost:8080/v1/cleaning-sessions
  And   the request body includes roomSize <dimension>, patches <patches>, hoover location <coords>, and the instruction <instructions>
  When  I receive a response
  Then  I expect response should have a status 200
  And I expect response to include json <responseBody> 
  
  Examples: 
    |dimension    |coords       |patches                                          |instructions    |coordinates      |cleanedPatches   |responseBody                         |
    |[2,2]        |[1,0]        |[[1,1],[2,1]]                                    |NE              |[2,1]            |2                | {"coords":[2,1],"patches":2}        |                                  
    |[4,4]        |[1,1]        |[[1,1],[1,2],[1,3],[2,3],[3,3],[3,2],[3,1],[2,1]]|NNEESSWW        |[1,1]            |8                | {"coords":[1,1],"patches":8}        | 
    |[4,4]        |[3,1]        |[[3,2]]                                          |SESENN          |[3,2]            |1                | {"coords":[3,2],"patches":1}        |   

Scenario: API returns the correct Status code (400), where the required data is missing
  Given I make a POST request to pltsci-sdet-assignment with http://localhost:8080/v1/cleaning-sessions
  And   the request body includes roomSize <dimension>, patches <patches>, hoover location <coords>, and the instruction <instructions>
  When  I receive a response
  Then  I expect response should have a status 400 
  
  Examples: 
    |dimension    |coords       |patches                                          |instructions    |coordinates      |cleanedPatches   |responseBody                         |
    |[4,4]        |[3,1]        |[]                                               |SESENN          |[3,1]            |8                | {"coords":[3,1],"patches":0}        |  
    |[4,4]        |[3,1]        |                                                 |SESENN          |[3,1]            |8                | {"coords":[3,1],"patches":0}        |    
    |[4,4]        |             |[[3,2]]                                          |SESENN          |                 |                 |                                     |                                  
    |[4,4]        |[3,1]        |[[3,2]]                                          |                |                 |                 |                                     |       
 
 Scenario: API returns the correct Status code (400), where the required data is invalid (nagative Coordinate)
  Given I make a POST request to pltsci-sdet-assignment with http://localhost:8080/v1/cleaning-sessions
  And   the request body includes roomSize <dimension>, patches <patches>, hoover location <coords>, and the instruction <instructions>
  When  I receive a response
  Then  I expect response should have a status 400 
  
  Examples: 
    |dimension    |coords       |patches                                          |instructions    |coordinates      |cleanedPatches   |responseBody                         |
    |[-4,4]       |[3,1]        |[[3,2]]                                          |SESENN          |                 |                 |                                     |  
    |[-4,-4]      |[3,1]        |[[3,2]]                                          |SESENN          |                 |                 |                                     |  
    |[4,4]        |[-3,-1]      |[[3,2]]                                          |SESENN          |                 |                 |                                     |
    |[4,4]        |[3,-1]       |[[3,2]]                                          |SESENN          |                 |                 |                                     |
    |[4,4]        |[3,1]        |[[-3,-2]]                                        |SESENN          |                 |                 |                                     |     
    |[4,4]        |[3,1]        |[[-3,2]]                                          |SESENN         |                 |                 |                                     |     


 Scenario: API returns the correct Status code (200), RoomSize is 10X10 and instruction is in lower case 
  Given I make a POST request to pltsci-sdet-assignment with http://localhost:8080/v1/cleaning-sessions
  And   the request body includes roomSize <dimension>, patches <patches>, hoover location <coords>, and the instruction <instructions>
  When  I receive a response
  Then  I expect response should have a status 200 
  
  Examples: 
    |dimension     |coords       |patches                |instructions                |coordinates      |cleanedPatches   |responseBody                        |
    |[10,10]       |[2,3]        |[[5,5]]                |NNNNEEEEEESSSSWWWW          |[3,3]            |2                |{"coords":[3,3],"patches":0}        |  
    |[10,10]       |[2,2]        |[[6,3],[4,5],[7,2]]    |NNNNNNNEESSSSSSEENNNN       |[6,7]            |0                |{"coords":[6,17],"patches":2}       |    
    |[10,10]       |[2,2]        |[[6,3],[4,5],[7,2]]    |nnnnnnneesssssseennnn       |[6,7]            |0                |{"coords":[6,17],"patches":2}       |                                                            


 Scenario: API returns the correct Status code (200), RoomSize is 5.5X5.5  
  Given I make a POST request to pltsci-sdet-assignment with http://localhost:8080/v1/cleaning-sessions
  And   the request body includes roomSize <dimension>, patches <patches>, hoover location <coords>, and the instruction <instructions>
  When  I receive a response
  Then  I expect response should have a status 200 

  Examples: 
    |dimension    |coords       |patches              |instructions    |coordinates      |cleanedPatches   |responseBody                         |
    |[5.5,5.5]    |[1.5,2]      |[[1,0],[2,2],[2,3]]  |NNESEESWNWW     |[1,3]            | 1               | {"coords":[1,3],"patches":1}        |

 