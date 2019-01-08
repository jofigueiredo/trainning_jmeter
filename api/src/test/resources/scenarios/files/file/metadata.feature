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

# GET method
Scenario Outline: A valid user calls the web service to retrieve the metadata of a path in the repository. #TC1
	Given <Path> exists
	When the <User> gets the metadata of <Path>
	Then the status code is 200
	And the _PERM_SCHEDULABLE property value is "true"
	And the _PERM_HIDDEN property value is "false"
Examples:
	| User  | Path                                                 | #TC1
	| admin | :home:admin:metadataTest:TestPAZ1.xanalyzer          | #TC1.1
	| admin | :public:Steel Wheels:metadataTest:TestPAZ2.xanalyzer | #TC1.2
	| suzy  | :home:suzy:metadataTest:TestPAZ4.xanalyzer           | #TC1.3
	| suzy  | :public:Steel Wheels:metadataTest:TestPAZ5.xanalyzer | #TC1.4

Scenario Outline: A valid user calls the web service to retrieve the metadata of a path that contains valid special characters.
	Given <Path> exists
	When the user gets the metadata of <Path>
	Then the status code is 200
	And the _PERM_SCHEDULABLE property value is "true"
	And the _PERM_HIDDEN property value is "false"
Examples:
	| Path                                   | #TC2
	| /home/admin/metadataTest/!.xanalyzer   | #TC2.1
	| /home/admin/metadataTest/!             | #TC2.2
	| /home/admin/metadataTest/@.xanalyzer   | #TC2.3
	| /home/admin/metadataTest/@             | #TC2.4
	| /home/admin/metadataTest/$.xanalyzer   | #TC2.5
	| /home/admin/metadataTest/$             | #TC2.6
	| /home/admin/metadataTest/*.xanalyzer   | #TC2.7
	| /home/admin/metadataTest/*             | #TC2.8
	| /home/admin/metadataTest/(.xanalyzer   | #TC2.9
	| /home/admin/metadataTest/(             | #TC2.10
	| /home/admin/metadataTest/).xanalyzer   | #TC2.11
	| /home/admin/metadataTest/)             | #TC2.12
	| /home/admin/metadataTest/_.xanalyzer   | #TC2.13
	| /home/admin/metadataTest/_             | #TC2.14
	| /home/admin/metadataTest/-.xanalyzer   | #TC2.15
	| /home/admin/metadataTest/-             | #TC2.16
	| /home/admin/metadataTest/=.xanalyzer   | #TC2.17
	| /home/admin/metadataTest/=             | #TC2.18
	| /home/admin/metadataTest/'.xanalyzer   | #TC2.19
	| /home/admin/metadataTest/'             | #TC2.20
	| /home/admin/metadataTest/,.xanalyzer   | #TC2.21
	| /home/admin/metadataTest/,             | #TC2.22
	| /home/admin/metadataTest/~.xanalyzer   | #TC2.23
	| /home/admin/metadataTest/~             | #TC2.24
	| /home/admin/metadataTest/%23.xanalyzer | #TC2.25
	| /home/admin/metadataTest/%23           | #TC2.26
	| /home/admin/metadataTest/%25.xanalyzer | #TC2.27
	| /home/admin/metadataTest/%25           | #TC2.28
	| /home/admin/metadataTest/%5E.xanalyzer | #TC2.29
	| /home/admin/metadataTest/%5E           | #TC2.30
	| /home/admin/metadataTest/%26.xanalyzer | #TC2.31
	| /home/admin/metadataTest/%26           | #TC2.32
	| /home/admin/metadataTest/%2B.xanalyzer | #TC2.33
	| /home/admin/metadataTest/%2B           | #TC2.34
	| /home/admin/metadataTest/%3B.xanalyzer | #TC2.35
	| /home/admin/metadataTest/%3B           | #TC2.36
	| /home/admin/metadataTest/%3A.xanalyzer | #TC2.37
	| /home/admin/metadataTest/%3A           | #TC2.38
	| /home/admin/metadataTest/%22.xanalyzer | #TC2.39
	| /home/admin/metadataTest/%22           | #TC2.40
	| /home/admin/metadataTest/%3F.xanalyzer | #TC2.41
	| /home/admin/metadataTest/%3F           | #TC2.42
	| /home/admin/metadataTest/%3C.xanalyzer | #TC2.43
	| /home/admin/metadataTest/%3C           | #TC2.44
	| /home/admin/metadataTest/%3E.xanalyzer | #TC2.45
	| /home/admin/metadataTest/%3E           | #TC2.46
	| /home/admin/metadataTest/%60.xanalyzer | #TC2.47
	| /home/admin/metadataTest/%60           | #TC2.48
	| /home/admin/metadataTest/%5B.xanalyzer | #TC2.49
	| /home/admin/metadataTest/%5B           | #TC2.50
	| /home/admin/metadataTest/%5D.xanalyzer | #TC2.51
	| /home/admin/metadataTest/%5D           | #TC2.52
	| /home/admin/metadataTest/%7B.xanalyzer | #TC2.53
	| /home/admin/metadataTest/%7B           | #TC2.54
	| /home/admin/metadataTest/%7D.xanalyzer | #TC2.55
	| /home/admin/metadataTest/%7D           | #TC2.56
	| /home/admin/metadataTest/%7C.xanalyzer | #TC2.57
	| /home/admin/metadataTest/%7C           | #TC2.58
	| /home/admin/metadataTest/%21.xanalyzer | #TC2.59
	| /home/admin/metadataTest/%21           | #TC2.60
	| /home/admin/metadataTest/%40.xanalyzer | #TC2.61
	| /home/admin/metadataTest/%40           | #TC2.62
	| /home/admin/metadataTest/%24.xanalyzer | #TC2.63
	| /home/admin/metadataTest/%24           | #TC2.64
	| /home/admin/metadataTest/%2A.xanalyzer | #TC2.65
	| /home/admin/metadataTest/%2A           | #TC2.66
	| /home/admin/metadataTest/%28.xanalyzer | #TC2.67
	| /home/admin/metadataTest/%28           | #TC2.68
	| /home/admin/metadataTest/%29.xanalyzer | #TC2.69
	| /home/admin/metadataTest/%29           | #TC2.70
	| /home/admin/metadataTest/%5F.xanalyzer | #TC2.71
	| /home/admin/metadataTest/%5F           | #TC2.72
	| /home/admin/metadataTest/%2D.xanalyzer | #TC2.73
	| /home/admin/metadataTest/%2D           | #TC2.74
	| /home/admin/metadataTest/%3D.xanalyzer | #TC2.75
	| /home/admin/metadataTest/%3D           | #TC2.76
	| /home/admin/metadataTest/%27.xanalyzer | #TC2.77
	| /home/admin/metadataTest/%27           | #TC2.78
	| /home/admin/metadataTest/%2C.xanalyzer | #TC2.79
	| /home/admin/metadataTest/%2C           | #TC2.80
	| /home/admin/metadataTest/%7E.xanalyzer | #TC2.81
	| /home/admin/metadataTest/%7E           | #TC2.82

Scenario: A non-admin user calls the web service to retrieve the metadata of a path that exists in a different user's directory. #TC3
	Given the path exists
	And the user has read permissions
	When The user gets the metadata of the path from a different user's home directory
	Then the status code is 403
	And the response body does not contain metadata values

Scenario: The anonymous user calls the web service to retrieve the metadata of a path that exists. #TC4
	Given <Path> exists
	And no authentication is used in the request
	When the anonymous user gets the metadata of path <Path>
	Then the status code is 401
	And the response body does not contain metadata values
Examples:
	| Path                                                             | #TC4
	| :home:admin:metadataTest:TestPAZUnauthorized1.xanalyzer          | #TC4.1
	| :public:Steel Wheels:metadataTest:TestPAZUnauthorized2.xanalyzer | #TC4.2
	
# The user's role does not have the read permission, but this currently disregards the "Authenticated" system permission that has read permissions by default, resulting in a 200 status code. Ticket QUALITY-5592 should address this.
Scenario: A user with no permissions calls the web service to retrieve the metadata of a path that exists. #TC5
	Given the user does not have read permissions.
	And the path exists
	When the user gets the metadata of the path
	Then the status code is 200
	And the _PERM_SCHEDULABLE property value is "true"
	And the _PERM_HIDDEN property value is "false"
	
Scenario: The admin user calls the web service to retrieve the metadata of a path that does not exist. #TC6
	Given the path does not exist
	When the admin user attempts to get the metadata of the path
	Then the status code is 404
	And the response body does not contain metadata values
	
# This path should not actually exist due to invalid characters in the name.
Scenario: Admin user calls the web service to retrieve the metadata of a path with invalid special characters in its name. #TC7
	When the user calls the web service for the path <Path>
	Then the status code is 400
	And the response body is empty
Examples:
	| Path                                   | #TC7
	| :home:admin:metadataTest:%2F.xanalyzer | #TC7.1
	| :home:admin:metadataTest:%2F           | #TC7.2
	| :home:admin:metadataTest:%5C.xanalyzer | #TC7.3
	| :home:admin:metadataTest:%5C           | #TC7.4

# PUT Method
Scenario Outline: A valid user calls the web service to set the metadata using XML format. #TC8
	Given <Path> exists
	When <User> sets the path <Path> metadata property _PERM_SCHEDULABLE to "false" using XML format
	And <User> sets the path <Path> metadata property _PERM_HIDDEN to "true" using XML format
	Then the status code is 200
	And the _PERM_SCHEDULABLE property value is "false"
	And the _PERM_HIDDEN property value is "true"
Examples:
	| User  | Path                                                         | #TC8
	| admin | :home:admin:metadataTest:TestPAZAdminXML1.xanalyzer          | #TC8.1
	| suzy  | :home:suzy:metadataTest:TestPAZSuzyXML1.xanalyzer            | #TC8.2
	| admin | :public:Steel Wheels:metadataTest:TestPAZAdminXML2.xanalyzer | #TC8.3
	
Scenario: A valid user calls the web service to set the metadata of a path using JSON format. #TC9
	Given the path exists at <Path>
	When <User> sets the path <Path> metadata property _PERM_SCHEDULABLE to "false" using JSON format
	And <User> sets the path <Path> metadata property _PERM_HIDDEN to "true" using using JSON format
	Then the status code is 200
	And the _PERM_SCHEDULABLE property value is "false"
	And the _PERM_HIDDEN property value is "true"
Examples:
	| User  | Path                                                          | #TC9
    | admin | :home:admin:metadataTest:TestPAZAdminJSON1.xanalyzer          | #TC9.1
	| suzy  | :home:suzy:metadataTest:TestPAZSuzyJSON1.xanalyzer            | #TC9.2
	| admin | :public:Steel Wheels:metadataTest:TestPAZAdminJSON2.xanalyzer | #TC9.3
	
Scenario Outline: A valid user calls the web service to set the metadata of a path that contains valid special characters. #TC10
	Given <Path> exists
	When the user sets the path <Path> metadata property _PERM_SCHEDULABLE to "false"
	And the user sets the path <Path> metadata property _PERM_HIDDEN to "true"
	Then the status code is 200
	And the _PERM_SCHEDULABLE property value is "false"
	And the _PERM_HIDDEN property value is "true"
Examples:
	| Path                                   | #TC10
	| /home/admin/metadataTest/!.xanalyzer   | #TC10.1
	| /home/admin/metadataTest/!             | #TC10.2
	| /home/admin/metadataTest/@.xanalyzer   | #TC10.3
	| /home/admin/metadataTest/@             | #TC10.4
	| /home/admin/metadataTest/$.xanalyzer   | #TC10.5
	| /home/admin/metadataTest/$             | #TC10.6
	| /home/admin/metadataTest/*.xanalyzer   | #TC10.7
	| /home/admin/metadataTest/*             | #TC10.8
	| /home/admin/metadataTest/(.xanalyzer   | #TC10.9
	| /home/admin/metadataTest/(             | #TC10.10
	| /home/admin/metadataTest/).xanalyzer   | #TC10.11
	| /home/admin/metadataTest/)             | #TC10.12
	| /home/admin/metadataTest/_.xanalyzer   | #TC10.13
	| /home/admin/metadataTest/_             | #TC10.14
	| /home/admin/metadataTest/-.xanalyzer   | #TC10.15
	| /home/admin/metadataTest/-             | #TC10.16
	| /home/admin/metadataTest/=.xanalyzer   | #TC10.17
	| /home/admin/metadataTest/=             | #TC10.18
	| /home/admin/metadataTest/'.xanalyzer   | #TC10.19
	| /home/admin/metadataTest/'             | #TC10.20
	| /home/admin/metadataTest/,.xanalyzer   | #TC10.21
	| /home/admin/metadataTest/,             | #TC10.22
	| /home/admin/metadataTest/~.xanalyzer   | #TC10.23
	| /home/admin/metadataTest/~             | #TC10.24
	| /home/admin/metadataTest/%23.xanalyzer | #TC10.25
	| /home/admin/metadataTest/%23           | #TC10.26
	| /home/admin/metadataTest/%25.xanalyzer | #TC10.27
	| /home/admin/metadataTest/%25           | #TC10.28
	| /home/admin/metadataTest/%5E.xanalyzer | #TC10.29
	| /home/admin/metadataTest/%5E           | #TC10.30
	| /home/admin/metadataTest/%26.xanalyzer | #TC10.31
	| /home/admin/metadataTest/%26           | #TC10.32
	| /home/admin/metadataTest/%2B.xanalyzer | #TC10.33
	| /home/admin/metadataTest/%2B           | #TC10.34
	| /home/admin/metadataTest/%3B.xanalyzer | #TC10.35
	| /home/admin/metadataTest/%3B           | #TC10.36
	| /home/admin/metadataTest/%3A.xanalyzer | #TC10.37
	| /home/admin/metadataTest/%3A           | #TC10.38
	| /home/admin/metadataTest/%22.xanalyzer | #TC10.39
	| /home/admin/metadataTest/%22           | #TC10.40
	| /home/admin/metadataTest/%3F.xanalyzer | #TC10.41
	| /home/admin/metadataTest/%3F           | #TC10.42
	| /home/admin/metadataTest/%3C.xanalyzer | #TC10.43
	| /home/admin/metadataTest/%3C           | #TC10.44
	| /home/admin/metadataTest/%3E.xanalyzer | #TC10.45
	| /home/admin/metadataTest/%3E           | #TC10.46
	| /home/admin/metadataTest/%60.xanalyzer | #TC10.47
	| /home/admin/metadataTest/%60           | #TC10.48
	| /home/admin/metadataTest/%5B.xanalyzer | #TC10.49
	| /home/admin/metadataTest/%5B           | #TC10.50
	| /home/admin/metadataTest/%5D.xanalyzer | #TC10.51
	| /home/admin/metadataTest/%5D           | #TC10.52
	| /home/admin/metadataTest/%7B.xanalyzer | #TC10.53
	| /home/admin/metadataTest/%7B           | #TC10.54
	| /home/admin/metadataTest/%7D.xanalyzer | #TC10.55
	| /home/admin/metadataTest/%7D           | #TC10.56
	| /home/admin/metadataTest/%7C.xanalyzer | #TC10.57
	| /home/admin/metadataTest/%7C           | #TC10.58
	| /home/admin/metadataTest/%21.xanalyzer | #TC10.59
	| /home/admin/metadataTest/%21           | #TC10.60
	| /home/admin/metadataTest/%40.xanalyzer | #TC10.61
	| /home/admin/metadataTest/%40           | #TC10.62
	| /home/admin/metadataTest/%24.xanalyzer | #TC10.63
	| /home/admin/metadataTest/%24           | #TC10.64
	| /home/admin/metadataTest/%2A.xanalyzer | #TC10.65
	| /home/admin/metadataTest/%2A           | #TC10.66
	| /home/admin/metadataTest/%28.xanalyzer | #TC10.67
	| /home/admin/metadataTest/%28           | #TC10.68
	| /home/admin/metadataTest/%29.xanalyzer | #TC10.69
	| /home/admin/metadataTest/%29           | #TC10.70
	| /home/admin/metadataTest/%5F.xanalyzer | #TC10.71
	| /home/admin/metadataTest/%5F           | #TC10.72
	| /home/admin/metadataTest/%2D.xanalyzer | #TC10.73
	| /home/admin/metadataTest/%2D           | #TC10.74
	| /home/admin/metadataTest/%3D.xanalyzer | #TC10.75
	| /home/admin/metadataTest/%3D           | #TC10.76
	| /home/admin/metadataTest/%27.xanalyzer | #TC10.77
	| /home/admin/metadataTest/%27           | #TC10.78
	| /home/admin/metadataTest/%2C.xanalyzer | #TC10.79
	| /home/admin/metadataTest/%2C           | #TC10.80
	| /home/admin/metadataTest/%7E.xanalyzer | #TC10.81
	| /home/admin/metadataTest/%7E           | #TC10.82

Scenario: Admin user calls the web service to set the metadata of a path using XML format with invalid XML in the request body. #TC11
	Given the path exists
	When the admin user sets the metadata of the path using invalid XML
	Then the status code is 400
	And the metadata properties have not been updated
	
Scenario: Admin user calls the web service to set the metadata of a path using JSON format with invalid JSON in the request body. #TC12
	Given the path exists
	When the admin user sets the metadata of the path using invalid JSON
	Then the status code is 400
	And the metadata properties have not been updated
	
Scenario: A user calls the web service to set the metadata of a path that exists in a different user's home directory. #TC13
	Given the path exists
	When The user sets the metadata of the path within a different user's home directory.
	Then the status code is 403
	And the metadata properties are not updated
	
Scenario: The anonymous user calls the web service to set the metadata of a path that exists. #TC14
	Given <Path> exists
	And no authentication is used in the request
	When the anonymous user sets the metadata of path <Path>
	Then the status code is 401
	And the metadata properties are not updated
Examples:
	| Path                                                                | #TC14
	| :home:admin:metadataTest:TestPAZUnauthorizedSet1.xanalyzer          | #TC14.1
	| :public:Steel Wheels:metadataTest:TestPAZUnauthorizedSet2.xanalyzer | #TC14.2

Scenario: A user without permissions calls the web service to set the metadata of a path that exists. #TC15
	Given the user does not have administer security permissions
	And the path exists
	When the user sets the metadata of the path
	Then the status code is 403 
	And the metadata properties are not updated

Scenario: the admin user calls the web service to set the metadata of a path that does not exist. #TC16
	Given the path does not exist
	When the admin user sets metadata of the path
	Then the status code is 404
	
# This path should not actually exist due to invalid characters in the name.
Scenario: Admin user calls the web service to set the metadata of a path/folder with invalid special characters in its name. #TC17
	When the user calls the web service for the path/folder <Path>
	Then the status code is 400
	And the metadata properties are not updated
Examples:
	| Path                                   | #TC17
	| :home:admin:metadataTest:%2F.xanalyzer | #TC17.1
	| :home:admin:metadataTest:%2F           | #TC17.2
	| :home:admin:metadataTest:%5C.xanalyzer | #TC17.3
	| :home:admin:metadataTest:%5C           | #TC17.4