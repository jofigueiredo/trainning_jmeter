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
# POST method - Creates a new scheduled job - pentaho/api/scheduler/job
# ========================================================================================================
Scenario: A valid user calls web service to create a new scheduled job in XML format
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the POST data include all valid input
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id.
	And a scheduled job created with the job name given in the request payload
	
	Examples:
		| username | password | jobName |
		| admin | password | AdminScheduleTest1 |
		| suzy | password | SuzyScheduleTest2 |
		| admin | password | Admin~`!@#$%^*()_-+=|\}]{[""':;?/.>,<& |
		| suzy | password | Suzy~`!@#$%^*()_-+=|\}]{[""':;?/.>,<& |

Scenario: A valid user calls web service to create a new scheduled job in JSON format
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the POST data include all valid input
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/json"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And a scheduled job created with the job name given in the request payload
		Examples:
		| username | password | jobName |
		| admin | password | AdminScheduleTest1 |
		| suzy | password | SuzyScheduleTest2 |
		| admin | password | Admin~`!@#$%^*()_-+=|\}]{[""':;?/.>,<& |
		| suzy | password | Suzy~`!@#$%^*()_-+=|\}]{[""':;?/.>,<& |
		
Scenario: Admin user calls web service to create a new scheduled job in XML format but no value provided for job name (<jobName>)
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And no value provided for <jobName>
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id. 
	And the "Schedule Name" is set to "Top Customers (report)" as default
	
Scenario: Admin user calls web service to create a new scheduled job in XML format but invalid special characters "&<" in the job name field
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the job name is "&<" 
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And the response body is empty

Scenario: Admin user calls web service to create a new scheduled job in XML format but a schedule with given job name already exists (<jobName>)
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the scheduled job "AdminScheduleTest1" is already exists
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id. 
	And a new scheduled job created with same name as "AdminScheduleTest1" 

Scenario: Admin user calls web service to create a new scheduled job in XML format, but no value provided for "outputFile" (<outputFile> tag)
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And no value provided for "Output File" 
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id. 
	And the output file location is set to user's home folder as default, i.e, /home/admin

Scenario: Admin user calls web service to create a new scheduled job in XML format, but invalid output location provided for "outputFile" (<outputFile> tag)
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the "Output File" value is "/home/adm"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id. 
	And the output file location is set to user's home folder as default, i.e, /home/admin

Scenario: Admin user calls web service to create a new scheduled job in XML format but the "Recurrence Pattern" (<repeatInterval>) is greater than or equal to 60 seconds
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the <recurrenceInterval> is 60 seconds
	And no value provided for "uiPassParam" 
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id. 
	And the "Recurrence" is set to "MINUTES"
	And the "Recurrence Pattern" is set to 1 minutes

Scenario: Admin user calls web service to create a new scheduled job in XML format but the "Recurrence Pattern" (<repeatInterval>) is less than 60 seconds
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the <recurrenceInterval> is 45 seconds
	And no value provided for "uiPassParam" 
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id. 
	And the "Recurrence" is set to "SECONDS" 
	And the "Recurrence Pattern" is set to 45 seconds

Scenario: Admin user calls web service to create a new scheduled job in XML format but the "Recurrence Pattern" (<repeatInterval>) is greater than or equal to 3600 seconds
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the <recurrenceInterval> is 3600 seconds
	And no value provided for "uiPassParam" 
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id.
	And the "Recurrence" is set to "HOURS"
	And the "Recurrence Pattern" is set to 1 hour

Scenario: Admin user calls web service to create a new scheduled job in XML format but the "Recurrence Pattern" (<repeatInterval>) is less than 1 seconds
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the <recurrenceInterval> is 0 seconds
	And no value provided for "uiPassParam" 
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And the response shows an error message "Repeat Interval cannot be zero."
# Note: API returned 500 code which is not expected. Expecting 400 Bad Request response as the payload contains invalid data

Scenario: Admin user calls web service to create a new scheduled job in XML format but the <repeatCount> is greater than -1
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the <repeatCount> is 5
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the Repeat count set to 5 

Scenario: Admin user calls web service to create a new scheduled job in XML format but the <repeatCount> is -1
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the <repeatCount> is -1
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the job created with no repeat for the recurrence pattern

Scenario: Admin user calls web service to create a new scheduled job in XML format but the <repeatCount> is invalid
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the job created with no repeat for the recurrence pattern
Examples:
	| repeatCount |
	| ab |
	| #4 |
	
