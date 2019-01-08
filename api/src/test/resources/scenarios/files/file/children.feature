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
Scenario Outline: <User> calls web service to retrieve the list of files/folders and their permission information within <Path>.
	Given <User> has read permissions
	And <Path> is a valid path
	And <Path> is not hidden
	When <User> retrieves the list of files/folders within <Path>
	Then The response code is 200
	And the response body contains "<repositoryFileTreeDto>"
	And the response body contains "<repositoryFileAclDto>"
	
Scenario: Admin user calls web service to retrieve the list of files/folders with permission information in JSON format.
	Given the path "/public/Steel Wheels/Widget Library" exists
	And the folder is not hidden
	When the admin retrieves the list of files/folders within "/public/Steel Wheels/Widget Library"
	Then the response code is 200
	And the response body contains the following:
		"file": {
	And the response body contains the following:
		"repositoryFileAclDto": [
		
Scenario: The suzy user calls the web service to retrieve the list of files/folders
	Given the path "/public/Steel Wheels" exists
	And the suzy user has read permissions
	And the folder is not hidden
	When the suzy user retrieves the list of files/folders within "/public/Steel Wheels"
	Then the status code is 200
	And the response body contains "<path>/public/Steel Wheels/Widget Library</path>"
	And the response body does not contain "<path>/public/Steel Wheels/Widget Library/Analysis Views</path>"
	
Scenario Outline: <User> calls the web service to retrieve the list of files/folders at <Path> filtering by <FileType>, <ChildNode>, and <Members>
	Given <User> has read permissions
	And <Path> exists
	When <User> retrieves the list of files/folders with a filter parameter specified
	Then the status code is 200
	And the response body only contains child files/folders of the type <Type>
	And the response body only contains files with the name/type <ChildNode>
	And the response body <IncludesOrExcludes> the members <Members>
	
Scenario: The admin user calls the web service to retrieve the list of files/folders including those that are hidden
	Given the path "/public/bi-developers" exists
	And the folder "/public/bi-developers" is hidden
	When the admin user retrieves the list of files/folders within "/public" with the showHidden parameter's value set to true
	Then the status code is 200
	And the response body contains "<path>/public/bi-developers</path>"
	
Scenario: The admin user calls the web service to retrieve the list of files/folders excluding those that are hidden
	Given the path "/public/bi-developers" exists
	And the folder "/public/bi-developers" is hidden
	And the folder "/public/Steel Wheels" is not hidden
	When the admin user retrieves the list of files/folders within "/public" with the showHidden parameter's value set to false
	Then the status code is 200
	And the response body contains "<path>/public/Steel Wheels</path>"
	But the response body does not contain "<path>/public/bi-developers</path>"
	
Scenario: The admin user calls the web service to retrieve the list of files/folders that excludes permission information
	Given the path "/public/Steel Wheels" exists
	When the admin user retrieves the list of files/folders within "/public" with the includeAcls parameter's value set to false
	Then the status code is 200
	And the response body contains "<path>/public/Steel Wheels</path>"
	But the response body does not contain "<repositoryFileAclDto>"
	
Scenario: The suzy user calls the web service to retrieve the list of files/folders within a different user's folder.
	Given the path "/home/admin" exists
	When the suzy user retrieves the list of files/folders
	Then the status code is 403
	And the response body does not contain "<path>/home/admin</path>"
	
Scenario: The anonymous user calls the web service to retrieve the list of files/folders.
	Given the path "/public/Steel Wheels" exists
	When the anonymous user retrieves the list of files/folders
	Then the status code is 401
	And the response body does not contain "<repositoryFileTreeDto>"
	
Scenario: The pat user calls the web service to retrieve the list of files/folders but does not have read permissoins.
	Given the pat user does not have read permissions
	And the path "/public/Steel Wheels" exists
	Then the status code is 403
	And the response body does not contain "<repositoryFileTreeDto>"
	
Scenario: Admin calls web service to retrieve the list of files/folders within a folder with valid special characters in its name.
	Given the following folder exists: "/home/admin/!@#$%^&*()_-=+;:'\"?<>,.`~[]{}|" (No backslash included. That is used as an escape for the double-quotes)
	When the user calls the web service
	Then the status code is 200
	And the response body contains "<repositoryFileTreeDto>"
	
# This file should not actually exist due to invalid characters in the name.
Scenario: Admin calls web service to retrieve the list of files/folders within a folder with invalid special characters in its name.
	When the user calls the web serivce for the folder "/\\" (only one backslash. Two are used because it is an excape character in the syntax)
	Then the status code is 400
	And the response body is empty