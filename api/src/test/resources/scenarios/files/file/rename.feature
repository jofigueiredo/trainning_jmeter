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
Scenario Outline: A user with various path permissions assigned to the user attempt to rename a path. #TC1
	Given a path exists at <pathId>
	And the user belongs to a role with <rolePermission> permissions
	And the user has <userPathPermission> assigned to the parent directory of <pathId>
	When the user calls the web service to rename the path <pathId>
	Then the status code is <statusCode>
	And the path's name <result> updated
Examples:
	| pathId                                      | rolePermission | userPathPermission | statusCode | result | #notes                                                                    | #TC1
	| :public:UrenameDir1-1:renameTest.xanalyzer  | read,create    | all                | 200        | is     |                                                                           | #TC1.1
	| :public:UrenameDir1-2:renameTest            | read,create    | all                | 200        | is     |                                                                           | #TC1.2
	| :public:UrenameDir1-3:renameTest.xanalyzer  | read,create    | read               | 403        | is not |                                                                           | #TC1.3
	| :public:UrenameDir1-4:renameTest            | read,create    | read               | 403        | is not |                                                                           | #TC1.4
	| :public:UrenameDir1-5:renameTest.xanalyzer  | read,create    | write              | 403        | is not |                                                                           | #TC1.5
	| :public:UrenameDir1-6:renameTest            | read,create    | write              | 403        | is not |                                                                           | #TC1.6
	| :public:UrenameDir1-7:renameTest.xanalyzer  | read,create    | manage             | 403        | is not |                                                                           | #TC1.7
	| :public:UrenameDir1-8:renameTest            | read,create    | manage             | 403        | is not |                                                                           | #TC1.8
	| :public:UrenameDir1-9:renameTest.xanalyzer  | read,create    | read,write         | 200        | is     |                                                                           | #TC1.9
	| :public:UrenameDir1-10:renameTest           | read,create    | read,write         | 200        | is     |                                                                           | #TC1.10
	| :public:UrenameDir1-11:renameTest.xanalyzer | read,create    | read,manage        | 403        | is not |                                                                           | #TC1.11
	| :public:UrenameDir1-12:renameTest           | read,create    | read,manage        | 403        | is not |                                                                           | #TC1.12
	| :public:UrenameDir1-13:renameTest.xanalyzer | Administrator  | all                | 200        | is     | Default Administrator user renaming a directory with default permissions. | #TC1.13
	| :public:UrenameDir1-14:renameTest           | Administrator  | all                | 200        | is     | Default Administrator user renaming a directory with default permissions. | #TC1.14
	| :public:UrenameDir1-15:renameTest.xanalyzer | all            |                    | 200        | is     |                                                                           | #TC1.15
	| :public:UrenameDir1-16:renameTest           | all            |                    | 200        | is     |                                                                           | #TC1.16
	
Scenario Outline: A user with various path permissions assigned to the role attempt to rename a path. #TC2
	Given a path exists at <pathId>
	And the user belongs to a role with <rolePermission> permissions
	And the role has <rolePathPermission> assigned to the parent directory of <pathId>
	When the user calls the web service to rename the path <pathId> to <newName>
	Then the status code is <statusCode>
	And the path's name <result> updated
