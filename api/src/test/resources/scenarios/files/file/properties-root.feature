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

#GET Method
Scenario: Admin user user calls the web service to retrieve the properties of the root directory.
	Given The root directory exists
	When Admin user gets the properties of the root directory
	Then the status code is 200
	And the response body contains "<repositoryFileDto>"
	And the response pody contains "<path>/</path>"
	
Scenario: The admin user calls the web service to retrieve the properties of the root directory in JSON format
	Given the "Accept" header is set to "application/json"
	When the admin user gets the properties of the root directory
	Then the status code is 200
	And the response body contains the following:
		"path": "/"
		
Scenario: The Suzy user user calls the web service to retrieve the properties of the root directory.
	Given The root directory exists
	And the Suzy user has read permissions
	When The Suzy user gets the properties of the root directory
	Then the status code is 200
	And the response body contains "<repositoryFileDto>"
	And the response pody contains "<path>/</path>"

Scenario: The anonymous user calls the web service to retrieve the properties of the root directory.
	Given No authentication is used in the request
	When the anonymous user gets the properties of the root directory
	Then the status code is 401
	And the response body does not contain "<path>/</path>"

Scenario: The pat user calls the web service to retrieve the properties of the root directory, but does not have read permissions.
	Given the pat user does not have read permissions.
	When the pat user gets the properties of the root directory
	Then the status code is 403
	And the response body does not contain "<path>/</path>"