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

# POST Method
Scenario: The admin user calls the web service to retrieve a list of permissions for the specified files.
	Given all files exist
	When the admin user calls the web service
	Then the status code is 200
	And the response body contains all files wrapped in "<name>" and "</name>"
	And the response body contains "<value>0</value>"
	And the response body contains "<value>1</value>"
	And the response body contains "<value>2</value>"
	And the response body contains "<value>3</value>"
	And the response body contains "<value>4</value>"
	
Scenario: The admin user calls the web service to retrieve a list of permissions for the specified files with the request and response in JSON format.
	Given "/home/admin/AdminFile.txt" exists
	When the admin user calls the web service
	Then the status code is 200
	And the response body contains the following:
		"name":"/home/admin/test.prpti"
	And the response body contains the following:
		"value":"0"
	And the response body contains the following:
		"value":"1"
	And the response body contains the following:
		"value":"2"
	And the response body contains the following:
		"value":"3"
	And the response body contains the following:
		"value":"4"
	
Scenario: The suzy user calls the web service to retrieve a list of permissions to a file in their own folder and in another user's folder.
	Given "/home/suzy/SuzyFile.txt" exists
	And "/home/admin/AdminFile.txt"
	When The suzy user calls the web service
	Then the status code is 200
	And the response body contains "<name>/home/suzy/SuzyFile.txt</name>"
	And the response body contains "<value>0</value>"
	And the response body contains "<value>1</value>"
	And the response body contains "<value>2</value>"
	And the response body contains "<value>3</value>"
	And the response body contains "<value>4</value>"
	But the response body does not contain "<name>/home/admin/AdminFile.txt</name>"
	
Scenario: The suzy user calls the web service to retrieve a list of permissions to a file in the public folder.
	Given "/public/Steel Wheels/Product Sales.prpt" exists
	And the user has read permissions
	When the user calls the web service
	Then the status code is 200
	And the response body contains "<name>/public/Steel Wheels/Product Sales.prpt</name>"
	And the response body contains "<value>0</value>"
	But the response body does not contain "<value>1</value>"
	And the response body does not contain "<value>2</value>"
	And the response body does not contain "<value>3</value>"
	And the response body does not contain "<value>24</value>"
	
Scenario: The pat user calls the web service to retrieve a list of permissions to a file in the public folder.
	Given "/public/Steel Wheels/Product Sales.prpt" exists
	And the pat user does not have any permissions 
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain "<settings>"
	
Scenario: The admin user calls the web service to retrieve a list of permissions to a file that does not exist.
	Given "/home/admin/MyFile.txt" does not exist
	When the user calls the web service
	Then the status code is 200
	And the response body contains "<settings>"
	But the response body does not contain "<name>"
	And the response body does not contain "<value>"
	
Scenario: The anonymous user calls the web service to retrieve a list of permissions to a file that exists.
	Given "/public/Steel Wheels/Product Sales.prpt" exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the response body does not contain "<settings>"
	
Scenario: The admin user calls the web service to retrieve a list of permissions for a file with valid special characters in its name.
	Given the following file exists: "/home/admin/!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|.prpti" (No backslash included. That is used as an escape for the double-quotes)
	When the user calls the web service
	Then the status code is 200
	And the response body contains the file wrapped in "<name>" and "</name>"
	And the response body contains "<value>0</value>"
	And the response body contains "<value>1</value>"
	And the response body contains "<value>2</value>"
	And the response body contains "<value>3</value>"
	And the response body contains "<value>4</value>"
	
# This file should not actually exist due to invalid characters in the name.
Scenario: The admin user calls the web service to retrieve a list of permissions for a file with invalid special characters in its name.
	When the user calls the web serivce for the file "/\.prpti"
	Then the status code is 400
	And the response body is empty