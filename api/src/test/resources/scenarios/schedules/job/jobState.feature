# ========================================================================================================
# POST method - Return the state of the specified job - pentaho/api/scheduler/jobinfo
# ========================================================================================================
Scenario: A valid user calls web service to retrieve a scheduled job state in XML format
	Given a scheduled job exists 
	And the job state is "Normal"
	When a HTTP POST request sent to "pentaho/api/scheduler/jobinfo"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message is "NORMAL"

	Examples:
		| username | password | jobId |
		| admin | password | admin	AdminScheduleTest16	1512766765982 |
		| suzy | password | suzy	SuzyScheduleTest16	1512766765982 |
		| admin | password | admin	Admin~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |
		| suzy | password | suzy	Suzy~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |

Scenario: A valid user calls web service to retrieve a scheduled job state in JSON format
	Given a scheduled job exists 
	And the job state is "Normal"
	When a HTTP POST request sent to "pentaho/api/scheduler/jobinfo"
	And the Content-Type header is set to "application/json"
	Then the returned status code is 200 OK
	And the response message is "NORMAL"

	Examples:
		| username | password | jobId |
		| admin | password | admin	AdminScheduleTest16	1512766765982 |
		| suzy | password | suzy	SuzyScheduleTest16	1512766765982 |
		| admin | password | admin	Admin~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |
		| suzy | password | suzy	Suzy~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |
		
Scenario: Admin user calls web service to retrieve a scheduled job state in XML format but the job is "Paused"
	Given a scheduled job exists 
	And the job state is "Paused"
	And the "jobId" is "admin	AdminScheduleTest16	1512758922854"
	When a HTTP POST request sent to "pentaho/api/scheduler/jobinfo"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message is "PAUSED"

Scenario: Admin user calls web service to retrieve a scheduled job state in XML format but the job is "Finished"
	Given a scheduled job exists 
	And the job state is "Finished"
	And the "jobId" is "admin	AdminScheduleTest16	1512758922854"
	When a HTTP POST request sent to "pentaho/api/scheduler/jobinfo"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message is "COMPLETE"
	
Scenario: Pat user calls web service to retrieve a scheduled job state in XML format but the job is created by Suzy
	Given a scheduled job created by Suzy exists
	And the job state is "Normal"
	And the "jobId" is "suzy	SuzyScheduleTest16	1512758922854"
	When a HTTP POST request sent to "pentaho/api/scheduler/jobinfo"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 403 Forbidden
# Note: API call returned 500 Unavailable error. But expecting 403 as Pat user is not authorized to view the schedule job created by Suzy

Scenario: A non-existent user calls web service to retrieve a scheduled job state in XML format 
	Given the User ID and/or Password are invalid/not provided
	And the "jobId" is "suzy	SuzyScheduleTest16	1512758922854"
	When a HTTP POST request sent to "pentaho/api/scheduler/jobinfo"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 401 Unauthorized
	And the response body header shows "HTTP Status 401 - Bad credentials"

	Examples:
		| username | password |
		| Emily | password |
		| Mike | password01 |
		| notUser | wrongPassword |
		| noPass  |        |
		|         | noUser |
		|         |        |
		
Scenario: Admin user calls web service to retrieve a scheduled job state in XML format but the job id is invalid
	Given the job ID is invalid "admin	AdminScheduleTest16	wefwsf34222"
	When a HTTP POST request sent to "pentaho/api/scheduler/jobinfo"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 404 Not Found
# Note: API call returned 500 Internal Server Error status code which is not expected. Since the payload data include invalid input, expecting 404 Not Found response code.
		