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

# ==============================================================================================================================================
# GET method - Checks whether the current user may schedule a repository file in the platform - pentaho/api/scheduler/isScheduleAllowed?id=<id>
# ==============================================================================================================================================
Scenario: A valid <user> calls web service to check whether the current <user> may schedule a repository file in the platform
	Given the <user> has "Schedule Content" permission 
	And scheduling is allowed for the repository file
	When a HTTP GET request sent to "pentaho/api/scheduler/isScheduleAllowed?id=<>"
	Then the returned status code is 200 OK
	And the response message is "true"

	Examples:
		| user | password | 
		| admin | password | 
		| suzy | password |

Scenario: A valid <user> calls web service to check whether the current <user> may schedule a repository file in the platform, but the user do not have schedule content permission
	Given the <user> do not have "Schedule Content" permission 
	And scheduling is allowed for the repository file
	When a HTTP GET request sent to "pentaho/api/scheduler/isScheduleAllowed?id=<>"
	Then the returned status code is 200 OK
	And the response message is "false"

	Examples:
		| user | password | 
		| pat | password | 
		
Scenario: A valid <user> calls web service to check whether the current <user> may schedule a repository file in the platform, but scheduling is not allowed for the repository file (for example, a dashboard file)
	Given the <user> has "Schedule Content" permission
	And scheduling is not allowed for the repository file
	When a HTTP GET request sent to "pentaho/api/scheduler/isScheduleAllowed?id=<>"
	Then the returned status code is 200 OK
	And the response message is "false"

	Examples:
		| user | password | 
		| admin | password | 
		| suzy | password |
# Note: API call has returned 200 OK and the response message is "true". This might be a product bug as schedules are not allowed on Dashboard files.

Scenario: A valid <user> calls web service to check whether the current <user> may schedule a repository file in the platform, but <repository file id> doesn't exist
	Given the <user> has "Schedule Content" permission
	And the <repository file id> doesn't exist
	When a HTTP GET request sent to "pentaho/api/scheduler/isScheduleAllowed?id=<>"
	Then the returned status code is 404 Not Found

	Examples:
		| user | repository file id | 
		| admin | sfdfdsg#$%# | 
		| suzy | 2432432dsf |
		
Scenario: A non-existent <user> calls web service to check whether the current <user> may schedule a repository file in the platform
	Given the <user> and/or <password> are not valid/provided
	When a HTTP GET request sent to "pentaho/api/scheduler/isScheduleAllowed?id=<>"
	Then the returned status code is 401 Unauthorized
	And the response body contains header "HTTP Status 401 - Bad credentials"

	Examples:
		| user | password |
		| Emily | password |
		| Mike | password01 |
		| notUser | wrongPassword |
		| noPass  |        |
		|         | noUser |
		|         |        |