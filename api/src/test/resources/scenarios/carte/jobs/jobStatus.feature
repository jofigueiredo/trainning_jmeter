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

Scenario: The user calls the web service to retrieve the status of a job using the name parameter.
	Given the job is present on Carte server
	And the name of the job is unique
	When the user calls the web service
	And the name parameter is set to <name>
	Then the status code is 200
	And the response body contains the job's status in HTML format
Examples:
	| name |
	| LoadData |
	| LoadData2 |
	| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
	
Scenario: The user calls the web service to retrieve the status of a job using the name and id parameters.
	Given the job is present on Carte server
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the response body contains the job's status in HTML format
	
Scenario Outline: The user calls the web service to retrieve the status of a job using the name and xml parameters.
	Given the job is present on Carte server
	And the name of the job is unique
	When the user calls the web service
	And the name parameter is set to <name>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the response body contains the job's status in <responseFormat> format
Examples:
	| name | xml | responseFormat |
	| LoadData | N | HTML |
	| LoadData | Y | XML |
	
Scenario: The user calls the web service to retrieve the status of a job using the name and from parameters.
	Given the job is present on Carte server
	And the name of the job is unique
	When the user calls the web service using the name and from parameters
	Then the status code is 200
	And the response body contains the job's status in HTML format
	And the log begins at the line indicated by the value of the from parameter
	
Scenario Outline: The user calls the web service to retrieve the status of a job using the name, id, and xml parameters.
	Given the job is present on Carte server
	When the user calls the web service
	And the name parameter is set to <name>
	And the id parameter is set to <id>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the response body contains the job's status in <responseFormat> format
Examples:
	| name | id | xml | responseFormat |
	| LoadData10 | 665c5b50-6cc9-4768-b703-af13a378ca8d | N | HTML |
	| LoadData11 | 9bfb851b-c096-453d-8110-b8292de50208 | Y | XML |
	
Scenario Outline: The user calls the web service to retrieve the status of a job using the name, id, xml, and from parameters.
	Given the job is present on Carte server
	When the user calls the web service
	And the name parameter is set to <name>
	And the id parameter is set to <id>
	And the xml parameter is set to <xml>
	And the from parameter is set to <from>
	Then the status code is 200
	And the response body contains the job's status in <responseFormat> format
	And the log begins at the line indicated by the value of the from parameter
Examples:
	| name | id | xml | from | responseFormat |
	| LoadData12 | 36e3c345-fcbe-4a3d-acc8-f66ca73d4e39 | N | 5 | HTML |
	| LoadData12 | 7e7adb92-edf0-4ad3-ac9e-614381994011 | Y | 15 | XML |
	
Scenario: The user calls the web service to retrieve the status of a job using the id parameter.
	Given the job is present on Carte server
	When the user calls the web service using the id parameter
	Then the status code is 200
	And the response body contains the job's status in HTML format
	
Scenario Outline: The user calls the web service to retrieve the status of a job using the id and xml parameters.
	Given the job is present on Carte server
	When the user calls the web service
	And the id parameter is set to <id>
	And the xml parameter is set to <xml>
	Then the status code is 200
	And the response body contains the job's status in <responseFormat> format
Examples:
	| id | xml | responseFormat |
	| b6322b9f-bc2f-4797-9dc2-3ae542a10e11 | N | HTML |
	| c88b5fce-7f15-44cc-bb1f-753beadef7d9 | Y | XML |
	
Scenario: The user calls the web service to retrieve the status of a job using the id and from parameters.
	Given the job is present on Carte server
	When the user calls the web service using the id and from parameters
	Then the status code is 200
	And the response body contains the job's status in HTML format
	And the log begins at the line indicated by the value of the from parameter
	
Scenario Outline: The user calls the web service to retrieve the status of a job using the id, xml, and from parameters.
	Given the job is present on Carte server
	When the user calls the web service
	And the id parameter is set to <id>
	And the xml parameter is set to <xml>
	And the from parameter is set to <from>
	Then the status code is 200
	And the response body contains the job's status in <responseFormat> format
	And the log begins at the line indicated by the value of the from parameter
Examples:
	| id | xml | from | responseFormat |
	| 6b6e5d5f-6118-4c86-b6dd-a4357b589334 | N | 15 | HTML |
	| 7eb6bfee-3369-4c98-b90b-666d01a3756a | Y | 10 | XML |
	
Scenario: The user calls the web service to retrieve the status of a job by id, but two jobs exist with the same name and different ids.
	Given two different jobs exist with the same name
	But both jobs have unique Ids
	When the user calls the web service using a unique job id
	Then the status code is 200
	And the response contains the status of the job with the matching id
	
Scenario: The user calls the web service to retrieve the status of a job by name and id, but two jobs exist with the same name and different ids.
	Given two different jobs exist with the same name
	But both jobs have unique Ids
	When the user calls the web service using the name parameter and a unique job id
	Then the status code is 200
	And the response contains the status of the job with the matching id

Scenario: The anonymous user calls the web service to retrieve the status of a job.
	Given the job is present on Carte server
	When the anonymous user calls the web service
	Then the status code is 401
	And the response body does not contain the job status
	
Scenario Outline: The user calls the web service to retrieve the status of a job by <Parameters>, but the job does not exist.
	Given the job does not exist on Carte server
	When the user calls the web service using the parameters <Parameters>
	Then the status code is 404
	And the response body does not contain a job status
Examples:
	| Parameters |
	| name |
	| id |
	| name and id |
	| |

Scenario: The user calls the web service to retrieve the status of a job by name, but two different jobs with the same name exist.
	Given multiple different jobs with the same name exist on Carte server
	When the user calls the web service using the name parameter
	Then the status code is 409
	And the response body does not contain a job status