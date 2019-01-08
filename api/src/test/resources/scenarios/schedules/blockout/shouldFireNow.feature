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
# GET method - Checks if the selected blockout schedule should be fired now - pentaho/api/scheduler/blockout/shouldFireNow
# ========================================================================================================
Scenario: A valid user calls web service to check if the selected blockout schedule should fire now
	Given a active blockout exist 
	When a HTTP GET request sent to "pentaho/api/scheduler/blockout/shouldFireNow"
	Then the returned status code is 200 OK
	And the response message is "false"

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |
		
Scenario: A valid user calls web service to check if the selected blockout schedule should fire now but the blockout exist and not active
	Given the blockout exist but not active 
	When a HTTP GET request sent to "pentaho/api/scheduler/blockout/shouldFireNow"
	Then the returned status code is 200 OK
	And the response message is "true"

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |

Scenario: A valid user calls web service to check if the selected blockout schedule should fire now but blockout doesn't exist
	Given the blockout doesn't exist
	When a HTTP GET request sent to "pentaho/api/scheduler/blockout/shouldFireNow"
	Then the returned status code is 200 OK
	And the response message is "true"

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |
		
Scenario: A non-existent user calls web service to check if the selected blockout schedule should fire now
	Given the User ID and/or Password are not valid/provided
	When a HTTP GET request sent to "pentaho/api/scheduler/blockout/shouldFireNow"
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