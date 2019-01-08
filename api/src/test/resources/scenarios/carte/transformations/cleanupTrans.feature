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

# GET and POST Methods
# Both methods can be used using the same parameters. Both have the same expected results.
# Note: The results of what this endpoint does are not exposed to the API. The transformation status remains the same before and after cleanup. Therefore, the test scenarios only consider validations using what is exposed.

Scenario Outline: The user calls the web service to cleanup a transformation using the name parameter.
	Given the transformation exists on Carte server
	And the name of the transformation is unique
	When the user calls the web service
	And the name parameter is set to <name>
	Then the status code is 200
	And the response body is in HTML format
Examples:
	| name |
	| LoadData |
	| LoadData2 |
	| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
	
Scenario: The user calls the web service to cleanup a transformation using the name and id parameters.
	Given the transformation exists on Carte server
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the response body is in HTML format
	
Scenario Outline: The user calls the web service to cleanup a transformation using the name and xml parameters.
	Given the transformation exists on Carte server
	And the name of the transformation is unique
	When the user calls the web service
	And the name parameter is set to <name>
	And the xml is set to <xml>
	Then the status code is 200
	And the response body is in <responseFormat> format
Examples:
	| name | xml | responseFormat |
	| LoadData | N | HTML |
	| LoadData | Y | XML |
	
Scenario Outline: The user calls the web service to cleanup a transformation using the name, id, and xml parameters.
	Given the transformation exists on Carte server
	When the user calls the web service 
	And the name parameter is set to <name>
	And the id parameter is set to <id>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the response body is in <responseFormat> format
Examples:
	| name | id | xml | responseFormat |
	| LoadData10 | 665c5b50-6cc9-4768-b703-af13a378ca8d | N | HTML |
	| LoadData11 | 9bfb851b-c096-453d-8110-b8292de50208 | Y | XML |
	
Scenario: The user calls the web service to cleanup a transformation using the id parameter.
	Given the transformation exists on Carte server
	When the user calls the web service using the id parameter
	Then the status code is 200
	And the response body is in HTML format
	
Scenario Outline: The user calls the web service to cleanup a transformation using the id and xml parameters.
	Given the transformation exists on Carte server
	When the user calls the web service 
	And the id parameter is set to <id>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the response body is in <responseFormat> format
Examples:
	| id | xml | responseFormat |
	| b6322b9f-bc2f-4797-9dc2-3ae542a10e11 | N | | HTML |
	| c88b5fce-7f15-44cc-bb1f-753beadef7d9 | Y | | XML |
	
Scenario: The user calls the web service to cleanup a transformation by name and id, but two different transformations exist with the same name.
	Given the specified name is ambiguous
	When the user calls the web service
	Then the status code is 200
	
Scenario: The user calls the web service to cleanup a transformation using the name and sockets parameters.
	Given the specified transformation is present on Carte server
	When the user calls the web service
	And the name parameter is set to <name>
	And the sockets parameter is set to <sockets>
	Then the status code is 200
Examples:
	| name | sockets |
	| LoadData2 | Y |
	| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| | N |
	
Scenario: The user calls the web service to cleanup a transformation using the id and sockets parameters.
	Given the specified transformation is present on Carte server
	When the user calls the web service
	And the id parameter is set to <id>
	And the sockets parameter is set to <sockets>
	Then the status code is 200
Examples:
	| id | sockets |
	| b6322b9f-bc2f-4797-9dc2-3ae542a10e11 | Y |
	| c88b5fce-7f15-44cc-bb1f-753beadef7d9 | N |
	
Scenario: The user calls the web service to cleanup a transformation using the name, id, and sockets parameters.
	Given the specified transformation is present on Carte server
	When the user calls the web service
	And the name parameter is set to <name>
	And the id parameter is set to <id>
	And the sockets parameter is set to <sockets>
	Then the status code is 200
Examples:
	| name | id | sockets |
	| LoadData2 | b6322b9f-bc2f-4797-9dc2-3ae542a10e11 | Y |
	| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| | c88b5fce-7f15-44cc-bb1f-753beadef7d9 | N |
	
Scenario: The anonymous user calls the web service to cleanup a transformation.
	Given the specified transformation is present on Carte server
	When the anonymous user calls the web service
	Then the status code is 401
	
Scenario Outline: The user calls the web service to cleanup a transformation that does not exist
	Given the transformation does not exist
	When the user calls the web service using the parameters <Parameters>
	Then the status code is 404
Examples:
	| Parameters |
	| name |
	| id |
	| name and id |
	| |
	
Scenario: The user calls the web service to cleanup a transformation by name, but multiple transformations with the same name exist.
	Given multiple different transformations with the same name exist on Carte server
	When the user calls the web service using the name parameter
	Then the status code is 409
	And the transformations are not removed