Examples:
	| pathId                                      | rolePermission | rolePathPermission | statusCode | result | #notes                                                                   | #TC2
	| :public:UrenameDir2-1:renameTest.xanalyzer  | read,create    | all                | 200        | is     |                                                                          | #TC2.1
	| :public:UrenameDir2-2:renameTest            | read,create    | all                | 200        | is     |                                                                          | #TC2.2
	| :public:UrenameDir2-3:renameTest.xanalyzer  | read,create    | read               | 403        | is not |                                                                          | #TC2.3
	| :public:UrenameDir2-4:renameTest            | read,create    | read               | 403        | is not |                                                                          | #TC2.4
	| :public:UrenameDir2-5:renameTest.xanalyzer  | read,create    | write              | 403        | is not |                                                                          | #TC2.5
	| :public:UrenameDir2-6:renameTest            | read,create    | write              | 403        | is not |                                                                          | #TC2.6
	| :public:UrenameDir2-7:renameTest.xanalyzer  | read,create    | manage             | 403        | is not |                                                                          | #TC2.7
	| :public:UrenameDir2-8:renameTest            | read,create    | manage             | 403        | is not |                                                                          | #TC2.8
	| :public:UrenameDir2-9:renameTest.xanalyzer  | read,create    | read,write         | 200        | is     |                                                                          | #TC2.9
	| :public:UrenameDir2-10:renameTest           | read,create    | read,write         | 200        | is     |                                                                          | #TC2.10
	| :public:UrenameDir2-11:renameTest.xanalyzer | read,create    | read,manage        | 403        | is not |                                                                          | #TC2.11
	| :public:UrenameDir2-12:renameTest           | read,create    | read,manage        | 403        | is not |                                                                          | #TC2.12
	| :public:UrenameDir2-13:renameTest.xanalyzer | Administrator  | all                | 200        | is     |                                                                          | #TC2.13
	| :public:UrenameDir2-14:renameTest           | Administrator  | all                | 200        | is     |                                                                          | #TC2.14
	| :public:UrenameDir2-15:renameTest.xanalyzer | all            |                    | 200        | is     | Default Administrator user renaming a directory with default permissions | #TC2.15
	| :public:UrenameDir2-16:renameTest           | all            |                    | 200        | is     |                                                                          | #TC2.16
	
Scenario Outline: A user with various path permissions assigned to the user and role attempt to rename a path. #TC3
	Given a path exists at <pathId>
	And the user belongs to a role with read permissions
	And the user belongs to a role with create permissions
	And the user has <userPathPermission> assigned to the parent directory of <pathId>
	And the role has <rolePathPermission> assigned to the parent directory of <pathId>
	When the user calls the web service to rename the path <pathId>
	Then the status code is <statusCode>
	And the path's name <result> updated
Examples:
	| pathId                                     | userPathPermission | rolePathPermission | statusCode | result | #notes | #TC3
	| :public:UrenameDir3-1:renameTest.xanalyzer | read               | write              | 200        | is     |        | #TC3.1
	| :public:UrenameDir3-2:renameTest           | read               | write              | 200        | is     |        | #TC3.2
	| :public:UrenameDir3-3:renameTest.xanalyzer | write              | read               | 200        | is     |        | #TC3.3
	| :public:UrenameDir3-4:renameTest           | write              | read               | 200        | is     |        | #TC3.4
	
Scenario Outline: A users assigned to a role with various permissions attempt to rename a path. #TC4
	Given a path exists at <pathId>
	And the user belongs to a role with <rolePermission> permissions
	And the user has all user-based path permissions assigned to the parent directory of <pathId>
	And the user has all role-based path permissions assigned to the parent directory of <pathId>
	When the user calls the web service to rename the path <pathId>
	Then the status code is <statusCode>
	And the path's name <result> updated
