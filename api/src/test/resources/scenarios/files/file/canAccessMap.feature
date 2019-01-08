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
Scenario Outline: A user with various path permissions assigned to the user checks if they have access to a path. #TC1
	Given the path <pathId> exists
	And the user belongs to a role with <rolePermission> permissions
	And the user has <userPathPermission> assigned to <pathId>
	When the user calls the web service to check if they have <permissions> access to <pathId>
	Then the status code is 200
	And the response body indicates the value <values> for the respective permissions
Examples:
	| pathId                                               | rolePermission | userPathPermission | permissions              | values                 | #notes | #TC1
	| :home:UcanAccessMap1-1:canAccessMapTest.xanalyzer    | read,create    | all                | all                      | true                   |        | #TC1.1
	| :public:UcanAccessMap1-2:canAccessMapTest            | read,create    | all                | read,write,delete,manage | true,true,true,true    |        | #TC1.2
	| :public:UcanAccessMap1-3:canAccessMapTest.xanalyzer  | read,create    | all                | read,write,delete        | true,true,true         |        | #TC1.3
	| :public:UcanAccessMap1-4:canAccessMapTest            | read,create    | all                | read,write               | true,true              |        | #TC1.4
	| :public:UcanAccessMap1-5:canAccessMapTest.xanalyzer  | read,create    | all                | read                     | true                   |        | #TC1.5
	| :public:UcanAccessMap1-6:canAccessMapTest            | read,create    | all                | write                    | true                   |        | #TC1.6
	| :public:UcanAccessMap1-7:canAccessMapTest.xanalyzer  | read,create    | all                | delete                   | true                   |        | #TC1.7
	| :public:UcanAccessMap1-8:canAccessMapTest            | read,create    | all                | manage                   | true                   |        | #TC1.8
	| :public:UcanAccessMap1-9:canAccessMapTest.xanalyzer  | read,create    | read,write,delete  | all                      | false                  |        | #TC1.9
	| :public:UcanAccessMap1-10:canAccessMapTest           | read,create    | read,write,delete  | read,write,delete,manage | true,true,true,false   |        | #TC1.10
	| :public:UcanAccessMap1-11:canAccessMapTest.xanalyzer | read,create    | read,write,delete  | read,write,delete        | true,true,true         |        | #TC1.11
	| :public:UcanAccessMap1-12:canAccessMapTest           | read,create    | read,write,delete  | read,write               | true,true              |        | #TC1.12
	| :public:UcanAccessMap1-13:canAccessMapTest.xanalyzer | read,create    | read,write,delete  | read                     | true                   |        | #TC1.13
	| :public:UcanAccessMap1-14:canAccessMapTest           | read,create    | read,write,delete  | write                    | true                   |        | #TC1.14
	| :public:UcanAccessMap1-15:canAccessMapTest.xanalyzer | read,create    | read,write,delete  | delete                   | true                   |        | #TC1.15
	| :public:UcanAccessMap1-16:canAccessMapTest           | read,create    | read,write,delete  | manage                   | false                  |        | #TC1.16
	| :public:UcanAccessMap1-17:canAccessMapTest.xanalyzer | read,create    | read,write         | all                      | false                  |        | #TC1.17
	| :public:UcanAccessMap1-18:canAccessMapTest           | read,create    | read,write         | read,write,delete,manage | true,true,false,false  |        | #TC1.18
	| :public:UcanAccessMap1-19:canAccessMapTest.xanalyzer | read,create    | read,write         | read,write,delete        | true,true,false        |        | #TC1.19
	| :public:UcanAccessMap1-20:canAccessMapTest           | read,create    | read,write         | read,write               | true,true              |        | #TC1.20
	| :public:UcanAccessMap1-21:canAccessMapTest.xanalyzer | read,create    | read,write         | read                     | true                   |        | #TC1.21
	| :public:UcanAccessMap1-22:canAccessMapTest           | read,create    | read,write         | write                    | true                   |        | #TC1.22
	| :public:UcanAccessMap1-23:canAccessMapTest.xanalyzer | read,create    | read,write         | delete                   | false                  |        | #TC1.23
	| :public:UcanAccessMap1-24:canAccessMapTest           | read,create    | read,write         | manage                   | false                  |        | #TC1.24
	| :public:UcanAccessMap1-25:canAccessMapTest.xanalyzer | read,create    | read,delete        | all                      | false                  |        | #TC1.25
	| :public:UcanAccessMap1-26:canAccessMapTest           | read,create    | read,delete        | read,write,delete,manage | true,false,true,false  |        | #TC1.26
	| :public:UcanAccessMap1-27:canAccessMapTest.xanalyzer | read,create    | read,delete        | read,write,delete        | true,false,true        |        | #TC1.27
	| :public:UcanAccessMap1-28:canAccessMapTest           | read,create    | read,delete        | read,write               | true,false             |        | #TC1.28
	| :public:UcanAccessMap1-29:canAccessMapTest.xanalyzer | read,create    | read,delete        | read                     | true                   |        | #TC1.29
	| :public:UcanAccessMap1-30:canAccessMapTest           | read,create    | read,delete        | write                    | false                  |        | #TC1.30
	| :public:UcanAccessMap1-31:canAccessMapTest.xanalyzer | read,create    | read,delete        | delete                   | true                   |        | #TC1.31
	| :public:UcanAccessMap1-32:canAccessMapTest           | read,create    | read,delete        | manage                   | false                  |        | #TC1.32
	| :public:UcanAccessMap1-33:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | all                      | false                  |        | #TC1.33
	| :public:UcanAccessMap1-34:canAccessMapTest           | read,create    | read,delete,manage | read,write,delete,manage | true,false,true,true   |        | #TC1.34
	| :public:UcanAccessMap1-35:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | read,write,delete        | true,false,true        |        | #TC1.35
	| :public:UcanAccessMap1-36:canAccessMapTest           | read,create    | read,delete,manage | read,write               | true,false             |        | #TC1.36
	| :public:UcanAccessMap1-37:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | read                     | true                   |        | #TC1.37
	| :public:UcanAccessMap1-38:canAccessMapTest           | read,create    | read,delete,manage | write                    | false                  |        | #TC1.38
	| :public:UcanAccessMap1-39:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | delete                   | true                   |        | #TC1.39
	| :public:UcanAccessMap1-40:canAccessMapTest           | read,create    | read,delete,manage | manage                   | true                   |        | #TC1.40
	| :public:UcanAccessMap1-41:canAccessMapTest.xanalyzer | read,create    | read               | all                      | false                  |        | #TC1.41
	| :public:UcanAccessMap1-42:canAccessMapTest           | read,create    | read               | read,write,delete,manage | true,false,false,false |        | #TC1.42
	| :public:UcanAccessMap1-43:canAccessMapTest.xanalyzer | read,create    | read               | read,write,delete        | true,false,false       |        | #TC1.43
	| :public:UcanAccessMap1-44:canAccessMapTest           | read,create    | read               | read,write               | true,false             |        | #TC1.44
	| :public:UcanAccessMap1-45:canAccessMapTest.xanalyzer | read,create    | read               | read                     | true                   |        | #TC1.45
	| :public:UcanAccessMap1-46:canAccessMapTest           | read,create    | write              | all                      | false                  |        | #TC1.46
	| :public:UcanAccessMap1-47:canAccessMapTest.xanalyzer | read,create    | write              | read,write,delete,manage | false,true,false,false |        | #TC1.47
	| :public:UcanAccessMap1-48:canAccessMapTest           | read,create    | write              | read,write,delete        | false,true,false       |        | #TC1.48
	| :public:UcanAccessMap1-49:canAccessMapTest.xanalyzer | read,create    | write              | read,write               | false,true             |        | #TC1.49
	| :public:UcanAccessMap1-50:canAccessMapTest           | read,create    | write              | read                     | false                  |        | #TC1.50
	| :public:UcanAccessMap1-51:canAccessMapTest.xanalyzer | read,create    | delete             | all                      | false                  |        | #TC1.51
	| :public:UcanAccessMap1-52:canAccessMapTest           | read,create    | delete             | read,write,delete,manage | false,false,true,false |        | #TC1.52
	| :public:UcanAccessMap1-53:canAccessMapTest.xanalyzer | read,create    | delete             | read,write,delete        | false,false,true       |        | #TC1.53
	| :public:UcanAccessMap1-54:canAccessMapTest           | read,create    | delete             | read,write               | false,false            |        | #TC1.54
	| :public:UcanAccessMap1-55:canAccessMapTest.xanalyzer | read,create    | delete             | read                     | false                  |        | #TC1.55
	| :public:UcanAccessMap1-56:canAccessMapTest           | read,create    | manage             | all                      | false                  |        | #TC1.56
	| :public:UcanAccessMap1-57:canAccessMapTest.xanalyzer | read,create    | manage             | read,write,delete,manage | false,false,false,true |        | #TC1.57
	| :public:UcanAccessMap1-58:canAccessMapTest           | read,create    | manage             | read,write,delete        | false,false,false      |        | #TC1.58
	| :public:UcanAccessMap1-59:canAccessMapTest.xanalyzer | read,create    | manage             | read,write               | false,false            |        | #TC1.59
	| :public:UcanAccessMap1-60:canAccessMapTest           | read,create    | manage             | read                     | false                  |        | #TC1.60
	| :public:UcanAccessMap1-61:canAccessMapTest.xanalyzer | Administrator  | all                | all                      | true                   |        | #TC1.61
	| :public:UcanAccessMap1-62:canAccessMapTest           | Administrator  | all                | read,write,delete,manage | true,true,true,true    |        | #TC1.62
	| :public:UcanAccessMap1-63:canAccessMapTest.xanalyzer | all            | all                | all                      | true                   |        | #TC1.63
	| :public:UcanAccessMap1-64:canAccessMapTest           | all            | all                | read,write,delete,manage | true,true,true,true    |        | #TC1.64
	
