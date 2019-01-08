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

# Note: The examples for this scenario have been saved in csv format for better readability within the same directory: jdbcExamples.csv
Scenario Outline: <User> calls the web service to create a new JDBC connection using various parameters.
	Given <User> has read content permissions
	And <User> has manage data sources permissions
	And <User> has create content permissions
	And <User> has publish content permissions
	And the data source does not exist
	When <User> calls the web service with paramaters in the request body in JSON format
	Then the status code is 200
	And the data source is created with the specified parameters and values
	
# Note: jdbcExamples.csv can be reused as examples of what already exists, and modify values as needed for updating.
Scenario Outline: <User> calls the web service to update an existing JDBC connection using various parameters.
	Given <User> has read content permissions
	And <User> has manage data sources permissions
	And <User> has create content permissions
	And <User> has publish content permissions
	And the data source already exists
	When <User> calls the web service with paramaters in the request body in JSON format
	Then the status code is 200
	And the data source is updated with the specified parameters and values
	
# Note: The examples for this scenario have been saved in csv format for better readability within the same directory: jdbcExamples-InvalidValues.csv
Scenario Outline: <User> calls the web service to create a new JDBC connection using various parameters.
	Given <User> has read content permissions
	And <User> has manage data sources permissions
	And <User> has create content permissions
	And <User> has publish content permissions
	And the data source does not exist
	When <User> calls the web service with paramaters in the request body in JSON format
	Then the status code is 400
	And the data source is not created with the specified parameters and values
	
# Note: The examples for this scenario have been saved in csv format for better readability within the same directory: jdbcExamples-InvalidValues.csv
Scenario Outline: <User> calls the web service to update an existing JDBC connection using various parameters.
	Given <User> has read content permissions
	And <User> has manage data sources permissions
	And <User> has create content permissions
	And <User> has publish content permissions
	And the data source already exists
	When <User> calls the web service with paramaters in the request body in JSON format
	Then the status code is 400
	And the data source is not updated with the specified parameters and values

# Note: jdbcExamples.csv can be reused as examples for valid values.	
Scenario: The user calls the web service to create a new JDBC connection, but does not have read permissions
	Given the user does not have read content permissions
	And the user has manage data source permissions
	And the user has create content permissions
	And the user has publish content permissions
	And the data source does not exist
	When the user calls the web service
	Then the status code is 403
	And the data source is not created
	
# Note: jdbcExamples.csv can be reused as examples for valid values.	
Scenario: The user calls the web service to update an existing JDBC connection, but does not have read permissions
	Given the user does not have read content permissions
	And the user has manage data source permissions
	And the user has create content permissions
	And the user has publish content permissions
	And the data source already exists
	When the user calls the web service
	Then the status code is 403
	And the data source is not updated
	
# Note: jdbcExamples.csv can be reused as examples for valid values.	
Scenario: The user calls the web service to create a new JDBC connection, but does not have manage data source permissions
	Given the user has read content permissions
	And the user does not have manage data source permissions
	And the user has create content permissions
	And the user has publish content permissions
	And the data source does not exist
	When the user calls the web service
	Then the status code is 403
	And the data source is not created
	
# Note: jdbcExamples.csv can be reused as examples for valid values.	
Scenario: The user calls the web service to update an existing JDBC connection, but does not have manage data source permissions
	Given the user has read content permissions
	And the user does not have manage data source permissions
	And the user has create content permissions
	And the user has publish content permissions
	And the data source already exists
	When the user calls the web service
	Then the status code is 403
	And the data source is not updated
	
# Note: jdbcExamples.csv can be reused as examples for valid values.	
Scenario: The user calls the web service to create a new JDBC connection, but does not have create content permissions
	Given the user has read content permissions
	And the user has manage data source permissions
	And the user does not have create content permissions
	And the user has publish content permissions
	And the data source does not exist
	When the user calls the web service
	Then the status code is 403
	And the data source is not created
	
# Note: jdbcExamples.csv can be reused as examples for valid values.	
Scenario: The user calls the web service to update an existing JDBC connection, but does not have create content permissions
	Given the user has read content permissions
	And the user has manage data source permissions
	And the user does not have create content permissions
	And the user has publish content permissions
	And the data source already exists
	When the user calls the web service
	Then the status code is 403
	And the data source is not updated
	
# Note: jdbcExamples.csv can be reused as examples for valid values.	
Scenario: The user calls the web service to create a new JDBC connection, but does not have publish content permissions
	Given the user has read content permissions
	And the user has manage data source permissions
	And the user has create content permissions
	And the user does not have publish content permissions
	And the data source does not exist
	When the user calls the web service
	Then the status code is 403
	And the data source is not created
	
# Note: jdbcExamples.csv can be reused as examples for valid values.	
Scenario: The user calls the web service to update an existing JDBC connection, but does not have publish content permissions
	Given the user has read content permissions
	And the user has manage data source permissions
	And the user has create content permissions
	And the user does not have publish content permissions
	And the data source already exists
	When the user calls the web service
	Then the status code is 403
	And the data source is not updated
	
# Note: jdbcExamples.csv can be reused as examples for valid values.	
Scenario: The anonymous user calls the web service to create a new JDBC connection
	Given the data source does not exist
	When the anonymous user calls the web service
	Then the status code is 401
	And the data source is not created
	
# Note: jdbcExamples.csv can be reused as examples for valid values.	
Scenario: The anonymous user calls the web service to update an existing JDBC connection
	Given the data source already exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the data source is not updated
	
# Note: jdbcExamples.csv can be reused as examples for valid parameter values.	
Scenario: The user calls the web service to update an existing JDBC connection using a conditional header.
	Given the user has read content permissions
	And the user has manage data source permissions
	And the user has create content permissions
	And the user has publish content permissions
	And the data source already exists
	And the conditional header's value is set to a value that will fail
	When the user calls the web service
	Then the status code is 304
	And the data source is not updated
Examples:
	| Header | Header Value |
	| If-Modified-Since | Mon, Dec 25 2017 00:00:00 GMT |
	| If-Unmodified-Since | Thu, Jan 1 2015 00:00:00 GMT |