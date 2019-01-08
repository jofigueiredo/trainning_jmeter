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
Scenario Outline: <User> retrieves the locale maps in XML format for the file at <Path>
	Given <User> has read permissions
	And the file at <Path> exists
	When the user calls the web service with the header "Accept: application/xml"
	Then the status code is 200
	And the response body contains "<localeMapDtoes>"
Examples:
	| User | Path |
	| admin | /home/admin/myFile.prpt |
	| admin | /public/Steel Wheels/Product Sales.prpt |
	| suzy | /home/suzy/myFile.prpt |
	| admin | /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}|.prpti |
	
Scenario: A user retreives the locale maps for a file in JSON format
	Given the user has read permissions
	And the file exists
	When the user calls the web service with the header "Accept: application/json"
	Then the status code is 200
	And the response body contains the following:
		{"localeMapDto":[
		
Scenario: The user attempts to retrieve the locale maps for a file that does not exist.
	Given the user has read permissions
	And the file a the specified path does not exist
	When the user calls the web service
	Then the status code is 404
	And the response body does not contain "<localeMapDtoes>"
		
Scenario: A user attempts to retrieve the locale maps for a file from a different user's home directory.
	Given the file exists
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain "<localeMapDtoes>"
		
Scenario: A user that does not have read permissions attempts to retrieve the locale maps for a file.
	Given the user does not have read permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain "<localeMapDtoes>"
	
Scenario: A user attempts to retrieve the locale maps for a non-existant file that contains invalid special characters in its name
	Given the user has read permissions
	When the user calls the web service
	Then the status code is 400
	And the response body does not contain "<localeMapDtoes>"
Examples:
	| pathId |
	| :home:admin:/.prpti |
	| :home:admin:\.prpti |
	
Scenario: The anonymous user attempts to retrieve the locale maps for a file.
	Given the file exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the response body does not contain "<localeMapDtoes>"
	
Scenario: The user attempts to retrieve the locale maps for a file that does not exist.
	Given the user has read permissions
	When the user calls the web service
	Then the status code is 404
	And the response body does not contain "<localeMapDtoes>"