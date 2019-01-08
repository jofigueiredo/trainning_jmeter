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
Scenario Outline: A user with various user path permissions assigned checks if he have access to a path. #TC1
	Given the user belongs to a role with 'read and create' permissions
	And the path exists
	And just is assigned <userPathPermission> on path
	When the user calls the web service to check if he have <testPermissions> access to path
	Then the status code is '200'
	And the response body just indicates the value <values> for the respective permissions
Examples:
	| userPathPermission       | testPermissions          | values | #notes                                                                            | #TC1
	| read                     | read                     | true   | Read User Path Permission Can Access Read                                         | #TC1.1
	| read                     | write                    | false  | Read User Path Permission Can Not Access Write                                    | #TC1.2
	| read                     | delete                   | false  | Read User Path Permission Can Not Access Delete                                   | #TC1.3
	| read                     | manage                   | false  | Read User Path Permission Can Not Access Manage                                   | #TC1.4
	| read                     | all                      | false  | Read User Path Permission Can Not Access All                                      | #TC1.5
	| read                     | read,write,delete,manage | false  | Read User Path Permission Can Not Access Read,Write,Delete,Manage                 | #TC1.6
	| write                    | read                     | false  | Write User Path Permission Can Not Access Read                                    | #TC1.7
	| write                    | write                    | true   | Write User Path Permission Can Access Write                                       | #TC1.8
	| write                    | delete                   | false  | Write User Path Permission Can Not Access Delete                                  | #TC1.9
	| write                    | manage                   | false  | Write User Path Permission Can Not Access Manage                                  | #TC1.10
	| write                    | all                      | false  | Write User Path Permission Can Not Access All                                     | #TC1.11
	| write                    | read,write,delete        | false  | Write User Path Permission Can Not Access Read,Write,Delete                       | #TC1.12
	| delete                   | read                     | false  | Delete User Path Permission Can Not Access Read                                   | #TC1.13
	| delete                   | write                    | false  | Delete User Path Permission Can Not Access Write                                  | #TC1.14
	| delete                   | delete                   | true   | Delete User Path Permission Can Access Delete                                     | #TC1.15
	| delete                   | manage                   | false  | Delete User Path Permission Can Not Access Manage                                 | #TC1.16
	| delete                   | all                      | false  | Delete User Path Permission Can Not Access All                                    | #TC1.17
	| delete                   | read,write               | false  | Delete User Path Permission Can Not Access Read,Write                             | #TC1.18
	| manage                   | read                     | false  | Manage User Path Permission Can Not Access Read                                   | #TC1.19
	| manage                   | write                    | false  | Manage User Path Permission Can Not Access Write                                  | #TC1.20
	| manage                   | delete                   | false  | Manage User Path Permission Can Not Access Delete                                 | #TC1.21
	| manage                   | manage                   | true   | Manage User Path Permission Can Access Manage                                     | #TC1.22
	| manage                   | all                      | false  | Manage User Path Permission Can Not Access All                                    | #TC1.23
	| manage                   | read,write,delete,manage | false  | Manage User Path Permission Can Not Access Read,Write,Delete,Manage               | #TC1.24
	| all                      | read                     | true   | All User Path Permission Can Access Read                                          | #TC1.25
	| all                      | write                    | true   | All User Path Permission Can Access Write                                         | #TC1.26
	| all                      | delete                   | true   | All User Path Permission Can Access Delete                                        | #TC1.27
	| all                      | manage                   | true   | All User Path Permission Can Access Manage                                        | #TC1.28
	| all                      | all                      | true   | All User Path Permission Can Access All                                           | #TC1.29
	| all                      | read,write,delete,manage | true   | All User Path Permission Can Access Read,Write,Delete,Manage                      | #TC1.30
	| read,write               | read                     | true   | Read,Write User Path Permission Can Access Read                                   | #TC1.31
	| read,write               | write                    | true   | Read,Write User Path Permission Can Access Write                                  | #TC1.32
	| read,write               | delete                   | false  | Read,Write User Path Permission Can Not Access Delete                             | #TC1.33
	| read,write               | manage                   | false  | Read,Write User Path Permission Can Not Access Manage                             | #TC1.34
	| read,write               | all                      | false  | Read,Write User Path Permission Can Not Access All                                | #TC1.35
	| read,write               | read,write               | true   | Read,Write User Path Permission Can Access Read,Write                             | #TC1.36
	| read,write               | delete,manage            | false  | Read,Write User Path Permission Can Not Access Delete,Manage                      | #TC1.37
	| read,write               | read,write,delete        | false  | Read,Write User Path Permission Can Not Access Read,Write,Delete                  | #TC1.38
	| read,delete              | read                     | true   | Read,Delete User Path Permission Can Access Read                                  | #TC1.39
	| read,delete              | write                    | false  | Read,Delete User Path Permission Can Not Access Write                             | #TC1.40
	| read,delete              | delete                   | true   | Read,Delete User Path Permission Can Access Delete                                | #TC1.41
	| read,delete              | manage                   | false  | Read,Delete User Path Permission Can Not Access Manage                            | #TC1.42
	| read,delete              | all                      | false  | Read,Delete User Path Permission Can Not Access All                               | #TC1.43
	| read,delete              | read,delete              | true   | Read,Delete User Path Permission Can Access Read,Delete                           | #TC1.44
	| read,delete              | write,manage             | false  | Read,Delete User Path Permission Can Not Access Write,Manage                      | #TC1.45
	| read,write,delete        | read                     | true   | Read,Write,Delete User Path Permission Can Access Read                            | #TC1.46
	| read,write,delete        | write                    | true   | Read,Write,Delete User Path Permission Can Access Write                           | #TC1.47
	| read,write,delete        | delete                   | true   | Read,Write,Delete User Path Permission Can Access Delete                          | #TC1.48
	| read,write,delete        | manage                   | false  | Read,Write,Delete User Path Permission Can Not Access Manage                      | #TC1.49
	| read,write,delete        | all                      | false  | Read,Write,Delete User Path Permission Can Not Access All                         | #TC1.50
	| read,write,delete        | read,write,delete        | true   | Read,Write,Delete User Path Permission Can Access Read,Write,Delete               | #TC1.51
	| read,write,delete        | read,write,delete,manage | false  | Read,Write,Delete User Path Permission Can Not Access Read,Write,Delete,Manage    | #TC1.52
	| read,delete,manage       | read                     | true   | Read,Delete,Manage User Path Permission Can Access Read                           | #TC1.53
	| read,delete,manage       | write                    | false  | Read,Delete,Manage User Path Permission Can Not Access Write                      | #TC1.54
	| read,delete,manage       | delete                   | true   | Read,Delete,Manage User Path Permission Can Access Delete                         | #TC1.55
	| read,delete,manage       | manage                   | true   | Read,Delete,Manage User Path Permission Can Access Manage                         | #TC1.56
	| read,delete,manage       | all                      | false  | Read,Delete,Manage User Path Permission Can Not Access All                        | #TC1.57
	| read,delete,manage       | read,delete,manage       | true   | Read,Delete,Manage User Path Permission Can Access Read,Delete,Manage             | #TC1.58
	| read,delete,manage       | read,write,delete,manage | false  | Read,Delete,Manage User Path Permission Can Not Access Read,Write,Delete,Manage   | #TC1.59
	| read,write,delete,manage | read                     | true   | Read,Write,Delete,Manage User Path Permission Can Access Read                     | #TC1.60
	| read,write,delete,manage | write                    | true   | Read,Write,Delete,Manage User Path Permission Can Access Write                    | #TC1.61
	| read,write,delete,manage | delete                   | true   | Read,Write,Delete,Manage User Path Permission Can Access Delete                   | #TC1.62
	| read,write,delete,manage | manage                   | true   | Read,Write,Delete,Manage User Path Permission Can Access Manage                   | #TC1.63
	| read,write,delete,manage | all                      | true   | Read,Write,Delete,Manage User Path Permission Can Access All                      | #TC1.64
	| read,write,delete,manage | read,write,delete,manage | true   | Read,Write,Delete,Manage User Path Permission Can Access Read,Write,Delete,Manage | #TC1.65

