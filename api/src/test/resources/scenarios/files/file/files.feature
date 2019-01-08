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
Scenario Outline: <User> calls the web service to upload a file to <Path>
	Given <User> has read permissions to <Path>
	And <User> has create permissions to <Path>
	When the user calls the web service
	Then the status code is 200
	And the file exists at <Path>
	
Scenario: The suzy user attempts to upload a file to a different user's home folder.
	Given the suzy user has read permissions
	And the suzy user has create permissions
	And the path "/home/admin" exists
	When the user calls the web service
	Then the status code is 403
	And the file does not exist in "/home/admin"
	
Scenario: The pat user attempts to upload a file to their home folder, but do not have read permissions.
	Given the pat user does not have read permissions
	And the pat user has create permissions
	When the user calls the web service
	Then the status code is 403
	And the file does not exist in their home folder
	
Scenario: The tiffany user attempts to upload a file to their home folder, but do not have create permissions.
	Given the tiffany user does not have create permissions
	When the user calls the web service
	Then the status code is 403
	And the file does not exist in their home folder
	
Scenario: The admin user attempts to upload a file that already exists.
	Given the file "/home/admin/MyFile.txt" already exists
	When the user calls the web service
	Then the status code is 403
	And the file "/home/admin/MyFile.txt" was not overwritten
	
Scenario: The admin user calls the web service to upload a file with valid special characters in its name.
	Given the following path exists: "/home/admin/"
	When the user calls the web service to upload the file "!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|.prpti"
	Then the status code is 200
	And the file "/home/admin/!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|.prpti" exists
	
Scenario: The admin user calls the web service to upload a file with invalid special characters in its name.
	Given the following path exists: "/home/admin/"
	When the user calls the web serivce for the file "/\.prpti"
	Then the status code is 400
	
Scenario: The anonymous user calls the web service to upload a file.
	Given the path "/public/Steel Wheels" exists
	When the anonymous user calls the web service to upload "Anonymous.txt"
	Then the status code is 401
	And the file "/public/Steel Wheels/Anonymous.txt" does not exist
	
#GET Method
Scenario Outline: <User> calls the web service to retrieve file <FileName> at <Path>
	Given the file <FileName> at <Path> exists
	And <User> has read permissions
	And <User> has read permissions for <Path>
	And <User> has publish permissions
	When <User> calls the web service
	Then the status code is 200
	And the response header Content-Disposition contains <FileName>
	And the response header Content-Type equals <ContentType>
	
Scenario: The suzy user calls the web service to retrieve a file in a different user's folder
	Given the file "/home/admin/MyFile.xanalyzer" exists
	When the user calls the web service
	Then the status code is 404
	And the response body is empty
	
Scenario: The pat user calls the web service to retrieve a file, but does not have read permissions
	Given the file "/public/Steel Wheels/Product Sales.prpt" exists
	And the pat user does not have read permissions
	When the user calls the web service
	Then the status code is 403
	And the response header Content-Disposition does not exist
	And the response header Content-Type contains "text/html"
	
Scenario: The tiffany user calls the web service to retrieve a file, but does not have publish permissions
	Given the file "/public/Steel Wheels/Product Sales.prpt" exists
	And the tiffany user does not have publish permissions
	When the user calls the web service
	Then the status code is 403
	And the response body is empty
	
Scenario: The anonymous user calls the web service to retrieve a file
	Given the file "/public/Steel Wheels/Product Sales.prpt" exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the response header Content-Disposition does not exist
	And the response header Content-Type contains "text/html"
	
Scenario: The admin user calls the web service to retrieve a file with valid special characters in its name.
	Given the following file exists: "/home/admin/!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|.prpti" (No backslash included. That is used as an escape for the double-quotes)
	When the user calls the web service
	Then the status code is 200
	And the response header Content-Disposition contains "!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|.prpti" (No backslash included. That is used as an escape for the double-quotes)
	And the response header Content-Type contains "text/xml"
	
# This file should not actually exist due to invalid characters in the name.
Scenario: The admin user calls the web service to retrieve a file with invalid special characters in its name.
	When the user calls the web serivce for the file "/\.prpti"
	Then the status code is 400
	And the response body is empty