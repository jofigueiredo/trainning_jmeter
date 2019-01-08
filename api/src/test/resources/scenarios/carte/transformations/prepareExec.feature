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

Scenario: The user calls the web service to prepare the specified transformation for execution using the name parameter.
	Given the transformation is present on Carte server
	And the name is unique to one transformation
	When the user calls the web service using the name parameter
	Then the status code is 200
	And the response body indicates the request was successful in HTML format
	And the specified transformation is prepared for execution
	
Scenario Outline: The user calls the web service to prepare the specified transformation for execution using the name and xml parameters.
	Given the transformation is present on Carte server
	And the name is unique to one transformation
	When the user calls the web service with the value of name as <name> and of xml as <xml>
	Then the status code is 200
	And the response body indicates the request was successful in <responseFormat> format
	And the specified transformation is prepared for execution
Examples:
	| name | xml | responseFormat |
	| LoadData | N | HTML |
	| LoadData | Y | XML |
	
Scenario: The user calls the web service to prepare the specified transformation for execution using the name and id parameters.
	Given the transformation is present on Carte server
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the response body indicates the request was successful in HTML format
	And the specified transformation is prepared for execution
	
Scenario Outline: The user calls the web service to prepare the specified transformation for execution using the name, id, and xml parameters.
	Given the transformation is present on Carte server
	When the user calls the web service using the value of name as <name>, id as <id>, and xml as <xml>
	Then the status code is 200
	And the response body indicates the request was successful in <responseFormat> format
	And the specified transformation is prepared for execution
Examples:
	| name | id | xml | responseFormat |
	| LoadData | 167fba44-3cd6-4cb4-bda9-fabb5de21a4b | N | HTML |
	| LoadData | 167fba44-3cd6-4cb4-bda9-fabb5de21a4b	| Y | XML |
	
Scenario: The user calls the web service to prepare the specified transformation for execution using the id parameter.
	Given the transformation is present on Carte server
	When the user calls the web service using the id parameter
	Then the status code is 200
	And the response body indicates the request was successful in HTML format
	And the specified transformation is prepared for execution
	
Scenario Outline: The user calls the web service to prepare the specified transformation for execution using the id and xml parameters.
	Given the transformation is present on Carte server
	When the user calls the web service using the value of id as <id> and of xml as <xml>
	Then the status code is 200
	And the response body indicates the request was successful in <responseFormat> format
	And the specified transformation is prepared for execution
Examples:
	| id | xml | responseFormat |
	| 167fba44-3cd6-4cb4-bda9-fabb5de21a4b | N | HTML |
	| 167fba44-3cd6-4cb4-bda9-fabb5de21a4b | Y | XML |
	
Scenario: The user calls the web service to prepare a transformation by name and id, but two different transformations exist with the same name.
	Given the transformation is present on Carte server
	And the name of the transformation is ambiguous
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the correct transformation is prepared
	
Scenario: The user calls the web service to prepare the specified transformation for execution, but the transformation has already been prepared.
	Given the transformation is present on Carte server
	And the transformation has already been prepared
	When the user calls the web service
	Then the status code is 200
	And the specified transformation is prepared for execution
	
Scenario: The anonymous user calls the web service to prepare the specified transformation for execution.
	Given the transformation is present on Carte server
	When the anonymous user calls the web service
	Then the status code is 401
	
Scenario: The user calls the web service to prepare the specified transformation for execution by name and/or id, but the transformation does not exist.
	Given the transformation does not exist on Carte server
	When the user calls the web service using the value for name as <name> and id as <id>
	Then the status code is 404
Examples:
	| name | id |
	| MyTransformation | null |
	| null | bceb263c-79bc-4cc4-b4cb-dcabc197be81 |
	| MyTransformation | bceb263c-79bc-4cc4-b4cb-dcabc197be81 |
	| LoadData | bceb263c-79bc-4cc4-b4cb-dcabc197be81 |
	| MyTransformation | 167fba44-3cd6-4cb4-bda9-fabb5de21a4b |
	
Scenario: The user calls the web service to prepare the transformation for execution by name, but multiple transformations with the same name exist.
	Given multiple transformations with the same name exist on Carte server
	When the user calls the web service using the name parameter
	Then the status code is 409