Examples:
	| pathId                                      | rolePermission     | statusCode | result | #notes | #TC4
	| :public:UrenameDir4-1:renameTest.xanalyzer  | Administrator      | 200        | is     |        | #TC4.1
	| :public:UrenameDir4-2:renameTest            | Administrator      | 200        | is     |        | #TC4.2
	| :public:UrenameDir4-3:renameTest.xanalyzer  | all                | 200        | is     |        | #TC4.3
	| :public:UrenameDir4-4:renameTest            | all                | 200        | is     |        | #TC4.4
	| :public:UrenameDir4-5:renameTest.xanalyzer  | read,create        | 200        | is     |        | #TC4.5
	| :public:UrenameDir4-6:renameTest            | read,create        | 200        | is     |        | #TC4.6
	| :public:UrenameDir4-7:renameTest.xanalyzer  | read               | 403        | is not |        | #TC4.7
	| :public:UrenameDir4-8:renameTest            | read               | 403        | is not |        | #TC4.8
	| :public:UrenameDir4-9:renameTest.xanalyzer  | create             | 403        | is not |        | #TC4.9
	| :public:UrenameDir4-10:renameTest           | create             | 403        | is not |        | #TC4.10
	| :public:UrenameDir4-11:renameTest.xanalyzer | scheduler          | 403        | is not |        | #TC4.11
	| :public:UrenameDir4-12:renameTest           | scheduler          | 403        | is not |        | #TC4.12
	| :public:UrenameDir4-13:renameTest.xanalyzer | publish            | 403        | is not |        | #TC4.13
	| :public:UrenameDir4-14:renameTest           | publish            | 403        | is not |        | #TC4.14
	| :public:UrenameDir4-15:renameTest.xanalyzer | execute            | 403        | is not |        | #TC4.15
	| :public:UrenameDir4-16:renameTest           | execute            | 403        | is not |        | #TC4.16
	| :public:UrenameDir4-17:renameTest.xanalyzer | datasource         | 403        | is not |        | #TC4.17
	| :public:UrenameDir4-18:renameTest           | datasource         | 403        | is not |        | #TC4.18
	| :public:UrenameDir4-19:renameTest.xanalyzer | administerSecurity | 403        | is not |        | #TC4.19
	| :public:UrenameDir4-20:renameTest           | administerSecurity | 403        | is not |        | #TC4.20
	| :public:UrenameDir4-21:renameTest.xanalyzer | read,scheduler     | 403        | is not |        | #TC4.21
	| :public:UrenameDir4-22:renameTest           | read,scheduler     | 403        | is not |        | #TC4.22
	| :public:UrenameDir4-23:renameTest.xanalyzer | read,publish       | 403        | is not |        | #TC4.23
	| :public:UrenameDir4-24:renameTest           | read,publish       | 403        | is not |        | #TC4.24
	| :public:UrenameDir4-25:renameTest.xanalyzer | read,execute       | 403        | is not |        | #TC4.25
	| :public:UrenameDir4-26:renameTest           | read,execute       | 403        | is not |        | #TC4.26
	| :public:UrenameDir4-27:renameTest.xanalyzer | read,datasource    | 403        | is not |        | #TC4.27
	| :public:UrenameDir4-28:renameTest           | read,datasource    | 403        | is not |        | #TC4.28
	| :public:UrenameDir4-29:renameTest.xanalyzer | create,scheduler   | 403        | is not |        | #TC4.29
	| :public:UrenameDir4-30:renameTest           | create,scheduler   | 403        | is not |        | #TC4.30
	| :public:UrenameDir4-31:renameTest.xanalyzer | create,publish     | 403        | is not |        | #TC4.31
	| :public:UrenameDir4-32:renameTest           | create,publish     | 403        | is not |        | #TC4.32
	| :public:UrenameDir4-33:renameTest.xanalyzer | create,execute     | 403        | is not |        | #TC4.33
	| :public:UrenameDir4-34:renameTest           | create,execute     | 403        | is not |        | #TC4.34
	| :public:UrenameDir4-35:renameTest.xanalyzer | create,datasource  | 403        | is not |        | #TC4.35
	| :public:UrenameDir4-36:renameTest           | create,datasource  | 403        | is not |        | #TC4.36
	
Scenario Outline: An anonymous user attempts to rename a directory while the anonymous role has various permissions #TC5
	Given a path exists at <pathId>
	And the anonymous role has <rolePathPermission> permissions assigned to the parent directory of <pathId>
	When the anonymous user calls the web service to rename the path <pathId> to <newName>
	Then the status code is <statusCode>
	And the path's name <result> updated
Examples:
	| pathId                                 | newName      | rolePathPermission | statusCode | result | #notes | #TC5
	| :public:anonymous:renameTest.xanalyzer | testRenaming | all                | 401        | is not |        | #TC5.1
	| :public:anonymous:renameTest           | testRenaming | all                | 401        | is not |        | #TC5.2
	| :public:anonymous:renameTest.xanalyzer | testRenaming | read,write         | 401        | is not |        | #TC5.3
	| :public:anonymous:renameTest           | testRenaming | read,write         | 401        | is not |        | #TC5.4
	| :public:anonymous:renameTest.xanalyzer | testRenaming | read               | 401        | is not |        | #TC5.5
	| :public:anonymous:renameTest           | testRenaming | read               | 401        | is not |        | #TC5.6
	| :public:anonymous:renameTest.xanalyzer | testRenaming | null               | 401        | is not |        | #TC5.7
	| :public:anonymous:renameTest           | testRenaming | null               | 401        | is not |        | #TC5.8

Scenario Outline: The user calls the web service to rename the path to the new name that contains special characters. #TC6
	Given a path exists at <pathId>
	When admin user calls the web service to rename the path <pathId> to <newName>
	Then the status code is 200
	And the path name has been updated