Scenario Outline: A user with various role path permissions assigned checks if he have access to a path. #TC2
	Given the user belongs to a role with 'read and create' permissions
	And the path exists
	And just is assigned <rolePathPermission> on path
	When the user calls the web service to check if he have <testPermissions> access to path
	Then the status code is '200'
	And the response body just indicates the value <values> for the respective permissions
Examples:
	| rolePathPermission       | testPermissions          | values | #notes                                                                            | #TC2
	| read                     | read                     | true   | Read Role Path Permission Can Access Read                                         | #TC2.1
	| read                     | write                    | false  | Read Role Path Permission Can Not Access Write                                    | #TC2.2
	| read                     | delete                   | false  | Read Role Path Permission Can Not Access Delete                                   | #TC2.3
	| read                     | manage                   | false  | Read Role Path Permission Can Not Access Manage                                   | #TC2.4
	| read                     | all                      | false  | Read Role Path Permission Can Not Access All                                      | #TC2.5
	| read                     | read,write,delete,manage | false  | Read Role Path Permission Can Not Access Read,Write,Delete,Manage                 | #TC2.6
	| write                    | read                     | false  | Write Role Path Permission Can Not Access Read                                    | #TC2.7
	| write                    | write                    | true   | Write Role Path Permission Can Access Write                                       | #TC2.8
	| write                    | delete                   | false  | Write Role Path Permission Can Not Access Delete                                  | #TC2.9
	| write                    | manage                   | false  | Write Role Path Permission Can Not Access Manage                                  | #TC2.10
	| write                    | all                      | false  | Write Role Path Permission Can Not Access All                                     | #TC2.11
	| write                    | read,write,delete        | false  | Write Role Path Permission Can Not Access Read,Write,Delete                       | #TC2.12
	| delete                   | read                     | false  | Delete Role Path Permission Can Not Access Read                                   | #TC2.13
	| delete                   | write                    | false  | Delete Role Path Permission Can Not Access Write                                  | #TC2.14
	| delete                   | delete                   | true   | Delete Role Path Permission Can Access Delete                                     | #TC2.15
	| delete                   | manage                   | false  | Delete Role Path Permission Can Not Access Manage                                 | #TC2.16
	| delete                   | all                      | false  | Delete Role Path Permission Can Not Access All                                    | #TC2.17
	| delete                   | read,write               | false  | Delete Role Path Permission Can Not Access Read,Write                             | #TC2.18
	| manage                   | read                     | false  | Manage Role Path Permission Can Not Access Read                                   | #TC2.19
	| manage                   | write                    | false  | Manage Role Path Permission Can Not Access Write                                  | #TC2.20
	| manage                   | delete                   | false  | Manage Role Path Permission Can Not Access Delete                                 | #TC2.21
	| manage                   | manage                   | true   | Manage Role Path Permission Can Access Manage                                     | #TC2.22
	| manage                   | all                      | false  | Manage Role Path Permission Can Not Access All                                    | #TC2.23
	| manage                   | read,write,delete,manage | false  | Manage Role Path Permission Can Not Access Read,Write,Delete,Manage               | #TC2.24
	| all                      | read                     | true   | All Role Path Permission Can Access Read                                          | #TC2.25
	| all                      | write                    | true   | All Role Path Permission Can Access Write                                         | #TC2.26
	| all                      | delete                   | true   | All Role Path Permission Can Access Delete                                        | #TC2.27
	| all                      | manage                   | true   | All Role Path Permission Can Access Manage                                        | #TC2.28
	| all                      | all                      | true   | All Role Path Permission Can Access All                                           | #TC2.29
	| all                      | read,write,delete,manage | true   | All Role Path Permission Can Access Read,Write,Delete,Manage                      | #TC2.30
	| read,write               | read                     | true   | Read,Write Role Path Permission Can Access Read                                   | #TC2.31
	| read,write               | write                    | true   | Read,Write Role Path Permission Can Access Write                                  | #TC2.32
	| read,write               | delete                   | false  | Read,Write Role Path Permission Can Not Access Delete                             | #TC2.33
	| read,write               | manage                   | false  | Read,Write Role Path Permission Can Not Access Manage                             | #TC2.34
	| read,write               | all                      | false  | Read,Write Role Path Permission Can Not Access All                                | #TC2.35
	| read,write               | read,write               | true   | Read,Write Role Path Permission Can Access Read,Write                             | #TC2.36
	| read,write               | delete,manage            | false  | Read,Write Role Path Permission Can Not Access Delete,Manage                      | #TC2.37
	| read,write               | read,write,delete        | false  | Read,Write Role Path Permission Can Not Access Read,Write,Delete                  | #TC2.38
	| read,delete              | read                     | true   | Read,Delete Role Path Permission Can Access Read                                  | #TC2.39
	| read,delete              | write                    | false  | Read,Delete Role Path Permission Can Not Access Write                             | #TC2.40
	| read,delete              | delete                   | true   | Read,Delete Role Path Permission Can Access Delete                                | #TC2.41
	| read,delete              | manage                   | false  | Read,Delete Role Path Permission Can Not Access Manage                            | #TC2.42
	| read,delete              | all                      | false  | Read,Delete Role Path Permission Can Not Access All                               | #TC2.43
	| read,delete              | read,delete              | true   | Read,Delete Role Path Permission Can Access Read,Delete                           | #TC2.44
	| read,delete              | write,manage             | false  | Read,Delete Role Path Permission Can Not Access Write,Manage                      | #TC2.45
	| read,write,delete        | read                     | true   | Read,Write,Delete Role Path Permission Can Access Read                            | #TC2.46
	| read,write,delete        | write                    | true   | Read,Write,Delete Role Path Permission Can Access Write                           | #TC2.47
	| read,write,delete        | delete                   | true   | Read,Write,Delete Role Path Permission Can Access Delete                          | #TC2.48
	| read,write,delete        | manage                   | false  | Read,Write,Delete Role Path Permission Can Not Access Manage                      | #TC2.49
	| read,write,delete        | all                      | false  | Read,Write,Delete Role Path Permission Can Not Access All                         | #TC2.50
	| read,write,delete        | read,write,delete        | true   | Read,Write,Delete Role Path Permission Can Access Read,Write,Delete               | #TC2.51
	| read,write,delete        | read,write,delete,manage | false  | Read,Write,Delete Role Path Permission Can Not Access Read,Write,Delete,Manage    | #TC2.52
	| read,delete,manage       | read                     | true   | Read,Delete,Manage Role Path Permission Can Access Read                           | #TC2.53
	| read,delete,manage       | write                    | false  | Read,Delete,Manage Role Path Permission Can Not Access Write                      | #TC2.54
	| read,delete,manage       | delete                   | true   | Read,Delete,Manage Role Path Permission Can Access Delete                         | #TC2.55
	| read,delete,manage       | manage                   | true   | Read,Delete,Manage Role Path Permission Can Access Manage                         | #TC2.56
	| read,delete,manage       | all                      | false  | Read,Delete,Manage Role Path Permission Can Not Access All                        | #TC2.57
	| read,delete,manage       | read,delete,manage       | true   | Read,Delete,Manage Role Path Permission Can Access Read,Delete,Manage             | #TC2.58
	| read,delete,manage       | read,write,delete,manage | false  | Read,Delete,Manage Role Path Permission Can Not Access Read,Write,Delete,Manage   | #TC2.59
	| read,write,delete,manage | read                     | true   | Read,Write,Delete,Manage Role Path Permission Can Access Read                     | #TC2.60
	| read,write,delete,manage | write                    | true   | Read,Write,Delete,Manage Role Path Permission Can Access Write                    | #TC2.61
	| read,write,delete,manage | delete                   | true   | Read,Write,Delete,Manage Role Path Permission Can Access Delete                   | #TC2.62
	| read,write,delete,manage | manage                   | true   | Read,Write,Delete,Manage Role Path Permission Can Access Manage                   | #TC2.63
	| read,write,delete,manage | all                      | true   | Read,Write,Delete,Manage Role Path Permission Can Access All                      | #TC2.64
	| read,write,delete,manage | read,write,delete,manage | true   | Read,Write,Delete,Manage Role Path Permission Can Access Read,Write,Delete,Manage | #TC2.65

