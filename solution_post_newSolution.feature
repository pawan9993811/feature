@functionaltest
@servicetest
Feature: DDPDWS-2290 :  Solution Service V2 - (/solutionsvc/api/v1/providers/{uid}) POST 
  Background:
    * call read('classpath:features/common/generic_functions.feature')
    * def sqlInjection = '\'; select * from ordersubscription ; \''
    * def xmlInjection = '<script>alert(1)</script>'
    * def jwtToken = call read('classpath:features/common/coreTokenGen.feature@createCoreToken')
    * def jwtExpiredDFToken = jwtToken.coreExpiredJwtToken
    * def jwtInvalidDFToken = jwtToken.coreInvalidJwtToken
  
    # Set test data to be set in request body
    * set payloadData
      | path                 | 0               |
      | name                 | randomAlpha(5)  |
      | companyName          | randomAlpha(10) |
      | onboardingServiceUri | randomAlpha(20) |

    * table inputValsTable
      |   payload          |  status   |
      |  payloadData[0]    |  200      |
    * json solutionPostResponse = call read('classpath:features/solutionPortalSvc/common/solution_common_post.feature@postNewSolution') inputValsTable
    * def solutionPostuid = solutionPostResponse[0].response.uid
    
    @functionaltest
     @servicetest  
  Scenario Outline: <jira> :  Solution Service V2 - (/solutionsvc/api/v1/providers/{uid}) POST Returns 200 response
    # Set test data to be set in request body
    * set payloadData
      | path                 | 0                      |
      | name                 | <name>                 |
      | companyName          | <companyName>          |
      | onboardingServiceUri | <onboardingServiceUri> |

    * table inputValsTable
      |   payload          |  status   |uid|
      |  payloadData[0]    |  200      |solutionPostuid|
    * json solutionPostResponse = call read('classpath:features/solutionPortalSvc/common/solution_common_post.feature@postNewSolutionUid') inputValsTable
    
    Examples:
      | jira        | name                 | companyName         | onboardingServiceUri |
      | DDPDWS-2290 | randomNumber(3)      | randomNumber(3)     | randomNumber(3)      |
  #     | DDPDWS-2290 | randomNumber(256)    | randomNumber(50)    | randomNumber(512)    |
  #     | DDPDWS-2290 | randomAlphaNum(3)    | randomAlphaNum(3)   | randomAlphaNum(3)    |
  #     | DDPDWS-2290 | randomAlphaNum(256)  | randomAlphaNum(50)  | randomAlphaNum(512)  |
  #     | DDPDWS-2290 | randomAlpha(3)       | randomAlpha(3)      | randomAlpha(3)       |
  #     | DDPDWS-2290 | randomAlpha(256)     | randomAlpha(50)     | randomAlpha(512)     |
  #     | DDPDWS-2290 | randomSplString(3)   | randomSplString(3)  | randomSplString(3)   |
  #     | DDPDWS-2290 | randomSplString(256) | randomSplString(50) | randomSplString(512) |
  #     | DDPDWS-2290 | randomAlpha(136)     | randomNumber(27)    | randomAlphaNum(368)  |
  #  #  | DDPDWS-2290 | sqlInjection         | sqlInjection        | sqlInjection         |
  # #   | DDPDWS-2290 | xmlInjection         | xmlInjection        | xmlInjection         |
  #     | DDPDWS-2290 | randomNumber(256)    | randomSplString(50) | randomAlpha(3)       |
      @ignore
      @functionaltest
       @servicetest
    Scenario Outline: <jira> :  Solution Service V2 - (/solutionsvc/api/v1/providers/{uid}) POST Returns 401 response
      # Set test data to be set in request body
      * set payloadData
        | path                 | 0                      |
        | name                 | <name>                 |
        | companyName          | <companyName>          |
        | onboardingServiceUri | <onboardingServiceUri> |
  
      * table inputValsTable
        |   payload          |  status   |uid            |JWTToken|
        |  payloadData[0]    |  401      |solutionPostuid|<Token> |
      * json solutionPostResponse = call read('classpath:features/solutionPortalSvc/common/solution_common_post.feature@unauthorizedPostUID') inputValsTable
      
      Examples:
        | jira        | name                 | companyName         | onboardingServiceUri |   Token         |
        | DDPDWS-2290 | randomNumber(3)      | randomNumber(3)     | randomNumber(3)      |jwtExpiredDFToken|
        | DDPDWS-2290 | randomNumber(256)    | randomNumber(50)    | randomNumber(512)    |jwtInvalidDFToken|
        | DDPDWS-2290 | randomAlphaNum(3)    | randomAlphaNum(3)   | randomAlphaNum(3)    |jwtExpiredDFToken|
        | DDPDWS-2290 | randomAlphaNum(256)  | randomAlphaNum(50)  | randomAlphaNum(512)  |jwtInvalidDFToken|
        | DDPDWS-2290 | randomAlpha(3)       | randomAlpha(3)      | randomAlpha(3)       |jwtExpiredDFToken|
        | DDPDWS-2290 | randomAlpha(256)     | randomAlpha(50)     | randomAlpha(512)     |jwtInvalidDFToken|
        | DDPDWS-2290 | randomSplString(3)   | randomSplString(3)  | randomSplString(3)   |jwtExpiredDFToken|
        | DDPDWS-2290 | randomSplString(256) | randomSplString(50) | randomSplString(512) |jwtInvalidDFToken|
        | DDPDWS-2290 | randomAlpha(136)     | randomNumber(27)    | randomAlphaNum(368)  |jwtExpiredDFToken|
     #  | DDPDWS-2290 | sqlInjection         | sqlInjection        | sqlInjection         |jwtInvalidDFToken|
    #   | DDPDWS-2290 | xmlInjection         | xmlInjection        | xmlInjection         |jwtExpiredDFToken|
        | DDPDWS-2290 | randomNumber(256)    | randomSplString(50) | randomAlpha(3)       |jwtInvalidDFToken|
        | DDPDWS-2290 | randomNumber(3)      | randomNumber(3)     | randomNumber(3)      |       ''        |
        | DDPDWS-2290 | randomNumber(256)    | randomNumber(50)    | randomNumber(512)    |      (null)     |
       
        @ignore
      @functionaltest 
      @servicetest
      Scenario: <jira> :  Solution Service V2 - (/solutionsvc/api/v1/providers/{uid}) POST Returns 404 response
        # Set test data to be set in request body
        * set payload
          | path                 | 0              |
          | name                 | randomAlpha(10)|
          | companyName          | randomAlpha(3) |
          | onboardingServiceUri | randomAlpha(20)|
          
        * table inputValsTable
        |   payload          |  status   |uid|
        |  payloadData[0]    |  404      |randomGUID()|
      * json solutionPostResponse = call read('classpath:features/solutionPortalSvc/common/solution_common_post.feature@randomPostuid') inputValsTable
    
    @ignore
      @functionaltest 
      @servicetest
    Scenario Outline: <jira> :  Solution Service V2 - (/solutionsvc/api/v1/providers/{uid}) POST Returns 400 response
      # Set test data to be set in request body
      * set invalidPayloadData
        | path                 | 0                      |
        | name                 | <name>                 |
        | companyName          | <companyName>          |
        | onboardingServiceUri | <onboardingServiceUri> |
  
      * table inputValsTable
        |   invalidpayload          |  status   |uid|
        |  invalidPayloadData[0]    |  400      |solutionPostuid|
      * json solutionPostResponse = call read('classpath:features/solutionPortalSvc/common/solution_common_post.feature@postNewSolutionUidforbadData') inputValsTable
      * def message = solutionPostResponse[0].response.errors
      * print message
     * match solutionPostResponse[0].response.errors == <responseMessage>
       
      Examples:
        | jira        | name                 | companyName         | onboardingServiceUri | responseMessage                           |
        | DDPDWS-2290 |                      | randomAlphaNum(3)   | randomAlphaNum(512)  | {"Name":["The Name field is required."]}  |
        | DDPDWS-2290 | randomAlpha(256)     |                     | randomAlpha(512)     | {"CompanyName":["The CompanyName field is required."]}  |
        | DDPDWS-2290 | randomAlpha(3)       | randomAlpha(3)      |                      | {"OnboardingServiceURI":["The OnboardingServiceURI field is required."]} | 
        | DDPDWS-2290 | randomNumber(256)    |                     |                      | {"CompanyName":["The CompanyName field is required."],"OnboardingServiceURI":["The OnboardingServiceURI field is required."]} |
        | DDPDWS-2290 |                      | randomAlphaNum(3)   |                      | {"Name":["The Name field is required."],"OnboardingServiceURI":["The OnboardingServiceURI field is required."]}               |
        | DDPDWS-2290 |                      |                     | randomAlphaNum(512)  | {"Name":["The Name field is required."],"CompanyName":["The CompanyName field is required."]}                                 |
        | DDPDWS-2290 | (null)               | (null)              | (null)               | {"Name":["The Name field is required."],"CompanyName":["The CompanyName field is required."],"OnboardingServiceURI":["The OnboardingServiceURI field is required."]} |
    
