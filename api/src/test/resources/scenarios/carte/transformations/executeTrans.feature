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

Scenario Outline: The user calls the web service to execute the transformation <trans> on the repository <repo> using the username <user> and password <pass>.
	Given the transformation <trans> exists on the repository id <repo>
	And the repository id <repo> is set up in the respository.xml file within the same directory as Carte server
	And the username and password <user>/<pass> are valid credentials
	When the user calls the web service
	Then the status code is 200
	And the transformation executed
Examples:
	| repo | user | pass | trans |
	| Automation | admin | password | home/admin/ChangeUser |
	| !@#$%^&*()_-=+;:'"?<>,.`~[]{}| | suzy | password | home/suzy/myTransformation |
	| Automation | user1 | !@#$%^&*()_-=+;:'"?<>,.`~[]{}| | public/transformations/publicTransformation |
	| Automation | admin | password | /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
	
Scenario Outline: The user calls the web service to execute a transformation using the logging level <level>.
	Given a transformation that has a logging step for each logging level exists on the Pentaho repository
	And the repository id <repo> is set up in the respository.xml file within the same directory as Carte server
	And the username and password <user>/<pass> are valid credentials
	When the user calls the web service using the level parameter
	Then the status code is 200
	And the transformation executed
	And the logging of the transformation contains <LogResult>
Examples: # Note: the value of LogResult is an example and will depend on what the output is set to for the transformation
	| trans | repo | user | pass | level | LogResult |
	| /public/transformations/Logging | Automation | admin | password | Basic | Basic logging enabled,Error logging enabled,Minimal logging enabled |
	| /public/transformations/Logging | Automation | suzy | password | Debug | Basic logging enabled,Debug logging enabled,Detailed logging enabled,Error logging enabled,Minimal logging enabled |
	| /public/transformations/Logging | Automation | admin | password | Detailed | Basic logging enabled,Detailed logging enabled,Error logging enabled,Minimal logging enabled |
	| /public/transformations/Logging | Automation | suzy | password | Error | Error logging enabled |
	| /public/transformations/Logging | Automation | admin | password | Minimal | Minimal logging enabled |
	| /public/transformations/Logging | Automation | suzy | password | Rowlevel | Basic logging enabled,Debug logging enabled,Detailed logging enabled,Error logging enabled,Minimal logging enabled,Row Level logging enabled |
	| /public/transformations/Logging | Automation | admin | password | Nothing | |
	| /public/transformations/Logging | Automation | suzy | password | FakeLevel | Basic logging enabled,Error logging enabled,Minimal logging enabled |
	
Scenario Outline: The user calls the web service to execute a transformation that contains parameters <Parameters> with values <Values>
	Given a transformation that contains the parameters <Parameters> exists on the Pentaho repository
	And the repository id <repo> is set up in the respository.xml file within the same directory as Carte server
	And the username and password <user>/<pass> are valid credentials
	When the user calls the web service with transformation parameters specified in the request
	Then the status code is 200
	And the transformation is executed
	And the parameters and their values affected the result of the transformation
Examples:
	| repo | user | pass | trans | Parameters | Values |
	| Automation | admin | password | /public/transformations/TransWithParameters | myParameter | myValue |
	| Automation | suzy | password | /public/transformations/TransWithParameters2 | myParameter,name | myValue,Bob |
	| Automation | admin | password | /public/transformations/TransWithParameters2 | myParameter,name,city,state,zip | myValue,Bob,Orlando,FL,32822 |
	| Automation | suzy | password | /public/transformations/TransWithParameters2 | | |
	| Automation | admin | password | /public/transformations/TransWithParameters | !@#%^&*()_-=+;:'"?<>,.`~[]| | !@#%^&*()_-=+;:'"?<>,.`~[]| |
	
Scenario: The user calls the web service to execute a transformation, but provides parameters that do not exist in the transformation.
	Given the transformation exists in the specified repository
	And the credentials for the repository are valid
	And the transformation does not have parameters that match those specified in the request
	When the user calls the web service with transformation parameters that do not exist
	Then the status code is 200
	And the transformation is executed using the default values of the existing transformation parameters
	
Scenario: The user calls the web service to execute a transformation and the transformation finishes with errors.
	Given the transformation exists in the specified repository
	And the credentials for the repository are valid
	And the transformation will have errors
	When the user calls the web service
	Then the status code is 200
	And the transformation is executed
	And the transformation finishes with errors
	
Scenario: The user calls the web service to execute a transformation, but provides invalid credentials for the repository.
	Given the transformation exists in the specified repository
	And valid credentials are used for the endpoint
	And invalid credentials are specified in the user and pass parameters
	When the user calls the web service
	Then the status code is 400
	And the response body indicates that Pentaho Server responded with a 401 status code indicating that the credentials specified in the user and pass parameters are invalid
	And the response body is in XML format
	
Scenario: The user calls the web service to execute a transformation that the specified user does not have permission to access
	Given the transformation exists in the specified repository
	And valid credentials are used for the endpoint
	And valid credentials are specified in the user and pass parameters
	And the user specified in the user parameter does not have Read Content permission in the repository
	When the user calls the web service
	Then the status code is 400
	And the response body indicates that Pentaho Server responded with a 403 status code indicating that the user specified in the user parameter does not have access to the repository
	And the response body is in XML format
	
Scenario: The anonymous user calls the web service to execute a transformation.
	Given the transformation exists on the specified repository
	And the credentials specified with the user and pass parameters are valid
	When the anonymous user calls the web service
	Then the status code is 401
	And the transformation is not executed
	And the response body is in XML format
	
Scenario: The user calls the web service to execute a transformation, but the specified repo is not found.
	Given the specified repository is invalid
	When the user calls the web service
	Then the status code is 404
	And the response body indicates that the repository was not found
	And the response body is in XML format
	
Scenario: The user calls the web service to execute a transformation that does not exist in the specified repository.
	Given the specified repository is valid
	And the specified transformation does not exist
	And the credentials specified for the repository are valid
	When the user calls the web service
	Then the status code is 404
	And the response body indicates that the transformation was not found at the specified path
	And the response body is in XML format