Scenario: Admin user calls web service to create a new scheduled job in XML format but with invalid source file location
	Given the input source file is invalid ( <inputFile>/public/Steel Wheels/Customers (report).prpt</inputFile> )
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And the response body contains error message "Cannot find input source file /public/Steel Wheels/Customers (report).prpt"
# Note: API returned 500 code which is not expected. Expecting 400 Bad Request response as the payload has incorrect value.

Scenario: Admin user calls web service to create a new scheduled job in XML format but with invalid "Start Time" (<startTime>) value 
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the <startTime> value is invalid ( <startTime>2018T12:30:00.000-05:00</startTime> )
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Start Time" and "Range of Recurrence" Start are set to current date and time as default

Scenario: Admin user calls web service to create a new scheduled job in XML format but with valid "End Time" (<endTime>) value
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the <endDate> is valid ( <endTime>2017-12-30T11:00:00.000-05:00</endTime> )
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "End By" value is set to 2017-12-30

Scenario: Admin user calls web service to create a new scheduled job in XML format but with invalid <endTime> value 
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the <endTime> is invalid ( <endTime>2017-15-30T29:00:00.000-05:00</endTime> )
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id. "admin	AdminScheduleTest1 1512058617432"
	And the "Range of Recurrence" is set to "No end date"
	
Scenario: Pat user calls web service to create a new scheduled job in XML format but do not have "Schedule Content" permission
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And Pat user do not have "Schedule Content" permission
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 403 Forbidden
	And the response body is empty

Scenario: An non-existent user calls web service to create a new scheduled job in XML format
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the User name and password are invalid
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 401 Unauthorized
	And the response body contains text "HTTP Status 401 - Bad credentials"

	Examples:
		| username | password |
		| Emily | password |
		| Mike | password01 |
		| notUser | wrongPassword |
		| noPass  |        |
		|         | noUser |
		|         |        |
		
Scenario: Admin user calls web service to create a new scheduled job in XML format using Job parameters
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And valid values set for parameters "sLine", "sMarket", "sYear", "TopCount" and "output-target"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the parameter values are set as given in the request payload
	
	Examples:
		| sLine | sMarket | sYear | TopCount | output-target |
		| [Product].[All Products].[Planes] | [Markets].[All Markets].[Japan] | [Time].[All Years].[2004] | 5 | pageable/pdf |
		| [Product].[All Products].[Classic Cars] | [Markets].[All Markets].[EMEA] | [Time].[All Years].[2003] | 3 | pageable/HTML |
		| [Product].[All Products].[Trains] | [Markets].[All Markets].[NA] | [Time].[All Years].[2004] | 10 | Excel |
		
Scenario: Admin user calls web service to create a new scheduled job in XML format using invalid value for the job parameters
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And invalid values for job parameters
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API returned 200 OK response which is not expected. Expecting 400 Bad Request response as the payload has incorrect parameter value.

	Examples:
		| sLine | sYear |
		| [Product].[All Products].[Plan] | [Time].[All Years].[2004] |
		| [Product].[All Products].[Planes] | [Time].[All Years].[56] |
				
Scenario: Admin user calls web service to create a new scheduled job in XML format and configuring email parameters to send scheduled report
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And valid values for email parameters
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the email report configurations are saved for the created job
	
	Examples:
		| showParameters | _SCH_EMAIL_MESSAGE | _SCH_EMAIL_TO | _SCH_EMAIL_SUBJECT | _SCH_EMAIL_ATTACHMENT_NAME |
		| true | testrequest | pentaho.auto.qa@gmail.com | Report successfully created! | Top Customers (report)_testout and test request |
		| true | Inventory Report is generated | reportstatus@gmail.com | Report successfully created! | Inventory List (report)_testout and test request |
	
Scenario: Admin user calls web service to create a new scheduled job in XML format and enabling email configuration but not providing "Subject" and "Attachment name" configurations
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the job name is "AdminScheduleTest1"
	And the email "To" configuration is set to "pentaho.auto.qa@gmail.com"
	And no value provided for "Subject" configuration
	And no value provided for "Attachment name"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the email "Subject" set to "Top Customers (report) schedule has successfully run." as default
	And the email "Attachment name" set to "AdminScheduleTest1" which is the job name
	