Scenario Outline: A user with various path permissions assigned to the role checks if they have access to a path. #TC2
	Given the path <pathId> exists
	And the user belongs to a role with <rolePermission> permissions
	And the role has <rolePathPermission> assigned to <pathId>
	When the user calls the web service to check if they have <permissions> access to <pathId>
	Then the status code is 200
	And the response body indicates the value <values> for the respective permissions
Examples:
	| pathId                                               | rolePermission | userPathPermission | permissions              | values                 | #notes | #TC2
	| :home:UcanAccessMap2-1:canAccessMapTest.xanalyzer    | read,create    | all                | all                      | true                   |        | #TC2.1
	| :public:UcanAccessMap2-2:canAccessMapTest            | read,create    | all                | read,write,delete,manage | true,true,true,true    |        | #TC2.2
	| :public:UcanAccessMap2-3:canAccessMapTest.xanalyzer  | read,create    | all                | read,write,delete        | true,true,true         |        | #TC2.3
	| :public:UcanAccessMap2-4:canAccessMapTest            | read,create    | all                | read,write               | true,true              |        | #TC2.4
	| :public:UcanAccessMap2-5:canAccessMapTest.xanalyzer  | read,create    | all                | read                     | true                   |        | #TC2.5
	| :public:UcanAccessMap2-6:canAccessMapTest            | read,create    | all                | write                    | true                   |        | #TC2.6
	| :public:UcanAccessMap2-7:canAccessMapTest.xanalyzer  | read,create    | all                | delete                   | true                   |        | #TC2.7
	| :public:UcanAccessMap2-8:canAccessMapTest            | read,create    | all                | manage                   | true                   |        | #TC2.8
	| :public:UcanAccessMap2-9:canAccessMapTest.xanalyzer  | read,create    | read,write,delete  | all                      | false                  |        | #TC2.9
	| :public:UcanAccessMap2-10:canAccessMapTest           | read,create    | read,write,delete  | read,write,delete,manage | true,true,true,false   |        | #TC2.10
	| :public:UcanAccessMap2-11:canAccessMapTest.xanalyzer | read,create    | read,write,delete  | read,write,delete        | true,true,true         |        | #TC2.11
	| :public:UcanAccessMap2-12:canAccessMapTest           | read,create    | read,write,delete  | read,write               | true,true              |        | #TC2.12
	| :public:UcanAccessMap2-13:canAccessMapTest.xanalyzer | read,create    | read,write,delete  | read                     | true                   |        | #TC2.13
	| :public:UcanAccessMap2-14:canAccessMapTest           | read,create    | read,write,delete  | write                    | true                   |        | #TC2.14
	| :public:UcanAccessMap2-15:canAccessMapTest.xanalyzer | read,create    | read,write,delete  | delete                   | true                   |        | #TC2.15
	| :public:UcanAccessMap2-16:canAccessMapTest           | read,create    | read,write,delete  | manage                   | false                  |        | #TC2.16
	| :public:UcanAccessMap2-17:canAccessMapTest.xanalyzer | read,create    | read,write         | all                      | false                  |        | #TC2.17
	| :public:UcanAccessMap2-18:canAccessMapTest           | read,create    | read,write         | read,write,delete,manage | true,true,false,false  |        | #TC2.18
	| :public:UcanAccessMap2-19:canAccessMapTest.xanalyzer | read,create    | read,write         | read,write,delete        | true,true,false        |        | #TC2.19
	| :public:UcanAccessMap2-20:canAccessMapTest           | read,create    | read,write         | read,write               | true,true              |        | #TC2.20
	| :public:UcanAccessMap2-21:canAccessMapTest.xanalyzer | read,create    | read,write         | read                     | true                   |        | #TC2.21
	| :public:UcanAccessMap2-22:canAccessMapTest           | read,create    | read,write         | write                    | true                   |        | #TC2.22
	| :public:UcanAccessMap2-23:canAccessMapTest.xanalyzer | read,create    | read,write         | delete                   | false                  |        | #TC2.23
	| :public:UcanAccessMap2-24:canAccessMapTest           | read,create    | read,write         | manage                   | false                  |        | #TC2.24
	| :public:UcanAccessMap2-25:canAccessMapTest.xanalyzer | read,create    | read,delete        | all                      | false                  |        | #TC2.25
	| :public:UcanAccessMap2-26:canAccessMapTest           | read,create    | read,delete        | read,write,delete,manage | true,false,true,false  |        | #TC2.26
	| :public:UcanAccessMap2-27:canAccessMapTest.xanalyzer | read,create    | read,delete        | read,write,delete        | true,false,true        |        | #TC2.27
	| :public:UcanAccessMap2-28:canAccessMapTest           | read,create    | read,delete        | read,write               | true,false             |        | #TC2.28
	| :public:UcanAccessMap2-29:canAccessMapTest.xanalyzer | read,create    | read,delete        | read                     | true                   |        | #TC2.29
	| :public:UcanAccessMap2-30:canAccessMapTest           | read,create    | read,delete        | write                    | false                  |        | #TC2.30
	| :public:UcanAccessMap2-31:canAccessMapTest.xanalyzer | read,create    | read,delete        | delete                   | true                   |        | #TC2.31
	| :public:UcanAccessMap2-32:canAccessMapTest           | read,create    | read,delete        | manage                   | false                  |        | #TC2.32
	| :public:UcanAccessMap2-33:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | all                      | false                  |        | #TC2.33
	| :public:UcanAccessMap2-34:canAccessMapTest           | read,create    | read,delete,manage | read,write,delete,manage | true,false,true,true   |        | #TC2.34
	| :public:UcanAccessMap2-35:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | read,write,delete        | true,false,true        |        | #TC2.35
	| :public:UcanAccessMap2-36:canAccessMapTest           | read,create    | read,delete,manage | read,write               | true,false             |        | #TC2.36
	| :public:UcanAccessMap2-37:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | read                     | true                   |        | #TC2.37
	| :public:UcanAccessMap2-38:canAccessMapTest           | read,create    | read,delete,manage | write                    | false                  |        | #TC2.38
	| :public:UcanAccessMap2-39:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | delete                   | true                   |        | #TC2.39
	| :public:UcanAccessMap2-40:canAccessMapTest           | read,create    | read,delete,manage | manage                   | true                   |        | #TC2.40
	| :public:UcanAccessMap2-41:canAccessMapTest.xanalyzer | read,create    | read               | all                      | false                  |        | #TC2.41
	| :public:UcanAccessMap2-42:canAccessMapTest           | read,create    | read               | read,write,delete,manage | true,false,false,false |        | #TC2.42
	| :public:UcanAccessMap2-43:canAccessMapTest.xanalyzer | read,create    | read               | read,write,delete        | true,false,false       |        | #TC2.43
	| :public:UcanAccessMap2-44:canAccessMapTest           | read,create    | read               | read,write               | true,false             |        | #TC2.44
	| :public:UcanAccessMap2-45:canAccessMapTest.xanalyzer | read,create    | read               | read                     | true                   |        | #TC2.45
	| :public:UcanAccessMap2-46:canAccessMapTest           | read,create    | write              | all                      | false                  |        | #TC2.46
	| :public:UcanAccessMap2-47:canAccessMapTest.xanalyzer | read,create    | write              | read,write,delete,manage | false,true,false,false |        | #TC2.47
	| :public:UcanAccessMap2-48:canAccessMapTest           | read,create    | write              | read,write,delete        | false,true,false       |        | #TC2.48
	| :public:UcanAccessMap2-49:canAccessMapTest.xanalyzer | read,create    | write              | read,write               | false,true             |        | #TC2.49
	| :public:UcanAccessMap2-50:canAccessMapTest           | read,create    | write              | read                     | false                  |        | #TC2.50
	| :public:UcanAccessMap2-51:canAccessMapTest.xanalyzer | read,create    | delete             | all                      | false                  |        | #TC2.51
	| :public:UcanAccessMap2-52:canAccessMapTest           | read,create    | delete             | read,write,delete,manage | false,false,true,false |        | #TC2.52
	| :public:UcanAccessMap2-53:canAccessMapTest.xanalyzer | read,create    | delete             | read,write,delete        | false,false,true       |        | #TC2.53
	| :public:UcanAccessMap2-54:canAccessMapTest           | read,create    | delete             | read,write               | false,false            |        | #TC2.54
	| :public:UcanAccessMap2-55:canAccessMapTest.xanalyzer | read,create    | delete             | read                     | false                  |        | #TC2.55
	| :public:UcanAccessMap2-56:canAccessMapTest           | read,create    | manage             | all                      | false                  |        | #TC2.56
	| :public:UcanAccessMap2-57:canAccessMapTest.xanalyzer | read,create    | manage             | read,write,delete,manage | false,false,false,true |        | #TC2.57
	| :public:UcanAccessMap2-58:canAccessMapTest           | read,create    | manage             | read,write,delete        | false,false,false      |        | #TC2.58
	| :public:UcanAccessMap2-59:canAccessMapTest.xanalyzer | read,create    | manage             | read,write               | false,false            |        | #TC2.59
	| :public:UcanAccessMap2-60:canAccessMapTest           | read,create    | manage             | read                     | false                  |        | #TC2.60
	| :public:UcanAccessMap2-61:canAccessMapTest.xanalyzer | Administrator  | all                | all                      | true                   |        | #TC2.61
	| :public:UcanAccessMap2-62:canAccessMapTest           | Administrator  | all                | read,write,delete,manage | true,true,true,true    |        | #TC2.62
	| :public:UcanAccessMap2-63:canAccessMapTest.xanalyzer | all            | all                | all                      | true                   |        | #TC2.63
	| :public:UcanAccessMap2-64:canAccessMapTest           | all            | all                | read,write,delete,manage | true,true,true,true    |        | #TC2.64