Scenario Outline: A anonymous user with various role path permissions assigned checks if he have access to a path. #TC3
	Given the anonymous user
	And the path exists
	And just is assigned <rolePathPermission> on path
	When the user calls the web service to check if he have <testPermissions> access to path
	Then the status code is <statusCode>
	And the response body just indicates the value <values> for the respective permissions
Examples:
	| rolePathPermission | testPermissions          | statusCode | values | #notes                                                                                    | #TC3
	| read               | read                     | 401        | true   | Read Anonymous Role Path Permission Can Access Read                                       | #TC3.1
	| read               | write                    | 401        | false  | Read Anonymous Role Path Permission Can Not Access Write                                  | #TC3.2
	| read               | delete                   | 401        | false  | Read Anonymous Role Path Permission Can Not Access Delete                                 | #TC3.3
	| read               | manage                   | 401        | false  | Read Anonymous Role Path Permission Can Not Access Manage                                 | #TC3.4
	| read               | all                      | 401        | false  | Read Anonymous Role Path Permission Can Not Access All                                    | #TC3.5
	| read,write         | read                     | 401        | true   | Read,Write Anonymous Role Path Permission Can Access Read                                 | #TC3.6
	| read,write         | write                    | 401        | true   | Read,Write Anonymous Role Path Permission Can Access Write                                | #TC3.7
	| read,write         | delete                   | 401        | false  | Read,Write Anonymous Role Path Permission Can Not Access Delete                           | #TC3.8
	| read,write         | manage                   | 401        | false  | Read,Write Anonymous Role Path Permission Can Not Access Manage                           | #TC3.9
	| read,write         | all                      | 401        | false  | Read,Write Anonymous Role Path Permission Can Not Access All                              | #TC3.10
	| read,write,delete  | read                     | 401        | true   | Read,Write,Delete Anonymous Role Path Permission Can Access Read                          | #TC3.11
	| read,write,delete  | write                    | 401        | true   | Read,Write,Delete Anonymous Role Path Permission Can Access Write                         | #TC3.12
	| read,write,delete  | delete                   | 401        | true   | Read,Write,Delete Anonymous Role Path Permission Can Access Delete                        | #TC3.13
	| read,write,delete  | manage                   | 401        | false  | Read,Write,Delete Anonymous Role Path Permission Can Not Access Manage                    | #TC3.14
	| read,write,delete  | all                      | 401        | false  | Read,Write,Delete Anonymous Role Path Permission Can Not Access All                       | #TC3.15
	| read,delete        | read                     | 401        | true   | Read,Delete Anonymous Role Path Permission Can Access Read                                | #TC3.16
	| read,delete        | write                    | 401        | false  | Read,Delete Anonymous Role Path Permission Can Not Access Write                           | #TC3.17
	| read,delete        | delete                   | 401        | true   | Read,Delete Anonymous Role Path Permission Can Access Delete                              | #TC3.18
	| read,delete        | manage                   | 401        | false  | Read,Delete Anonymous Role Path Permission Can Not Access Manage                          | #TC3.19
	| read,delete        | all                      | 401        | false  | Read,Delete Anonymous Role Path Permission Can Not Access All                             | #TC3.20
	| read,delete,manage | read                     | 401        | true   | Read,Delete,Manage Anonymous Role Path Permission Can Access Read                         | #TC3.21
	| read,delete,manage | write                    | 401        | false  | Read,Delete,Manage Anonymous Role Path Permission Can Not Access Write                    | #TC3.22
	| read,delete,manage | delete                   | 401        | true   | Read,Delete,Manage Anonymous Role Path Permission Can Access Delete                       | #TC3.23
	| read,delete,manage | manage                   | 401        | true   | Read,Delete,Manage Anonymous Role Path Permission Can Access Manage                       | #TC3.24
	| read,delete,manage | all                      | 401        | false  | Read,Delete,Manage Anonymous Role Path Permission Can Not Access All                      | #TC3.25
	| read,delete,manage | read,delete,manage       | 401        | true   | Read,Delete,Manage Anonymous Role Path Permission Can Access Read,Delete,Manage           | #TC3.26
	| read,delete,manage | read,write,delete,manage | 401        | false  | Read,Delete,Manage Anonymous Role Path Permission Can Not Access Read,Write,Delete,Manage | #TC3.27
	| all                | read                     | 401        | true   | All Anonymous Role Path Permission Can Access Read                                        | #TC3.28
	| all                | write                    | 401        | true   | All Anonymous Role Path Permission Can Access Write                                       | #TC3.29
	| all                | delete                   | 401        | true   | All Anonymous Role Path Permission Can Access Delete                                      | #TC3.30
	| all                | manage                   | 401        | true   | All Anonymous Role Path Permission Can Access Manage                                      | #TC3.31
	| all                | all                      | 401        | true   | All Anonymous Role Path Permission Can Access All                                         | #TC3.32
	| all                | read,write,delete,manage | 401        | true   | All Anonymous Role Path Permission Can Access Read,Write,Delete,Manage                    | #TC3.33
	| null               | read                     | 401        |        | Nulll Anonymous Role Path Permission Can Not Access Read                                  | #TC3.34
	| null               | write                    | 401        |        | Nulll Anonymous Role Path Permission Can Not Access Write                                 | #TC3.35
	| null               | delete                   | 401        |        | Nulll Anonymous Role Path Permission Can Not Access Delete                                | #TC3.36
	| null               | manage                   | 401        |        | Nulll Anonymous Role Path Permission Can Not Access Manage                                | #TC3.37
	| null               | all                      | 401        |        | Nulll Anonymous Role Path Permission Can Not Access All                                   | #TC3.38
	| null               | read,write,delete,manage | 401        |        | Nulll Anonymous Role Path Permission Can Not Access Read,Write,Delete,Manage              | #TC3.39

