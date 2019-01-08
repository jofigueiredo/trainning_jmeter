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
# POST method - Creates a new blockout for scheduled jobs - pentaho/api/scheduler/blockout/add
# ========================================================================================================
Scenario: A valid user calls web service to add a blockout in XML format
	Given the user has "Administer Security" and "Schedule Content" permission 
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response message contains the job ID 

	Examples:
		| username | password | 
		| admin | password | 
# Note: Irrespective of Accept header (XML or JSON), API always return the response in Text format. As per documentation, the response can be in XML or JSON.

Scenario: A valid user calls web service to add a blockout in JSON format
	Given the user has "Administer Security" and "Schedule Content" permission 
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/json"
	Then the returned status code is 200 OK
	And the response message contains the job ID

	Examples:
		| username | password | 
		| admin | password | 
# Note: Irrespective of Accept header (XML or JSON), API always return the response in Text format. As per documentation, the response can be in XML or JSON.
		
Scenario: A non-existent user calls web service to add a blockout in XML format 
	Given the User ID and/or Password are not valid/provided
	When a HTTP GET request sent to "pentaho/api/scheduler/getJobs"
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

Scenario: A valid user calls web service to add blockout in JSON format but do not have "Administer Security" permission 
	Given the user has "Schedule Content" permission but do not have "Administer Security" permission 
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/json"
	Then the returned status code is 403 Forbidden
	And the response body is empty
# Note: API call has returned 401 Unauthorized status code. Expecting 403 Forbidden as the user is valid but do not have "Administer Security" permission.

Scenario: A valid user calls web service to add a blockout in XML format but do not have "Schedule Content" permission 
	Given the user has "Administer Security" permission but do not have "Schedule Content" permission 
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add" 
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 403 Forbidden
	And the response body is empty
# Note: API call has returned 500 Internal Server Error status code. Expecting 403 Forbidden as the user is valid but do not have "Schedule Content" permission.

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Run Once" with "Duration" 
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "RUN_ONCE"
	And the "Start Time" is "2018-01-12T15:00:00-05:00"
	And the "Duration" is "462600000" (5 days - 8 hours - 30 min)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Run Once"
	And the "Start Time" is set to "Fri, Jan 12 3:00 PM"
	And the "Duration" is set to "5 days - 8 hours - 30 min"

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Run Once" with "End Time"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "RUN_ONCE"
	And the "End Time" is "T16:00:00-05:00"
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Run Once"
	And the "End Time" is set to "4 PM"

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Run Once" and Time Zone is "America/Argentina/Tucuman"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "RUN_ONCE"
	And the "Start Time" is "2018-01-12T15:00:00-05:00"
	And the "Time Zone" is "America/Argentina/Tucuman"
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the time zone is set to local time zone as "Eastern Daylight Time (UTC-500)" and the "Start Time" is converted based on local time zone as Fri, Jan 12 3:00 PM

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Run Once" and Time Zone is invalid 
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "RUN_ONCE"
	And the "Start Time" is "2018-01-12T15:00:00-05:00"
	And the "timeZone" is "America/Arg" (invalid value)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 200 OK response and the time zone is set to local time zone as "Eastern Daylight Time (UTC-500)" without any conversion which is "Fri, Jan 12 3:00 PM"

Scenario: A valid user calls web service to add a blockout and "Recurrence" is "Run Once" but "Start Time" is invalid
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "RUN_ONCE"
	And the "Start Time" is "2018-45-31T10:51:00-05:00" (invalid Month provided)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has retunred 200 OK and set the start date as current date.

