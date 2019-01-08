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

#GET Method
Scenario Outline: <User> calls the web service to retrieve the properties of a file in the repository
	Given a file exists at <Path>
	When <User> user gets the properties of <Path>
	Then the status code is 200
	And the response body contains "<repositoryFileDto>"
	And the response pody contains "<Path>" + <Path> + "</Path>"
	
Scenario: The admin user calls the web service to retrieve the properties of a file in the repository in JSON format
	Given a file exists at "/public/Steel Wheels/Inventory List (report).prpt"
	And the "Accept" header is set to "application/json"
	When the admin user gets the properties of the file at the path "/public/Steel Wheels/Inventory List (report).prpt"
	Then the status code is 200
	And the response body contains the following:
		"path": "/public/Steel Wheels/Inventory List (report).prpt"
		
Scenario: The admin user calls the web service to retrieve the properties of a file in the repository that is hidden
	Given the file "/public/bi-developres/Analysis/Analyzer Prompt.xaction" exists
	And the file is hidden
	When the admin user gets the properties of the file
	Then the status code is 200
	And the response body contains "<Path>/public/bi-developres/Analysis/Analyzer Prompt.xaction</Path>"

Scenario: The Suzy user calls the web service to retrieve the properties of a file that exists in a different user's folder
	Given the file "/home/admin/MyFile.txt" exists
	And the user has read permissions
	When The Suzy user gets the properties of "/home/admin/MyFile.txt"
	Then the status code is 403
	And the response body is empty
	
Scenario: The admin user calls the web service to retrieve the properties of a file that does not exist.
	Given the file "/home/admin/test.txt" does not exist
	When the admin user gets properties of "/home/admin/test.txt"
	Then the status code is 404
	And the response body is empty
	
Scenario: The anonymous user calls the web service to retrieve the properties of a file that exists.
	Given a file exists at "/home/admin/MyFile.txt"
	And no authentication is used in the request
	When the anonymous user gets the properties of "/home/admin/MyFile.txt"
	Then the status code is 401
	And the response body does not contain "/home/admin/MyFile.txt"
	
Scenario: The pat user calls the web service to retrieve the properties of a file that exists, but does not have read permissions.
	Given the pat user does not have read permissions.
	And the file "/public/Steel Wheels/Inventory List (report).prpt" exists
	When the pat user gets the properties of the file at the path "/public/Steel Wheels/Inventory List (report).prpt"
	Then the status code is 403
	And the response body does not contain "/public/Steel Wheels/Inventory List (report).prpt"
	
Scenario: Admin user calls the web service to retrieve the properties of a file with valid special characters in its name.
	Given the following file exists: "/home/admin/!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|.prpti" (No backslash included. That is used as an escape for the double-quotes)
	When the user calls the web service
	Then the status code is 200
	And the response body contains "<repositoryFileDto>"
	And the response pody contains "<Path>/home/admin/!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|.prpti</Path>"
	
# This file should not actually exist due to invalid characters in the name.
Scenario: Admin user calls the web service to retrieve the properties of a file with invalid special characters in its name.
	When the user calls the web serivce for the file "/\.prpti"
	Then the status code is 400
	And the response body is empty