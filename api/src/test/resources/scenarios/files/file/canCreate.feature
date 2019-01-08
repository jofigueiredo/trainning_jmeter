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
Scenario Outline: Created user calls the web service to check if they can create content in the repository. #TC1
	Given created user with assigned role that have Operation Permissions <rolePermissions>
	When is called the web service canCreate
	Then the status code is 200
	And the response body contains <responseBody>
Examples:
	| rolePermissions                                                            | responseBody | #notes                                         | #TC1
	| administerSecurity                                                         | false        | Single Operation Permission administerSecurity | #TC1.1
	| scheduler                                                                  | false        | Single Operation Permission scheduler          | #TC1.2
	| read                                                                       | false        | Single Operation Permission read               | #TC1.3
	| publish                                                                    | false        | Single Operation Permission publish            | #TC1.4
	| create                                                                     | true         | Single Operation Permission create             | #TC1.5
	| execute                                                                    | false        | Single Operation Permission execute            | #TC1.6
	| manageDataSources                                                          | false        | Single Operation Permission manageDataSources  | #TC1.7
	| administerSecurity,scheduler,read,publish,create,execute,manageDataSources | true         | Role Administrator (All permissions)           | #TC1.8
	| scheduler,read,publish,create,execute                                      | true         | Role Power User                                | #TC1.9
	| scheduler,publish                                                          | false        | Role Report User                               | #TC1.10
	| read,create                                                                | true         | Role Permissions combinantion                  | #TC1.11
	| "empty/null"                                                               | false        | No Operation Permission assigned to Role       | #TC1.12

Scenario: Created user with no role assigned calls the web service to check if they can create content in the repository. #TC2
	Given created user with no assigned role
	When is called the web service canCreate
	Then the status code is 200
	And the response body equals "false"

Scenario Outline: Invalid user calls the web service to check if they can create content in the repository. #TC3
	Given a invalid <user>
	When is called the web service canCreate
	Then the status code is 401
	And the response body does not contain "true"
	And the response body does not contain "false"
Examples:
	| user                                       | #TC3
	| "null/empty"                               | #TC3.1
	| "any name that don't belong users created" | #TC3.2