Scenario Outline: A user with various path permissions assigned to the user and the role checks if they have access to a path. #TC3
	Given the path <pathId> exists
	And the user belongs to a role with the read and create permissions
	And the user has <userPathPermission> assigned to <pathId>
	And the role has <rolePathPermission> assigned to <pathId>
	When the user calls the web service to check if they have <permissions> access to <pathId>
	Then the status code is 200
	And the response body indicates the value <values> for the respective permissions
Examples:
	| pathId                                              | userPathPermission | rolePathPermission | permissions              | values              | #notes | #TC3
	| :home:UcanAccessMap3-1:canAccessMapTest.xanalyzer   | read,write         | delete,manage      | all                      | true                |        | #TC3.1
	| :public:UcanAccessMap3-2:canAccessMapTest           | read,write         | delete,manage      | all                      | true                |        | #TC3.2
	| :public:UcanAccessMap3-3:canAccessMapTest.xanalyzer | read,write         | delete,manage      | read,write,delete,manage | true,true,true,true |        | #TC3.3
	| :public:UcanAccessMap3-4:canAccessMapTest           | read,write         | delete,manage      | read,write,delete,manage | true,true,true,true |        | #TC3.4
	| :public:UcanAccessMap3-5:canAccessMapTest.xanalyzer | all                | null               | all                      | true                |        | #TC3.5
	| :public:UcanAccessMap3-6:canAccessMapTest           | null               | all                | all                      | true                |        | #TC3.6
	| :public:UcanAccessMap3-7:canAccessMapTest.xanalyzer | all                | null               | read,write,delete,manage | true,true,true,true |        | #TC3.7
	| :public:UcanAccessMap3-8:canAccessMapTest           | null               | all                | read,write,delete,manage | true,true,true,true |        | #TC3.8
	
