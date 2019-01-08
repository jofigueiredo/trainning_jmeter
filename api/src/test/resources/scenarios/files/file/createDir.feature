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

Scenario Outline: Distinct user directory permissions on create new directory inside #TC1
	Given user with the (read, create) as role feature permissions
	And directory is with <userPathPermission> as user permissions
	And directory is without any role on permissions
	When the user sends an HTTP PUT to createDir encoded
	Then the status code is <statusCode>
	And the inside directory <is> created
Examples:
	| statusCode | is    | userPathPermission | #notes                                                    | #TC1
	| 500        | isn't | read               | read User Path Permission Can Not Create Directory        | #TC1.1
	| 500        | isn't | write              | write User Path Permission Can Not Create Directory       | #TC1.2
	| 500        | isn't | delete             | delete User Path Permission Can Not Create Directory      | #TC1.3
	| 500        | isn't | manage             | manage User Path Permission Can Not Create Directory      | #TC1.4
	| 200        | is    | read,write         | read,write User Path Permission Can Create Directory      | #TC1.5
	| 500        | isn't | read,delete        | read,delete User Path Permission Can Not Create Directory | #TC1.6
	| 200        | is    | all                | all User Path Permission Can Create Directory             | #TC1.7

Scenario Outline: Distinct role directory permissions on create new directory inside #TC2
	Given user with the (read, create) as role feature permissions
	And directory is without any user on permissions
	And directory is with <rolePathPermission> as role permissions
	When the user sends an HTTP PUT to createDir encoded
	Then the status code is <statusCode>
	And the inside directory <is> created
Examples:
	| statusCode | is    | rolePathPermission | #notes                                                    | #TC2
	| 500        | isn't | read               | read Role Path Permission Can Not Create Directory        | #TC2.1
	| 500        | isn't | write              | write Role Path Permission Can Not Create Directory       | #TC2.2
	| 500        | isn't | delete             | delete Role Path Permission Can Not Create Directory      | #TC2.3
	| 500        | isn't | manage             | manage Role Path Permission Can Not Create Directory      | #TC2.4
	| 200        | is    | read,write         | read,write Role Path Permission Can Create Directory      | #TC2.5
	| 500        | isn't | read,delete        | read,delete Role Path Permission Can Not Create Directory | #TC2.6
	| 200        | is    | all                | all Role Path Permission Can Create Directory             | #TC2.7

Scenario Outline: Mix distinct user and role directory permissions on create new directory inside #TC3
	Given user with the (read, create) as role feature permissions
	And directory is with <userPathPermission> as user permissions
	And directory is with <rolePathPermission> as role permissions
	When the user sends an HTTP PUT to createDir encoded
	Then the status code is 200
	And the inside directory is created
Examples:
	| userPathPermission | rolePathPermission | #notes                                                                        | #TC3
	| read               | write              | read User Path Permission and write Role Path Permission Can Create Directory | #TC3.1
	| write              | read               | write User Path Permission and read Role Path Permission Can Create Directory | #TC3.2

Scenario Outline: Anonymous role directory permissions on create new directory inside #TC4
	Given Anonymous user
	And directory is with <rolePathPermission> as Anonymous role permissions
	When the Anonymous user sends an HTTP PUT to createDir encoded
	Then the status code is <statusCode>
	And the inside directory <is> created
Examples:
	| statusCode | isn't | rolePathPermission | #notes                                                          | #TC4
	| 401        | isn't |                    | Anonymous Role Path Permission Can Not Create Directory        | #TC4.1
	| 401        | isn't | read               | read Anonymous Role Path Permission Can Not Create Directory   | #TC4.2
	| 401        | isn't | write              | write Anonymous Role Path Permission Can Not Create Directory  | #TC4.3
	| 401        | isn't | delete             | delete Anonymous Role Path Permission Can Not Create Directory | #TC4.4
	| 401        | isn't | manage             | manage Anonymous Role Path Permission Can Not Create Directory | #TC4.5
	| 401        | isn't | read,write         | read,write Anonymous Role Path Permission Can Create Directory | #TC4.6
	| 401        | isn't | all                | all Anonymous Role Path Permission Can Create Directory        | #TC4.7

Scenario Outline: Role Permissions versus directory permissions on create new directory #TC5
	Given user with the <rolePermission> as role feature permissions
	And directory is with <userPathPermission> as user permissions
	And directory is with <rolePathPermission> as role permissions
	When the user sends an HTTP PUT to createDir encoded
	Then the status code is <statusCode>
	And the inside directory <is> created
