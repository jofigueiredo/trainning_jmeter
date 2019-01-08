###########################################################################
# HITACHI VANTARA PROPRIETARY AND CONFIDENTIAL
# 
# Copyright 2002 - 2018 Hitachi Vantara. All rights reserved.
# 
# NOTICE: All information including source code contained herein is, and
# remains the sole property of Hitachi Vantara and its licensors. The intellectual
# and technical concepts contained herein are proprietary and confidential
# to, and are trade secrets of Hitachi Vantara and may be covered by U.S. and foreign
# patents, or patents in process, and are protected by trade secret and
# copyright laws. The receipt or possession of this source code and/or related
# information does not convey or imply any rights to reproduce, disclose or
# distribute its contents, or to manufacture, use, or sell anything that it
# may describe, in whole or in part. Any reproduction, modification, distribution,
# or public display of this information without the express written authorization
# from Hitachi Vantara is strictly prohibited and in violation of applicable laws and
# international treaties. Access to the source code contained herein is strictly
# prohibited to anyone except those individuals and entities who have executed
# confidentiality and non-disclosure agreements or other agreements with Hitachi Vantara,
# explicitly covering such access.
###########################################################################

# ========================================================================================================
# GET method - Executes job from the specified repository or file system - /kettle/executeJob
# ========================================================================================================
Scenario: An authorized user calls web service to execute a <job> from repository <repo> using credentials <user> and <password>
  Given a Carte slave server is running
  And the job <job> exist in the repository
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the job is executed and the response body contains the job id
	
	Examples:
		| repo | user | password | job | 
		| pentaho | admin | password | /home/admin/Job1 | 
		| pentaho | admin | password | /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
		| pentaho | suzy | password | /home/suzy/Job2 | 
		| pentaho | suzy | password | /home/suzy/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
		| pentaho | admin | password | /public/job/Job1 | 
		| pentaho | suzy | password | /public/job/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| |

Scenario: An non-existent <user> calls web service to execute a job from repository using password <password>
  Given a Carte slave server is running
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 401 Unauthorized
  And the response body contains HTML block with "title" as "Error 401 Unauthorized"
  
	Examples:
		| user | password |
		| Emily | password |
		| Mike | password01 |
		| notUser | wrongPassword |
		| noPass  |        |
		|         | noUser |
		|         |        |
		
Scenario: An authorized user calls web service to execute a job from repository using Carte server, but invalid credentials <user>/<password> provided for pentaho Repository connection
  Given a Carte slave server is running
  And the job exist in the repository
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 400 Bad Request
  And the response body contains response code 401 which indicate repository connection failure due to invalid credentials
# Note: API call has returned 200 OK and response message contains Null pointer exception message

	Examples:
		| user | password |
		| adm | password |
		| admin | password01 |
		| suz | Password |
		| suzy  | test |
		|		|      |

Scenario: An authorized user calls web service to execute a job from repository using Carte server, but the user specified in the repository connection do not have permission to access the job
  Given a Carte slave server is running
  And the job exist in the repository
  And valid credentials "admin" and "password" specified for repository connection
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 400 Bad Request
  And the response body contains response code 403 which indicate the specified user do not have permission to access the job
# Note: API call has returned 200 OK and response message contains "Unable to find the job"

Scenario: An authorized user calls web service to execute a job from repository using Carte server, but the specified repository is not found
  Given a Carte slave server is running
  And valid credentials "admin" and "password" specified for repository connection
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 404 Not Found
  And the response body indicate the repository was not found

Scenario: An authorized user calls web service to execute a job from repository using Carte server, but there is an error while executing the job
  Given a Carte slave server is running
  And the job exist in the repository
  And the using valid credentials for repository "admin" and "password"
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the job status status shows "Finished (with errors)"

Scenario: An authorized user calls web service to execute a job from repository using Carte server, but the Job doesn't exist
  Given a Carte slave server is running
  And the job doesn't exist in the repository
  And the using valid credentials for repository "admin" and "password"
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2Fafdfd" (Job doesn't exist)
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 404 Not Found
# Note: API call has returned 200 OK with message "Unexpected error executing the job: org.pentaho.di.core.exception.KettleException: Unable to find job"

Scenario: An authorized user calls web service to execute a job from repository using Carte server for log level <level>
  Given a Carte slave server is running
  And the job exist in the repository
  And the using valid credentials for repository "admin" and "password"
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1" 
  And the "level" parameter set to <level>
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the log results contains the information based on the specified level
  
	Examples:
		| level |
		| Nothing |
		| Error |
		| Minimal |
		| Basic |
		| Detailed |
		| Debug |
		| Rowlevel |
		
Scenario: An authorized user calls web service to execute a job from repository using Carte server, but invalid value for log "level"
  Given a Carte slave server is running
  And the using valid credentials for repository "admin" and "password"
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Deb" (invalid)
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 400 Bad Request
# Note: API call has returned 200 OK and the job has executed without any errors

