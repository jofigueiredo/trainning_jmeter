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

# GET Method

Scenario Outline: <User> calls the web service to download the file <Path> from the repository as inline.
	Given <User> has read content permissions
	And <User> has publish content permissions
	And the file <Path> exists
	When the user calls the web service
	Then the status code is 200
	And the value of the response header Content-Disposition is "inline; filename=" followed by the file name
Examples:
	| User | Path |
	| admin | /home/admin/MyFile.prpt |
	| admin | /public/Steel Wheels/Product Sales.prpt |
	| suzy | /home/suzy/MyFile.prpt |
	| suzy | /public/Steel Wheels/Product Sales.prpt |
	| admin | /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}|.prpt |
	
Scenario: A user calls the web service to download a file as inline in another user's home directory.
	Given the user has read content permissions
	And the user has publish content permissions
	And the file exists
	And the user does not have access to the directory.
	When the user calls the web service
	Then the status code is 403
	And the response does not include an attached inline file
	
Scenario: A user calls the web service to download a file as inline, but does not have read permissions
	Given the user does not have read content permissions
	And the user has publish content permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the response does not include an attached inline file
	
Scenario: A user calls the web service to download a file as inline, but does not have publish permissions
	Given the user has read content permissions
	And the user does not have publish content permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the response does not include an attached inline file
	
Scenario: A user calls the web service to download a non-existant file as inline that has invalid characters
	Given the user has read content permissions
	And the user has publish content permissions
	When the user calls the web service
	Then the status code is 400
	And the response does not include an attached inline file
Examples:
	| pathId |
	| :home:admin:/.prpt |
	| :home:admin:\.prpt |
	
Scenario: The user calls the web service to download a non-existant file as inline.
	Given the user has read content permissions
	And the user has publish content permissions
	And the file does not exist
	When the user calls the web service
	Then the status code is 404
	And the response does not include an attached inline file
	
Scenario: The anonymous user calls the web service to download a file as inline.
	Given the file exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the response does not include an attached inline file