Scenario Outline: A user with mix role and user path permissions assigned checks if he have access to a path. #TC4
	Given the user belongs to a role with 'read and create' permissions
	And the path exists
	And is assigned <userPathPermission> on path
	And is assigned <rolePathPermission> on path
	When the user calls the web service to check if he have <testPermissions> access to path
	Then the status code is '200'
	And the response body just indicates the value <values> for the respective permissions
Examples:
	| userPathPermission | rolePathPermission | testPermissions          | values | #notes                                                                      | #TC4
	| read,write         | read               | read                     | true   | Null User And Role Path Permissions Can Not Access Read                     | #TC4.1
	| read,write         | read               | write                    | true   | Null User And Role Path Permissions Can Not Access Write                    | #TC4.2
	| read,write         | read               | delete                   | false  | Null User And Role Path Permissions Can Not Access Delete                   | #TC4.3
	| read,write         | read               | manage                   | false  | Null User And Role Path Permissions Can Not Access Manage                   | #TC4.4
	| read,write         | read               | all                      | false  | Null User And Role Path Permissions Can Not Access All                      | #TC4.5
	| read,delete,manage | read,write         | read                     | true   | Null User And Role Path Permissions Can Not Access Read                     | #TC4.6
	| read,delete,manage | read,write         | write                    | true   | Null User And Role Path Permissions Can Not Access Write                    | #TC4.7
	| read,delete,manage | read,write         | delete                   | true   | Null User And Role Path Permissions Can Not Access Delete                   | #TC4.8
	| read,delete,manage | read,write         | manage                   | true   | Null User And Role Path Permissions Can Not Access Manage                   | #TC4.9
	| read,delete,manage | read,write         | all                      | true   | Null User And Role Path Permissions Can Not Access All                      | #TC4.10
	| read,delete,manage | read,write         | read,write,delete,manage | true   | Null User And Role Path Permissions Can Not Access Read,Write,Delete,Manage | #TC4.11
	| read               | all                | read                     | true   | Null User And Role Path Permissions Can Not Access Read                     | #TC4.12
	| read               | all                | write                    | true   | Null User And Role Path Permissions Can Not Access Write                    | #TC4.13
	| read               | all                | delete                   | true   | Null User And Role Path Permissions Can Not Access Delete                   | #TC4.14
	| read               | all                | manage                   | true   | Null User And Role Path Permissions Can Not Access Manage                   | #TC4.15
	| read               | all                | all                      | true   | Null User And Role Path Permissions Can Not Access All                      | #TC4.16
	| all                | read               | read                     | true   | Null User And Role Path Permissions Can Not Access Read                     | #TC4.17
	| all                | read               | write                    | true   | Null User And Role Path Permissions Can Not Access Write                    | #TC4.18
	| all                | read               | delete                   | true   | Null User And Role Path Permissions Can Not Access Delete                   | #TC4.19
	| all                | read               | manage                   | true   | Null User And Role Path Permissions Can Not Access Manage                   | #TC4.20
	| all                | read               | all                      | true   | Null User And Role Path Permissions Can Not Access All                      | #TC4.21
	| all                | read               | read,write,delete,manage | true   | Null User And Role Path Permissions Can Not Access Read,Write,Delete,Manage | #TC4.22