Scenario Outline: A user with various path permissions assigned to the user and the role checks if they have access to a path, but do not have access to the parent directory. #TC4
	Given the path <pathId> exists
	And the user belongs to a role with the read and create permissions
	And the user has <userPathPermission> assigned to <pathId>
	And the role has <rolePathPermission> assigned to <pathId>
	When the user calls the web service to check if they have <permissions> access to <pathId>
	Then the status code is 200
	And the response body indicates the value <values> for the respective permissions
Examples:
	| pathId                                              | userPathPermission | rolePathPermission | permissions              | values              | #notes | #TC4
	| :home:UcanAccessMap4-1:canAccessMapTest.xanalyzer   | read,write         | delete,manage      | all                      | true                |        | #TC4.1
	| :public:UcanAccessMap4-2:canAccessMapTest           | read,write         | delete,manage      | all                      | true                |        | #TC4.2
	| :public:UcanAccessMap4-3:canAccessMapTest.xanalyzer | read,write         | delete,manage      | read,write,delete,manage | true,true,true,true |        | #TC4.3
	| :public:UcanAccessMap4-4:canAccessMapTest           | read,write         | delete,manage      | read,write,delete,manage | true,true,true,true |        | #TC4.4
	| :public:UcanAccessMap4-5:canAccessMapTest.xanalyzer | all                | null               | all                      | true                |        | #TC4.5
	| :public:UcanAccessMap4-6:canAccessMapTest           | null               | all                | all                      | true                |        | #TC4.6
	| :public:UcanAccessMap4-7:canAccessMapTest.xanalyzer | all                | null               | read,write,delete,manage | true,true,true,true |        | #TC4.7
	| :public:UcanAccessMap4-8:canAccessMapTest           | null               | all                | read,write,delete,manage | true,true,true,true |        | #TC4.8
	
Scenario Outline: A user assigned to a role with various permissions checks if they have access to a path. #TC5
	Given the path <pathId> exists
	And the user belongs to a role with <rolePermission> permissions
	And the user has all user-based path permissions assigned to <pathId>
	And the user has all role-based path permissions assigned to <pathId>
	When the user calls the web service to check if they have access with all permissions to <pathId>
	Then the status code is 200
	And the response body indicates the value <values> for the respective permissions
