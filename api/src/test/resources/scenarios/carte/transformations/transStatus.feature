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

Scenario: The user calls the web service to retrieve the status of a transformation using the name parameter.
	Given the transformation is present on Carte server
	And the name of the transformation is unique
	When the user calls the web service using the name parameter
	Then the status code is 200
	And the response body contains the transformation's status in HTML format
	
Scenario: The user calls the web service to retrieve the status of a transformation using the name and id parameters.
	Given the transformation is present on Carte server
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the response body contains the transformation's status in HTML format
	
Scenario Outline: The user calls the web service to retrieve the status of a transformation using the name and xml parameters.
	Given the transformation is present on Carte server
	And the name of the transformation is unique
	When the user calls the web service with the value of name as <name> and xml as <xml>
	Then the status code is 200
	And the response body contains the transformation's status in <responseFormat> format
Examples:
	| name | xml | responseFormat |
	| LoadData | N | HTML |
	| LoadData | Y | XML |
	
Scenario: The user calls the web service to retrieve the status of a transformation using the name and from parameters.
	Given the transformation is present on Carte server
	And the name of the transformation is unique
	When the user calls the web service using the name and from parameters
	Then the status code is 200
	And the response body contains the transformation's status in HTML format
	And the log begins at the line indicated by the value of the from parameter
	
Scenario Outline: The user calls the web service to retrieve the status of a transformation using the name, id, and xml parameters.
	Given the transformation is present on Carte server
	When the user calls the web service with the value of name as <name>, id as <id>, and xml as <xml>
	Then the status code is 200
	And the response body contains the transformation's status in <responseFormat> format
Examples:
	| name | id | xml | responseFormat |
	| LoadData10 | 665c5b50-6cc9-4768-b703-af13a378ca8d | N | HTML |
	| LoadData11 | 9bfb851b-c096-453d-8110-b8292de50208 | Y | XML |
	
Scenario Outline: The user calls the web service to retrieve the status of a transformation using the name, id, xml, and from parameters.
	Given the transformation is present on Carte server
	When the user calls the web service with the value of name as <name>, id as <id>, xml as <xml>, and from as <from>
	Then the status code is 200
	And the response body contains the transformation's status in <responseFormat> format
	And the log begins at the line indicated by the value of the from parameter
Examples:
	| name | id | xml | from | responseFormat |
	| LoadData12 | 36e3c345-fcbe-4a3d-acc8-f66ca73d4e39 | N | 5 | HTML |
	| LoadData12 | 7e7adb92-edf0-4ad3-ac9e-614381994011 | Y | 15 | XML |
	
Scenario: The user calls the web service to retrieve the status of a transformation using the id parameter.
	Given the transformation is present on Carte server
	When the user calls the web service using the id parameter
	Then the status code is 200
	And the response body contains the transformation's status in HTML format
	
Scenario Outline: The user calls the web service to retrieve the status of a transformation using the id and xml parameters.
	Given the transformation is present on Carte server
	When the user calls the web service with the value of id as <id> and xml as <xml>
	Then the status code is 200
	And the response body contains the transformation's status in <responseFormat> format
Examples:
	| id and xml | | b6322b9f-bc2f-4797-9dc2-3ae542a10e11 | N | | HTML |
	| id and xml | | c88b5fce-7f15-44cc-bb1f-753beadef7d9 | Y | | XML |
	
Scenario: The user calls the web service to retrieve the status of a transformation using the id and from parameters.
	Given the transformation is present on Carte server
	When the user calls the web service using the id and from parameters
	Then the status code is 200
	And the response body contains the transformation's status in HTML format
	And the log begins at the line indicated by the value of the from parameter
	
Scenario Outline: The user calls the web service to retrieve the status of a transformation using the id, xml, and from parameters.
	Given the transformation is present on Carte server
	When the user calls the web service with the value of id as <id>, xml as <xml>, and from as <from>
	Then the status code is 200
	And the response body contains the transformation's status in <responseFormat> format
	And the log begins at the line indicated by the value of the from parameter
Examples:
	| id | xml | from | responseFormat |
	| 6b6e5d5f-6118-4c86-b6dd-a4357b589334 | N | 15 | HTML |
	| 7eb6bfee-3369-4c98-b90b-666d01a3756a | Y | 10 | XML |
	
Scenario: The user calls the web service to retrieve the status of a transformation by name and id, but two different transformations exist with the same name.
	Given the transformation is present on Carte server
	And the name of the transformation is ambiguous
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the response contains the status of the correct transformation

Scenario: The anonymous user calls the web service to retrieve the status of a transformation.
	Given the transformation is present on Carte server
	When the anonymous user calls the web service
	Then the status code is 401
	And the response body does not contain the transformation status
	
Scenario Outline: The user calls the web service to retrieve the status of a transformation by <Parameters>, but the transformation does not exist.
	Given the transformation does not exist on Carte server
	When the user calls the web service using the parameters <Parameters>
	Then the status code is 404
	And the response body does not contain a transformation status
Examples:
	| Parameters |
	| name |
	| id |
	| name and id |
	| |

Scenario: The user calls the web service to retrieve the status of a transformation by name, but two different transformations with the same name exist.
	Given multiple different transformations with the same name exist on Carte server
	When the user calls the web service using the name parameter
	Then the status code is 409
	And the response body does not contain a transformation status