Examples:
	| pathId                                               | newName       | #TC6
	| :public:UrenameDir6-1:renameTest:renameTest.xanalyzer  | !.xanalyzer   | #TC6.1
	| :public:UrenameDir6-2:renameTest                       | !             | #TC6.2
	| :public:UrenameDir6-3:renameTest:renameTest.xanalyzer  | @.xanalyzer   | #TC6.3
	| :public:UrenameDir6-4:renameTest                       | @             | #TC6.4
	| :public:UrenameDir6-5:renameTest:renameTest.xanalyzer  | $.xanalyzer   | #TC6.5
	| :public:UrenameDir6-6:renameTest                       | $             | #TC6.6
	| :public:UrenameDir6-7:renameTest:renameTest.xanalyzer  | *.xanalyzer   | #TC6.7
	| :public:UrenameDir6-8:renameTest                       | *             | #TC6.8
	| :public:UrenameDir6-9:renameTest:renameTest.xanalyzer  | (.xanalyzer   | #TC6.9
	| :public:UrenameDir6-10:renameTest                      | (             | #TC6.10
	| :public:UrenameDir6-11:renameTest:renameTest.xanalyzer | ).xanalyzer   | #TC6.11
	| :public:UrenameDir6-12:renameTest                      | )             | #TC6.12
	| :public:UrenameDir6-13:renameTest:renameTest.xanalyzer | _.xanalyzer   | #TC6.13
	| :public:UrenameDir6-14:renameTest                      | _             | #TC6.14
	| :public:UrenameDir6-15:renameTest:renameTest.xanalyzer | -.xanalyzer   | #TC6.15
	| :public:UrenameDir6-16:renameTest                      | -             | #TC6.16
	| :public:UrenameDir6-17:renameTest:renameTest.xanalyzer | =.xanalyzer   | #TC6.17
	| :public:UrenameDir6-18:renameTest                      | =             | #TC6.18
	| :public:UrenameDir6-19:renameTest:renameTest.xanalyzer | '.xanalyzer   | #TC6.19
	| :public:UrenameDir6-20:renameTest                      | '             | #TC6.20
	| :public:UrenameDir6-21:renameTest:renameTest.xanalyzer | ,.xanalyzer   | #TC6.21
	| :public:UrenameDir6-22:renameTest                      | ,             | #TC6.22
	| :public:UrenameDir6-23:renameTest:renameTest.xanalyzer | ~.xanalyzer   | #TC6.23
	| :public:UrenameDir6-24:renameTest                      | ~             | #TC6.24
	| :public:UrenameDir6-25:renameTest:renameTest.xanalyzer | %23.xanalyzer | #TC6.25
	| :public:UrenameDir6-26:renameTest                      | %23           | #TC6.26
	| :public:UrenameDir6-27:renameTest:renameTest.xanalyzer | %25.xanalyzer | #TC6.27
	| :public:UrenameDir6-28:renameTest                      | %25           | #TC6.28
	| :public:UrenameDir6-29:renameTest:renameTest.xanalyzer | %5E.xanalyzer | #TC6.29
	| :public:UrenameDir6-30:renameTest                      | %5E           | #TC6.30
	| :public:UrenameDir6-31:renameTest:renameTest.xanalyzer | %26.xanalyzer | #TC6.31
	| :public:UrenameDir6-32:renameTest                      | %26           | #TC6.32
	| :public:UrenameDir6-33:renameTest:renameTest.xanalyzer | %2B.xanalyzer | #TC6.33
	| :public:UrenameDir6-34:renameTest                      | %2B           | #TC6.34
	| :public:UrenameDir6-35:renameTest:renameTest.xanalyzer | %3B.xanalyzer | #TC6.35
	| :public:UrenameDir6-36:renameTest                      | %3B           | #TC6.36
	| :public:UrenameDir6-37:renameTest:renameTest.xanalyzer | %3A.xanalyzer | #TC6.37
	| :public:UrenameDir6-38:renameTest                      | %3A           | #TC6.38
	| :public:UrenameDir6-39:renameTest:renameTest.xanalyzer | %22.xanalyzer | #TC6.39
	| :public:UrenameDir6-40:renameTest                      | %22           | #TC6.40
	| :public:UrenameDir6-41:renameTest:renameTest.xanalyzer | %3F.xanalyzer | #TC6.41
	| :public:UrenameDir6-42:renameTest                      | %3F           | #TC6.42
	| :public:UrenameDir6-43:renameTest:renameTest.xanalyzer | %3C.xanalyzer | #TC6.43
	| :public:UrenameDir6-44:renameTest                      | %3C           | #TC6.44
	| :public:UrenameDir6-45:renameTest:renameTest.xanalyzer | %3E.xanalyzer | #TC6.45
	| :public:UrenameDir6-46:renameTest                      | %3E           | #TC6.46
	| :public:UrenameDir6-47:renameTest:renameTest.xanalyzer | %60.xanalyzer | #TC6.47
	| :public:UrenameDir6-48:renameTest                      | %60           | #TC6.48
	| :public:UrenameDir6-49:renameTest:renameTest.xanalyzer | %5B.xanalyzer | #TC6.49
	| :public:UrenameDir6-50:renameTest                      | %5B           | #TC6.50
	| :public:UrenameDir6-51:renameTest:renameTest.xanalyzer | %5D.xanalyzer | #TC6.51
	| :public:UrenameDir6-52:renameTest                      | %5D           | #TC6.52
	| :public:UrenameDir6-53:renameTest:renameTest.xanalyzer | %7B.xanalyzer | #TC6.53
	| :public:UrenameDir6-54:renameTest                      | %7B           | #TC6.54
	| :public:UrenameDir6-55:renameTest:renameTest.xanalyzer | %7D.xanalyzer | #TC6.55
	| :public:UrenameDir6-56:renameTest                      | %7D           | #TC6.56
	| :public:UrenameDir6-57:renameTest:renameTest.xanalyzer | %7C.xanalyzer | #TC6.57
	| :public:UrenameDir6-58:renameTest                      | %7C           | #TC6.58
	| :public:UrenameDir6-59:renameTest:renameTest.xanalyzer | %21.xanalyzer | #TC6.59
	| :public:UrenameDir6-60:renameTest                      | %21           | #TC6.60
	| :public:UrenameDir6-61:renameTest:renameTest.xanalyzer | %40.xanalyzer | #TC6.61
	| :public:UrenameDir6-62:renameTest                      | %40           | #TC6.62
	| :public:UrenameDir6-63:renameTest:renameTest.xanalyzer | %24.xanalyzer | #TC6.63
	| :public:UrenameDir6-64:renameTest                      | %24           | #TC6.64
	| :public:UrenameDir6-65:renameTest:renameTest.xanalyzer | %2A.xanalyzer | #TC6.65
	| :public:UrenameDir6-66:renameTest                      | %2A           | #TC6.66
	| :public:UrenameDir6-67:renameTest:renameTest.xanalyzer | %28.xanalyzer | #TC6.67
	| :public:UrenameDir6-68:renameTest                      | %28           | #TC6.68
	| :public:UrenameDir6-69:renameTest:renameTest.xanalyzer | %29.xanalyzer | #TC6.69
	| :public:UrenameDir6-70:renameTest                      | %29           | #TC6.70
	| :public:UrenameDir6-71:renameTest:renameTest.xanalyzer | %5F.xanalyzer | #TC6.71
	| :public:UrenameDir6-72:renameTest                      | %5F           | #TC6.72
	| :public:UrenameDir6-73:renameTest:renameTest.xanalyzer | %2D.xanalyzer | #TC6.73
	| :public:UrenameDir6-74:renameTest                      | %2D           | #TC6.74
	| :public:UrenameDir6-75:renameTest:renameTest.xanalyzer | %3D.xanalyzer | #TC6.75
	| :public:UrenameDir6-76:renameTest                      | %3D           | #TC6.76
	| :public:UrenameDir6-77:renameTest:renameTest.xanalyzer | %27.xanalyzer | #TC6.77
	| :public:UrenameDir6-78:renameTest                      | %27           | #TC6.78
	| :public:UrenameDir6-79:renameTest:renameTest.xanalyzer | %2C.xanalyzer | #TC6.79
	| :public:UrenameDir6-80:renameTest                      | %2C           | #TC6.80
	| :public:UrenameDir6-81:renameTest:renameTest.xanalyzer | %7E.xanalyzer | #TC6.81
	| :public:UrenameDir6-82:renameTest                      | %7E           | #TC6.82