Examples:
	| pathId                                               | rolePermission            | values | #notes | #TC5
	| :public:UcanAccessMap5-1:canAccessMapTest.xanalyzer  | Administrator             | true   |        | #TC5.1
	| :public:UcanAccessMap5-2:canAccessMapTest            | Administrator             | true   |        | #TC5.2
	| :public:UcanAccessMap5-3:canAccessMapTest.xanalyzer  | all                       | true   |        | #TC5.3
	| :public:UcanAccessMap5-4:canAccessMapTest            | all                       | true   |        | #TC5.4
	| :home:UcanAccessMap5-5:canAccessMapTest.xanalyzer    | read                      | false  |        | #TC5.5
	| :public:UcanAccessMap5-6:canAccessMapTest            | read                      | false  |        | #TC5.6
	| :public:UcanAccessMap5-7:canAccessMapTest.xanalyzer  | create                    | false  |        | #TC5.7
	| :public:UcanAccessMap5-8:canAccessMapTest            | create                    | false  |        | #TC5.8
	| :public:UcanAccessMap5-9:canAccessMapTest.xanalyzer  | scheduler                 | false  |        | #TC5.9
	| :public:UcanAccessMap5-10:canAccessMapTest           | scheduler                 | false  |        | #TC5.10
	| :public:UcanAccessMap5-11:canAccessMapTest.xanalyzer | execute                   | false  |        | #TC5.11
	| :public:UcanAccessMap5-12:canAccessMapTest           | execute                   | false  |        | #TC5.12
	| :public:UcanAccessMap5-13:canAccessMapTest.xanalyzer | datasource                | false  |        | #TC5.13
	| :public:UcanAccessMap5-14:canAccessMapTest           | datasource                | false  |        | #TC5.14
	| :public:UcanAccessMap5-15:canAccessMapTest.xanalyzer | administerSecurity        | false  |        | #TC5.15
	| :public:UcanAccessMap5-16:canAccessMapTest           | administerSecurity        | false  |        | #TC5.16
	| :public:UcanAccessMap5-17:canAccessMapTest.xanalyzer | read,scheduler            | false  |        | #TC5.17
	| :public:UcanAccessMap5-18:canAccessMapTest           | read,scheduler            | false  |        | #TC5.18
	| :public:UcanAccessMap5-19:canAccessMapTest.xanalyzer | read,publish              | false  |        | #TC5.19
	| :public:UcanAccessMap5-20:canAccessMapTest           | read,publish              | false  |        | #TC5.20
	| :public:UcanAccessMap5-21:canAccessMapTest.xanalyzer | read,execute              | false  |        | #TC5.21
	| :public:UcanAccessMap5-22:canAccessMapTest           | read,execute              | false  |        | #TC5.22
	| :public:UcanAccessMap5-23:canAccessMapTest.xanalyzer | read,datasource           | false  |        | #TC5.23
	| :public:UcanAccessMap5-24:canAccessMapTest           | read,datasource           | false  |        | #TC5.24
	| :public:UcanAccessMap5-25:canAccessMapTest.xanalyzer | read,administerSecurity   | false  |        | #TC5.25
	| :public:UcanAccessMap5-26:canAccessMapTest           | read,administerSecurity   | false  |        | #TC5.26
	| :public:UcanAccessMap5-27:canAccessMapTest.xanalyzer | read,create               | true   |        | #TC5.27
	| :public:UcanAccessMap5-28:canAccessMapTest           | read,create               | true   |        | #TC5.28
	| :public:UcanAccessMap5-29:canAccessMapTest.xanalyzer | create,scheduler          | false  |        | #TC5.29
	| :public:UcanAccessMap5-30:canAccessMapTest           | create,scheduler          | false  |        | #TC5.30
	| :public:UcanAccessMap5-31:canAccessMapTest.xanalyzer | create,publish            | false  |        | #TC5.31
	| :public:UcanAccessMap5-32:canAccessMapTest           | create,publish            | false  |        | #TC5.32
	| :public:UcanAccessMap5-33:canAccessMapTest.xanalyzer | create,execute            | false  |        | #TC5.33
	| :public:UcanAccessMap5-34:canAccessMapTest           | create,execute            | false  |        | #TC5.34
	| :public:UcanAccessMap5-35:canAccessMapTest.xanalyzer | create,datasource         | false  |        | #TC5.35
	| :public:UcanAccessMap5-36:canAccessMapTest           | create,datasource         | false  |        | #TC5.36
	| :public:UcanAccessMap5-37:canAccessMapTest.xanalyzer | create,administerSecurity | false  |        | #TC5.37
	| :public:UcanAccessMap5-38:canAccessMapTest           | create,administerSecurity | false  |        | #TC5.38
	| :public:UcanAccessMap5-37:canAccessMapTest.xanalyzer | null                      | false  |        | #TC5.39
	| :public:UcanAccessMap5-38:canAccessMapTest           | null                      | false  |        | #TC5.40
	
Scenario Outline: An anonymous user checks if they have access to a path while the Anonymous role has various permissions. #TC6
	Given the path <pathId> exists
	And the anonymous role has <rolePathPermission> permissions assigned to <pathId>
	When the user calls the web service to check if they have access with all permissions to <pathId>
	Then the status code is <statusCode>
	And the response body indicates the value <values> for the respective permissions
	
