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
Scenario Outline: A user calls the web service to retrieve a list of reserved characters. #TC1
	When <user> calls the web service
	And the user is assigned to <role>
	And the role has the permissions <rolePermission>
	Then the status code is 200
	And the response body contains "/"
	And the response body contains "\\" (single backslash)
Examples: 
	| user                | role                 | rolePermission                                                            | #notes                          | #TC1
	| reservedUsrAll      | Administrator        | administerSecurity, scheduler, read, publish, create, execute, datasource | Default Role Administrator      | #TC1.1
	| reservedUsrNonAdmin | reservedRoleNonAdmin | scheduler, read, publish, create, execute                                 | All permissions except admin    | #TC1.2
	| reservedUsrPublish  | reservedRolePublish  | publish                                                                   |                                 | #TC1.3
	| reservedUsrSecurity | reservedRoleSecurity | administerSecurity                                                        |                                 | #TC1.4
	| reservedUsrSchedule | reservedRoleSchedule | scheduler                                                                 |                                 | #TC1.5
	| reservedUsrRead     | reservedRoleRead     | read                                                                      |                                 | #TC1.6
	| reservedUsrCreate   | reservedRoleCreate   | create                                                                    |                                 | #TC1.7
	| reservedUsrexecute  | reservedRoleexecute  | execute                                                                   |                                 | #TC1.8
	| reservedUsrManage   | reservedRoleManage   | datasource                                                                |                                 | #TC1.9
	| reservedUsrNone     | reservedRoleNone     | "empty/null"                                                              | No permissions assigned on role | #TC1.10
	
Scenario: The anonymous user calls the web service to retrieve a list of reserved characters. #TC2
	When the anonymous user calls the web service
	Then the status code is 401
	And the response body does not contain "/"
	And the response body does not contain "\\" (single backslash)