Scenario Outline: Admin user calls the web service to rename a path, which has a series of invalid special characters in its name. #TC7
	Given Admin User with all path permissions
	When the user calls the web service to rename the path with <newName>
	Then the status code is 500
	And the path name has not been updated
	And the <newName> path name has not been created
Examples:
	| newName             | #notes                     | #TC7  
	| /.xanalyzer         |                            | #TC7.1
	| /                   |                            | #TC7.2
	| %2F.xanalyzer       |                            | #TC7.3
	| %2F                 |                            | #TC7.4
	| %5C.xanalyzer       |                            | #TC7.5
	| %5C                 |                            | #TC7.6
	| ..xanalyzer         |                            | #TC7.7
	| .                   |                            | #TC7.8
	| %2E.xanalyzer       |                            | #TC7.9
	| %2E                 |                            | #TC7.10
	| .xanalyzer          | New name as a single space | #TC7.11
	|                     | New name as a single space | #TC7.12
	| %20.xanalyzer       | New name as a single space | #TC7.13
	| %20                 | New name as a single space | #TC7.14
	| my/file.xanalyzer   |                            | #TC7.15
	| my/directory        |                            | #TC7.16
	| my%2Ffile.xanalyzer |                            | #TC7.17
	| my%2Fdirectory      |                            | #TC7.18
	| my%5Cfile.xanalyzer |                            | #TC7.19
	| my%5Cdirectory      |                            | #TC7.20
	| myfile.xanalyzer    | Leading space              | #TC7.21
	| mydirectory         | Leading space              | #TC7.22
	| %20myfile.xanalyzer | Leading space              | #TC7.23
	| %20mydirectory      | Leading space              | #TC7.24
	| myfile .xanalyzer   | Trailing space             | #TC7.25
	| mydirectory         | Trailing space             | #TC7.26
	| myfile%20.xanalyzer | Trailing space             | #TC7.27
	| mydirectory%20      | Trailing space             | #TC7.28
	
