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
# GET method - Retrieve the all the scheduled job(s) visible to the current users - pentaho/api/scheduler/getJobs
# ========================================================================================================
Scenario: Admin user calls web service to retrieve the scheduled jobs in JSON format
	Given scheduled jobs are already exists
	When a HTTP GET request sent to "pentaho/api/scheduler/getJobs" using the header "Accept: application/json"
	Then the returned status code is 200 OK
	And the response body contains the list of scheduled jobs created by all the users in JSON format
	
Scenario: Admin user calls web service to retrieve the scheduled jobs in XML format
	Given scheduled jobs are already exists
	When a HTTP GET request sent to "pentaho/api/scheduler/getJobs" using the header "Accept: application/xml"
	Then the returned status code is 200 OK
	And the response body contains the list of scheduled jobs created by all the users in XML format
		
Scenario: Suzy user calls web service to retrieve the scheduled jobs created by Suzy in JSON format
	Given the scheduled job created by Suzy exists
	When a HTTP GET request sent to "pentaho/api/scheduler/getJobs" using the header "Accept: application/json"
	Then the returned status code is 200 OK
	And the response body contains the list of scheduled jobs created only by the Suzy in JSON format

Scenario: Suzy user calls web service to retrieve the scheduled jobs, but there are no scheduled jobs created by Suzy
	Given there are no scheduled job created by Suzy, but by other users
	When a HTTP GET request sent to "pentaho/api/scheduler/getJobs" using the header "Accept: application/json"
	Then the returned status code is 200 OK
	And the response body contains value "null" which indicate there are no scheduled jobs created by Suzy

Scenario: Pat user calls web service to retrieve the scheduled jobs but do not have permission to view the scheduled job
	Given the user do not have permission to create or view scheduled job
	When a HTTP GET request sent to "pentaho/api/scheduler/getJobs"
	Then the returned status code is 403 Forbidden
# Note: API call has returned 200 OK status code which is not expected. Expecting 403 Forbidden as Pat user do not have permission.
	
Scenario: A non-existent user calls web service to retrieve the scheduled jobs 
	Given the User ID and/or Password are not valid/provided
	When a HTTP GET request sent to "pentaho/api/scheduler/getJobs"
	Then the returned status code is 401 Unauthorized
	And the response body contains header "HTTP Status 401 - Bad credentials"

	Examples:
		| username | password |
		| Emily | password |
		| Mike | password01 |
		| notUser | wrongPassword |
		| noPass  |        |
		|         | noUser |
		|         |        |