Scenario Outline: A user with mix role and user path permissions assigned checks if he have access to a path. #TC5
	Given the user belongs to a role with <rolePermission> permissions
	And the path exists
	And is assigned <userPathPermission> on path
	And is assigned <rolePathPermission> on path
	When the user calls the web service to check if he have <testPermissions> access to path
	Then the status code is '200'
	And the response body just indicates the value <values> for the respective permissions
Examples:
	| rolePermission | userPathPermission | rolePathPermission | testPermissions          | values | #notes                                                                                              | #TC5
	| null           | all                | all                | read                     | false  | User Role Without Permissions But With All Path Permissions Can Not Access Read                     | #TC5.1
	| null           | all                | all                | write                    | false  | User Role Without Permissions But With All Path Permissions Can Not Access Write                    | #TC5.2
	| null           | all                | all                | delete                   | false  | User Role Without Permissions But With All Path Permissions Can Not Access Delete                   | #TC5.3
	| null           | all                | all                | manage                   | false  | User Role Without Permissions But With All Path Permissions Can Not Access Manage                   | #TC5.4
	| null           | all                | all                | all                      | false  | User Role Without Permissions But With All Path Permissions Can Not Access All                      | #TC5.5
	| null           | all                | all                | read,write,delete,manage | false  | User Role Without Permissions But With All Path Permissions Can Not Access Read,Write,Delete,Manage | #TC5.6
	| all            | null               | null               | all                      | true   | User with all role Permissions Can Access All files                                                 | #TC5.7
	| read,create    | null               | null               | read                     | false  | Null User And Role Path Permissions Can Not Access Read                                             | #TC5.8
	| read,create    | null               | null               | write                    | false  | Null User And Role Path Permissions Can Not Access Write                                            | #TC5.9
	| read,create    | null               | null               | delete                   | false  | Null User And Role Path Permissions Can Not Access Delete                                           | #TC5.10
	| read,create    | null               | null               | manage                   | false  | Null User And Role Path Permissions Can Not Access Manage                                           | #TC5.11
	| read,create    | null               | null               | all                      | false  | Null User And Role Path Permissions Can Not Access All                                              | #TC5.12
	| read,create    | null               | null               | read,write,delete,manage | false  | Null User And Role Path Permissions Can Not Access Read,Write,Delete,Manage                         | #TC5.13
	| read           | all                | all                | read                     | true   | Read Role Permissions And All Path Permissions Can Access Read                                      | #TC5.14
	| read           | all                | all                | write                    | false  | Read Role Permissions And All Path Permissions Can Not Access Write                                 | #TC5.15
	| read           | all                | all                | delete                   | false  | Read Role Permissions And All Path Permissions Can Not Access Delete                                | #TC5.16
	| read           | all                | all                | manage                   | false  | Read Role Permissions And All Path Permissions Can Not Access Manage                                | #TC5.17
	| read           | all                | all                | all                      | false  | Read Role Permissions And All Path Permissions Can Not Access All                                   | #TC5.18
	| read,create    | all                | all                | read                     | true   | Read,Create Role Permissions And All Path Permissions Can Access Read                               | #TC5.19
	| read,create    | all                | all                | write                    | true   | Read,Create Role Permissions And All Path Permissions Can Access Write                              | #TC5.20
	| read,create    | all                | all                | delete                   | true   | Read,Create Role Permissions And All Path Permissions Can Access Delete                             | #TC5.21
	| read,create    | all                | all                | manage                   | true   | Read,Create Role Permissions And All Path Permissions Can Access Manage                             | #TC5.22
	| read,create    | all                | all                | all                      | true   | Read,Create Role Permissions And All Path Permissions Can Access All                                | #TC5.23
	| read,create    | all                | all                | read,write,delete,manage | true   | Read,Create Role Permissions And All Path Permissions Can Access Read,Write,Delete,Manage           | #TC5.24

