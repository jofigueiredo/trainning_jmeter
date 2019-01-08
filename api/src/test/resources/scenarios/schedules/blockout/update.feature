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
# POST method - Update an existing blockout - pentaho/api/scheduler/blockout/update?jobid=<jobid>
# ========================================================================================================
Scenario: A valid user calls web service to update an existing blockout in XML format
	Given the user has "Administer Security" and "Schedule Content" permission
	And the blockout exist
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message contains the job ID
	And the existing job is updated with given changes

	Examples:
		| username | password | 
		| admin | password | 
# Note: Irrespective of Accept header (XML or JSON), API always return the response in Text format. Documentation says that the response can be in XML or JSON.

Scenario: A valid user calls web service to update an existing blockout in JSON format
	Given the user has "Administer Security" and "Schedule Content" permission
	And the blockout exist
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/json"
	Then the returned status code is 200 OK
	And the response message contains the job ID
	And the existing job is updated with given changes

	Examples:
		| username | password | 
		| admin | password | 
# Note: Irrespective of Accept header (XML or JSON), API always return the response in Text format. Documentation says that the response can be in XML or JSON.
		
Scenario: A non-existent user calls web service to update an existing blockout
	Given the User ID and/or Password are not valid/provided
	And the blockout exist
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	Then the returned status code is 401 Unauthorized
	And the response body contains header "HTTP Status 401 - Bad credentials"

	Examples:
		| username | password |
		| Emily | password |
		| Mike | password01 |
		| notAUser | wrong |
		| noPass  |        |
		|         | noUser |
		|         |        |

Scenario: A valid user calls web service to update an existing blockout in XML format but do not have "Administer Security" permission 
	Given the user has "Schedule Content" permission but do not have "Administer Security" permission 
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 403 Forbidden
	And the response body is empty
# Note: API call has returned 401 Unauthorized status code. Expecting 403 Forbidden as the user is valid but do not have "Administer Security" permission.

Scenario: A valid user calls web service to update an existing blockout in XML format but do not have "Schedule Content" permission 
	Given the user has "Administer Security" permission but do not have "Schedule Content" permission 
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 403 Forbidden
	And the response body is empty
# Note: API call has returned 500 Internal Server Error status code. Expecting 403 Forbidden as the user is valid but do not have "Schedule Content" permission.

Scenario: A valid user calls web service to update a blockout in XML format but the blockout doesn't exist
	Given the user has "Administer Security" and "Schedule Content" permission
	And the blockout doesn't exist
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 404 Not Found

	Examples:
		| username | password | 
		| admin | password | 
# Note: API call has returned 200 OK response and a new blockout is created and the response message contains the new job ID
		
Scenario: A valid user calls web service to update an existing blockout in XML format but updating the "Recurrence" from "Run Once" to "Daily"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a blockout with "Run Once" recurrence type exist
	And the new recurrence type is "Daily"
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the existing blockout is updated and "Recurrence" is set to "Daily"

Scenario: A valid user calls web service to update an existing blockout in XML format but updating the "Ends" type from "Duration" to "End Time" of "Run Once" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Run Once" blockout with "Ends" as "Duration" exist
	And the new Ends type is "End Time" and the value is "2 PM"
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the existing blockout is updated and the End type is set to "End Time" and the value is "2 PM"
	
Scenario: A valid user calls web service to update an existing blockout in XML format but updating the "Duration" of a "Daily" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Daily" recurrence blockout exist with duration 3 hours 20 min
	And the new "Duration" is 5 days 3 hours 30 min
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the existing blockout is updated and the "Duration" is set to 5 days 3 hours 30 min

Scenario: A valid user calls web service to update an existing blockout in XML format but updating the "Start Time" of a "Weekly" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Weekly" recurrence blockout exist with start time "2018-01-12T16:00:00-05:00"
	And the new "Start Time" is "2018-01-15T11:00:00-05:00"
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the existing blockout is updated and the "Start Time" is set to "2018-01-15T11:00:00-05:00"

