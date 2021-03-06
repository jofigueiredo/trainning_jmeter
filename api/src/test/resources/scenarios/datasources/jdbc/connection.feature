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
Scenario Outline: <User> calls the web service to retrieve a list of JDBC connections in XML format.
	Given <User> has read content permissions
	And <User> has manage data sources permissions
	And JDBC connections exist
	When <User> calls the web service using the Accept header value "application/xml"
	Then the status code is 200
	And the response body contains a list of data sources in XML format
Examples:
	| User |
	| admin |
	| suzy |
	
Scenario: The user calls the web service to retrieve a list of JDBC connections in JSON format
	Given the user has read content permissions
	And the user has manage data sources permissions
	And JDBC connections exist
	When the user calls the web service using the Accept header value "application/json"
	Then the status code is 200
	And the response body contains a list of data sources in JSON format
	
Scenario: The user calls the web service to retrieve a list of JDBC connections, but no JDBC connections exist
	Given the user has read content permissions
	And the user has manage data sources permissions
	And no JDBC connections exist
	When the user calls the web service
	Then the status code is 200
	And the response body does not contain a list of data sources
	
Scenario: The user calls the web service to retrieve a list of JDBC connections, but does not have read content permissions
	Given the user does not have read content permissions
	And the user has manage data sources permissions
	And JDBC connections exist
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain a list of data sources
	
Scenario: The user calls the web service to retrieve a list of JDBC connections, but does not have manage data sources permissions
	Given the user has read content permissions
	And the user does not have manage data sources permissions
	And JDBC connections exist
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain a list of data sources
	
Scenario: The anonymous user calls the web service to retrieve a list of JDBC connections
	Given JDBC connections exist
	When the anonymous user calls the web service
	Then the status code is 401
	And the response body does not contain a list of data sources