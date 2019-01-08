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

Scenario Outline: The user calls the web service to run the transformation <trans>.
	Given the transformation <trans> exists on the Pentaho repository
	When the user calls the web service using the trans parameter
	Then the status code is 200
	And the response body indicates the request was successful
	And the transformation executed
Examples:
	| trans |
	| /home/admin/DummyTrans |
	| /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
	| /public/carte/MyTrans |
	
# Use the write log step to specify a message and log level in order to test this.
Scenario Outline: THe user calls the web service to run a transformation using the logging level <level>
	Given a transformation that has a logging step for each logging level exists on the Pentaho repository
	When the user calls the web service using the level parameter
	Then the status code is 200
	And the response body indicates the request was successful
	And the transformation executed
	And the logging of the transformation contains <LogResult>
Examples: # Note: the value of LogResult is an example and will depend on what the output is set to for the transformation
	| trans | level | LogResult |
	| /home/admin/Logging | Basic | Basic logging enabled,Error logging enabled,Minimal logging enabled |
	| /home/admin/Logging | Debug | Basic logging enabled,Debug logging enabled,Detailed logging enabled,Error logging enabled,Minimal logging enabled |
	| /home/admin/Logging | Detailed | Basic logging enabled,Detailed logging enabled,Error logging enabled,Minimal logging enabled |
	| /home/admin/Logging | Error | Error logging enabled |
	| /home/admin/Logging | Minimal | Minimal logging enabled |
	| /home/admin/Logging | Rowlevel | Basic logging enabled,Debug logging enabled,Detailed logging enabled,Error logging enabled,Minimal logging enabled,Row Level logging enabled |
	| /home/admin/Logging | Nothing | |
	| /home/admin/Logging | FakeLevel | Basic logging enabled,Error logging enabled,Minimal logging enabled |
	
Scenario: The anonymous user calls the web service to run a transformation on Pentaho Server.
	Given the transformation exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the transformation is not executed
	
Scenario: The user calls the web service to run a transformation that does not exist.
	Given the transformation does not exist on Pentaho Server
	When the use calls the web service
	Then the status code is 404