Examples:
	| statusCode | is    | rolePermission     | userPathPermission | rolePathPermission | #notes                                                                | #TC5
	| 200        | is    | all                |                    |                    | all Role Permission Without Path Permissions Can Create Directory     | #TC5.1
	| 500        | isn't | read               | all                | all                | read Role Permission Can Not Create Directory                         | #TC5.2
	| 200        | is    | create             | all                | all                | create Role Permission Can Create Directory                           | #TC5.3
	| 500        | isn't | execute            | all                | all                | execute Role Permission Can Not Create Directory                      | #TC5.4
	| 500        | isn't | publish            | all                | all                | publish Role Permission Can Not Create Directory                      | #TC5.5
	| 500        | isn't | scheduler          | all                | all                | scheduler Role Permission Can Not Create Directory                    | #TC5.6
	| 500        | isn't | datasource         | all                | all                | datasource Role Permission Can Not Create Directory                   | #TC5.7
	| 500        | isn't | administerSecurity | all                | all                | administerSecurity Role Permission Can Not Create Directory           | #TC5.8
	| 200        | is    | read,create        | all                | all                | read,create Role Permission Can Create Directory                      | #TC5.9
	| 500        | isn't | read,execute       | all                | all                | read,execute Role Permission Can Not Create Directory                 | #TC5.10
	| 500        | isn't | read,publish       | all                | all                | read,publish Role Permission Can Not Create Directory                 | #TC5.11
	| 500        | isn't | read,scheduler     | all                | all                | read,scheduler Role Permission Can Not Create Directory               | #TC5.12
	| 500        | isn't | read,datasource    | all                | all                | read,datasource Role Permission Can Not Create Directory              | #TC5.13
	| 200        | is    | all                | all                | all                | all Role Permission Can Create Directory                              | #TC5.14

Scenario Outline: Parental directory permissions on create new directory #TC6
	Given user with the (create) as role feature permissions
	And directory is with <userPathPermission> as user permissions
	And directory is with <rolePathPermission> as role permissions
	When the user sends an HTTP PUT to createDir encoded
	Then the status code is <statusCode>
	And the inside directory <is> created
Examples:
	| statusCode | is    | userPathPermission | rolePathPermission | #notes                                                                | #TC6
	| 500        | isn't |                    |                    | null User And Role Parental Path Permissions Can Not Create Directory | #TC6.1
	| 200        | is    | all                |                    | all User Parental Path Permissions Can Create Directory               | #TC6.2
	| 200        | is    |                    | read,write         | read,write Role Parental Path Permissions Can Create Directory        | #TC6.3

Scenario Outline: Directory name with distinct sizes #TC7
	Given User with all role permission
	And all permissions on directory
	And read permission on Parental directories
	When the user sends an HTTP PUT to /repo/files/<path>/createDir encoded
	Then the returned status code is <statusCode>
	And the <path> directory <is> created
Examples:
	| statusCode | is    | path                                         | #notes                                                                                                      | #TC7
	| 200        | is    | home:1                                       | Name Size In Minimal Boundary                                                                               | #TC7.1
	| 200        | is    | public:crtDirTC7.2:${__RandomString(7000,n)} | Name Size In Maximal Boundary                                                                               | #TC7.2
	| 500        | isn't | :home:                                       | Name Size Out Minimal Boundary                                                                              | #TC7.3
	| 400        | isn't | public:crtDirTC7.4:${__RandomString(8000,n)} | Name Size Out Maximal Boundary                                                                              | #TC7.4
	| 500        | isn't |                                              | Minimal size Excluding Domain. Update this test if the following improvement is implemented: BISERVER-14013 | #TC7.5

Scenario Outline: Directory name with distinct capitalization #TC8
	Given User with all role permission
	And all permissions on directory
	And read permission on Parental directories
	When the user sends an HTTP PUT to /repo/files/<path>/createDir <encoded>
	Then the returned status code is 200
	And the <path> directory is created
Examples:
	| path                    | encoded | #notes                 | #TC8
	| public:crtdir:tc8.1:dir | yes     | Low Case               | #TC8.1
	| public:CRTDIR:TC8.2:DIR | yes     | Upper Case             | #TC8.2
	| public:crtDir:TC8.3:Dir | yes     | Camel Case             | #TC8.3
	| public:crtdir:tc8.4:dir | no      | Not Encoded Low Case   | #TC8.4
	| public:CRTDIR:TC8.5:DIR | no      | Not Encoded Upper Case | #TC8.5
	| public:crtDir:TC8.6:Dir | no      | Not Encoded Camel Case | #TC8.6

