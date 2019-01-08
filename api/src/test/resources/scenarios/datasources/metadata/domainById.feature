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

Scenario Outline: <User> calls the web service to retrieve the contents of the metadata data source <domainId>.
	Given <User> has the Administer Security permission
	And the metadata data source <domainId> exists
	When <User> calls the web service
	Then the status code is 200
	And the response body contains the contents of the metadata data source's XMI file.
Examples:
	| User | domainId |
	| admin | steel-wheels.xmi |
	| admin | MyDataSource.xmi |
	| manager | steel-wheels.xmi |
	| manager | MyDataSource.xmi |
	| admin | !@#$%^&*()_-=+;:'"?<>,.`~[]{}|.xmi |
	
Scenario: The user calls the web service to retrieve the contents of the metadata data source's XMI file, but the user is not an administrator
	Given the user is not an administrator
	And the metadata data source exists
	When the user calls the web service
	Then the status code is 403
	And the response body does not contain the contents of the metadata data source's XMI file.
	
Scenario: The user calls the web service to retrieve the contents of the metadata data source's XMI file, but a data source with the specified ID does not exist.
	Given the user is an administrator
	And the metadata data source does not exist.
	When the user calls the web service
	Then the status code is 404
	And the response body does not contain the contents of the metadata data source's XMI file.
	
Scenario: The anonymous user calls the web service to retrieve the contents of the metadata data source's XMI file.
	Given the metadata data source exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the response body does not contain the contents of the metadata data source's XMI file.
	
# PUT Method
Scenario Outline: <User> calls the web service to import the metadata data source <domainId> using the file <metadataFile> with overwrite set to false.
	Given <User> has the Read Content permission
	And <User> has the Publish Content permission
	And <User> has the Create Content permission
	And <Usre> has the Manage Data Sources permission
	And the metadata data source <domainId> does not exist.
	When <User> calls the web service with the overwrite parameter value set to false
	Then the status code is 201
	And the metadata data source <domainId> has been created
Examples:
	| User | domainId | metadataFile |
	| admin | TestXMI.xmi | TestXMI.xmi |
	| suzy | !@#$%^&*()_-=+;:'"?<>,.`~[]{}|.xmi | myDataSource.xmi |
	| admin | TestDataSource | !@#$%^&_-=+;',.`~[]{}.xmi |
	
Scenario Outline: <User> calls the web service to import the metadata data source <domainId> using the file <metadataFile> with overwrite set to true.
	Given <User> has the Read Content permission
	And <User> has the Publish Content permission
	And <User> has the Create Content permission
	And <Usre> has the Manage Data Sources permission
	And the metadata data source <domainId> already exists
	When <User> calls the web service with the overwrite parameter value set to true
	Then the status code is 201
	And the metadata data source <domainId> has been overwritten
Examples:
	| User | domainId | metadataFile |
	| admin | TestXMI.xmi | myDataSource.xmi |
	| suzy | !@#$%^&*()_-=+;:'"?<>,.`~[]{}|.xmi | !@#$%^&_-=+;',.`~[]{}.xmi |
	| admin | TestDataSource | TestXMI.xmi |
	
Scenario: The user calls the web service to import a metadata data source using the localeFiles parameter.
	Given the user has the Read Content permission
	And the user has the Publish Content permission
	And the user has the Create Content permission
	And the user has the Manage Data Sources permission
	And the data source does not exist 
	And the file used for the localeFiles parameter is valid
	When the user calls the web service using the localeFiles parameter
	Then the status code is 201
	And the metadata data source contents are translated
Examples:
	| User | domainId | metadataFile | localeFiles |
	| admin | SteelWheelsTest.xmi | SteelWheelsTest.xmi | SteelWheelsTest_de.properties |
	| suzy | !@#$%^&*()_-=+;:'"?<>,.`~[]{}|.xmi | myFile.xmi | !@#$%^&_-=+;',.`~[]{}_fr.properties |
	
Scenario: The user calls the web service to import a metadata data source and uses an invalid value for the domainId parameter.
	Given the user has the Read Content permission
	And the user has the Publish Content permission
	And the user has the Create Content permission
	And the user has the Manage Data Sources permission
	When the user calls the web service
	Then the status code is 400
	And the metadata data source is not created
Examples:
	| domainId |
	| /.xmi |
	| \.xmi |
	
Scenario: The user calls the web service to import a metadata data source, but does not have Read Content permission.
	Given the user does not have the Read Content permission
	And the user has the Publish Content permission
	And the user has the Create Content permission
	And the user has the Manage Data Sources permission
	When the user calls the web service
	Then the status code is 403
	And the metadata data source is not created
	
