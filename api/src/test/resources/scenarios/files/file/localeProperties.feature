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
Scenario Outline: <User> retrieves the locale properties in XML format for the file <Path> for the <Locale> locale.
	Given <User> has read permissions
	And the file at <Path> exists
	And there is an associated value for the key "file.title" for the <Locale> locale
	When <User> calls the web service with the header "Accept: application/xml"
	Then the status code is 200
	And the response body contains "<stringKeyStringValueDtoes>"
	And the response body contains "<key>file.title</key>"
Examples:
	| User | Path | Locale |
	| admin | /home/admin/myFile.prpt | default |
	| admin | /home/admin/myFile.prpt | en |
	| admin | /home/admin/myFile.prpt | fr |
	| admin | /home/admin/myFile.prpt | de |
	| admin | /public/Steel Wheels/Product Sales.prpt | ja |
	| suzy | /home/suzy/myFile.prpt | fr |
	| suzy | /public/Steel Wheels/Product Sales.prpt | ja |
	| admin | /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}|.prpti | de |
	
Scenario: A user retrieves the locale properties in JSON format for a file.
	Given the user has read permissions
	And the file exists
	And there is an associated value for the key "file.title" for the "de" locale
	When the user calls the web service with the header "Accept: application/json"
	Then the status code is 200
	And the response body contains the following:
		{"stringKeyStringValueDto":[
	And the response body contains the following:
		{"key":"file.title","value":
		
Scenario: A user retrieves the locale properties for a file that does not have properties for the specified locale.
	Given the user has read permissions
	And the file exists
	And there are no properties for the specified locale
	When the user calls the web service
	Then the status code is 200
	And the response body contains "<stringKeyStringValueDtoes>"
	But the resopnse body does not contain "<key>"
	
# The default value for locale is "default"
Scenario: A user attempts to retrieve the locale properties for a file without specifying a locale
	Given the user has read permissions
	And the file exists
	And the query string parameter "locale" is not used
	When the user calls the web service
	Then the status code is 200
	And the response body contains "<stringKeyStringValueDtoes>"
	And the response body contains "<key>file.title</key>"
	And the response body contains "<value>" + NameOfFile + "</value>"
		
Scenario: A user attempts to retrieve the locale properties of a file in a different user's home directory.
	Given the file exists
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain "<stringKeyStringValueDtoes>"
	
Scenario: A user who does not have read permissions attempts to retrieve the locale properties of a file
	Given the file exists
	And the user does not have read permissions
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain "<stringKeyStringValueDtoes>"
	
Scenario: A user attempts to retrieve the locale properties of a non-existant file with invalid characters
	Given the user has read permissions
	When the user calls the web service with a value for pathId that contains invalid special characters
	Then the status code is 400
	And the response body does not contain "<stringKeyStringValueDtoes>"
Examples:
	| pathId |
	| :home:admin:/.prpt |
	| :home:admin:\.prpt |
	
Scenario: The anonymous user attempts to retrieve the locale properties of a file.
	Given the file exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the response body does not contain "<stringKeyStringValueDtoes>"
	

Scenario: The user attempts to retrieve the locale properties of a file that does not exist.
	Given the user has read permissions
	When the user calls the web service
	Then the status code is 404
	And the response body does not contain "<stringKeyStringValueDtoes>"

# PUT Method
Scenario Outline: <User> saves a list of properties for the file <Path> and the locale <Locale>
	Given <User> has read permissions
	And <User> has create content permissions
	And the file <Path> exists
	When the user calls the web service
	Then the status code is 200
	And the locale properties for the file have been updated for <Locale>
Examples:
	| User | Path | Locale |
	| admin | /home/admin/myFile.prpt | default |
	| admin | /home/admin/myFile.prpt | en |
	| admin | /home/admin/myFile.prpt | fr |
	| admin | /home/admin/myFile.prpt | de |
	| admin | /public/Steel Wheels/Product Sales.prpt | ja |
	| suzy | /home/suzy/myFile.prpt | fr |
	| admin | /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}|.prpti | de |
	
Scenario: A user updates a list of properties for a file.
	Given the user has read permissions
	And the user as create content permissions
	And the file exists
	And locale properties already exist for the specified locale
	When the user calls the web service
	Then the status code is 200
	And the locale properties have been updated
	
Scenario: A user attempts to save a list of properties for a file without specifying any content in the request body.
	Given the user has read permissions
	And the user as create content permissions
	And the file exists
	When the user calls the web service with a blank request body
	Then the status code is 400
	And the locale properties have not been updated
	
Scenario: A user attempts to save a list of properties for a file and uses invalid XML in the request body
	Given the user has read permissions
	And the user as create content permissions
	And the file exists
	When the user calls the web service with invalid XML in the request body
	Then the status code is 400
	And the locale properties have not been updated
	
Scenario: A user attempts to save a list of properties for a file without specifying the "locale" query parameter
	Given the user has read permissions
	And the user as create content permissions
	And the file exists
	When the user calls the web service without using the "locale" query parameter
	Then the status code is 400
	And the locale properties have not been updated
	
Scenario: A user attempts to save a list of properties for a file within another user's home directory.
	Given the user has read permissions
	And the user as create content permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the locale properties have not been updated
	
Scenario: A user with read permissions attempts to save a list of properties for a file, but does not have create content permissions
	Given the user has read permissions
	And the user does not have create content permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the locale properties have not been updated
	
Scenario: A user with create content permissions attempts to save a list of locale properties for a file, but does not have read permissions
	Given the user has create content permissions
	And the user does not have read permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the locale properties have not been updated
	
Scenario: A user attempts to save a list of locale properties for a non-existant file with invalid characters in the name.
	Given the user has create content permissions
	And the user has read permissions
	When the user calls the web service with a value for pathId that contains invalid special characters
	Then the status code is 400
	And the locale properties have not been updated
Examples:
	| pathId |
	| :home:admin:/.prpt |
	| :home:admin:\.prpt |
	
Scenario: The anonymous user attempts to save a list of locale properties for a file.
	Given the file exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the locale properties have not been updated
	
Scenario: The user attempts to save a list of locale properties for a file that does not exist.
	Given the user has create content permissions
	And the user has read permissions
	When the user calls the web service
	Then the status code is 404