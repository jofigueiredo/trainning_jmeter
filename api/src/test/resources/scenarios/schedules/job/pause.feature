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
# POST method - Pause the scheduler from a running state - pentaho/api/scheduler/pause
# ========================================================================================================
Scenario: A valid <user> calls web service to pause the scheduler from a running state
	Given the <user> has "Schedule Content" permission
	And the scheduler is in "Running" state
	When a HTTP POST request sent to "pentaho/api/scheduler/pause"
	Then the returned status code is 200 OK
	And the response message is "PAUSED"

	Examples:
		| user | password | 
		| admin | password | 
		| suzy | password | 
		
Scenario: A valid user calls web service to pause the scheduler, but the scheduler is in "Paused" state
	Given the user has "Schedule Content" permission
	And the scheduler is in "Paused" state
	When a HTTP POST request sent to "pentaho/api/scheduler/pause"
	Then the returned status code is 200 OK
	And the response message is "PAUSED"

Scenario: A valid user calls web service to pause the scheduler from a running state, but do not have "Schedule Content" permission
	Given the user do not have "Schedule Content" permission
	And the scheduler is in "Running" state
	When a HTTP POST request sent to "pentaho/api/scheduler/pause"
	Then the returned status code is 403 Forbidden
# Note: API call returned 200 OK and the response message is "RUNNING". But expecting 403 as user do not have "Schedule Content" permission.

Scenario: A valid <user> calls web service to pause the scheduler from a running state
	Given the <user> and/or <password> are not valid/provided
	When a HTTP POST request sent to "pentaho/api/scheduler/pause"
	Then the returned status code is 401 Unauthorized
	And the response body header shows "HTTP Status 401 - Bad credentials"
	
	Examples:
		| user | password |
		| Emily | password |
		| Mike | password01 |
		| notUser | wrongPassword |
		| noPass  |        |
		|         | noUser |
		|         |        |