Scenario Outline: The admin user calls the web service to rename a path that does not exist. #TC8
	Given the path <pathId> does not exist
	When the admin user calls the web service to rename the path
	Then the status code is 404
Examples:
	| pathId                       | #TC8
	| /home/admin/missingDirectory | #TC8.1
	| /public/missingFile.prpti    | #TC8.2

Scenario Outline: User calls the web service to rename a path to a name that already exists #TC9
	Given user with all path permissions
	And path with name <newName> already exists
	When the user calls the web service to rename <pathId> with a name that already exists
	Then the status code is 500
	And the path name has not been updated
Examples:
	| pathId                                                             | newName       | #TC9
	| :public:renameParent:UrenameDir9-1:renameTest:renameTest.xanalyzer | alreadyExists | #TC9.1
	| :public:renameParent:UrenameDir9-2:renameTest:renameTest           | alreadyExists | #TC9.2
	| :public:renameParent:UrenameDir9-3:renameTest:renameTest.xanalyzer | renameTest    | #TC9.3
	
Scenario Outline: User calls the web service to rename a path to a name that is within maximal and minimal boundaries. #TC10
	Given user has all permissions
	And <pathId> exists
	When the user calls the web service to rename <pathId> to the name <name> 
	Then the status code is 200
	And the path has been renamed
Examples:
	| pathId                                                      | name                      | #notes                                   | #TC10
	| :public:renameParent:UrenameDir10-1:renameTest:myFile.prpti | 1                         |                                          | #TC10.1
	| :public:renameParent:UrenameDir10-2:myDir                   | 1                         |                                          | #TC10.2
	| :public:renameParent:UrenameDir10-3:myFile.prpti            | ${__RandomString(7000,n)} | File name at maximum length              | #TC10.3
	| :public:renameParent:UrenameDir10-4:renameTest:myDir        | ${__RandomString(7000,n)} | Directory name with maximum length       | #TC10.4
  
Scenario Outline: User calls the web service to rename a path to a name that is outside maximal and minimal boundaries. #TC11
	Given user has all permissions
	And <pathId> exists
	When the user calls the web service to rename <pathId> to the name <name> 
	Then the status code is <statusCode>
	And the path is not renamed
