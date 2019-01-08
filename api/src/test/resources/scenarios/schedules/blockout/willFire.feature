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
# POST method - Checks if the selected blockout schedule will be fired - pentaho/api/scheduler/blockout/willFire
# ========================================================================================================
Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but blockout exists with same recurrence interval
	Given the blockout exist with same recurrence interval
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message is "false"

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |

Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in JSON format but blockout exists with same recurrence interval
	Given the blockout exist with same recurrence interval
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/json"
	Then the returned status code is 200 OK
	And the response message is "false"

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |
		
Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but blockout exists with different non-overlapping recurrence interval
	Given the blockout exist with different non-overlapping recurrence interval
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message is "true"

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |
		
Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but blockout exists with different overlapping recurrence interval
	Given the blockout exists with different overlapping recurrence interval
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message is "true"

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |

Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but blockout's doesn't exist
	Given no blockout exist
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message is "true"

	Examples:
		| username | password | 
		| admin | password | 
		| suzy | password |
		| pat | password |
		
Scenario: A non-existent user calls web service to check if the selected blockout schedule will be fired in XML format
	Given the User ID and/or Password are not valid/provided
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
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
		
		
Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but the "Start Date" is invalid
	Given a blockout exist
	And the "Start Date" is "2018-45-31T10:51:00-05:00" (invalid Month provided)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Interval Server Error

Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but the "End Date" is invalid
	Given a blockout exist
	And the "End Date" is "2018-45-31T10:51:00-05:00" (invalid Month provided)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 200 OK

Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but the "Time Zone" is invalid
	Given a blockout exist
	And the "timeZone" is "America/Arg" (invalid value)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 200 OK

Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but the "Duration" is invalid
	Given a blockout exist
	And the "Duration" is "wrewr32" (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 200 OK

Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but the "Repeat Interval" is invalid
	Given a blockout exist
	And the "repeatInterval" is "dsfwer" (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Internal Server Error

Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but the "Days Of Week" is invalid
	Given a blockout exist
	And the "Days of Week" is set to 9 (9 is invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Internal Server Error

Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but the "Days Of Month" is invalid
	Given a blockout exist
	And the "Days of Month" is 43 (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Internal Server Error

Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but the "Weeks Of Month" is invalid
	Given a blockout exist
	And the "Weeks of Month" is 7 (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Internal Server Error

Scenario: A valid user calls web service to check if the selected blockout schedule will be fired in XML format but the "Months of Year" is invalid
	Given a blockout exist
	And the "Months of Year" is "15" (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/willFire"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Internal Server Error