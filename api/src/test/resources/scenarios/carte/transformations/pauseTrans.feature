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

Scenario Outline: The user calls the web service to pause a transformation using the name parameter.
	Given the transformation is running
	And the name of the transformation is unique
	When the user calls the web service
	And the name parameter is set to <name>
	Then the status code is 200
	And the transformation is paused
	And the response body is in HTML format
Examples:
	| name |
	| LoadData |
	| LoadData2 |
	| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
	
Scenario: The user calls the web service to pause a transformation using the name and id parameters.
	Given the transformation is running
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the transformation is paused
	And the response body is in HTML format
	
Scenario Outline: The user calls the web service to pause a transformation using the name and xml parameters.
	Given the transformation is running
	And the name of the transformation is unique
	When the user calls the web service
	And the name parameter is set to <name>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the transformation is paused
	And the response body is in <responseFormat> format
Examples:
	| name | xml | responseFormat |
	| LoadData | N | HTML |
	| LoadData | Y | XML |
	
Scenario Outline: The user calls the web service to pause a transformation using the name, id, and xml parameters.
	Given the transformation is running
	When the user calls the web service
	And the name parameter is set to <name>
	And the id parameter is set to <id>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the transformation is paused
	And the response body is in <responseFormat> format
Examples:
	| name | id | xml | responseFormat |
	| LoadData10 | 665c5b50-6cc9-4768-b703-af13a378ca8d | N | HTML |
	| LoadData11 | 9bfb851b-c096-453d-8110-b8292de50208 | Y | XML |
	
Scenario: The user calls the web service to pause a transformation using the id parameter.
	Given the transformation is running
	When the user calls the web service using the id parameter
	Then the status code is 200
	And the transformation is paused
	And the response body is in HTML format
	
Scenario Outline: The user calls the web service to pause a transformation using the id and xml parameters.
	Given the transformation is running
	When the user calls the web service
	And the id parameter is set to <id>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the transformation is paused
	And the response body is in <responseFormat> format
Examples:
	| id | xml | responseFormat |
	| b6322b9f-bc2f-4797-9dc2-3ae542a10e11 | N | | HTML |
	| c88b5fce-7f15-44cc-bb1f-753beadef7d9 | Y | | XML |

Scenario: The user calls the web service to pause a transformation that is already paused.
	Given the transformation is already paused
	When the user calls the web service
	Then the status code is 200
	And the transformation remains paused
	
Scenario: The user calls the web service to pause a transformation by name and id, but two different transformations exist with the same name.
	Given the transformation identified by both name and id is running
	And the specified name is ambiguous
	When the user calls the web service
	Then the status code is 200
	And the correct transformation, identified by both name and id, is paused
	
Scenario: The anonymous user calls the web service to pause a transformation.
	Given the transformation is running
	When the anonymous user calls the web service
	Then the status code is 401
	And the transformation is still running
	
Scenario Outline: The user calls the web service to pause a transformation that does not exist.
	Given the specified transformation is not present on Carte server
	When the user calls the web service using the parameters <Parameters>
	Then the status code is 404
Examples:
	| Parameters |
	| name |
	| id |
	| name and id |
	| |
	
Scenario: The user calls the web service to pause a transformation by name, but multiple transformations with the same name exist.
	Given multiple different transformations with the same name exist on Carte server
	And both transformations are running
	When the user calls the web service using the name parameter
	Then the status code is 409
	And both transformations are not stopped