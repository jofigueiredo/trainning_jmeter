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

============================================================================================================================
GET method - Starts the job - /kettle/startJob/<job>&<xml> or /kettle/startJob/<job>&<id> 
============================================================================================================================
Scenario: An authorized user calls web service to start a job by using the <jobname> and xml parameter <xml>
  Given a Carte slave server is running
  And the job name is <jobname>
  And the "xml" parameter is set to <xml>
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the job is started
  And the response body contains the result, message and id of the job in the format based on the <xml> flag
	
	Examples:
		| jobname | xml |
		| Job1 | Y |
		| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| | Y |
		| SampleJob | Y |
		| Job1 | N |
		| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| | N |
		| SampleJob | N |

Scenario: An non-existent user calls web service to start a job using credentials <user>/<password>
  Given a Carte slave server is running
  And the job exist
  And the "xml" parameter is set to "Y"
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
		
Scenario: An authorized user calls web service to start a job, but there is an error while executing the job
  Given a Carte slave server is running
  And the job exist 
  And the "xml" parameter is set to "Y"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the response body contains the result, message and id in XML format
  And the job status status shows "Finished (with errors)"

Scenario: An authorized user calls web service to start a job, but there is no job exist with given job name
  Given a Carte slave server is running
  And there is no job exist with given job name
  And the "xml" parameter is set to "Y"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 404 Not Found
Note: API call has returned 200 OK with message "The specified job [Job] could not be found"

Scenario: An authorized user calls web service to start a job using job id, but the job id is invalid
  Given a Carte slave server is running
  And the job id is invalid
  And the "xml" parameter is set to "Y"
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 404 Not Found
Note: API call has returned 200 OK with message "The specified job [Job] could not be found"

Scenario: An authorized user calls web service to start a job using job name and Carte job id parameters
  Given a Carte slave server is running
  And a valid job name is specified
  And a valid Carte job id is specified
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the job is started
  And the response body contains the result, message and id in HTML format

Scenario: An authorized user calls web service to start a job using id <id> and XML <XMLFlag> parameter
  Given a Carte slave server is running
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the job is started
  And the response body contains the result, message and id in <ResultFormat> format
  
  	Examples:
		| id | XMLFlag | ResultFormat |
		| 8a847bd2-a025-4f7e-b9a5-caf5cf19f21d | Y | XML |
		| 66c22ea8-6df2-4844-93fc-9606085b0022 | N | HTML |
  
Scenario: An authorized user calls web service to start a job using job name <job>, XML <XMLFlag> and job id <id> parameters
  Given a Carte slave server is running
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the job is started
  And the response body contains the result, message and id in <ResultFormat> format
  
    Examples:
		| job | id | XMLFlag | ResultFormat |
		| Job1 | 8a847bd2-a025-4f7e-b9a5-caf5cf19f21d | Y | XML |
		| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| | 66c22ea8-6df2-4844-93fc-9606085b0022 | N | HTML |
		
Scenario: An authorized user calls web service to start a job using only the job name
  Given a Carte slave server is running
  And the job exist 
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the job is started
  And the response body contains the result, message and id in HTML format
  
Scenario: An authorized user calls web service to start a job using only the job name, but more than one job exists with same name
  Given a Carte slave server is running
  And multiple job exists with same name 
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 409
  And the jobs are not started
  
Scenario: An authorized user calls web service to start a job using only the job name and id, but more than one job exists with same name
  Given a Carte slave server is running
  And multiple job exists with same name 
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response code is 200 OK
  And the job that satisfy the given name and id is started
================================================================================================================
POST method - Starts the job - /kettle/startJob
================================================================================================================
Scenario: An authorized user calls web service to start a job by specifying the <jobname> and response format <format>
  Given a Carte slave server is running
  And the job name parameter is set to <jobname>
  And the "xml" parameter is set to <xml>
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the job is started
  And the response body contains the result, message and id of the job in the format based on the <xml> flag
	
	Examples:
		| jobname | xml |
		| Job1 | Y |
		| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| | Y |
		| SampleJob | Y |
		| Job1 | N |
		| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| | N |
		| SampleJob | N |

Scenario: An non-existent user calls web service to start a job using credentials <user>/<password>
  Given a Carte slave server is running
  And the job exist
  And the "xml" parameter is set to "Y"
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
		
Scenario: An authorized user calls web service to start a job, but there is an error while executing the job
  Given a Carte slave server is running
  And the job exist 
  And the "xml" parameter is set to "Y"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the response body contains the result, message and id in XML format
  And the job status status shows "Finished (with errors)"

Scenario: An authorized user calls web service to start a job, but there is no job exist with given job name
  Given a Carte slave server is running
  And there is no job exist with given job name
  And the "xml" parameter is set to "Y"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 404 Not Found
Note: API call has returned 200 OK with message "The specified job [Job] could not be found"

Scenario: An authorized user calls web service to start a job using job id, but the job id is invalid
  Given a Carte slave server is running
  And the job id is invalid
  And the "xml" parameter is set to "Y"
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 404 Not Found
Note: API call has returned 200 OK with message "The specified job [Job] could not be found"

Scenario: An authorized user calls web service to start a job using job name and Carte job id parameters
  Given a Carte slave server is running
  And a valid job name is specified
  And a valid Carte job id is specified
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the job is started
  And the response body contains the result, message and id in HTML format
  
Scenario: An authorized user calls web service to start a job using id <id> and XML <XMLFlag> parameter
  Given a Carte slave server is running
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the job is started
  And the response body contains the result, message and id in <ResultFormat> format
  
  	Examples:
		| id | XMLFlag | ResultFormat |
		| 8a847bd2-a025-4f7e-b9a5-caf5cf19f21d | Y | XML |
		| 66c22ea8-6df2-4844-93fc-9606085b0022 | N | HTML |
  
Scenario: An authorized user calls web service to start a job using job name <job>, XML <XMLFlag> and job id <id> parameters
  Given a Carte slave server is running
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the job is started
  And the response body contains the result, message and id in <ResultFormat> format
  
    Examples:
		| job | id | XMLFlag | ResultFormat |
		| Job1 | 8a847bd2-a025-4f7e-b9a5-caf5cf19f21d | Y | XML |
		| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| | 66c22ea8-6df2-4844-93fc-9606085b0022 | N | HTML |
  
Scenario: An authorized user calls web service to start a job using only the job name
  Given a Carte slave server is running
  And the job exist 
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the job is started
  And the response body contains the result, message and id in HTML format
  
Scenario: An authorized user calls web service to start a job using only the job name, but more than one job exists with same name
  Given a Carte slave server is running
  And multiple job exists with same name 
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 409
  And the jobs are not started
  
Scenario: An authorized user calls web service to start a job using only the job name and id, but more than one job exists with same name
  Given a Carte slave server is running
  And multiple job exists with same name 
  When a HTTP POST request is sent to the root endpoint of the Carte slave server
  And the Content-Type header is set to "application/x-www-form-urlencoded"
  Then the response code is 200 OK
  And the job that satisfy the given name and id is started