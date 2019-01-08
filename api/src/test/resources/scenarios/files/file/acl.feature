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

#PUT Method
Scenario Outline: <User> calls the web service to update the ACL of the file <Path>
	Given <User> has read permissions
	And <User> has create permissions
	And <User> has Manage Permissions enabled for <Path>
	And the file <Path> exists
	When <User> calls the web service
	Then the status code is 200
	And the ACL for <Path> has been updated
	
Scenario: The admin user calls the web service to update the ACL of a file using JSON format
	Given "/home/admin/MyFile.txt" exists
	When the user calls the web service with the request body in JSON format
	Then the status code is 200
	And the ACL for "/home/admin/MyFile.txt" has been updated.
	
Scenario: The suzy user attempts to update the ACL of a file in a different user's directory.
	Given "/home/admin/MyFile.txt" exists
	When the user calls the web service
	Then the status code is 403
	And the ACL of the file has not been updated.
	
Scenario: The pat user attempts to update the ACL of a file, but does not have read permissions
	Given the pat user does not have read permissions
	And "/home/pat/MyFile.txt" exists
	When the user calls the web service
	Then the status code is 403
	And the ACL of the file has not been updated.
	
Scenario: The tiffany user attempts to update the ACL of a file, but does not have create permissions
	Given the tiffany user does not have create permissions
	And "/home/tiffany/MyFile.txt" exists
	When the user calls the web service
	Then the status code is 403
	And the ACL of the file has not been updated.
	
Scenario: The tom user attempts to update the ACL of a file, but does not have manage permissions set in the ACL
	Given the tom user does not have manage permissions
	And "/public/Steel Wheels/Product Sales.prpt" exists
	When the user calls the web service
	Then the status code is 403
	And the ACL of the file has not been updated.
	
Scenario: The admin user attempts to update the ACL of a file, but puts malformed XML in the request body.
	Given the file exists
	When the user calls the web service
	Then the status code is 400
	And the ACL of the file has not been updated.
	
Scenario: The anonymous user attempts to update the ACL of a file
	Given the file exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the ACL of the file has not been updated
	
Scenario: The admin user attempts to update the ACL of a file that does not exists
	Given the file does not exists
	When the user calls the web service
	Then the status code is 404
	
Scenario: The admin user calls the web service to update the ACL of a file with valid special characters in its name.
	Given the following file exists: "/home/admin/!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|.prpti" (No backslash included. That is used as an escape for the double-quotes)
	When the user calls the web service
	Then the status code is 200
	And the ACL of the file has been updated
	
# This file should not actually exist due to invalid characters in the name.
Scenario: The admin user calls the web service to update the ACL of a file with invalid special characters in its name.
	When the user calls the web serivce for the file "/\.prpti"
	Then the status code is 400
	And the ACL of the file has not been updated
	
# GET Method
Scenario: <User> calls the web service to retrieve the ACL for the file <Path>
	Given the file <Path> exists
	When <User> calls the web service
	Then the status code is 200
	And the response body contains "<repositoryFileAclDto>"
	
Scenario: The admin user calls the web service to retrieve the ACL for a file in JSON format
	Given the file "/home/admin/MyFile.txt" exists
	When the user calls the web service
	Then the status code is 200
	And the response body contains the following:
		{"aces":
		
Scenario: The suzy user attempts to retrieve the ACL of a file in a different user's directory.
	Given "/home/admin/MyFile.txt" exists
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain "<repositoryFileAclDto>"
	
Scenario: The pat user attempts to retrieve the ACL of a file, but does not have read permissions
	Given the pat user does not have read permissions
	And "/home/pat/MyFile.txt" exists
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain "<repositoryFileAclDto>"
	
Scenario: The tom user attempts to retrieve the ACL of a file, but does not have manage permissions set in the ACL
	Given the tom user does not have manage permissions
	And "/public/Steel Wheels/Product Sales.prpt" exists
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain "<repositoryFileAclDto>"
	
Scenario: The anonymous user attempts to retrieve the ACL of a file
	Given the file exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the response body does not contain "<repositoryFileAclDto>"
	
Scenario: The admin user attempts to retrieve the ACL of a file that does not exists
	Given the file does not exists
	When the user calls the web service
	Then the status code is 404
	And the response body does not contain "<repositoryFileAclDto>"
	
Scenario: The admin user calls the web service to retrieve the ACL of a file with valid special characters in its name.
	Given the following file exists: "/home/admin/!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|.prpti" (No backslash included. That is used as an escape for the double-quotes)
	When the user calls the web service
	Then the status code is 200
	And the response body contains "<repositoryFileAclDto>"
	
# This file should not actually exist due to invalid characters in the name.
Scenario: The admin user calls the web service to retrieve the ACL of a file with invalid special characters in its name.
	When the user calls the web serivce for the file "/\.prpti"
	Then the status code is 400
	And the response body does not contain "<repositoryFileAclDto>"