Examples:
	| pathId                                           | rolePermission | userPathPermission | permissions              | values                 | statusCode | #notes | #TC6
	| :public:Anonymous6-1:canAccessMapTest.xanalyzer  | read,create    | all                | all                      | true                   | 200        |        | #TC6.1
	| :public:Anonymous6-2:canAccessMapTest            | read,create    | all                | read,write,delete,manage | true,true,true,true    | 200        |        | #TC6.2
	| :public:Anonymous6-3:canAccessMapTest.xanalyzer  | read,create    | all                | read,write,delete        | true,true,true         | 200        |        | #TC6.3
	| :public:Anonymous6-4:canAccessMapTest            | read,create    | all                | read,write               | true,true              | 200        |        | #TC6.4
	| :public:Anonymous6-5:canAccessMapTest.xanalyzer  | read,create    | all                | read                     | true                   | 200        |        | #TC6.5
	| :public:Anonymous6-6:canAccessMapTest            | read,create    | all                | write                    | true                   | 200        |        | #TC6.6
	| :public:Anonymous6-7:canAccessMapTest.xanalyzer  | read,create    | all                | delete                   | true                   | 200        |        | #TC6.7
	| :public:Anonymous6-8:canAccessMapTest            | read,create    | all                | manage                   | true                   | 200        |        | #TC6.8
	| :public:Anonymous6-9:canAccessMapTest.xanalyzer  | read,create    | read,write,delete  | all                      | false                  | 200        |        | #TC6.9
	| :public:Anonymous6-10:canAccessMapTest           | read,create    | read,write,delete  | read,write,delete,manage | true,true,true,false   | 200        |        | #TC6.10
	| :public:Anonymous6-11:canAccessMapTest.xanalyzer | read,create    | read,write,delete  | read,write,delete        | true,true,true         | 200        |        | #TC6.11
	| :public:Anonymous6-12:canAccessMapTest           | read,create    | read,write,delete  | read,write               | true,true              | 200        |        | #TC6.12
	| :public:Anonymous6-13:canAccessMapTest.xanalyzer | read,create    | read,write,delete  | read                     | true                   | 200        |        | #TC6.13
	| :public:Anonymous6-14:canAccessMapTest           | read,create    | read,write,delete  | write                    | true                   | 200        |        | #TC6.14
	| :public:Anonymous6-15:canAccessMapTest.xanalyzer | read,create    | read,write,delete  | delete                   | true                   | 200        |        | #TC6.15
	| :public:Anonymous6-16:canAccessMapTest           | read,create    | read,write,delete  | manage                   | false                  | 200        |        | #TC6.16
	| :public:Anonymous6-17:canAccessMapTest.xanalyzer | read,create    | read,write         | all                      | false                  | 200        |        | #TC6.17
	| :public:Anonymous6-18:canAccessMapTest           | read,create    | read,write         | read,write,delete,manage | true,true,false,false  | 200        |        | #TC6.18
	| :public:Anonymous6-19:canAccessMapTest.xanalyzer | read,create    | read,write         | read,write,delete        | true,true,false        | 200        |        | #TC6.19
	| :public:Anonymous6-20:canAccessMapTest           | read,create    | read,write         | read,write               | true,true              | 200        |        | #TC6.20
	| :public:Anonymous6-21:canAccessMapTest.xanalyzer | read,create    | read,write         | read                     | true                   | 200        |        | #TC6.21
	| :public:Anonymous6-22:canAccessMapTest           | read,create    | read,write         | write                    | true                   | 200        |        | #TC6.22
	| :public:Anonymous6-23:canAccessMapTest.xanalyzer | read,create    | read,write         | delete                   | false                  | 200        |        | #TC6.23
	| :public:Anonymous6-24:canAccessMapTest           | read,create    | read,write         | manage                   | false                  | 200        |        | #TC6.24
	| :public:Anonymous6-25:canAccessMapTest.xanalyzer | read,create    | read,delete        | all                      | false                  | 200        |        | #TC6.25
	| :public:Anonymous6-26:canAccessMapTest           | read,create    | read,delete        | read,write,delete,manage | true,false,true,false  | 200        |        | #TC6.26
	| :public:Anonymous6-27:canAccessMapTest.xanalyzer | read,create    | read,delete        | read,write,delete        | true,false,true        | 200        |        | #TC6.27
	| :public:Anonymous6-28:canAccessMapTest           | read,create    | read,delete        | read,write               | true,false             | 200        |        | #TC6.28
	| :public:Anonymous6-29:canAccessMapTest.xanalyzer | read,create    | read,delete        | read                     | true                   | 200        |        | #TC6.29
	| :public:Anonymous6-30:canAccessMapTest           | read,create    | read,delete        | write                    | false                  | 200        |        | #TC6.30
	| :public:Anonymous6-31:canAccessMapTest.xanalyzer | read,create    | read,delete        | delete                   | true                   | 200        |        | #TC6.31
	| :public:Anonymous6-32:canAccessMapTest           | read,create    | read,delete        | manage                   | false                  | 200        |        | #TC6.32
	| :public:Anonymous6-33:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | all                      | false                  | 200        |        | #TC6.33
	| :public:Anonymous6-34:canAccessMapTest           | read,create    | read,delete,manage | read,write,delete,manage | true,false,true,true   | 200        |        | #TC6.34
	| :public:Anonymous6-35:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | read,write,delete        | true,false,true        | 200        |        | #TC6.35
	| :public:Anonymous6-36:canAccessMapTest           | read,create    | read,delete,manage | read,write               | true,false             | 200        |        | #TC6.36
	| :public:Anonymous6-37:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | read                     | true                   | 200        |        | #TC6.37
	| :public:Anonymous6-38:canAccessMapTest.          | read,create    | read,delete,manage | write                    | false                  | 200        |        | #TC6.38
	| :public:Anonymous6-39:canAccessMapTest.xanalyzer | read,create    | read,delete,manage | delete                   | true                   | 200        |        | #TC6.39
	| :public:Anonymous6-40:canAccessMapTest           | read,create    | read,delete,manage | manage                   | true                   | 200        |        | #TC6.40
	| :public:Anonymous6-41:canAccessMapTest.xanalyzer | read,create    | read               | all                      | false                  | 200        |        | #TC6.41
	| :public:Anonymous6-42:canAccessMapTest           | read,create    | read               | read,write,delete,manage | true,false,false,false | 200        |        | #TC6.42
	| :public:Anonymous6-43:canAccessMapTest.xanalyzer | read,create    | read               | read,write,delete        | true,false,false       | 200        |        | #TC6.43
	| :public:Anonymous6-44:canAccessMapTest           | read,create    | read               | read,write               | true,false             | 200        |        | #TC6.44
	| :public:Anonymous6-45:canAccessMapTest.xanalyzer | read,create    | read               | read                     | true                   | 200        |        | #TC6.45
	| :public:Anonymous6-46:canAccessMapTest           | read,create    | write              | all                      | false                  | 200        |        | #TC6.46
	| :public:Anonymous6-47:canAccessMapTest.xanalyzer | read,create    | write              | read,write,delete,manage | false,true,false,false | 200        |        | #TC6.47
	| :public:Anonymous6-48:canAccessMapTest           | read,create    | write              | read,write,delete        | false,true,false       | 200        |        | #TC6.48
	| :public:Anonymous6-49:canAccessMapTest.xanalyzer | read,create    | write              | read,write               | false,true             | 200        |        | #TC6.49
	| :public:Anonymous6-50:canAccessMapTest           | read,create    | write              | read                     | false                  | 200        |        | #TC6.50
	| :public:Anonymous6-51:canAccessMapTest.xanalyzer | read,create    | delete             | all                      | false                  | 200        |        | #TC6.51
	| :public:Anonymous6-52:canAccessMapTest           | read,create    | delete             | read,write,delete,manage | false,false,true,false | 200        |        | #TC6.52
	| :public:Anonymous6-53:canAccessMapTest.xanalyzer | read,create    | delete             | read,write,delete        | false,false,true       | 200        |        | #TC6.53
	| :public:Anonymous6-54:canAccessMapTest           | read,create    | delete             | read,write               | false,false            | 200        |        | #TC6.54
	| :public:Anonymous6-55:canAccessMapTest.xanalyzer | read,create    | delete             | read                     | false                  | 200        |        | #TC6.55
	| :public:Anonymous6-56:canAccessMapTest           | read,create    | manage             | all                      | false                  | 200        |        | #TC6.56
	| :public:Anonymous6-57:canAccessMapTest.xanalyzer | read,create    | manage             | read,write,delete,manage | false,false,false,true | 200        |        | #TC6.57
	| :public:Anonymous6-58:canAccessMapTest           | read,create    | manage             | read,write,delete        | false,false,false      | 200        |        | #TC6.58
	| :public:Anonymous6-59:canAccessMapTest.xanalyzer | read,create    | manage             | read,write               | false,false            | 200        |        | #TC6.59
	| :public:Anonymous6-60:canAccessMapTest           | read,create    | manage             | read                     | false                  | 200        |        | #TC6.60
	| :public:Anonymous6-61:canAccessMapTest.xanalyzer | null           | all                | all                      | null                   | 401        |        | #TC6.61
	| :public:Anonymous6-62:canAccessMapTest           | null           | all                | read,write,delete,manage | null                   | 401        |        | #TC6.62
	| :public:Anonymous6-64:canAccessMapTest.xanalyzer | null           | all                | read                     | null                   | 401        |        | #TC6.64	
	| :public:Anonymous6-65:canAccessMapTest           | null           | all                | write                    | null                   | 401        |        | #TC6.65	
	| :public:Anonymous6-66:canAccessMapTest.xanalyzer | null           | all                | delete                   | null                   | 401        |        | #TC6.66	
	| :public:Anonymous6-67:canAccessMapTest           | null           | all                | manage                   | null                   | 401        |        | #TC6.67	
	