Scenario: The user calls the web service to import a metadata data source, but does not have Publish Content permission.
	Given the user has the Read Content permission
	And the user does not have the Publish Content permission
	And the user has the Create Content permission
	And the user has the Manage Data Sources permission
	When the user calls the web service
	Then the status code is 403
	And the metadata data source is not created
	
Scenario: The user calls the web service to import a metadata data source, but does not have Create Content permission.
	Given the user has the Read Content permission
	And the user has the Publish Content permission
	And the user does not have the Create Content permission
	And the user has the Manage Data Sources permission
	When the user calls the web service
	Then the status code is 403
	And the metadata data source is not created
	
Scenario: The user calls the web service to import a metadata data source, but does not have Manage Data Sources permission.
	Given the user has the Read Content permission
	And the user has the Publish Content permission
	And the user has the Create Content permission
	And the user does not have the Manage Data Sources permission
	When the user calls the web service
	Then the status code is 403
	And the metadata data source is not created
	
Scenario: The anonymous user calls the web service to import a metadata data source
	Given the data source does not exist
	When the user calls the web service with the overwrite parameter value set to false
	Then the status code is 401
	And the metadata data source is not created
	
Scenario: The user calls the web service to import a metadata data source, but the specified domainId already exists and the value of the overwrite parameter is set to false
	Given the user has the Read Content permission
	And the user has the Publish Content permission
	And the user has the Create Content permission
	And the user has the Manage Data Sources permission
	And a data source with the specified domainId already exists
	When the user calls the web service with the value of the overwrite parameter set to false
	Then the status code is 409
	And response body contains "A Pentaho Metadata Domain already exists with the specified Domain ID"
	And the metadata data source was not overwritten
	
Scenario: The user calls the web service to import a metadata data source, but the XMI file contains invalid syntax.
	Given the user has the Read Content permission
	And the user has the Publish Content permission
	And the user has the Create Content permission
	And the user has the the Manage Data Sources permission
	And a data source with the specified domainId does not exist
	And the specified file for the metadataFile parameter contains malformed syntax
	When the user calls the web service
	Then the status code is 412
	And the response body contains an error message indicating a syntax error.
	
# DELETE Method

Scenario Outline: <User> calls the web service to delete the metadata data source <domainId>.
	Given <User> has the Read Content permission
	And <User> has the Publish Content permission
	And <User> has the Create Content permission
	And <User> has the Manage Data Sources permission
	And the metadata data source <domainId> already exists
Examples:
	| User | domainId |
	| admin | TestXMI.xmi |
	| suzy | !@#$%^&*()_-=+;:'"?<>,.`~[]{}|.xmi |
	
Scenario: The user calls the web service to delete the metadata data source, but does not of the Read Content permission.
	Given the user does not have the Read Content permission
	And the user has the Publish Content permission
	And the user has the Create Content permission
	And the user has the the Manage Data Sources permission
	And the metadata data source exists
	When the user calls the web service
	Then the status code is 403
	And the metadata data source is not deleted
	
Scenario: The user calls the web service to delete the metadata data source, but does not of the Publish Content permission.
	Given the user has the Read Content permission
	And the user does not have the Publish Content permission
	And the user has the Create Content permission
	And the user has the the Manage Data Sources permission
	And the metadata data source exists
	When the user calls the web service
	Then the status code is 403
	And the metadata data source is not deleted
	
Scenario: The user calls the web service to delete the metadata data source, but does not of the Create Content permission.
	Given the user has the Read Content permission
	And the user has the Publish Content permission
	And the user does not have the Create Content permission
	And the user has the the Manage Data Sources permission
	And the metadata data source exists
	When the user calls the web service
	Then the status code is 403
	And the metadata data source is not deleted
	
Scenario: The user calls the web service to delete the metadata data source, but does not of the Manage Data Sources permission.
	Given the user has the Read Content permission
	And the user has the Publish Content permission
	And the user has the Create Content permission
	And the user does not have the the Manage Data Sources permission
	And the metadata data source exists
	When the user calls the web service
	Then the status code is 403
	And the metadata data source is not deleted
	
Scenario: The anonymous user calls the web service to delete the metadata data source.
	Given the metadata data source exists
	When the anonymous user calls the web service
	Then the status code is 401
	And the metadata data source is not deleted
	
Scenario: The user calls the web service to delete a metdata data source that does not exist.
	Given the user has the Read Content permission
	And the user has the Publish Content permission
	And the user has the Create Content permission
	And the user has the the Manage Data Sources permission
	And the metadata data source does not exist
	When the user calls the web service
	Then the status code is 404