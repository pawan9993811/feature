@ignore
Feature: DDPDWS-2183 : DWS  Service - (/solutionsvc/api/v1/providers) POST Method
  Background:
    # sets base path variable for API
    # to be used in path variable in each of the scenarios
    Given url envHostSolutionService
    * def solutionsvcURL = '/solutionsvc/api/v1/providers'
    # need to define token
    * def jwtToken = call read('classpath:features/common/coreTokenGen.feature@createCoreToken')
    * def token = jwtToken.CoreJwtToken

  @postNewSolution
  Scenario: Post method for register new solution
    # sets base path variable for API
    # to be used in path variable in each of the scenarios
    And path solutionsvcURL
    And header Content-Type = 'application/json; charset=utf-8'
    And header Authorization = 'Bearer ' + token
    And request payload
    When method POST
    Then print 'State of GET response: ',responseStatus, ' ', response
    Then match responseStatus == status

  @postNewSolutionUid
  Scenario: Post method for update new solution using uid
    And path solutionsvcURL, uid
    And header Content-Type = 'application/json; charset=utf-8'
    And header Authorization = 'Bearer ' + token
    And request payload
    When method POST
    * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
    Then match responseStatus == status

    @postNewSolutionUidforbadData
  Scenario: Post method for update new solution using uid
    And path solutionsvcURL, uid
    And header Content-Type = 'application/json; charset=utf-8'
    And header Authorization = 'Bearer ' + token
    And request invalidpayload
    When method POST
    * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
    Then match responseStatus == status

    

  @invaildPostNewSolutionUid
  Scenario: Post method for update new solution using uid
    And path solutionsvcURL, uid
    * print uid
    And header Content-Type = 'application/json; charset=utf-8'
    And header Authorization = 'Bearer ' + token
    And request payload
    When method POST
    * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
    Then match responseStatus == status
    #* def requestId = response.requestId
    Then match response.message == responseMessage

    @unauthorizedPostUID
  Scenario: Solution Service V2 POST API to validate invalid token (401)
    And path solutionsvcURL, uid
    And header Content-Type = 'application/json; charset=utf-8'
    And header Authorization = 'Bearer ' + JWTToken
    And request payload
    When method POST
    * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
    Then match responseStatus == status 

    @missingPostNewSolutionUid
  Scenario: Solution Service V2 POST API to validate missing uid (404)
    And path solutionsvcURL
    And header Content-Type = 'application/json; charset=utf-8'
    And header Authorization = 'Bearer ' + token
    And request payload
    When method POST
    * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
    Then match responseStatus == status

    @randomPostuid
  Scenario:  Solution Service V2 POST API to validate invalid uid (404)
    And path solutionsvcURL, uid
    And header Content-Type = 'application/json; charset=utf-8'
    And header Authorization = 'Bearer ' + token
    And request payload
    When method POST
    * if (responseStatus != status) karate.log('State of POST response: ' + responseStatus + ' ' + response)
    Then match responseStatus == status
  
