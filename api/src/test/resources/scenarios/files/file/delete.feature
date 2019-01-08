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

# PUT Method

# Scenarios for files
Scenario Outline: <User> calls the web service to delete the file <Path>
	Given the file <Path> exists
	When <User> calls the web service
	Then the status code is 200
	And the file no longer exists at <Path>
	But the file does exist in the trash folder

Scenario: The admin user calls the web service to delete multiple files in a single request.
	Given the file "/home/admin/DeleteMe.txt" exists
	And the file "/public/DeleteMe.txt" exists
	When the user calls the web service to delete the files using the file IDs in the params parameter
	Then the status code is 200
	And the "DeleteMe.txt" file no longer exists in "/home/admin"
	And the "DeleteMe.txt" file no longer exists in "/public"
	But the "DeleteMe.txt" files are in the trash folder
	
Scenario: The suzy user calls the web service to delete a file.
	Given the file "/home/suzy/SuzyFile.txt" exists
	And the suzy user has read permissions
	When the user calls the web service
	Then the response code is 200
	And the file "/home/suzy/SuzyFile.txt" no longer exists
	But the file "SuzyFile.txt" exists in the trash folder
	
Scenario: The suzy user calls the web service to delete a file in another user's folder.
	Given the file "/home/admin/MyFile.txt" exists
	And the suzy user has read permissions
	When the user calls the web service
	Then the response code is 403
	And the file "/home/admin/MyFile.txt" exists
	
Scenario: The admin user calls the web service to delete a file, but uses an invalid ID in the params value.
	Given the file ID used does not exist
	When the user calls the web service
	Then the response code is 404
	
Scenario: The pat user calls the web service to delete a file, but does not have permissions.
	Given the suzy user does not have read permissions
	And the file "/public/Steel Wheels/Product Sales.prpt" exists
	When the user calls the web service
	Then the response code is 403
	And the file "/public/Steel Wheels/Product Sales.prpt" exists
	
Scenario: The anonymous user calls the web service to delete a file
	Given the file "/public/Steel Wheels/Product Sales.prpt" exists
	When the anonymous user calls the web service
	Then the response code is 401
	And the file "/public/Steel Wheels/Product Sales.prpt" exists
	
Scenario: The admin user calls the web service to delete a file with valid special characters in its name.
	Given the following file exists: "/home/admin/!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|.prpti" (No backslash included. That is used as an escape for the double-quotes)
	When the user calls the web service
	Then the status code is 200
	And the file no longer exists in "/home/admin/"
	But the file does exist in the trash folder
	
# This file should not actually exist due to invalid characters in the name.
Scenario: The admin user calls the web service to delete a file with invalid special characters in its name.
	When the user calls the web serivce for the file "/\.prpti"
	Then the status code is 400
	And the response body is empty

# Scenarios for folders	
Scenario Outline: <User> calls the web service to delete the folder <Path>
	Given the folder <Path> exists
	When <User> calls the web service
	Then the status code is 200
	And the folder no longer exists at <Path>
	But the folder does exist in the trash folder
	
Scenario: The admin user calls the web service to delete multiple folders in a single request.
	Given the folder "/home/admin/DeleteMe" exists
	And the folder "/public/DeleteMe" exists
	When the user calls the web service to delete the files using the folder IDs in the params parameter
	Then the status code is 200
	And the "DeleteMe" folder no longer exists in "/home/admin"
	And the "DeleteMe" folder no longer exists in "/public"
	But the "DeleteMe" folders are in the trash folder
	
Scenario: The suzy user calls the web service to delete a folder.
	Given the folder "/home/suzy/SuzyFile" exists
	And the suzy user has read permissions
	When the user calls the web service
	Then the response code is 200
	And the folder "/home/suzy/SuzyFile" no longer exists
	But the folder "SuzyFile" exists in the trash folder
	
Scenario: The suzy user calls the web service to delete a folder in another user's folder.
	Given the folder "/home/admin/MyFile" exists
	And the suzy user has read permissions
	When the user calls the web service
	Then the response code is 403
	And the folder "/home/admin/MyFile" exists
	
Scenario: The admin user calls the web service to delete a folder, but uses an invalid ID in the params value.
	Given the folder ID used does not exist
	When the user calls the web service
	Then the response code is 404
	
Scenario: The pat user calls the web service to delete a folder, but does not have permissions.
	Given the suzy user does not have read permissions
	And the folder "/public/Steel Wheels/DeleteMe" exists
	When the user calls the web service
	Then the response code is 403
	And the folder "/public/Steel Wheels/DeleteMe" exists
	
Scenario: The anonymous user calls the web service to delete a folder
	Given the folder "/public/Steel Wheels/DeleteMe" exists
	When the anonymous user calls the web service
	Then the response code is 401
	And the folder "/public/Steel Wheels/DeleteMe" exists
	
Scenario: The admin user calls the web service to delete a folder with valid special characters in its name.
	Given the following folder exists: "/home/admin/!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|" (No backslash included. That is used as an escape for the double-quotes)
	When the user calls the web service
	Then the status code is 200
	And the folder no longer exists in "/home/admin/"
	But the folder does exist in the trash folder