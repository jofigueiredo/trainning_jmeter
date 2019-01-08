# POST Method: /repos/{contextId}/{resourceId }
Scenario: The user calls the web service to post data to the specified resourceId within the specified contextId
	Given the contextId is valid
	And the resourceId is valid
	When the user calls the web service using the "Content-Type" header with the value "application/x-www-form-urlencoded"
	And the contextId portion of the URL is "xanalyzer"
	And the resourceId portion of the URL is "service/ajax/lookupXmiId"
	And the catalog form parameter is set to "t"
	And the cube form parameter is set to "t"
	Then the status code is 200
	
Scenario: The anonymous user calls the web service to post data to the specified resourceId within the specified contextId
	Given the contextId is valid
	And the resourceId is valid
	When the anonymous user calls the web service using the "Content-Type" header with the value "application/x-www-form-urlencoded"
	And the contextId portion of the URL is "xanalyzer"
	And the resourceId portion of the URL is "service/ajax/lookupXmiId"
	And the catalog form parameter is set to "t"
	And the cube form parameter is set to "t"
	Then the status code is 401
	
Scenario: The user calls the web service to post data to an invalid resourceId within a valid contextId
	Given the contextId is valid
	And the resourceId is invalid
	When the user calls the web service using the "Content-Type" header with the value "application/x-www-form-urlencoded"
	And the contextId portion of the URL is "xanalyzer"
	And the resourceId portion of the URL is "invalidContextId"
	And the catalog form parameter is set to "t"
	And the cube form parameter is set to "t"
	Then the status code is 404
	
Scenario: The user calls the web service to post data to an invalid resourceId and contextId
	Given the contextId is invalid
	And the resourceId is invalid
	When the user calls the web service
	And the contextId portion of the URL is "invalidContextId"
	And the resourceId portion of the URL is "invalidResourceId"
	Then the status code is 404

# GET Method: /repos/{contextId}/{resourceId }
# Note: Based on the documentation, the response can be in different formats, but the API call has always returned response in HTML format.	
Scenario Outline: An authorized user calls web service to retrieve a resource using Context ID <contextId> and Resource Id <resourceId>
  Given the <contextId> is valid
  And the <resourceId> is valid
  When a HTTP GET request is sent to the server
  Then the response code is 200 OK
  And the response body contains the resource details in HTML format

	Examples:
		| contextId | resourceId | 
		| admin-plugin | /resources/authenticationProviderModule/authenticationProviderAdmin.html | 
		| xanalyzer | /service/ajax/lookupXmiId |
		| prpt | /public:steel%20wheels:Invoice%20(report) |
		| prpt | /public:steel%20wheels:Invoice%20!@#$%^&*()_-=+;:'"?<>,.`~[]{}|(report) |
		
Scenario: An non-existent user calls web service to retrieve a resource using Context ID and Resource Id
  Given the contextId is valid
  And the resourceId is valid
  When a HTTP GET request is sent to the server
  And the Basic HTTP Authorization Request Header is using username "notUser" and password "wrongPassword"
  Then the response code is 401 Unauthorized
  And the response body contains HTML block with "title" as "Error 401 Unauthorized"
		
Scenario: An authorized user calls web service to retrieve a resource, but the resourceId is invalid
  Given the contextId is valid
  And the resourceId is invalid
  When a HTTP GET request is sent to the server
  Then the response code is 404 Not Found
  And the response body is empty
  
Scenario: An authorized user calls web service to retrieve a resource, but the contextID is invalid
  Given the resourceId is valid
  And the contextId is invalid
  When a HTTP GET request is sent to the server
  Then the response code is 404 Not Found
  And the response body is empty

Scenario: An authorized user calls web service to retrieve a resource, but both the contextID and resourceId are invalid
  Given the resourceId is invalid
  And the contextId is invalid
  When a HTTP GET request is sent to the server
  Then the response code is 404 Not Found
  And the response body is empty

# GET Method: /repos/{pathId }/default
Scenario Outline: The user calls the web service to generate a URI that will generate content from the specified file.
	Given the file <pathId> exists
	And the user <user> has the Read Content permission
	And the user <user> has access to the file <pathId>
	When the user calls the web service
	Then the status code is 303
	And the response header "Location" contains the URI <URI>
	And the URI contained 
Examples:
	| user | pathId | URI |
	| admin | :home:admin:Test.xanalyzer | /pentaho/api/repos/:home:admin:TestPAZ.xanalyzer/editor |
	| admin | :home:admin:!@#$%^&*()_-=+;:'"?<>,.`~[]{}|.prpti | /pentaho/api/repos/:home:admin:!%40%23%24%25%5E%26*()_-%3D%2B%3B%09%27%22%3F%3C%3E%2C.%60~%5B%5D%7B%7D%7C.prpti/prpti.view |
	| admin | :public:Steel%20Wheels:Invoice%20(report).prpt | /pentaho/api/repos/:public:Steel%20Wheels:Invoice%20(report).prpt/viewer |
	| admin | :public:Reports:!@#$%^&*()_-=+;:'"?<>,.`~[]{}|.prpti | /pentaho/api/repos/:public:Reports:!%40%23%24%25%5E%26*()_-%3D%2B%3B%09%27%22%3F%3C%3E%2C.%60~%5B%5D%7B%7D%7C.prpti/prpti.view |
	| suzy | :home:suzy:TestPAZ.xanalyzer | /pentaho/api/repos/:home:suzy:TestPAZ.xanalyzer/editor |
	| suzy | :public:Steel%20Wheels:Invoice%20(report).prpt | /pentaho/api/repos/:public:Steel%20Wheels:Invoice%20(report).prpt/viewer |
	| suzy | :public:Reports:!@#$%^&*()_-=+;:'"?<>,.`~[]{}|.prpti | /pentaho/api/repos/:public:Reports:!%40%23%24%25%5E%26*()_-%3D%2B%3B%09%27%22%3F%3C%3E%2C.%60~%5B%5D%7B%7D%7C.prpti/prpti.view |
	
Scenario: The anonymous user calls the web service to generate a URI that will generate content from the specified file.
	Given the file exists
	When the user calls the web service
	Then the status code is 401
	And the response header "Location" does not exist
	
Scenario Outline: The user calls the web service to generate a URI for a file that they do not have access to.
	Given the file <pathId> exists
	And the user <user> does not have access to <pathId>
	And the user <user> has the read content permission
	When the user calls the web service
	Then the status code is 403
	And the response header "Location" does not exist
Examples:
	| user | pathId |
	| suzy | :home:admin:Test.xanalyzer
	| suzy | :public:NoAccess:report.prpti |
	
Scenario: The user calls the web service to generate a URI for a file, but does not have the Read Content permission
	Given the file exists
	But the user does not have the Read Content permission
	When the user calls the web service
	Then the status code is 403
	And the response header "Location" does not exist
	
Scenario: The user calls the web service to generate a URI for a file that does not exist.
	Given the user has the Read Content permission
	But the file does not exist
	When the user calls the web service
	Then the status code is 404
	And the response header "Location" does not exist
