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
Scenario Outline: <User> calls the web service to delete the locale properties for the file <Path> and the locale <Locale>.
	Given <User> has read permissions
	And <User> has create content permissions
	And the file <Path> exists
	When the user calls the web service
	Then the status code is 200
	And the properties for <Locale> have been deleted
Examples:
	| User | Path | Locale |
	| admin | /home/admin/myFile.prpt | default |
	| admin | /home/admin/myFile.prpt | en |
	| admin | /home/admin/myFile.prpt | fr |
	| admin | /home/admin/myFile.prpt | de |
	| admin | /public/Steel Wheels/Product Sales.prpt | ja |
	| suzy | /home/suzy/myFile.prpt | fr |
	| admin | /home/admin/!@#$%^&*()_-=+;:'"?<>,.`~[]{}|.prpti | de |
	
Scenario: A user calls the web service to delete the locale properties for a file, but no properties exist for the specified locale.
	Given the user has read permissions
	And the user has create content permissions
	And the file exists
	And the file does not have locale properties set
	When the user calls the web service
	Then the status code is 404
	
Scenario: A user calls the web service to delete the locale properties for a file, but does not use the "locale" parameter
	Given the user has read permissions
	And the user has create content permissions
	And the file exists
	When the user calls the web service
	Then the status code is 400
	And the locale properties are unaffected for the file.
	
Scenario: A user calls the web service to delete the locale properties for a file in another user's home directory.
	Given the user has read permissions
	And the user as create content permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the locale properties have not been deleted
	
Scenario: A user with read permissions attempts to delete locale properties for a file, but does not have create content permissions
	Given the user has read permissions
	And the user does not have create content permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the locale properties have not been deleted
	
Scenario: A user with create content permissions attempts to delete locale properties for a file, but does not have read permissions
	Given the user has create content permissions
	And the user does not have read permissions
	And the file exists
	When the user calls the web service
	Then the status code is 403
	And the locale properties have not been deleted
	
Scenario: A user attempts to delete locale properties for a non-existant file with invalid characters in the name.
	Given the user has create content permissions
	And the user has read permissions
	When the user calls the web service with a value for pathId that contains invalid special characters
	Then the status code is 400
	And the locale properties have not been deleted
Examples:
	| pathId |
	| :home:admin:/.prpt |
	| :home:admin:\.prpt |
	
Scenario: The anonymous user attempts to delete locale properties for a file.
	Given the file exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the locale properties have not been updated
	
Scenario: The user attempts to delete locale properties for a file that does not exist.
	Given the user has create content permissions
	And the user has read permissions
	When the user calls the web service
	Then the status code is 404