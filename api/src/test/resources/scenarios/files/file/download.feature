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

#Files
Scenario Outline: <User> calls the web service to download the file <Path>.
	Given <User> has read content permissions
	And <User> has create content permissions
	And the file <Path> exists
	When the user calls the web service
	Then the status code is 200
	And the response includes an attached zip file
	And the response's Content-Disposition header value contains "filename="
Examples:
	| User | Path |
	| admin | /home/admin/MyFile.prpt |
	| admin | /public/Steel Wheels/Product Sales.prpt |
	| suzy | /home/suzy/MyFile.prpt |
	| suzy | /public/Steel Wheels/Product Sales.prpt |
	| admin | /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}|.prpt |
	
Scenario: A user calls the web service to download a file using the user-agent header.
	Given the user has read content permissions
	And the user has create content permissions
	And the file exists
	When the user calls the web service with the User-Agent header's value set to "Firefox"
	Then the status code is 200
	And the response includes an attached zip file
	And the response's Content-Disposition header value contains "filename*=UTF-8"
	
Scenario: A user calls the web service to download a file using the user-agent header, but with an unexpected value.
	Given the user has read content permissions
	And the user has create content permissions
	And the file exists
	When the user calls the web service with the User-Agent header's value set to "Chrome"
	Then the status code is 200
	And the response includes an attached zip file
	And the response's Content-Disposition header value contains "filename="
	
Scenario: A user calls the web service to download a file in another user's home directory.
	Given the user has read content permissions
	And the user has create content permissions
	And the file exists
	And the user does not have access to the directory.
	When the user calls the web service
	Then the status code is 403
	And the response does not include an attached zip file
	
Scenario: A user calls the web service to download a file, but does not have read permissions
	Given the user does not have read content permissions
	And the user has create content permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the response does not include an attached zip file
	
Scenario: A user calls the web service to download a file, but does not have create permissions
	Given the user has read content permissions
	And the user does not have create content permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the response does not include an attached zip file
	
Scenario: A user calls the web service to download a non-existant file that has invalid characters
	Given the user has read content permissions
	And the user has create content permissions
	When the user calls the web service
	Then the status code is 400
	And the response does not include an attached zip file
Examples:
	| pathId |
	| :home:admin:/.prpt |
	| :home:admin:\.prpt |
	
Scenario: The anonymous user calls the web service to download a file.
	Given the file exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the response does not include an attached zip file
	
Scenario: The user calls the web service to download a non-existant file.
	Given the user has read content permissions
	And the user has create content permissions
	And the file does not exist
	When the user calls the web service
	Then the status code is 404
	And the response does not include an attached zip file
	
#Directories
Scenario Outline: <User> calls the web service to download the directory <Path> and the withManifest query string value set to <trueORfalse>.
	Given <User> has read content permissions
	And <User> has create content permissions
	And the directory <Path> exists
	When the user calls the web service
	Then the status code is 200
	And the response includes an attached zip file
	And the zip file contains "exportManifest.xml" is <trueORfalse>
	And the response's Content-Disposition header value contains "filename="
Examples:
	| User | Path | trueORfalse |
	| admin | /home/admin | true |
	| admin | /public/Steel Wheels | false |
	| suzy | /home/suzy| false |
	| suzy | /public/Steel Wheels | true |
	| admin | /public/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| | true |
	| admin | /public/!@#$%^&*()_-=+;:'"?<>,.`~[]{}| | false |
	
#Verify default value for parameter when the parameter is not included
Scenario: A user calls the web service to download a directory.
	Given the user has read content permissions
	And the user has create content permissions
	And the directory exists
	And the withManifest parameter is not used
	When the user calls the web service
	Then the status code is 200
	And the response includes an attached zip file
	And the zip file contains "exportManifest.xml"
	
#Verify default value for parameter when the parameter value is null
Scenario: A user calls the web service to download a directory.
	Given the user has read content permissions
	And the user has create content permissions
	And the directory exists
	And the withManifest parameter value is null
	When the user calls the web service
	Then the status code is 200
	And the response includes an attached zip file
	And the zip file contains "exportManifest.xml"

Scenario: A user calls the web service to download a directory using the user-agent header.
	Given the user has read content permissions
	And the user has create content permissions
	And the directory exists
	When the user calls the web service with the User-Agent header's value set to "Firefox"
	Then the status code is 200
	And the response includes an attached zip file
	And the response's Content-Disposition header value contains "filename*=UTF-8"
	
Scenario: A user calls the web service to download a directory using the user-agent header, but with an unexpected value.
	Given the user has read content permissions
	And the user has create content permissions
	And the directory exists
	When the user calls the web service with the User-Agent header's value set to "Chrome"
	Then the status code is 200
	And the response includes an attached zip file
	And the response's Content-Disposition header value contains "filename="
	
Scenario: A user calls the web service to download a directory in another user's home directory.
	Given the user has read content permissions
	And the user has create content permissions
	And the file exists
	And the user does not have access to the directory.
	When the user calls the web service
	Then the status code is 403
	And the response does not include an attached zip file
	
Scenario: A user calls the web service to download a directory, but does not have read permissions
	Given the user does not have read content permissions
	And the user has create content permissions
	And the directory exists
	When the user calls the web service
	Then the status code is 403
	And the response does not include an attached zip file
	
Scenario: A user calls the web service to download a directory, but does not have create permissions
	Given the user has read content permissions
	And the user does not have create content permissions
	And the directory exists
	When the user calls the web service
	Then the status code is 403
	And the response does not include an attached zip file
	
Scenario: A user calls the web service to download a non-existant directory that has invalid characters
	Given the user has read content permissions
	And the user has create content permissions
	When the user calls the web service
	Then the status code is 400
	And the response does not include an attached zip file
Examples:
	| pathId |
	| :home:admin:/ |
	| :home:admin:\ |
	
Scenario: The anonymous user calls the web service to download a directory.
	Given the directory exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the response does not include an attached zip file
	
Scenario: The user calls the web service to download a non-existant directory.
	Given the user has read content permissions
	And the user has create content permissions
	And the directory does not exist
	When the user calls the web service
	Then the status code is 404
	And the response does not include an attached zip file