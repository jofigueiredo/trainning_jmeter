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

# DELETE Method
Scenario Outline: <User> calls the web service to delete the JDBC connection <Connection>.
	Given <User> has read content permissions
	And <User> has manage data sources permissions
	And <User> has create content permissions
	And <Connection> exists
	When <User> calls the web service
	Then the status code is 200
	And <Connection> no longer exists
Examples:
	| admin | MyConnection10 |
	| suzy | SuzyConnection |
	| admin | !@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
	
Scenario: The user calls the web service to delete a JDBC connection, but does not have read permissions.
	Given the user does not have read content permissions
	And the user has manage data sources permissions
	And the user has create content permissions
	And the connection exists
	When the user calls the web service
	Then the status code is 403
	And the data source still exists
	
Scenario: The user calls the web service to delete a JDBC connection, but does not have manage data sources permissions.
	Given the user has read content permissions
	And the user does not have manage data sources permissions
	And the user has create content permissions
	And the connection exists
	When the user calls the web service
	Then the status code is 403
	And the data source still exists
	
Scenario: The user calls the web service to delete a JDBC connection, but does not have create content permissions.
	Given the user has read content permissions
	And the user has manage data sources permissions
	And the user does not have create content permissions
	And the connection exists
	When the user calls the web service
	Then the status code is 403
	And the data source still exists
	
Scenario: The user calls the web service to delete a JDBC connection, but the specified connection does not exist.
	Given The user has read content permissions
	And the user has modify data sources permissions
	And the user has create content permissions
	And the connection does not exist
	When the user calls the web service
	Then the status code is 404
	
Scenario: The anonymous user calls the web service to delete a JDBC connection.
	Given the connection exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the data source still exists
	
# GET Method
Scenario Outline: <User> calls the web service to retrieve the JDBC connection information in XML format for <Connection>.
	Given <User> has read content permissions
	And <User> has manage data sources permissions
	And <Connection> exists
	When <User> calls the web service with the Accept header value "application/xml"
	Then the status code is 200
	And the response body contains the connection information in XML format
Examples:
	| admin | MyConnection10 |
	| suzy | SuzyConnection |
	| admin | !@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
	
Scenario Outline: <User> calls the web service to retrieve the JDBC connection information in JSON format for <Connection>.
	Given <User> has read content permissions
	And <User> has manage data sources permissions
	And <Connection> exists
	When <User> calls the web service with the Accept header value "application/json"
	Then the status code is 200
	And the response body contains the connection information in JSON format
Examples:
	| admin | MyConnection10 |
	| suzy | SuzyConnection |
	| admin | !@#$%^&*()_-=+;:'"?<>,.`~[]{}| |
	
Scenario: The user calls the web service to retrieve the JDBC connection information, but does not have read permissions
	Given the user does not have read content permissions
	And the user has manage data sources permissoins
	And the connection exists
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain the connection information
	
Scenario: The user calls the web service to retrieve the JDBC connection information, but does not have manage data sources permissions
	Given the user has read content permissions
	And the user does not have manage data sources permissoins
	And the connection exists
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain the connection information
	
Scenario: The user calls the web service to retrieve the JDBC connection information, but no connection exists with the specified name
	Given the user has read content permissions
	And the user has manage data sources permissoins
	And the connection does not exist
	When the user calls the web service
	Then the status code is 404
	And the response body does not contain any connection information
	
Scenario: The anonymous user calls the web service to retrieve the JDBC connection information
	Given the connection exists
	When the user calls the web service
	Then the status code is 401
	And the response body does not contain the connection information