Scenario Outline: The user calls the web service to check if they have access to a path, but want the response body in JSON format. #TC7
	Given the path <pathId> exists
	And the user belongs to a role with the read and create permissions
	And the user has read permissions to <pathId>
	When the user calls the web service to check if they have access with all permissions to <pathId>
	Then the status code is 200
	And the response body is in JSON format
Examples:
	| pathId                                              | #notes | #TC7
	| :public:UcanAccessMap7-1:canAccessMapTest.xanalyzer |        | #TC7.1
	| :public:UcanAccessMap7-2:canAccessMapTest           |        | #TC7.2
	
Scenario Outline: The user calls the web service to check if they have access to a path, but want the response body in XML format. #TC8
	Given the path <pathId> exists
	And the user belongs to a role with the read and create permissions
	And the user has read permissions to <pathId>
	When the user calls the web service to check if they have access with all permissions to <pathId>
	Then the status code is 200
	And the response body is in XML format
Examples:
	| pathId                                              | #notes | #TC8
	| :public:UcanAccessMap8-1:canAccessMapTest.xanalyzer |        | #TC8.1
	| :public:UcanAccessMap8-2:canAccessMapTest           |        | #TC8.2
	
Scenario Outline: The user calls the web service to check if they have access to a path, but do not provide the permissions parameter. #TC9
	Given the path <pathId> exists
	And the user belongs to a role with the read and create permissions
	And the user has read permissions to <pathId>
	When the user calls the web service for <pathId>
	But the user does not define the permissions parameter
	Then the status code is 400
Examples:
	| pathId                                              | #notes | #TC9
	| :public:UcanAccessMap9-1:canAccessMapTest.xanalyzer |        | #TC9.1
	| :public:UcanAccessMap9-2:canAccessMapTest           |        | #TC9.2
	
Scenario Outline: The user calls the web service to check if they have access to a path, but specifies an invalid value for the permissions parameter. #TC10
	Given the path <pathId> exists
	And the user belongs to a role with the read and create permissions
	And the user has read permissions to <pathId>
	When the user calls the web service for <pathId> with the invalid value <permissions> for the permissions parameter
	Then the status code is 400
Examples:
	| pathId                                               | permissions | #notes | #TC10
	| :public:UcanAccessMap10-1:canAccessMapTest.xanalyzer | a           |        | #TC10.1
	| :public:UcanAccessMap10-2:canAccessMapTest           | 0|a         |        | #TC10.2
	| :public:UcanAccessMap10-3:canAccessMapTest.xanalyzer | 0,1         |        | #TC10.3
	| :public:UcanAccessMap10-4:canAccessMapTest           | null        |        | #TC10.4
	
Scenario Outline: The user calls the web service to check if they have access to a path with valid special characters in its name. #TC11
	Given the path <pathId> exists
	And the user belongs to a role with the read and create permissions
	And the user has read permissions to <pathId>
	When the user calls the web service to check if they have read access to <pathId>
	Then the status code is 200
	And the response body includes "true" to indicate that the use has read access
