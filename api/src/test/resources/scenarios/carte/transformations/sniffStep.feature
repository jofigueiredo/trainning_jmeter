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
# Note: The value of the stepName parameter is the user-defined name of the step within the transformation.

Scenario Outline: The user calls the web service to track the metadata and data for a step of a transformation using the trans parameter.
	Given the transformation is running
	And the name of the transformation is unique
	And the specified step name is valid
	When the user calls the web service
	And the trans parameter is set to <trans>
	Then the status code is 200
	And the response body contains the metadata of the step
	And the response body contains all lines of the output data from the step
	And the response body is in HTML format
Examples:
	| trans |
	| LoadData |
	| LoadData2 |
	| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
	
Scenario: The user calls the web service to track the metadata and data for a step of a transformation using the trans and id parameters.
	Given the transformation is running
	And the specified step name is valid
	When the user calls the web service  using the trans and id parameters
	Then the status code is 200
	And the response body contains the metadata of the step
	And the response body contains all lines of the output data from the step
	And the response body is in HTML format

Scenario Outline: The user calls the web service to track the metadata and data for a step of a transformation using the trans and xml parameters.
	Given the transformation is running
	And the name of the transformation is unique
	And the specified step name is valid
	When the user calls the web service
	And the trans parameter is set to <trans>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the response body contains the metadata of the step
	And the response body contains all lines of the output data from the step
	And the response body is in <responseFormat> format
Examples:
	| trans | xml | responseFormat |
	| LoadData | N | HTML |
	| LoadData | Y | XML |
	
Scenario Outline: The user calls the web service to track the metadata and data for a step of a transformation using the trans, id, and xml parameters.
	Given the transformation is running
	And the specified step name is valid
	When the user calls the web service
	And the trans parameter is set to <trans>
	And the id parameter is set to <id>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the response body contains the metadata of the step
	And the response body contains all lines of the output data from the step
	And the response body is in <responseFormat> format
Examples:
	| trans | id | xml | responseFormat |
	| LoadData10 | 665c5b50-6cc9-4768-b703-af13a378ca8d | N | HTML |
	| LoadData11 | 9bfb851b-c096-453d-8110-b8292de50208 | Y | XML |

Scenario: The user calls the web service to track the metadata and data for a step of a transformation using the id parameter.
	Given the transformation is running
	And the specified step name is valid
	When the user calls the web service  using the id parameter
	Then the status code is 200
	And the response body contains the metadata of the step
	And the response body contains all lines of the output data from the step
	And the response body is in HTML format
	
Scenario: The user calls the web service to track the metadata and data for a step of a transformation using the id and xml parameters.
	Given the transformation is running
	And the specified step name is valid
	When the user calls the web service
	And the id parameter is set to <id>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the response body contains the metadata of the step
	And the response body contains all lines of the output data from the step
	And the response body is in <responseFormat> format
Examples:
	| id | xml | responseFormat |
	| b6322b9f-bc2f-4797-9dc2-3ae542a10e11 | N | | HTML |
	| c88b5fce-7f15-44cc-bb1f-753beadef7d9 | Y | | XML |
	
Scenario Outline: The user calls the web service to track the metadata and data for copy number <copynr> of a step of a transformation.
	Given the transformation is running
	And the specified step name is valid
	When the user calls the web service
	Then the status code is 200
	And the response body contains the metadata for the correct copy number of the step
	And the response body contains the output data for the correct copy number of the step
Examples:
	| copynr |
	| 0 |
	| 1 |
	| 2 |
	| 3 |
	
Scenario Outline: The user calls the web service to track the metadata and <type> data of a step of a transformation.
	Given the transformation is running
	And the specified step name is valid
	When the user calls the web service
	Then the status code is 200
	And the response body contains the <type> data of the step
Examples:
	| type |
	| input |
	| output |
	
Scenario Outline: The user calls the web service to track the metadata and first <lines> lines of data of a step of a transformation.
	Given the transformation is running
	And the specified step name is valid
	And the step will output at least <lines> of data
	When the user calls the web service
	Then the status code is 200
	And the response body contains <lines> lines of data of for the step
Examples:
	| lines |
	| 2 |
	| 10 |
	| 11 |
	| 100 |
	
Scenario: The user calls the web service to track the metadata and all lines of data of a step of a transformation.
	Given the transformation is running
	And the specified step name is valid
	When the user calls the web service
	Then the status code is 200
	And the response body contains all lines of data of for the step
	
Scenario Outline: The user calls the web service to track the metadata and first <lines> lines of data of a step of a transformation, but the step outputs fewer lines.
	Given the transformation is running
	And the specified step name is valid
	And the step will only output <actualLines> of data
	When the user calls the web service
	Then the status code is 200
	And the response body contains <actualLines> lines of data of for the step
Examples:
	| lines | actualLines |
	| 10 | 5 |
	| 11 | 5 | 
	| 100 | 20 |
	
Scenario: The user calls the web service to track the metadata for a step in a transformation by name and id, but two different transformations with the same name exist.
	Given the specified name is ambiguous
	And the transformation identified by both name and id is running
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the metadata/data of the transformation identified by both name and id are included in the response body
	
Scenario Outline: The user calls the web service to track the metadata and data for a step in a transformation that is not running and is in the state <State>.
	Given the transformation exists
	and the transformation is not running
	And the transformation state is <State>
	When the user calls the web service
	Then the status code is 400
	And the response body indicates that the transformation is not running.
Examples:
	| State |
	| Waiting |
	| Paused |
	| Finished |
	
Scenario: The user calls the web service to track the metadata and data for a step in the transformation, but an invalid value is provided for the lines parameter
	Given the transformation is running
	When the user calls the web service with 0 as the value of the lines parameter
	Then the status code is 400
	And the response body indicates the valid range for the lines parameter
	
Scenario: The anonymous use calls the web service to track the metadata and data for a step in the transformation
	Given the transformation is running
	When the anonymous user calls the web service
	Then the status code is 401
	
Scenario Outline: The user calls the web service to track the metadata and data for a transformation that does not exist.
	Given the transformation does not exist
	When the user calls the web service using <Parameters>
	Then the status code is 404
	And the response body indicates that the transformation does not exist
Examples:
	| Parameters |
	| name |
	| id |
	| name and id |
	| |
	
Scenario: The user calls the web service to track the metadata and data for the transformation, but the specified step name does not exist.
	Given the transformation is running
	And the transformation does not contain the specified step name
	When the user calls the web service
	Then the status code is 404
	And the response body indicates that the step was not found
	
Scenario: The user calls the web service to track the metadata and data for the transformation, but the specified copy number for the step exceeds the number of copies specified in the transformation
	Given the transformation is running
	And the specified step exists
	But the copy number to track exceeds the number of copies for the step
	When the user calls the web service
	Then the status code is 404
	And the response body indicates that the copy number for the step was not found
	
Scenario: The user calls the web service to track the metadata and data for a transformation by name, but multiple transformations with the same name exist.
	Given multiple different transformations with the same name exist on Carte server
	When the user calls the web service using the name parameter
	Then the status code is 409
	And the response body does not contain any tracked metadata/data