Scenario: A valid user calls web service to add a blockout and "Recurrence" is "Run Once" but "Duration" is invalid
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "RUN_ONCE"
	And the "Duration" is "wrewr32" (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 200 OK code and Duration is set to 0 which is invalid

Scenario: A valid user calls web service to add a blockout and "Recurrence" is "Run Once" but "End Date" is invalid
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "RUN_ONCE"
	And the "End Date" is "2018-45-05T05:51:00-05:00" (invalid month)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 200 OK and the "Range of Recurrence" is set to "No end date"

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Daily" with "Duration" and "Recurrence Pattern" is "Every 9 days"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "DAILY"
	And the "Duration" is "25800000" (7 hours - 10 min)
	And the "Repeat Interval" is "777600" (9 days)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Daily"
	And the "Duration" is set to "7 hours - 10 min"
	And the "Recurrence Pattern" is set to "Every 9 days"

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Daily" with "Duration" and invalid "Repeat Interval"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "DAILY"
	And the "Duration" is "25800000" (7 hours - 10 min)
	And the "repeatInterval" is "dsfwer" (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 401 Unauthorized
	
Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Daily" with "Duration" and "Recurrence Pattern" is "Every week"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "DAILY"
	And the "Duration" is "25800000" (7 hours - 10 min)
	And the "Days of Week" is set to 1,2,3,4, and 5 (Monday to Friday)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Daily"
	And the "Duration" is set to "7 hours - 10 min"
	And the "Recurrence Pattern" is set to "Every Week"

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Daily" with a valid "End Date"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "DAILY"
	And the "End Date" is "2018-01-18T13:00:00-05:00"
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Daily"
	And the "End Date" is set to "Thu, Jan 18"

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Daily" and "Days of Week" is invalid
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "DAILY"
	And the "Days of Week" is set to 9 (9 is invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 401 Unauthorized.
	
Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Weekly" with "endTime" and "daysOfWeek"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Weekly"
	And the "End Date" is "2018-01-18T13:00:00-05:00"
	And the "Days of Week" is 2,3 and 4 (Tuesday, Wednesday and Thursday)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Weekly"
	And the "End Date" is set to "Thu, Jan 18 1 PM"
	And the "Recurrence Pattern" is set to "Tuesday", "Wednesday" and "Thursday"
	
Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Monthly" with "Duration" and "Day ...of every month"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Monthly"
	And the "Duration" is "462600000" (5 days - 8 hours - 30 min)
	And the "daysOfMonth" is 16
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Monthly"
	And the "Duration" is set to "5 days - 8 hours - 30 min"
	And the "Recurrence Pattern" is set to "Day 16 of every month"
	
Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Monthly" with "End Date" and "Day ...of every month"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Monthly"
	And the "End Date" is "2018-01-18T13:00:00-05:00"
	And the "Days of Month" is 16
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Monthly"
	And the "End Date" is set to "Thu, Jan 18 1 PM"
	And the "Recurrence Pattern" is set to "Day 16 of every month"
	
Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Monthly" with "Week of month" and "day of week"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Monthly"
	And the "Weeks of Month" is 2 (2nd week of a month)
	And the "Days of Week" is 4 (Wednesday)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Monthly"
	And the "Recurrence Pattern" is set to "The Second week Wednesday of every month"
	
Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Monthly" with invalid "Days of Month"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Monthly"
	And the "Days of Month" is 43 (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 401 Unauthorized.

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Monthly" with invalid "Weeks Of Month"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Monthly"
	And the "Weeks of Month" is 7 (invalid)
	And the "Days of Week" is 4 (Wednesday)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Internal Server Error.

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Monthly" with invalid "Days of Week"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Monthly"
	And the "Weeks Of Month" is 3 
	And the "Days of Week" is 12 (Invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Internal Server Error.

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Yearly" and "Months of Year" and "Days of Month"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Yearly"
	And the "Months of Year" is "4"
	And the "Days of Month" is 15
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Yearly"
	And the "Recurrence Pattern" is set to "Every April 15"

Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Yearly" with "End Date" and "Months of Year" and "Days of Month"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Yearly"
	And the "End Date" is "2018-01-18T13:00:00-05:00"
	And the "Months of Year" is "4"
	And the "Days of Month" is 15
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Yearly"
	And the "End Date" is set to "Thu, Jan 18 1 PM"
	And the "Recurrence Pattern" is set to "Every April 15"
	
Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Yearly" with "Weeks of Month" and "Days of Week" and "Months of Year"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Yearly"
	And the "Months of Year" is "4"
	And the "Days of Week" is "0" (Sunday)
	And the "Weeks of Month" is 3
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the "Recurrence" is set to "Yearly"
	And the "Recurrence Pattern" is set to "The third week Sunday of April"
	
Scenario: A valid user calls web service to add a blockout in XML format but the "Recurrence" is "Yearly" with invalid "Months of Year"
	Given the user has "Administer Security" and "Schedule Content" permission 
	And the "Recurrence" is "Yearly"
	And the "Months of Year" is "15" (invalid)
	And the "Days of Week" is "0" (Sunday)
	And the "Weeks of Month" is 3
	When a HTTP POST request sent to "pentaho/api/scheduler/blockout/add"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call has returned 500 Internal Server Error