Examples:
	| pathId                                                | #notes | #TC11
	| :public:UcanAccessMap11-1:canAccessMap:!.xanalyzer    |        | #TC11.1
	| :public:UcanAccessMap11-2:!                           |        | #TC11.2
	| :public:UcanAccessMap11-3:canAccessMap:@.xanalyzer    |        | #TC11.3
	| :public:UcanAccessMap11-4:@                           |        | #TC11.4
	| :public:UcanAccessMap11-5:canAccessMap:$.xanalyzer    |        | #TC11.5
	| :public:UcanAccessMap11-6:$                           |        | #TC11.6
	| :public:UcanAccessMap11-7:canAccessMap:*.xanalyzer    |        | #TC11.7
	| :public:UcanAccessMap11-8:*                           |        | #TC11.8
	| :public:UcanAccessMap11-9:canAccessMap:(.xanalyzer    |        | #TC11.9
	| :public:UcanAccessMap11-10:(                          |        | #TC11.10
	| :public:UcanAccessMap11-11:canAccessMap:).xanalyzer   |        | #TC11.11
	| :public:UcanAccessMap11-12:)                          |        | #TC11.12
	| :public:UcanAccessMap11-13:canAccessMap:_.xanalyzer   |        | #TC11.13
	| :public:UcanAccessMap11-14:_                          |        | #TC11.14
	| :public:UcanAccessMap11-15:canAccessMap:-.xanalyzer   |        | #TC11.15
	| :public:UcanAccessMap11-16:-                          |        | #TC11.16
	| :public:UcanAccessMap11-17:canAccessMap:=.xanalyzer   |        | #TC11.17
	| :public:UcanAccessMap11-18:=                          |        | #TC11.18
	| :public:UcanAccessMap11-19:canAccessMap:'.xanalyzer   |        | #TC11.19
	| :public:UcanAccessMap11-20:'                          |        | #TC11.20
	| :public:UcanAccessMap11-21:canAccessMap:,.xanalyzer   |        | #TC11.21
	| :public:UcanAccessMap11-22:,                          |        | #TC11.22
	| :public:UcanAccessMap11-23:canAccessMap:~.xanalyzer   |        | #TC11.23
	| :public:UcanAccessMap11-24:~                          |        | #TC11.24
	| :public:UcanAccessMap11-25:canAccessMap:%23.xanalyzer |        | #TC11.25
	| :public:UcanAccessMap11-26:%23                        |        | #TC11.26
	| :public:UcanAccessMap11-27:canAccessMap:%25.xanalyzer |        | #TC11.27
	| :public:UcanAccessMap11-28:%25                        |        | #TC11.28
	| :public:UcanAccessMap11-29:canAccessMap:%5E.xanalyzer |        | #TC11.29
	| :public:UcanAccessMap11-30:%5E                        |        | #TC11.30
	| :public:UcanAccessMap11-31:canAccessMap:%26.xanalyzer |        | #TC11.31
	| :public:UcanAccessMap11-32:%26                        |        | #TC11.32
	| :public:UcanAccessMap11-33:canAccessMap:%2B.xanalyzer |        | #TC11.33
	| :public:UcanAccessMap11-34:%2B                        |        | #TC11.34
	| :public:UcanAccessMap11-35:canAccessMap:%3B.xanalyzer |        | #TC11.35
	| :public:UcanAccessMap11-36:%3B                        |        | #TC11.36
	| :public:UcanAccessMap11-37:canAccessMap:%3A.xanalyzer |        | #TC11.37
	| :public:UcanAccessMap11-38:%3A                        |        | #TC11.38
	| :public:UcanAccessMap11-39:canAccessMap:%22.xanalyzer |        | #TC11.39
	| :public:UcanAccessMap11-40:%22                        |        | #TC11.40
	| :public:UcanAccessMap11-41:canAccessMap:%3F.xanalyzer |        | #TC11.41
	| :public:UcanAccessMap11-42:%3F                        |        | #TC11.42
	| :public:UcanAccessMap11-43:canAccessMap:%3C.xanalyzer |        | #TC11.43
	| :public:UcanAccessMap11-44:%3C                        |        | #TC11.44
	| :public:UcanAccessMap11-45:canAccessMap:%3E.xanalyzer |        | #TC11.45
	| :public:UcanAccessMap11-46:%3E                        |        | #TC11.46
	| :public:UcanAccessMap11-47:canAccessMap:%60.xanalyzer |        | #TC11.47
	| :public:UcanAccessMap11-48:%60                        |        | #TC11.48
	| :public:UcanAccessMap11-49:canAccessMap:%5B.xanalyzer |        | #TC11.49
	| :public:UcanAccessMap11-50:%5B                        |        | #TC11.50
	| :public:UcanAccessMap11-51:canAccessMap:%5D.xanalyzer |        | #TC11.51
	| :public:UcanAccessMap11-52:%5D                        |        | #TC11.52
	| :public:UcanAccessMap11-53:canAccessMap:%7B.xanalyzer |        | #TC11.53
	| :public:UcanAccessMap11-54:%7B                        |        | #TC11.54
	| :public:UcanAccessMap11-55:canAccessMap:%7D.xanalyzer |        | #TC11.55
	| :public:UcanAccessMap11-56:%7D                        |        | #TC11.56
	| :public:UcanAccessMap11-57:canAccessMap:%7C.xanalyzer |        | #TC11.57
	| :public:UcanAccessMap11-58:%7C                        |        | #TC11.58
	| :public:UcanAccessMap11-59:canAccessMap:%21.xanalyzer |        | #TC11.59
	| :public:UcanAccessMap11-60:%21                        |        | #TC11.60
	| :public:UcanAccessMap11-61:canAccessMap:%40.xanalyzer |        | #TC11.61
	| :public:UcanAccessMap11-62:%40                        |        | #TC11.62
	| :public:UcanAccessMap11-63:canAccessMap:%24.xanalyzer |        | #TC11.63
	| :public:UcanAccessMap11-64:%24                        |        | #TC11.64
	| :public:UcanAccessMap11-65:canAccessMap:%2A.xanalyzer |        | #TC11.65
	| :public:UcanAccessMap11-66:%2A                        |        | #TC11.66
	| :public:UcanAccessMap11-67:canAccessMap:%28.xanalyzer |        | #TC11.67
	| :public:UcanAccessMap11-68:%28                        |        | #TC11.68
	| :public:UcanAccessMap11-69:canAccessMap:%29.xanalyzer |        | #TC11.69
	| :public:UcanAccessMap11-70:%29                        |        | #TC11.70
	| :public:UcanAccessMap11-71:canAccessMap:%5F.xanalyzer |        | #TC11.71
	| :public:UcanAccessMap11-72:%5F                        |        | #TC11.72
	| :public:UcanAccessMap11-73:canAccessMap:%2D.xanalyzer |        | #TC11.73
	| :public:UcanAccessMap11-74:%2D                        |        | #TC11.74
	| :public:UcanAccessMap11-75:canAccessMap:%3D.xanalyzer |        | #TC11.75
	| :public:UcanAccessMap11-76:%3D                        |        | #TC11.76
	| :public:UcanAccessMap11-77:canAccessMap:%27.xanalyzer |        | #TC11.77
	| :public:UcanAccessMap11-78:%27                        |        | #TC11.78
	| :public:UcanAccessMap11-79:canAccessMap:%2C.xanalyzer |        | #TC11.79
	| :public:UcanAccessMap11-80:%2C                        |        | #TC11.80
	| :public:UcanAccessMap11-81:canAccessMap:%7E.xanalyzer |        | #TC11.81
	| :public:UcanAccessMap11-82:%7E                        |        | #TC11.82
	| :public:UcanAccessMap11-83:canAccessMap: .xanalyzer   |        | #TC11.83
	| :public:UcanAccessMap11-84:%20                        |        | #TC11.84
	
Scenario Outline: The user calls the web service to check if they have access to a path with invalid special characters in its name. #TC12
	Given the path <pathId> does not exist
	When the user calls the web service to check if they have read access to <pathId>
	Then the status code is 400
Examples:
	| pathId                                               | #notes | #TC12
	| :public:UcanAccessMap12-1:canAccessMap:/.xanalyzer   |        | #TC12.1
	| :public:UcanAccessMap12-2:canAccessMap:%2F.xanalyzer |        | #TC12.2
	| :public:UcanAccessMap12-3:\                          |        | #TC12.3
	| :public:UcanAccessMap12-4:%5C                        |        | #TC12.4
	
Scenario: The user calls the web service to check if they have access to a path that does not exist. #TC13
	Given the path does not exist
	When the user calls the web service to check if they have read access to the path
	Then the status code is 404
	
Scenario Outline: The user calls the web service to check if they have access to a path that has a name within minimal and maximal boundaries. #TC14
	Given the path <pathId> exists
	And the user belongs to a role with the read and create permissions
	And the user has read permissions to <pathId>
	When the user calls the web service to check if they have read access to <pathId>
	Then the status code is 200
	And the response body includes "true" to indicate that the use has read access
Examples:
	| pathId                                                        | #notes | #TC14
	| :public:UcanAccessMap14-1:a.xanalyzer                         |        | #TC14.1
	| :public:UcanAccessMap14-2:a                                   |        | #TC14.2
	| :public:UcanAccessMap14-3:${__RandomString(7000,n)}.xanalyzer |        | #TC14.3
	| :public:UcanAccessMap14-4:${__RandomString(7000,n)}           |        | #TC14.4
	
Scenario Outline: The user calls the web service to check if they have access to a path that has a name that has lowercase and uppercase letters. #TC15
	Given the path <pathId> exists
	And the user belongs to a role with the read and create permissions
	And the user has read permissions to <pathId>
	When the user calls the web service to check if they have read access to <pathId>
	Then the status code is 200
	And the response body includes "true" to indicate that the use has read access
Examples:
	| pathId                                        | #notes | #TC15
	| :public:UcanAccessMap15-1:lowercase.xanalyzer |        | #TC15.1
	| :public:UcanAccessMap15-2:UPPERCASE           |        | #TC15.2
	| :public:UcanAccessMap15-3:CamelCase.xanalyzer |        | #TC15.3