Scenario: A user checks if he can access a path without parental path directory permissions assigned. #TC6.1
	Given the user belongs to a role with 'read' permission
	And the path exists
	And the user has 'not 'read' permission' on parental path directory
	And is assigned 'all' user path permissions on path
	And is assigned 'all' role path permissions on path
	When the user calls the web service to check if he have 'read' access to path
	Then the status code is '200'
	And the response body just indicates the value 'true' for the respective permissions

Scenario Outline: A user with 'all' role and user path permissions assigned checks if he can access a path with distinct sizes. #TC7
	Given the user belongs to a role with 'all' permissions
	And the <path> exists
	When the user calls the web service to check if he have 'read' access to path
	Then the status code is <statusCode>
	And the response body just indicates the value <values> for the respective permissions
Examples:
	| path                                           | statusCode | values | #notes               | #TC7
	| home                                           | 200        | true   | In Minimal Boundary  | #TC7.1
	| public:canAcc:TC7.2:${__RandomString(7000,n)}  | 200        | true   | In Maximal Boundary  | #TC7.2
	| null                                           | 404        | true   | Out Minimal Boundary | #TC7.3
	| public:canAcc:TC7.4:${__RandomString(20000,n)} | 400        |        | Out Maximal Boundary | #TC7.4

Scenario Outline: A user with 'all' role and user path permissions assigned checks if he can access a path with distinct capitalization. #TC8
	Given the user belongs to a role with 'all' permissions
	And the <path> exists
	When the user calls the web service to check if he have 'read' access to path
	Then the status code is '200'
	And the response body just indicates the value 'true' for the respective permissions