Scenario Outline: Directory name with distinct ASCII symbol #TC9
	Given User with all role permission
	And all permissions on directory
	And read permission on Parental directories
	When the user sends an HTTP PUT to /repo/files/<path>/createDir not encoded
	Then the returned status code is <statusCode>
	And the <path> directory <is> created
Examples:
	| statusCode | is    | path                         | #notes                                                                        | #TC9
	| 200        | is    | public:crtDir:TC9.1:_        |                                                                               | #TC9.1
	| 500        | isn't | public:crtDir:TC9.2:.        | not allowed just . char. Update this test when BISERVER-14083 is implemented. | #TC9.2
	| 200        | is    | public:crtDir:TC9.3:,        |                                                                               | #TC9.3
	| 200        | is    | public:crtDir:TC9.4:;        |                                                                               | #TC9.4
	| 200        | is    | public:crtDir:TC9.5:+        |                                                                               | #TC9.5
	| 200        | is    | public:crtDir:TC9.6:-        |                                                                               | #TC9.6
	| 200        | is    | public:crtDir:TC9.7:*        |                                                                               | #TC9.7
	| 200        | is    | public:crtDir:TC9.8:=        |                                                                               | #TC9.8
	| 200        | is    | public:crtDir:TC9.9:>        |                                                                               | #TC9.9
	| 200        | is    | public:crtDir:TC9.10:<       |                                                                               | #TC9.10
	| 200        | is    | public:crtDir:TC9.11:(       |                                                                               | #TC9.11
	| 200        | is    | public:crtDir:TC9.12:)       |                                                                               | #TC9.12
	| 200        | is    | public:crtDir:TC9.13:[       |                                                                               | #TC9.13
	| 200        | is    | public:crtDir:TC9.14:]       |                                                                               | #TC9.14
	| 200        | is    | public:crtDir:TC9.15:{       |                                                                               | #TC9.15
	| 200        | is    | public:crtDir:TC9.16:}       |                                                                               | #TC9.16
	| 200        | is    | public:crtDir:TC9.17:'       |                                                                               | #TC9.17
	| 200        | is    | public:crtDir:TC9.18:"       |                                                                               | #TC9.18
	| 200        | is    | public:crtDir:TC9.19:~       |                                                                               | #TC9.19
	| 200        | is    | public:crtDir:TC9.20:^       |                                                                               | #TC9.20
	| 200        | is    | public:crtDir:TC9.21:%       |                                                                               | #TC9.21
	| 200        | is    | public:crtDir:TC9.22:#       |                                                                               | #TC9.22
	| 200        | is    | public:crtDir:TC9.23:@       |                                                                               | #TC9.23
	| 200        | is    | public:crtDir:TC9.24:&       |                                                                               | #TC9.24
	| 200        | is    | public:crtDir:TC9.25:$       |                                                                               | #TC9.25
	| 200        | is    | public:crtDir:TC9.26:€       |                                                                               | #TC9.26
	| 200        | is    | public:crtDir:TC9.27::       |                                                                               | #TC9.27
	| 200        | is    | public:crtDir:TC9.28:abc.com | Combination abc.com                                                           | #TC9.28

Scenario Outline: Directory name with distinct ASCII symbol encoded #TC10
	Given User with all role permission
	And all permissions on directory
	And read permission on Parental directories
	When the user sends an HTTP PUT to /repo/files/<path>/createDir encoded
	Then the returned status code is <statusCode>
	And the <path> directory <is> created
