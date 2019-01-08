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

Scenario Outline: The user calls the web service to retrieve an image of a job file that is present on Carte server using the name parameter.
	Given the job is present on Carte server
	And the name of the job is unique
	When the user calls the web service
	And the name parameter is set to <name>
	Then the status code is 200
	And the response contains a PNG image of the job
Examples:
	| name |
	| LoadData |
	| LoadData2 |
	| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
	
Scenario: The user calls the web service to retrieve an image of a job file that is present on Carte server using the id parameter.
	Given the job is present on Carte server
	When the user calls the web service using the id parameter
	Then the status code is 200
	And the response contains a PNG image of the job
	
Scenario: The user calls the web service to retrieve an image of a job file that is present on Carte server using the name and id parameters.
	Given the job is present on Carte server
	When the user calls the web service using the name and id parameters
	Then the status code is 200
	And the response contains a PNG image of the job
	
Scenario: The user calls the web service to retrieve an image of a job file that is present on Carte server by id, but two jobs exist with the same name and different ids.
	Given two different jobs exist with the same name
	But both jobs have unique Ids
	When the user calls the web service using a unique job id
	Then the status code is 200
	And the response contains a PNG image of the job with the matching id
	
Scenario: The user calls the web service to retrieve an image of a job file that is present on Carte server by name and id, but two jobs exist with the same name and different ids.
	Given two different jobs exist with the same name
	But both jobs have unique Ids
	When the user calls the web service using the name parameter and a unique job id
	Then the status code is 200
	And the response contains a PNG image of the job with the matching id	
	
Scenario: The anonymous user calls the web service to retrieve an image of a job file that is present on Carte server.
	Given the job is present on Carte server
	When the anonymous user calls the web service
	Then the status code is 401
	And the response does not contain a PNG image of a job
	
Scenario Outline: The user calls the web service to retrieve an image of a job file by <Parameters>, but the job does not exist.
	Given the job does not exist on Carte server
	When the user calls the web service using the parameters <Parameters>
	Then the status code is 404
	And the response body does not contain a PNG image of a job
Examples:
	| Parameters |
	| name |
	| id |
	| name and id |
	| |
	
Scenario: The user calls the web service to retrieve an image of a job file by name, but two different jobs with the same name exist.
	Given multiple different jobs with the same name exist on Carte server
	When the user calls the web service using the name parameter
	Then the status code is 409
	And the response does not contain a PNG image of a job