Scenario: Admin user calls web service to create a new scheduled job in XML format using "Recurrence" as "Run Once"
	Given the input source file exists (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "RUN_ONCE"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Run Once"
	
Scenario: Admin user calls web service to create a new scheduled job in XML format using "Recurrence" as "Seconds"
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "SECONDS"
	And the "repeatInterval" is 30 seconds
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Seconds" and "Recurrence Pattern" set to every 30 seconds
	
Scenario: Admin user calls web service to create a new scheduled job in XML format using "Recurrence" as "Hours"
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "HOURS"
	And the "repeatInterval" is 7200 seconds
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Hours" and "Recurrence Pattern" set to every 2 hour(s)

Scenario: Admin user calls web service to create a new scheduled job in XML format using "Recurrence" as "Daily"
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "DAILY"
	And the "repeatInterval" is 432000 seconds
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Daily"
	And the "Recurrence Pattern" set to "Every 5 days"

Scenario: Admin user calls web service to create a new scheduled job in XML format using "Recurrence" as "Daily" and "Recurrence Pattern" is "Every weekday"
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "WEEKLY"
	And the "daysOfWeek" is set to "1,2,3,4,5"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Daily"
	And the "Recurrence Pattern" set to "Every Weekday"

Scenario: Admin user calls web service to create a new scheduled job in XML format using "Recurrence" as "Daily" but <repeatInterval> is less than a day
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "DAILY"
	And the "repeatInterval" is 43200 seconds
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Hours"
	And the "Recurrence Pattern" set to "Every 12 hours"

Scenario: Admin user calls web service to create a new scheduled job in XML format using "Recurrence" as "Weekly"
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "WEEKLY"
	And the "daysOfWeek" is "5" and "6"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Weekly"
	And the "Recurrence Pattern" set to "Friday" and "Saturday"

Scenario: Admin user calls web service to create a new scheduled job in XML format using "Recurrence" as "Weekly" but invalid value provided for <daysOfWeek> 
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "WEEKLY"
	And the "daysOfWeek" is "9"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And the response body shows the error message "Day-of-Week values must be between 1 and 7" 
# Note: API call returned 500 Internal server error which is not expected. Expecting 400 Bad Request as the day of week value is invalid.
# Also, the returned error message shows Day-of-Week values must be between 1 to 7. But the API accepts only values between 0-6 (Sunday to Saturday). Expecting the error message as "Day-of-Week values must be between 0 and 6"

Scenario: Admin user calls web service to create a new scheduled job in XML format but "Recurrence" is "MONTHLY"
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "MONTHLY"
	And the "daysOfMonth" is "16"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Monthly" 
	And the day of month is set to 16

Scenario: Admin user calls web service to create a new scheduled job as "MONTHLY" recurrence using <weeksOfMonth> as third and <daysOfWeek> as "Thursday"
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "MONTHLY"
	And the "weeksOfMonth" is "2"
	And the "daysOfWeek" is "4"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence Pattern" is set to "The third Thursday of every month"
	
Scenario: Admin user calls web service to create a new scheduled job in XML format as "Monthly" recurrence but invalid value provided for <daysOfMonth>
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "MONTHLY"
	And the "daysOfMonth" is "42"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And the response body contains error message "Day of month values must be between 1 and 31"
# Note: API call returned response code is 500 Internal Server Error which is not expected. Expecting 400 Bad Request response code as invalid value provided for <daysOfMonth>

Scenario: Admin user calls web service to create a new scheduled job as "MONTHLY" recurrence but invalid value for <weeksOfMonth> (valid values are 0,1,2,3, and 4)
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "MONTHLY"
	And the "weeksOfMonth" is "7" (invalid)
	And the "daysOfWeek" is "4"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call returned 500 Internal Server Error response code which is not expected. Expecting 400 Bad Request response code as invalid value provided for <weeksOfMonth>

Scenario: Admin user calls web service to create a new scheduled job as "MONTHLY" recurrence but invalid value for <daysOfWeek> (valid values are 0,1,2,3,4,5, and 6)
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "MONTHLY"
	And the "weeksOfMonth" is "2"
	And the "daysOfWeek" is "9" (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call returned 500 Internal Server Error response code which is not expected. Expecting 400 Bad Request response code as invalid value provided for <daysOfWeek>

Scenario: Admin user calls web service to create a new scheduled job as "MONTHLY" recurrence but invalid <weeksOfMonth>, <startTime> and <endTime> combination (weeks of month is not valid for the given date range)
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "MONTHLY"
	And the "weeksOfMonth" is "4"
	And the "daysOfWeek" is "3" 
	And the "startTime" is "2017-12-12T13:23:00.000-05:00"
	And the "endTime" is "2017-12-23T23:59:59.000-05:00"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And the response body contains error message "Based on configured schedule, the given trigger will never fire"
# Note: API call returned 500 Internal Server Error response code which is not expected. Expecting 400 Bad Request response code as weeks of month is not valid for the given date range

Scenario: Admin user calls web service to create a new scheduled job in XML format but "Recurrence" is "Yearly" and using <monthsOfYear> and <daysOfMonth>
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "YEARLY"
	And the "monthsOfYear" is "4"
	And the "daysOfMonth" is "25"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Yearly" 
	And the "Recurrence Pattern" is set to "Every May 25"

Scenario: Admin user calls web service to create a new scheduled job in XML format but "Recurrence" is "Yearly" and using <weeksOfMonth>, <daysOfWeek>, <monthsOfYear>
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "YEARLY"
	And the "weeksOfMonth" is "4"
	And the "daysOfWeek" is "3"
	And the "monthsOfYear" is "8"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Yearly" 
	And the "Recurrence Pattern" is set to "The last Wednesday of September"

Scenario: Admin user calls web service to create a new scheduled job in "YEARLY" recurrence but invalid value provided for <monthsOfYear>
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "YEARLY"
	And the "weeksOfMonth" is "4"
	And the "daysOfWeek" is "3"
	And the "monthsOfYear" is "15" (invalid)
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And the response body shows error message "Month values must be between 1 and 12"
# Note: API call returned 500 internal server error which is not expected. Expecting 400 Bad Request response code as invalid value provided for <monthsOfYear>

Scenario: Admin user calls web service to create a new scheduled job in "YEARLY" recurrence but invalid combination of <monthsOfYear>, <startTime> and <endTime>
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "YEARLY"
	And the "weeksOfMonth" is "3"
	And the "daysOfWeek" is "4"
	And the "monthsOfYear" is "8" 
	And the "startTime" is "2017-12-15T13:23:00.000-05:00"
	And the "endTime" is "2018-05-31T23:59:59.000-05:00"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
	And the response body shows error message "Based on configured schedule, the given trigger will never fire."
# Note: API call returned 500 internal server error which is not expected. Expecting 400 Bad Request response code as invalid combination of <monthsOfYear>, <startTime> and <endTime> provided

Scenario: Admin user calls web service to create a new scheduled job in XML format but "Recurrence" is "Cron"
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "CRON"
	And the "weeksOfMonth" is "3"
	And the "daysOfWeek" is "4"
	And the "monthsOfYear" is "8" 
	And the "startTime" is "2017-12-15T18:45:00.000-05:00"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Recurrence" type is set to "Cron"
	And the Cron string set to "0 45 18 ? 9 5#4 *"

Scenario: Admin user calls web service to create a new scheduled job in XML format but "Recurrence" is "Cron" and using invalid recurrence pattern values 
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "uiPassParam" is "CRON"
	And the "weeksOfMonth" is "8" (invalid)
	And the "daysOfWeek" is "4"
	And the "monthsOfYear" is "8" 
	And the "startTime" is "2017-12-15T18:45:00.000-05:00"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 400 Bad Request
# Note: API call returned 500 Internal Server Error which is not expected. Expecting 400 Bad Request response code as invalid value provided fro <weeksOfMonth>
	
Scenario: Admin user calls web service to create a new scheduled job in XML format but the selected file doesn't support Schedule option (for eg., a dashboard)
	Given the input source file exists  (/public/Steel Wheels/Sales Performance(dashboard).xdash)
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 403 Forbidden (Cannot create schedules for the specified file)
# Note: API call returned 200 OK response and schedule got created. This might be a product bug.

Scenario: Admin user calls web service to create a new scheduled job in JSON format but with various parameters
	Given the input source file exists  (/public/Steel Wheels/Top Customers (report).prpt)
	And the "jobName" is "AdminScheduleTest1"
	When a HTTP POST request sent to "pentaho/api/scheduler/job"
	And the Content-Type header is set to "application/json"
	Then the returned status code is 200 OK
	And the response body contains User name, Job name and Job id
	And the "Schedule Name" is updated as "AdminScheduleTest1"

	Examples:
		| sLine | sMarket | sYear | TopCount | output-target |
		| [Product].[All Products].[Planes] | [Markets].[All Markets].[Japan] | [Time].[All Years].[2004] | 5 | pageable/pdf |
		| [Product].[All Products].[Classic Cars] | [Markets].[All Markets].[EMEA] | [Time].[All Years].[2003] | 3 | pageable/HTML |
		| [Product].[All Products].[Trains] | [Markets].[All Markets].[NA] | [Time].[All Years].[2004] | 10 | Excel |