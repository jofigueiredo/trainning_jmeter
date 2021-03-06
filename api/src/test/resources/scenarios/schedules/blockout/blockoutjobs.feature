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
# GET method - Get all the blockout jobs in the system - pentaho/api/scheduler/blockout/blockoutjobs
# ========================================================================================================
Scenario: A valid user calls web service to get all the a blockout in XML format
	Given the blockout exist 
	When a HTTP GET request sent to "pentaho/api/scheduler/blockout/blockoutjobs" and using the header "Accept: application/xml"
	Then the returned status code is 200 OK
	And the response message contains all the blockout details in XML format

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |

Scenario: A valid user calls web service to get all the a blockout in JSON format
	Given the blockout exist 
	When a HTTP GET request sent to "pentaho/api/scheduler/blockout/blockoutjobs" and using the header "Accept: application/json"
	Then the returned status code is 200 OK
	And the response message contains all the blockout details in JSON format

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |
		
Scenario: A valid user calls web service to get all the a blockout in XML format but the blockout doesn't exist
	Given the blockout jobs doesn't exist 
	When a HTTP GET request sent to "pentaho/api/scheduler/blockout/blockoutjobs" and using the header "Accept: application/xml"
	Then the returned status code is 200 OK
	And the response message contains an empty list of jobs

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |
		
Scenario: A non-existent user calls web service to get all the a blockout 
	Given the User ID and/or Password are not valid/provided
	When a HTTP GET request sent to "pentaho/api/scheduler/blockout/blockoutjobs" and using the header "Accept: application/xml"
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