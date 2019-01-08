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

# GET Method
Scenario Outline: <User> calls the web service to retrieve the list of files within their home workspace directory that were generated from a schedule with the lineageId <LineageId>.
	Given <User> has read permissions
	And a schedule with the lineageId <LineageId> exists
	And a schedule with the lineageId <LineageId> has generated content within the directory /home/<User>/workspace
	When <User> calls the web service
	Then the status code is 200
	And the response body contains "<repositoryFileDto>"
	And the metadata of each file listed within the response body contains the "lineage-id" property value of <LineageId>
Examples:
	| User | LineageId |
	| admin | 5437f2d6-f0e1-4eb6-b479-90e665ab580a |
	| suzy | b18f6206-878f-4141-915b-4a5a630847ff |
	
Scenario: The user calls the web service to retrieve the list of files in JSON format within their home workspace directory that were generated from a schedule.
	Given the user has read permissions
	And the schedule with the specified lineageId exists
	And the schedule has generated content within the user's workspace directory
	When the user calls the web service with the Accept header value "application/json"
	Then the status code is 200
	And the response body contains the following:
		"repositoryFileDto":
	And the metadata of each file listed within the response body contains the "lineage-id" property value that matches the value of the query parameter used in the request.
	
Scenario: The user calls the web service to retrieve the list of files within their home workspace directory that were generated from a schedule, but no content has been generated.
	Given the user has read permissions
	And the schedule with the specified lineageId exists
	And the schedule does not have generated content within the user's workspace directory
	When the user calls the web service
	Then the status code is 200
	And the response body contains "<repositoryFileDtoes>"
	But the response body does not contain "<repositoryFileDto>"
	
Scenario: The user calls the web service to retrieve the list of files within their home workspace directory that were generated from a schedule, but the user does not have read permissions.
	Given the user does not have read permissions
	And the schedule with the specified lineageId exists
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain "<repositoryFileDtoes>"
	
Scenario: The user calls the web service to retrieve the list of files within their home workspace directory that were generated from a schedule, but the does not include the lineageId query parameter in the request.
	Given the user has read permissions
	When the user calls the web service without including the lineageId query parameter
	Then the status code is 400
	And the response body does not contain "<repositoryFileDtoes>"
	
Scenario: The user calls the web service to retrieve the list of files within their home workspace directory that were generated from a schedule, but the does not include a value for the lineageId query parameter in the request.
	Given the user has read permissions
	When the user calls the web service with the lineageId query parameter, but without a value
	Then the status code is 400
	And the response body does not contain "<repositoryFileDtoes>"
	
Scenario: The user calls the web service to retrieve the list of files within their home workspace directory that were generated from a schedule, but no schedule with the specified lineageId exists.
	Given the user has read permissions
	When the user calls the web service with the lineageId query parameter set to a value that does not exist
	Then the status code is 404
	And the response body does not contain "<repositoryFileDtoes>"
	
Scenario: The anonymous user calls the web service to retrieve the list of files that were generated from a schedule.
	Given the schedule with the specified lineageId exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the response body does not contain "<repositoryFileDtoes>"