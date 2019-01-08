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

# Note: this feature requires the transformation to be prepared using the prepareExec endpoint. If this prerequisite is not met, then an error will occur.

Scenario: The user calls the web service to execute a transformation using the name parameter.
	Given the transformation is present on Carte server
	And the name is unique to one transformation
	And the transformation has been prepared using the prepareExec endpoint
	When the user calls the web service using the name parameter
	Then the status code is 200
	And the transformation is executed
	And the response body indicates the request is successful in HTML format
	
Scenario: The user calls the web service to execute a transformation using the name and id parameters.
	Given the transformation is present on Carte server
	And the transformation has been prepared using the prepareExec endpoint
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the transformation is executed
	And the response body indicates the request is successful in HTML format
	
Scenario Outline: The user calls the web service to execute a transformation using the name and xml parameters.
	Given the transformation is present on Carte server
	And the transformation has been prepared using the prepareExec endpoint
	When the user calls the web service using the value of name as <name> and xml as <xml>
	Then the status code is 200
	And the transformation is executed
	And the response body indicates the request is successful in <responseFormat> format
Examples:
	| name | xml | responseFormat |
	| LoadData | N | HTML |
	| LoadData | Y | XML |
	
Scenario Outline: The user calls the web service to execute a transformation using the name, id, and xml parameters.
	Given the transformation is present on Carte server
	And the transformation has been prepared using the prepareExec endpoint
	When the user calls the web service using the value of name as <name>, id as <id>, and xml as <xml>
	Then the status code is 200
	And the transformation is executed
	And the response body indicates the request is successful in <responseFormat> format
Examples:
	| name | id | xml | responseFormat |
	| LoadData | 167fba44-3cd6-4cb4-bda9-fabb5de21a4b | N | HTML |
	| LoadData | 167fba44-3cd6-4cb4-bda9-fabb5de21a4b	| Y | XML |

Scenario: The user calls the web service to execute a transformation using the id parameter.
	Given the transformation is present on Carte server
	And the transformation has been prepared using the prepareExec endpoint
	When the user calls the web service using the id parameter
	Then the status code is 200
	And the transformation is executed
	And the response body indicates the request is successful in HTML format
	
Scenario Outline: The user calls the web service to execute a transformation using the id and xml parameters.
	Given the transformation is present on Carte server
	And the transformation has been prepared using the prepareExec endpoint
	When the user calls the web service using the value of id as <id> and xml as <xml>
	Then the status code is 200
	And the transformation is executed
	And the response body indicates the request is successful in <responseFormat> format
Examples:
	| id | xml | responseFormat |
	| 167fba44-3cd6-4cb4-bda9-fabb5de21a4b | N | HTML |
	| 167fba44-3cd6-4cb4-bda9-fabb5de21a4b | Y | XML |
	
Scenario: The user calls the web service to execute a transformation by name and id, but two different transformations exist with the same name.
	Given the transformation is present on Carte server
	And the transformation has been prepared using the prepareExec endpoint
	And the name of the transformation is ambiguous
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the correct transformation is executed
	
Scenario: The user calls the web service to execute a transformation that has been previously executed.
	Given the transformation is present on Carte server
	And the transformation has already been executed
	When the user calls the web service
	Then the status code is 400
	And the specified transformation is not executed
	
Scenario: The anonymous user calls the web service to execute a transformation.
	Given the transformation is present on Carte server
	And the transformation has been prepared using the prepareExec endpoint
	When the anonymous user calls the web service
	Then the status code is 401
	And the transformation is not executed
	
Scenario: The user calls the web service to execute a transformation by name and/or id, but the transformation does not exist.
	Given the transformation does not exist on Carte server
	When the user calls the web service using the value of name as <name> and id as <id>
	Then the status code is 404
Examples:
	| name | id |
	| MyTransformation | null |
	| null | bceb263c-79bc-4cc4-b4cb-dcabc197be81 |
	| MyTransformation | bceb263c-79bc-4cc4-b4cb-dcabc197be81 |
	| LoadData | bceb263c-79bc-4cc4-b4cb-dcabc197be81 |
	| MyTransformation | 167fba44-3cd6-4cb4-bda9-fabb5de21a4b |
	
Scenario: The user calls the web service to execute a transformation by name, but multiple transformations with the same name exist.
	Given multiple transformations with the same name exist on Carte server
	When the user calls the web service using the name parameter
	Then the status code is 409