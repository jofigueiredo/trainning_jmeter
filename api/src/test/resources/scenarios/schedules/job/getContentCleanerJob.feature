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

# ==========================================================================================================================================
# GET method - Get the scheduled job created by the system for deleting generated files - pentaho/api/scheduler/getContentCleanerJob
# ==========================================================================================================================================
Scenario: A valid <user> calls web service to get the definition of content cleaner job in <Format> format
	Given the content cleaner job exists
	And the user has "Administer Security" permission
	When a HTTP GET request sent to "pentaho/api/scheduler/getContentCleanerJob" using the Accept header <HeaderValue>
	Then the returned status code is 200 OK
	And the response message contains the definition of content cleaner job in <Format> format

	Examples:
		| user | password | Format | HeaderValue |
		| admin | password | XML | application/xml |
		| admin | password | JSON | application/json |
		| suzy | password | XML | application/xml |
		| suzy | password | JSON | application/json |
		| pat | password | XML | application/xml |
		| pat | password | JSON | application/json |
		
Scenario: A valid user calls web service to get the definition of content cleaner job, but the content cleaner job doesn't exist
	Given the content cleaner job doesn't exists
	And the user has "Administer Security" permission
	When a HTTP GET request sent to "pentaho/api/scheduler/getContentCleanerJob" 
	Then the returned status code is 204 No Content
	And the response body is empty
	
Scenario: A valid user calls web service to get the definition of content cleaner job, but the user do not have "Administer Security" permission
	Given the content cleaner job exists
	And the user do not have "Administer Security" permission
	When a HTTP GET request sent to "pentaho/api/scheduler/getContentCleanerJob" 
	Then the returned status code is 403 Forbidden
		
Scenario: A non-existent <user> calls web service to get the definition of content cleaner job
	Given the <user> and/or <password> are not valid/provided
	When a HTTP GET request sent to "pentaho/api/scheduler/getContentCleanerJob"
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