Examples:
	| pathId                                                      | name                      | statusCode | #notes                                | #TC11
	| :public:renameParent:UrenameDir11-1:renameTest:myDir        | null                      | 500        | Null value for new name               | #TC11.1
	| :public:renameTest:myFile.prpti                             | null                      | 500        | Null value for new name               | #TC11.2
	
Scenario Outline: Default admin user calls the web service to rename a default sub-directory within the root directory. #TC12
	Given user has all permissions
	And <pathId> exists
	When the user calls the web service to rename <pathId> to the name <name>
	Then the status code is 403
	And the path is not renamed
Examples:
	| pathId  | name      | #TC12
	| :home   | newHome   | #TC12.1
	| :public | newPublic | #TC12.2
	| :       | newRoot   | #TC12.3
	
Scenario Outline: User calls the web service to rename a path with a name that has lowercase and uppercase letters. #TC13
	Given the user has all permissions
	And the path exists
	When the user calls the web service to rename <pathId> to <newName>
	Then the status code is 200
Examples:
	| pathId                                           | newName   | #notes                                 | #TC13
	| :home:UrenameDir14-1:renameTest:renameTest.prpti | UPPERCASE | All uppercase letters                  | #TC13.1
	| :home:UrenameDir14-2:renameTest:renameTest.prpti | CamelCase | Mix of uppercase and lowercase letters | #TC13.2
	| :home:UrenameDir14-3:renameTest:renameTest.prpti | lowercase | All lowercase letters                  | #TC13.3
	
Scenario Outline: The user calls the web service to rename a path with special characters in the name to a new name that does not contain special characters. #TC14
	Given a path exists at <pathId>
	When admin user calls the web service to rename the path <pathId>
	Then the status code is 200
	And the path name has been updated
