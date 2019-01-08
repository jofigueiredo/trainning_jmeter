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
# POST method - Execute a previously scheduled job - pentaho/api/scheduler/triggerNow
# ========================================================================================================
Scenario: A valid user calls web service to execute a scheduled job in XML format using valid jobId
	Given a scheduled job already exists
	And the job state is "Normal"
	When a HTTP POST request sent to "pentaho/api/scheduler/triggerNow"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message is "NORMAL"
	And the job executed successfully
	And the "Last Run" is updated with job execution time
	
	Examples:
		| username | password | jobId |
		| admin | password | admin	AdminScheduleTest16	1512766765982 |
		| suzy | password | suzy	SuzyScheduleTest16	1512766765982 |
		| admin | password | admin	Admin~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |
		| suzy | password | suzy	Suzy~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |
		
Scenario: A valid user calls web service to execute a scheduled job in JSON format
	Given a scheduled job already exists
	And the job state is "Normal"
	When a HTTP POST request sent to "pentaho/api/scheduler/triggerNow"
	And the Content-Type header is set to "application/json"
	Then the returned status code is 200 OK
	And the response message is "NORMAL"
	And the job executed successfully
	And the "Last Run" value is updated with job execution time

	Examples:
		| username | password | jobId |
		| admin | password | admin	AdminScheduleTest16	1512766765982 |
		| suzy | password | suzy	SuzyScheduleTest16	1512766765982 |
		| admin | password | admin	Admin~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |
		| suzy | password | suzy	Suzy~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |
		
Scenario: Admin user calls web service to execute a scheduled job but the job is in "Paused" state 
	Given a scheduled job already exists
	And the job state is "Paused"
	And the "jobId" is "admin	AdminScheduleTest16	1512766765982"
	When a HTTP POST request sent to "pentaho/api/scheduler/triggerNow"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message is "NORMAL"
	And the job executed successfully
	And the "Last Run" value is updated with job execution time

Scenario: A valid user calls web service to execute a scheduled job but the job id is invalid
	Given the job id is invalid 
	When a HTTP POST request sent to "pentaho/api/scheduler/triggerNow"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 404 Not Found
# Note: API call returned 500 Internal Server error. Since it is an invalid request as the job id provided in the payload is invalid, expecting 404 Not Found response code.

	Examples:
		| username | password | jobId |
		| admin | password | admin	AdminScheduleTest16	1512766serwe#$# |
		| suzy | password | suzy	SuzyScheduleTest16	sdfwe2wr545er |

Scenario: A valid user calls web service to execute previously scheduled job in XML format but don't have "Execute" permission
	Given a scheduled job already exists
	And the job state is "Normal"
	And the jobId is "username	UserScheduleTest16	1512766765982" 
	And the user do not have "Execute" permission
	When a HTTP POST request sent to "pentaho/api/scheduler/triggerNow"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 403 Forbidden
# Note: API call returned 200 OK response code which is not expected. This might be a bug.
	
Scenario: Pat user calls web service to execute the specified scheduled job created by Suzy in XML format
	Given a scheduled job created by Suzy exists
	And the job state is "NORMAL"
	And the jobId is "suzy	SuzyScheduleTest16	1512766765982" 
	When a HTTP POST request sent to "pentaho/api/scheduler/triggerNow"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 403 Forbidden
# Note: API call returned 200 OK response code which is not expected. Should return 403 as Pat user is not authorized to execute the scheduled job created by Suzy.

Scenario: A non-existent user calls web service to execute the specified scheduled job
	Given the User ID and/or Password are invalid
	And the jobId is "suzy	SuzyScheduleTest16	1512766765982" 
	When a HTTP POST request sent to "pentaho/api/scheduler/triggerNow"
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