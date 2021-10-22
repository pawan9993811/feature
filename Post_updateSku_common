@ignore
Feature: DDPDWS-2294 : DWS  Service - (/solutionsvc/api/v1/providers) POST Method

  Background:
    # sets base path variable for API
    # to be used in path variable in each of the scenarios
    Given url envHostSolutionService
    * def solutionpath = '/solutionsvc/api/v1/providers'
    # need to define token
    * def jwtToken = call read('classpath:features/common/coreTokenGen.feature@createCoreToken')
    * def token = jwtToken.CoreJwtToken

@postNewSolution
Scenario: Post method for register new solution
  # sets base path variable for API
  # to be used in path variable in each of the scenarios
  And path solutionpath
  And header Content-Type = 'application/json; charset=utf-8'
  And header Authorization = 'Bearer ' + token
  And request payload
  When method POST
  Then print 'Status of Post response: ',responseStatus, ' ', response
  Then match responseStatus == status


@skupostNewSolution
Scenario: Post method for update new solution using uid
  And path solutionpath, uid, 'skus'
  And header Content-Type = 'application/json; charset=utf-8'
  And header Authorization = 'Bearer ' + token
  And request onepayload
  When method POST
  * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
  Then match responseStatus == status
  * print response






@postNewSolutionsku
Scenario: Post method for update new solution using uid
  And path solutionpath, uid, 'skus', sku
  And header Content-Type = 'application/json; charset=utf-8'
  And header Authorization = 'Bearer ' + token
  And request skupayload
  When method POST
  * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
  Then match responseStatus == status
  * print response



@getsku
Scenario: GET sku value
  # sets base path variable for API
  # to be used in path variable in each of the scenarios
  And path solutionpath,uid, 'skus'
  And header Content-Type = 'application/json; charset=utf-8'
  And header Authorization = 'Bearer ' + token
  When method GET
  Then print 'State of GET response: ',responseStatus, ' ', response
  Then match responseStatus == status

  

@sol1invalidPostAddRemoveSeats
Scenario: Orchestration Service POST API to add Seats on an existing Subscription
  And path solutionpath, uid, 'skus', sku
  And header Content-Type = 'application/json; charset=utf-8'
  And header Authorization = 'Bearer ' + token
  And request unauthotable
  When method POST
  * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
  Then match responseStatus == status
 # Then match response.message == responseMessage


 @skuunauthorizedPostOrder
Scenario: Orchestration Service POST API to create new Orders
  And path solutionpath, uid, 'skus', sku
  And header Content-Type = 'application/json; charset=utf-8'
  And header Authorization = 'Bearer ' + token
  And request skuPayload
  When method POST
  * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
  Then match responseStatus == status


@skusolutioninvalidPostAddons
Scenario: Orchestration Service POST API to add Seats on an existing Subscription
  And path solutionpath, uid, 'skus', sku
  And header Content-Type = 'application/json; charset=utf-8'
  And header Authorization = 'Bearer ' 
  And request seatskupayload
  When method POST
  * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
  Then match responseStatus == status