Scenario: An authorized user calls web service to execute a job from repository using parameters <Parameters>/<Values> to set job variable values
  Given a Carte slave server is running
  And the job exist in the repository
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the job is executed based on the given parameter values
  
	Examples:
		| Parameters | Values |
		| Param1 | value1 |
		| param1,param2,param3 | value1,value2,value3 |
		| !@#%^&*()_-=+;:'"?<>,.`~[]| | !@#%^&*()_-=+;:'"?<>,.`~[]| |
		| | |
# ========================================================================================================
# POST method - Executes job from enterprise repository - /kettle/executeJob
# ========================================================================================================
Scenario: An authorized user calls web service to execute a <job> from repository <repo> using credentials <user> and <password>
  Given a Carte slave server is running
  And the job <job> exist in the repository
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the job is executed and the response body contains the job id
	
	Examples:
		| repo | user | password | job | 
		| pentaho | admin | password | /home/admin/Job1 | 
		| pentaho | admin | password | /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
		| pentaho | suzy | password | /home/suzy/Job2 | 
		| pentaho | suzy | password | /home/suzy/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
		| pentaho | admin | password | /public/job/Job1 | 
		| pentaho | suzy | password | /public/job/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| |

Scenario: An non-existent <user> calls web service to execute a job from repository using password <password>
  Given a Carte slave server is running
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 401 Unauthorized
  And the response body contains HTML block with "title" as "Error 401 Unauthorized"
  
	Examples:
		| user | password |
		| Emily | password |
		| Mike | password01 |
		| notUser | wrongPassword |
		| noPass  |        |
		|         | noUser |
		|         |        |
		
Scenario: An authorized user calls web service to execute a job from repository using Carte server, but invalid credentials <user>/<password> provided for pentaho Repository connection
  Given a Carte slave server is running
  And the job exist in the repository
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 400 Bad Request
  And the response body contains response code 401 which indicate repository connection failure due to invalid credentials
# Note: API call has returned 200 OK and response message contains Null pointer exception message

	Examples:
		| user | password |
		| adm | password |
		| admin | password01 |
		| suz | Password |
		| suzy  | test |
		|		|      |

Scenario: An authorized user calls web service to execute a job from repository using Carte server, but the user specified in the repository connection do not have permission to access the job
  Given a Carte slave server is running
  And the job exist in the repository
  And valid credentials "admin" and "password" specified for repository connection
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 400 Bad Request
  And the response body contains response code 403 which indicate the specified user do not have permission to access the job
# Note: API call has returned 200 OK and response message contains "Unable to find the job"

Scenario: An authorized user calls web service to execute a job from repository using Carte server, but the specified repository is not found
  Given a Carte slave server is running
  And valid credentials "admin" and "password" specified for repository connection
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 404 Not Found
  And the response body indicate the repository was not found

Scenario: An authorized user calls web service to execute a job from repository using Carte server, but there is an error while executing the job
  Given a Carte slave server is running
  And the job exist in the repository
  And the using valid credentials for repository "admin" and "password"
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the job status status shows "Finished (with errors)"

Scenario: An authorized user calls web service to execute a job from repository using Carte server, but the Job doesn't exist
  Given a Carte slave server is running
  And the job doesn't exist in the repository
  And the using valid credentials for repository "admin" and "password"
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2Fafdfd" (Job doesn't exist)
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 404 Not Found
# Note: API call has returned 200 OK with message "Unexpected error executing the job: org.pentaho.di.core.exception.KettleException: Unable to find job"

Scenario: An authorized user calls web service to execute a job from repository using Carte server for log level <level>
  Given a Carte slave server is running
  And the job exist in the repository
  And the using valid credentials for repository "admin" and "password"
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1" 
  And the "level" parameter set to <level>
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the log results contains the information based on the specified level
  
	Examples:
		| level |
		| Nothing |
		| Error |
		| Minimal |
		| Basic |
		| Detailed |
		| Debug |
		| Rowlevel |
		
Scenario: An authorized user calls web service to execute a job from repository using Carte server, but invalid value for log "level"
  Given a Carte slave server is running
  And the using valid credentials for repository "admin" and "password"
  And the "rep" parameter is set to "pentaho"
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Deb" (invalid)
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 400 Bad Request
# Note: API call has returned 200 OK and the job has executed without any errors

Scenario: An authorized user calls web service to execute a job from repository using parameters <Parameters>/<Values> to set job variable values
  Given a Carte slave server is running
  And the job exist in the repository
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the job is executed based on the given parameter values
  
	Examples:
		| Parameters | Values |
		| Param1 | value1 |
		| param1,param2,param3 | value1,value2,value3 |
		| !@#%^&*()_-=+;:'"?<>,.`~[]| | !@#%^&*()_-=+;:'"?<>,.`~[]| |
		| | |