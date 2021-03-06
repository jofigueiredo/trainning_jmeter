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
# GET method - Retrieve the list of execute content by lineage id - pentaho/api/scheduler/generatedContentForSchedule?lineageId=<lineageId>
# ==========================================================================================================================================
Scenario: A valid <user> calls web service to Retrieve the list of execute content by lineage id in <Format> format
	Given the repository file exists 
	When a HTTP GET request sent to "pentaho/api/scheduler/generatedContentForSchedule?lineageId=<lineageId>" using Accept header <HeaderValue>
	Then the returned status code is 200 OK
	And the response message contains list of repository file dto objects in <Format> format

	Examples:
		| user | password | Format | HeaderValue |
		| admin | password | XML | application/xml |
		| admin | password | JSON | application/json |
		| suzy | password | XML | application/xml |
		| suzy | password | JSON | application/json |
		| pat | password | XML | application/xml |
		| pat | password | JSON | application/json |
		
Scenario: A valid user calls web service to Retrieve the list of execute content by lineage id, but the lineageId is invalid
	Given the content is generated 
	And the lineageId is invalid
	When a HTTP GET request sent to "pentaho/api/scheduler/generatedContentForSchedule?lineageId=<lineageId>"
	Then the returned status code is 404 Not Found
# Note: API call has returned 200 OK with empty <repositoryFileDtoes>.

Scenario: A valid user calls web service to Retrieve the list of execute content by valid lineage id, but no content was generated
	Given the lineageId is valid
	And no content is generated in the repository
	When a HTTP GET request sent to "pentaho/api/scheduler/generatedContentForSchedule?lineageId=<lineageId>"
	Then the returned status code is 204 No Content
# Note: API call has returned 200 OK with empty <repositoryFileDtoes>.

Scenario: A valid <user> calls web service to Retrieve the list of execute content by valid lineage id, but the content was generated by <anotheruser> in the <workspacedir>
	Given the lineageId is valid
	And the content is generated by another user in the <workspacedir>
	When a HTTP GET request sent to "pentaho/api/scheduler/generatedContentForSchedule?lineageId=<lineageId>"
	Then the returned status code is 403 Forbidden
# Note: API call has returned 200 OK with empty <repositoryFileDtoes>.

	Examples:
		| user | anotheruser | workspacedir | 
		| admin | suzy | /home/suzy/workspace |
		| suzy | admin | JSON | /home/admin/workspace |
		
Scenario: A non-existent <user> calls web service to Retrieve the list of execute content by lineage id
	Given the <user> and/or <password> are not valid/provided
	When a HTTP GET request sent to "pentaho/api/scheduler/generatedContentForSchedule?lineageId=<lineageId>"
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