Examples:
	| path                           | #notes     | #TC8
	| public:canAcc:TC8.1:low case   | Low Case   | #TC8.1
	| public:canAcc:TC8.2:UPPER CASE | Upper Case | #TC8.2
	| public:canAcc:TC8.3:Camel Case | Camel Case | #TC8.3


Scenario Outline: A user with 'all' role and user path permissions assigned checks if he can access a path with spaces. #TC9
	Given the user belongs to a role with 'all' permissions
	And the <path> exists
	When the user calls the web service to check if he have 'read' access to path
	Then the status code is '200'
	And the response body just indicates the value 'true' for the respective permissions
Examples:
	| path                        | #notes                         | #TC9
	| public:canAcc:      TC9.1   | No Trailing Spaces             | #TC9.1
	| public:canAcc:T        C9.2 | No Leading Spaces              | #TC9.2
	| public:canAcc:      TC9.3   | No Trailing Spaces Not Encoded | #TC9.3
	| public:canAcc:T        C9.4 | No Leading Spaces Not Encoded  | #TC9.4

Scenario Outline: A user with 'all' role and user path permissions assigned checks if he have access to a distinct path types. #TC10
	Given the user belongs to a role with 'all' permissions
	And the <path> exists
	When the user calls the web service to check if he have 'read' access to path
	Then the status code is '200'
	And the response body just indicates the value 'true' for the respective permissions
Examples:
	| path                                | #notes         | #TC10
	| public:canAcc:TC10.1:file.xml       | file.xml       | #TC10.1
	| public:canAcc:TC10.2:file.prtpi     | file.prtpi     | #TC10.2
	| public:canAcc:TC10.3:file.xanalyzer | file.xanalyzer | #TC10.3
	| public:canAcc:TC10.4:file.xdash     | file.xdash     | #TC10.4
	| public:canAcc:TC10.5:Directory      | Directory      | #TC10.5

Scenario Outline: A user with 'all' role and user path permissions assigned checks if he have access to a distinct path domains. #TC11
	Given the user belongs to a role with 'all' permissions
	And the <path> exists
	When the user calls the web service to check if he have 'read' access to path
	Then the status code is '200'
	And the response body just indicates the value 'true' for the respective permissions
Examples:
	| path   | #notes        | #TC11
	| home   | home domain   | #TC11.1
	| public | public domain | #TC11.2

Scenario Outline: A user with 'all' role and user path permissions assigned checks if he can access a path with distinct ASCII Symbol encoded. #TC12
	Given the user belongs to a role with 'all' permissions
	And the <path> with distinct ASCII Symbol encoded exists
	When the user calls the web service to check if he have 'read' access to path
	Then the status code is '200'
	And the response body just indicates the value 'true' for the respective permissions