Examples:
	| statusCode | is    | path                          | #notes                  | #TC10
	| 200        | is    | public:creDir:TC10.1:_        |                         | #TC10.1
	| 400        | isn't | public:creDir:TC10.2:.        | not allowed just . char | #TC10.2
	| 200        | is    | public:creDir:TC10.3:,        |                         | #TC10.3
	| 200        | is    | public:creDir:TC10.4:;        |                         | #TC10.4
	| 200        | is    | public:creDir:TC10.5:+        |                         | #TC10.5
	| 200        | is    | public:creDir:TC10.6:-        |                         | #TC10.6
	| 200        | is    | public:creDir:TC10.7:*        |                         | #TC10.7
	| 200        | is    | public:creDir:TC10.8:=        |                         | #TC10.8
	| 200        | is    | public:creDir:TC10.11:(       |                         | #TC10.11
	| 200        | is    | public:creDir:TC10.12:)       |                         | #TC10.12
	| 200        | is    | public:creDir:TC10.17:'       |                         | #TC10.17
	| 200        | is    | public:creDir:TC10.19:~       |                         | #TC10.19
	| 200        | is    | public:creDir:TC10.22:#       |                         | #TC10.22
	| 200        | is    | public:creDir:TC10.23:@       |                         | #TC10.23
	| 200        | is    | public:creDir:TC10.24:&       |                         | #TC10.24
	| 200        | is    | public:creDir:TC10.25:$       |                         | #TC10.25
	| 200        | is    | public:creDir:TC10.26:€       |                         | #TC10.26
	| 200        | is    | public:creDir:TC10.27::       |                         | #TC10.27
	| 200        | is    | public:creDir:TC10.28:1.0-2.0 | Combination             | #TC10.28

Scenario Outline: Directory name with distinct reserved character #TC11
	Given User with all role permission
	And all permissions on directory
	And read permission on Parental directories
	When the user sends an HTTP PUT to /repo/files/<PathId>/createDir <encoded>
	Then the status code is 400
	And the directory is not created
Examples:
	| path                   | encoded | #TC11
	| public:crtDir:TC11.1:/ | No      | #TC11.1
	| public:crtDir:TC11.2:\ | No      | #TC11.2
	| public:crtDir:TC11.3:/ | Yes     | #TC11.3

Scenario Outline: Directory name with distinct combination of spaces #TC12
	Given User with all role permission
	And all permissions on directory
	And read permission on Parental directories
	When the user sends an HTTP PUT to /repo/files/<path>/createDir <encoded>
	Then the returned status code is 200
	And the <path> directory is created
Examples:
	| path                                    | encoded | #notes                     | #TC12
	| public:crtDir:TC12.1:    trailing       | No      | No Trailing Spaces         | #TC12.1
	| public:crtDir:TC12.2:L     eadin      g | No      | No Leading Spaces          | #TC12.2
	| public:crtDir:TC12.3:    trailing       | Yes     | No Trailing Encoded Spaces | #TC12.3
	| public:crtDir:TC12.4:L     eadin      g | Yes     | No Leading Encoded Spaces  | #TC12.4

Scenario Outline: Directory name at distinct levels. #TC13
	Given User with all role permission
	And all permissions on directory
	And read permission on Parental directories
	When the user sends an HTTP PUT to /repo/files/<path>/createDir not encoded
	Then the returned status code is <statusCode>
	And the <path> directory <is> created
Examples:
	| statusCode | is    | path              |  #notes       | #TC13
	| 200        | is    | home:crtDir12.4   |  Home Level   | #TC13.1
	| 200        | is    | public:crtDir13.1 |  Public Level | #TC13.2
	| 403        | isn't | crtDir13.2        |  Root Level   | #TC13.3

Scenario Outline: Directory name distinct with distinct sub directories. #TC14
	Given User with all role permission
	And all permissions on directory
	And read permission on Parental directories
	When the user sends an HTTP PUT to /repo/files/<path>/createDir <encoded>
	Then the returned status code is 200
	And the directory is created
Examples:
	| path                                                     | encoded | #notes                              | #TC14
	| public:crtDir:TC14.1:1:2:3:4:5:6:7:8:9:10:11:12:13:14:15 | no      | Create one directory with that name | #TC14.1
	| public:crtDir:TC14.2:1:2:3:4:5:6:7:8:9:10:11:12:13:14:15 | yes     | Create Multiple Sub-Directories     | #TC14.2

Scenario Outline: A user attempts to create a directory that already exists #TC15
	Given User with all role permission
	And all permissions on directory
	And read permission on Parental directories
	And an existent directory /repo/files/:home:admin
	When The user sends an HTTP PUT to /repo/files/:home:admin/createDir <encoded>
	Then The returned status code is 409
	And The error message couldNotCreateFolderDuplicate is returned.
Examples:
	| encoded | #notes                                    | #TC15
	| Yes     | Path Encoded, Directory Already Exists    | #TC15.1
	| No      | Path No Encoded, Directory Already Exists | #TC15.2
