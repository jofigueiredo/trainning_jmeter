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

===============================================================================================================
GET method - Executes job from enterprise repository specified in the repositories.xml file - /kettle/runJob
===============================================================================================================
Scenario: An authorized user calls web service to run a <job> from repository using Carte server
  Given a Carte slave server is running
  And the job <job> exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the response body contains the result, message and id in XML format
	
	Examples:
		| job |
		| /home/admin/Job1 |
		| /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| | 
		| /public/carte/SampleJob |

Scenario: An non-existent <user> calls web service to run a job from repository using password <password>
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
		
Scenario: An authorized user calls web service to run a job from repository using Carte server, but invalid credentials provided for Pentaho Repository connection
  Given a Carte slave server is running
  And the job exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 400 Bad Request
  And the response body contains response code 401 which indicate repository connection failure due to invalid credentials
Note: API call has returned 200 OK and response message contains Null pointer exception message

Scenario: An authorized user calls web service to run a job from repository using Carte server, but the user specified in the repository connection do not have permission to access the job
  Given a Carte slave server is running
  And the job exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 400 Bad Request
  And the response body contains response code 403 which indicate the specified user do not have permission to access the job
Note: API call has returned 200 OK and response message contains "Unable to find the job"

Scenario: An authorized user calls web service to run a job from repository using Carte server, but the specified repository is not found
  Given a Carte slave server is running
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  And the repository is invalid
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 404 Not Found
  And the response body indicate the repository was not found

Scenario: An authorized user calls web service to run a job from repository using Carte server, but there is an error while executing the job
  Given a Carte slave server is running
  And the job exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the response body contains the result, message and id in XML format
  And the job status status shows "Finished (with errors)"

Scenario: An authorized user calls web service to run a job from repository using Carte server, but the Job doesn't exist
  Given a Carte slave server is running
  And the job doesn't exist in the repository
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 404 Not Found
Note: API call has returned 200 OK with Null pointer exception in the response message

Scenario: An authorized user calls web service to run a job from repository using Carte server for log level <level>
  Given a Carte slave server is running
  And the job exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the response body contains the result, message and id in XML format
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
		
Scenario: An authorized user calls web service to run a job from repository using Carte server, but invalid value for log "level"
  Given a Carte slave server is running
  And the job exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1" 
  And the "level" parameter set to "Deb" (Invalid)
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 400 Bad Request
Note: API call has returned 200 OK and the job has executed without any errors
================================================================================================================
POST method - Executes job from enterprise repository specified in the repositories.xml file - /kettle/runJob
================================================================================================================
Scenario: An authorized user calls web service to run a <job> from repository using Carte server
  Given a Carte slave server is running
  And the job <job> exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the response body contains the result, message and id in XML format

	Examples:
		| job |
		| /home/admin/Job1 |
		| /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| | 
		| /public/carte/SampleJob |
		
Scenario: An non-existent <user> calls web service to run a job from repository using password <password>
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
		
Scenario: An authorized user calls web service to run a job from repository using Carte server, but invalid credentials provided for Pentaho Repository connection
  Given a Carte slave server is running
  And the job exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 400 Bad Request
  And the response body contains response code 401 which indicate repository connection failure due to invalid credentials
Note: API call has returned 200 OK and response message contains Null pointer exception message

Scenario: An authorized user calls web service to run a job from repository using Carte server, but the user specified in the repository connection do not have permission to access the job
  Given a Carte slave server is running
  And the job exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 400 Bad Request
  And the response body contains response code 403 which indicate the specified user do not have permission to access the job
Note: API call has returned 200 OK and response message contains "Unable to find the job"

Scenario: An authorized user calls web service to run a job from repository using Carte server, but the specified repository is not found
  Given a Carte slave server is running
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  And the repository is invalid
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 404 Not Found
  And the response body indicate the repository was not found

Scenario: An authorized user calls web service to run a job from repository using Carte server, but there is an error while executing the job
  Given a Carte slave server is running
  And the job exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the response body contains the result, message and id in XML format
  And the job status status shows "Finished (with errors)"

Scenario: An authorized user calls web service to run a job from repository using Carte server, but the Job doesn't exist
  Given a Carte slave server is running
  And the job doesn't exist in the repository
  And the "job" parameter set to "home%2Fadmin%2Fafdfd" (Job doesn't exist)
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 404 Not Found
Note: API call has returned 200 OK with Null pointer exception in the response message

Scenario: An authorized user calls web service to run a job from repository using Carte server for log level <level>
  Given a Carte slave server is running
  And the job exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Debug"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the response body contains the result, message and id in XML format
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

Scenario: An authorized user calls web service to run a job from repository using Carte server, but invalid value for log "level"
  Given a Carte slave server is running
  And the job exist in the repository
  And the "job" parameter set to "home%2Fadmin%2FJob1"
  And the "level" parameter set to "Deb"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 400 Bad Request
Note: API call has returned 200 OK and the job has executed without any errors