Scenario: A valid user calls web service to update an existing blockout in XML format but updating the "Recurrence Pattern" of a "Daily" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Daily" recurrence blockout exist with "Recurrence Pattern" as "Every 5 days"
	And the new "Recurrence Pattern" is "Every Weekday"
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the existing blockout is updated and the "Recurrence Pattern" is set to "Every Weekday"

Scenario: A valid user calls web service to update an existing blockout in XML format but updating the "Recurrence Pattern" of a "Monthly" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Daily" recurrence blockout exist with "Recurrence Pattern" as "Day 16 of every month"
	And the new "Recurrence Pattern" is "The second Tuesday of every month"
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the existing blockout is updated and the "Recurrence Pattern" is set to "The second Tuesday of every month"
	
Scenario: A valid user calls web service to update an existing blockout in XML format but updating the "Range of Recurrence" of a "Yearly" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Yearly" recurrence blockout exist with "Range of Recurrence" as "No end date"
	And the new "Range of Recurrence" is "End by 1/18/18"
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the existing blockout is updated and the "Range of Recurrence" is set to "End by 1/18/18"
	
Scenario: A valid user calls web service to update an existing blockout in XML format but with invalid Time Zone for "Run Once" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Run Once" recurrence blockout exist with valid Time Zone
	And the new "timeZone" is "America/Arg" (invalid value)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And no change to the blockout time zone
# Note: API call has returned 200 OK.
	
Scenario: A valid user calls web service to update an existing blockout in XML format but invalid "Start Date" for "Run Once" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Run Once" recurrence blockout exist with valid "Start Date"
	And the new "Start Date" is "2018-45-31T10:51:00-05:00" (invalid month provided)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And no change to the block out start date
# Note: API call has returned 200 OK.

Scenario: A valid user calls web service to update an existing blockout in XML format but "Duration" is invalid for "Daily" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Daily" recurrence blockout exist with valid "Duration"
	And the new "Duration" is "wsfww#$#d"
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And no change to the blockout duration
# Note: API call has returned 200 OK code and changed the duration to "0" which is invalid

Scenario: A valid user calls web service to update an existing blockout in XML format but invalid "End Date" for "Monthly" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Monthly" recurrence blockout exist with valid "End Date"
	And the "End Date" is "2018-45-05T05:51:00-05:00" (invalid month)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And no changes to the existing blockout end date
# Note: API call has returned 200 OK.

Scenario: A valid user calls web service to update an existing blockout in XML format but invalid "Repeat Interval" for "Daily" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Daily" recurrence blockout exist with valid "repeatInterval"
	And the new "Repeat Interval" is "dsfwer" (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 401 Unauthorized and the existing blockout is removed. This might be a bug.
	
Scenario: A valid user calls web service to update an existing blockout in XML format but invalid "Days of Week" for "Daily" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Daily" recurrence blockout exist with valid "daysOfWeek"
	And the new "Days of Week" is set to 9 (9 is invalid. valid values are 0-6)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 401 Unauthorized and the existing blockout is removed. This might be a bug.

Scenario: A valid user calls web service to update an existing blockout in XML format but invalid "Days of Month" for "Monthly" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Monthly" recurrence blockout exist with valid "Days Of Month"
	And the new "Days of Month" is 43 (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 401 Unauthorized and the existing blockout is removed. This might be a bug.

Scenario: A valid user calls web service to update an existing blockout in XML format but invalid "Weeks of Month" for "Monthly" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Monthly" recurrence blockout exist with valid "Weeks of Month"
	And the "Weeks of Month" is 7 (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Internal Server Error and the existing blockout is removed. This might be a bug.

Scenario: A valid user calls web service to update an existing blockout in XML format but invalid "Months of Year" for "Yearly" recurrence
	Given the user has "Administer Security" and "Schedule Content" permission 
	And a "Monthly" recurrence blockout exist with valid "monthsOfYear"
	And the new "Months of Year" is "15" (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Internal Server Error and the existing blockout is removed. This might be a bug.

Scenario: A valid user calls web service to update an existing blockout created by an another user in XML format
	Given the user has "Administer Security" and "Schedule Content" permission
	And the blockout exist
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/update?jobid=<jobid>"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message contains the job ID
	And the existing job is updated with given changes