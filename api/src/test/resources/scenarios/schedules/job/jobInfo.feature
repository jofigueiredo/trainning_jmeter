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
# GET method - Return the information for a specified job - pentaho/api/scheduler/jobinfo
# ========================================================================================================
Scenario: A valid user calls web service to retrieve a scheduled job info in JSON format
	Given a scheduled job exists
	When a HTTP GET request sent to "pentaho/api/scheduler/jobinfo/<jobId>" using the header "Accept: application/json"
	Then the returned status code is 200 OK
	And the response body contains the details of given scheduled job in JSON format

	Examples:
		| username | password | jobId |
		| admin | password | admin	AdminScheduleTest16	1512766765982 |
		| suzy | password | suzy	SuzyScheduleTest16	1512766765982 |
		| admin | password | admin	Admin~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |
		| suzy | password | suzy	Suzy~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |

Scenario: A valid user calls web service to retrieve a scheduled job info in XML format
	Given a scheduled job exists
	When a HTTP GET request sent to "pentaho/api/scheduler/jobinfo/<jobId>" using the header "Accept: application/xml"
	Then the returned status code is 200 OK
	And the response body contains the details of given scheduled job in XML format

	Examples:
		| username | password | jobId |
		| admin | password | admin	AdminScheduleTest16	1512766765982 |
		| suzy | password | suzy	SuzyScheduleTest16	1512766765982 |
		| admin | password | admin	Admin~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |
		| suzy | password | suzy	Suzy~`!@#$%^*()_-+=|\}]{[""':;?/.>,&lt;&#38;	1512766765982 |
		
Scenario: A valid user calls web service to retrieve a scheduled job info but the job doesn't exists
	Given scheduled job doesn't exists
	When a HTTP GET request sent to "pentaho/api/scheduler/jobinfo/<jobId>"
	Then the returned status code is 404 Not Found
	And the response body is empty

	Examples:
		| username | password | jobId |
		| admin | password | admin	AdminScheduleTest16	1512766serwe#$# |
		| suzy | password | suzy	SuzyScheduleTest16	sdfwe2wr545er |
# Note: API call returned 500 Internal Server Error which is not expected.
		
Scenario: Suzy user calls web service to retrieve the details of a scheduled job created by Suzy in XML format
	Given a scheduled job created by Suzy exists
	When a HTTP GET request sent to "pentaho/api/scheduler/jobinfo/<jobId>" using the header "Accept: application/xml"
	Then the returned status code is 200 OK
	And the response body contains the details of scheduled job in XML format

Scenario: Pat user calls web service to retrieve the details of a scheduled job created by Suzy
	Given a scheduled job created by Suzy exists
	When a HTTP GET request sent to "pentaho/api/scheduler/jobinfo/<jobId>"
	Then the returned status code is 403 Forbidden
# Note: API call returned 500 Unavailable error. But expecting 403 as Pat user is not authorized to create/view the schedule job created by Suzy

Scenario: A non-existent user calls web service to retrieve the details of scheduled job info
	Given the User ID and/or Password are not valid/not provided
	When a HTTP GET request sent to "pentaho/api/scheduler/jobinfo/<jobId>"
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