Examples:
	| path                              | #notes                   | #TC12
	| public:canAcc:TC12.1:_            | ASCII Symbol _           | #TC12.1
	| public:canAcc:TC12.2:,            | ASCII Symbol ,           | #TC12.2
	| public:canAcc:TC12.3:;            | ASCII Symbol ;           | #TC12.3
	| public:canAcc:TC12.4:+            | ASCII Symbol +           | #TC12.4
	| public:canAcc:TC12.5:-            | ASCII Symbol -           | #TC12.5
	| public:canAcc:TC12.6:*            | ASCII Symbol *           | #TC12.6
	| public:canAcc:TC12.7:=            | ASCII Symbol =           | #TC12.7
	| public:canAcc:TC12.8:>            | ASCII Symbol >           | #TC12.8
	| public:canAcc:TC12.9:<            | ASCII Symbol <           | #TC12.9
	| public:canAcc:TC12.10:(           | ASCII Symbol (           | #TC12.10
	| public:canAcc:TC12.11:)           | ASCII Symbol )           | #TC12.11
	| public:canAcc:TC12.12:[           | ASCII Symbol [           | #TC12.12
	| public:canAcc:TC12.13:]           | ASCII Symbol ]           | #TC12.13
	| public:canAcc:TC12.14:{           | ASCII Symbol {           | #TC12.14
	| public:canAcc:TC12.15:}           | ASCII Symbol }           | #TC12.15
	| public:canAcc:TC12.16:'           | ASCII Symbol '           | #TC12.16
	| public:canAcc:TC12.17:"           | ASCII Symbol "           | #TC12.17
	| public:canAcc:TC12.18:~           | ASCII Symbol ~           | #TC12.18
	| public:canAcc:TC12.19:^           | ASCII Symbol ^           | #TC12.19
	| public:canAcc:TC12.20:%           | ASCII Symbol %           | #TC12.20
	| public:canAcc:TC12.21:#           | ASCII Symbol #           | #TC12.21
	| public:canAcc:TC12.22:@           | ASCII Symbol @           | #TC12.22
	| public:canAcc:TC12.23:&           | ASCII Symbol &           | #TC12.23
	| public:canAcc:TC12.24:$           | ASCII Symbol $           | #TC12.24
	| public:canAcc:TC12.25:€           | ASCII Symbol €           | #TC12.25
	| public:canAcc:TC12.26::           | ASCII Symbol :           | #TC12.26
	| public:canAcc:TC12.27:123@abc.com | ASCII Symbol 123@abc.com | #TC12.27

Scenario Outline: A user with 'all' role and user path permissions assigned checks if he can access a path with distinct ASCII Symbol not encoded. #TC13
	Given the user belongs to a role with 'all' permissions
	And the <path> with distinct ASCII Symbol not encoded exists
	When the user calls the web service to check if he have 'read' access to path
	Then the status code is '200'
	And the response body just indicates the value 'true' for the respective permissions
Examples:
	| path                          | #notes               | #TC13
	| public:canAcc:TC13.1:_        | ASCII Symbol _       | #TC13.1
	| public:canAcc:TC13.2:,        | ASCII Symbol ,       | #TC13.2
	| public:canAcc:TC13.3:;        | ASCII Symbol ;       | #TC13.3
	| public:canAcc:TC13.4:+        | ASCII Symbol +       | #TC13.4
	| public:canAcc:TC13.5:-        | ASCII Symbol -       | #TC13.5
	| public:canAcc:TC13.6:*        | ASCII Symbol *       | #TC13.6
	| public:canAcc:TC13.7:=        | ASCII Symbol =       | #TC13.7
	| public:canAcc:TC13.8:(        | ASCII Symbol (       | #TC13.8
	| public:canAcc:TC13.9:)        | ASCII Symbol )       | #TC13.9
	| public:canAcc:TC13.10:'       | ASCII Symbol '       | #TC13.10
	| public:canAcc:TC13.11:~       | ASCII Symbol ~       | #TC13.11
	| public:canAcc:TC13.12:@       | ASCII Symbol @       | #TC13.12
	| public:canAcc:TC13.13:&       | ASCII Symbol &       | #TC13.13
	| public:canAcc:TC13.14:$       | ASCII Symbol $       | #TC13.14
	| public:canAcc:TC13.15:€       | ASCII Symbol €       | #TC13.15
	| public:canAcc:TC13.16::       | ASCII Symbol :       | #TC13.16
	| public:canAcc:TC13.17:1.0-2.0 | ASCII Symbol 1.0-2.0 | #TC13.17

Scenario Outline: A user with 'all' role and user path permissions assigned checks if he can access a path with distinct ASCII Symbol reserved. #TC14
	Given the user belongs to a role with 'all' permissions
	When the user calls the web service to check if he have 'read' access to <path> with distinct ASCII Symbol reserved
	Then the status code is '400'
	And the response body don't indicates the value 'true or false' for the respective permissions
Examples:
	| path                      | #notes               | #TC14
	| public:canAcc:TC14.1:1/2  | ASCII Symbol /       | #TC14.1
	| public:canAcc:TC14.2:1\2  | ASCII Symbol \       | #TC14.2

Scenario Outline: A user with 'all' role and user path permissions assigned checks if he can access a path with invalid data test permission. #TC15
	Given the user belongs to a role with 'all' permissions
	When the user calls the web service to check if he have <testPermissions> access to path
	Then the status code is '500'
	And the response body don't indicates the value 'true or false' for the respective permissions
Examples:
	| testPermissions | #notes                                                                                                 | #TC15
	| 7               | Permission Wrong Number. Update this test if the following improvement is implemented: BISERVER-14063  | #TC15.1
	| null            | Permission Value Empty. Update this test if the following improvement is implemented: BISERVER-14063   | #TC15.2
	| 1.2             | Permission Value Decimal. Update this test if the following improvement is implemented: BISERVER-14063 | #TC15.3

Scenario: A user checks if he can access a inexistent path. #TC16.1
	Given the user belongs to a role with 'read' permission
	And the path don't exists
	When the user calls the web service to check if he have 'read' access to inexistent path
	Then the status code is '200'
	And the response body don't indicates the value 'true or false' for the respective permissions