Examples:
	| pathId                                           | #TC14
	| :public:UrenameDir15-1:renameTest:!.xanalyzer    | #TC14.1
	| :public:UrenameDir15-2:!                         | #TC14.2
	| :public:UrenameDir15-3:renameTest:@.xanalyzer    | #TC14.3
	| :public:UrenameDir15-4:@                         | #TC14.4
	| :public:UrenameDir15-5:renameTest:$.xanalyzer    | #TC14.5
	| :public:UrenameDir15-6:$                         | #TC14.6
	| :public:UrenameDir15-7:renameTest:*.xanalyzer    | #TC14.7
	| :public:UrenameDir15-8:*                         | #TC14.8
	| :public:UrenameDir15-9:renameTest:(.xanalyzer    | #TC14.9
	| :public:UrenameDir15-10:(                        | #TC14.10
	| :public:UrenameDir15-11:renameTest:).xanalyzer   | #TC14.11
	| :public:UrenameDir15-12:)                        | #TC14.12
	| :public:UrenameDir15-13:renameTest:_.xanalyzer   | #TC14.13
	| :public:UrenameDir15-14:_                        | #TC14.14
	| :public:UrenameDir15-15:renameTest:-.xanalyzer   | #TC14.15
	| :public:UrenameDir15-16:-                        | #TC14.16
	| :public:UrenameDir15-17:renameTest:=.xanalyzer   | #TC14.17
	| :public:UrenameDir15-18:=                        | #TC14.18
	| :public:UrenameDir15-19:renameTest:'.xanalyzer   | #TC14.19
	| :public:UrenameDir15-20:'                        | #TC14.20
	| :public:UrenameDir15-21:renameTest:,.xanalyzer   | #TC14.21
	| :public:UrenameDir15-22:,                        | #TC14.22
	| :public:UrenameDir15-23:renameTest:~.xanalyzer   | #TC14.23
	| :public:UrenameDir15-24:~                        | #TC14.24
	| :public:UrenameDir15-25:renameTest:%23.xanalyzer | #TC14.25
	| :public:UrenameDir15-26:%23                      | #TC14.26
	| :public:UrenameDir15-27:renameTest:%25.xanalyzer | #TC14.27
	| :public:UrenameDir15-28:%25                      | #TC14.28
	| :public:UrenameDir15-29:renameTest:%5E.xanalyzer | #TC14.29
	| :public:UrenameDir15-30:%5E                      | #TC14.30
	| :public:UrenameDir15-31:renameTest:%26.xanalyzer | #TC14.31
	| :public:UrenameDir15-32:%26                      | #TC14.32
	| :public:UrenameDir15-33:renameTest:%2B.xanalyzer | #TC14.33
	| :public:UrenameDir15-34:%2B                      | #TC14.34
	| :public:UrenameDir15-35:renameTest:%3B.xanalyzer | #TC14.35
	| :public:UrenameDir15-36:%3B                      | #TC14.36
	| :public:UrenameDir15-37:renameTest:%3A.xanalyzer | #TC14.37
	| :public:UrenameDir15-38:%3A                      | #TC14.38
	| :public:UrenameDir15-39:renameTest:%22.xanalyzer | #TC14.39
	| :public:UrenameDir15-40:%22                      | #TC14.40
	| :public:UrenameDir15-41:renameTest:%3F.xanalyzer | #TC14.41
	| :public:UrenameDir15-42:%3F                      | #TC14.42
	| :public:UrenameDir15-43:renameTest:%3C.xanalyzer | #TC14.43
	| :public:UrenameDir15-44:%3C                      | #TC14.44
	| :public:UrenameDir15-45:renameTest:%3E.xanalyzer | #TC14.45
	| :public:UrenameDir15-46:%3E                      | #TC14.46
	| :public:UrenameDir15-47:renameTest:%60.xanalyzer | #TC14.47
	| :public:UrenameDir15-48:%60                      | #TC14.48
	| :public:UrenameDir15-49:renameTest:%5B.xanalyzer | #TC14.49
	| :public:UrenameDir15-50:%5B                      | #TC14.50
	| :public:UrenameDir15-51:renameTest:%5D.xanalyzer | #TC14.51
	| :public:UrenameDir15-52:%5D                      | #TC14.52
	| :public:UrenameDir15-53:renameTest:%7B.xanalyzer | #TC14.53
	| :public:UrenameDir15-54:%7B                      | #TC14.54
	| :public:UrenameDir15-55:renameTest:%7D.xanalyzer | #TC14.55
	| :public:UrenameDir15-56:%7D                      | #TC14.56
	| :public:UrenameDir15-57:renameTest:%7C.xanalyzer | #TC14.57
	| :public:UrenameDir15-58:%7C                      | #TC14.58
	| :public:UrenameDir15-59:renameTest:%21.xanalyzer | #TC14.59
	| :public:UrenameDir15-60:%21                      | #TC14.60
	| :public:UrenameDir15-61:renameTest:%40.xanalyzer | #TC14.61
	| :public:UrenameDir15-62:%40                      | #TC14.62
	| :public:UrenameDir15-63:renameTest:%24.xanalyzer | #TC14.63
	| :public:UrenameDir15-64:%24                      | #TC14.64
	| :public:UrenameDir15-65:renameTest:%2A.xanalyzer | #TC14.65
	| :public:UrenameDir15-66:%2A                      | #TC14.66
	| :public:UrenameDir15-67:renameTest:%28.xanalyzer | #TC14.67
	| :public:UrenameDir15-68:%28                      | #TC14.68
	| :public:UrenameDir15-69:renameTest:%29.xanalyzer | #TC14.69
	| :public:UrenameDir15-70:%29                      | #TC14.70
	| :public:UrenameDir15-71:renameTest:%5F.xanalyzer | #TC14.71
	| :public:UrenameDir15-72:%5F                      | #TC14.72
	| :public:UrenameDir15-73:renameTest:%2D.xanalyzer | #TC14.73
	| :public:UrenameDir15-74:%2D                      | #TC14.74
	| :public:UrenameDir15-75:renameTest:%3D.xanalyzer | #TC14.75
	| :public:UrenameDir15-76:%3D                      | #TC14.76
	| :public:UrenameDir15-77:renameTest:%27.xanalyzer | #TC14.77
	| :public:UrenameDir15-78:%27                      | #TC14.78
	| :public:UrenameDir15-79:renameTest:%2C.xanalyzer | #TC14.79
	| :public:UrenameDir15-80:%2C                      | #TC14.80
	| :public:UrenameDir15-81:renameTest:%7E.xanalyzer | #TC14.81
	| :public:UrenameDir15-82:%7E                      | #TC14.82