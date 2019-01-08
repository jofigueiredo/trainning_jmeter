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

# ========================================================================================================
# PUT method - pentaho/plugin/data-access/api/datasource/analysis/catalog/SampleSchema
# ========================================================================================================
Scenario Outline: <User> calls web service to import Analysis Schema with all valid mandatory parameters
	Given the user has "Manage Datasource", "Create Content" and "Publish Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created

Scenario: An authorized user (Admin) calls web service to import Analysis Schema with all valid parameters and content already exists (using overwrite flag as "true" to force the import)
	Given the user has "Manage Datasource", "Create Content" and "Publish Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is "true"
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created

Scenario: An authorized user (Admin) calls web service to import Analysis Schema with all valid parameters and the analysis schema already exists
	Given the user has "Manage Datasource", "Create Content" and "Publish Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 409 Conflict
	And an error message "MondrianCatalogHelper.ERROR_0004 - already exists"

Scenario: An authorized user (Admin) calls web service to import Analysis Schema using corrupted Mondrian XML file and the analysis schema doesn’t exists
	Given the user has "Manage Datasource", "Create Content" and "Publish Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 412 Precondition Failed
	And the XML schema content with an error message "Mondrian Error: Internal error: MondrianCatalogHelper.ERROR_0009 - while parsing catalog"

Scenario: An unauthorized user (Suzy) calls web service to import Analysis Schema with valid parameters and the analysis schema doesn’t exists
	Given the user has "Manage Datasource", "Create Content" permissions but not "Publish Content"
	And a valid analysis schema file exists 
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is “false
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 403 Forbidden
	And the error message is "Access Denied"

Scenario: An unauthorized user (Suzy) calls web service to import Analysis Schema with valid parameters and the analysis schema doesn’t exists
	Given the user has "Manage Datasource", "Publish Content" permissions but not "Create Content"
	And a valid analysis schema file exists 
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is “false
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 403 Forbidden
	And the error message is "Access Denied"

Scenario: An unauthorized user (Suzy) calls web service to import Analysis Schema with valid parameters and the analysis schema doesn’t exists
	Given the user has "Publish Content", "Create Content" permissions but not "Manage Datasource"
	And a valid analysis schema file exists
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is “false
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 403 Forbidden 
	And the error message is "Access Denied"
	Note: This scenario using Postman, test returned 201 Created and able to see dataset created

Scenario: An unauthorized user (Suzy) calls web service to import Analysis Schema with invalid credentials (invalid username/password)
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is “false
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 401 Unauthorized
	And the XML body with an error message "HTTP Status 401 - Bad credentials"

Scenario: An authorized user calls (Admin) web service to import Analysis Schema with all valid parameters and xmlaEnabledFlag is "true" and the analysis schema doesn’t exist
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is "true"
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created

Scenario: An authorized user calls (Admin) web service to import Analysis Schema with all valid parameters and xmlaEnabledFlag is "true" and the analysis schema already exist
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is "true"
	And "xmlaEnabledFlag" is "true"
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created

Scenario: An authorized user calls (Admin) web service to import Analysis Schema with all valid parameters and xmlaEnabledFlag is "" (blank value) or "#$#Fss2432" and the analysis schema doesn’t exist
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is "true"
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created
	Note: The "parameters" section of imported analysis schema is updated with "EnableXmla" value is "false" as default

Scenario: An authorized user (Admin) calls web service to import Analysis Schema with all valid parameters and xmlaEnabledFlag is "" or "#$#Fss2432" and the analysis schema already exist
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is "true"
	And "xmlaEnabledFlag" is "true"
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created
	Note: The "parameters" section of imported analysis schema is updated with "EnableXmla" value is "false" as default

Scenario: An authorized user (Admin) calls web service to import Analysis Schema using parameter "Datasource=" (a blank value) and the analysis schema doesn’t exist
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource="
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created
	Note: The "parameters" section of imported analysis schema is updated with new parameter called "datasourceName" and value is "null"

Scenario: An authorized user (Admin) calls web service to import Analysis Schema using parameter Datasource="$%@%EGTRG!#@@#%#%^&&%#__+()(_+(*)~~`|}{}{}][\?>,./?21354" and the analysis schema doesn’t exist
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is "false"
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=$%@%EGTRG!#@@#%#%^&&%#__+()(_+(*)~~`|}{}{}][\?>,./?21354"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created
	Note: The "parameters" section of imported analysis schema is updated with parameter called “Datasource” and the value is "$%@%EGTRG!#@@#%#%^&&%#__+()(_+(*)~~`|}{}{}][\?>,./?21354"

Scenario: An authorized user (Admin) calls web service to import Analysis Schema with invalid value for "overwrite" flag and content already exists 
	Given the user has "Manage Datasource", "Create Content" and "Publish Content" permissions
	And a valid analysis schema file exists 
	And the "overwrite" value is " " or "#$#FDss" (invalid value)
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 409 Conflict
	And an error message "MondrianCatalogHelper.ERROR_0004 - already exists"

Scenario: An authorized user (Admin) calls web service to import Analysis Schema without providing all mandatory parameters – without "overwrite" parameter 
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists 
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 500 Internal Server Error

Scenario: An authorized user (Admin) calls web service to import Analysis Schema using valid "origCatalogName" and the analysis schema doesn’t exist 
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists (SampleData.mondrian.xml)
	And "overwrite" is false
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	And "origCatalogName" is "SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created

Scenario: An authorized user (Admin) calls web service to import Analysis Schema using valid "origCatalogName" name and the analysis schema already exist 
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists (SampleData.mondrian.xml)
	And "overwrite" is true
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	And "origCatalogName" is "SampleData"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created

Scenario: An authorized user (Admin) calls web service to import Analysis Schema using invalid "origCatalogName" name and the analysis schema already exist 
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists (SampleData.mondrian.xml)
	And "overwrite" is true
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	And "origCatalogName" is "Sample" (doesn’t match the schema name provided in the SampleData.mondrian.xml file)
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 500 Internal Server Error
	And an error message "MondrianCatalogHelper.ERROR_0015 - Catalog Sample not found"

Scenario: An authorized user (Admin) calls web service to import Analysis Schema by passing "origCatalogName" to replace an existing catalog and the analysis schema already exist 
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists (SampleData.mondrian.xml)
	And "overwrite" is true
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	And "SteelWheels" analysis schema already exists
	And “origCatalogName” is "SteelWheels" (by passing this parameter, the test will replace existing analysis schema "SteelWheels" with "SampleData")
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created

Scenario: An authorized user (Admin) calls web service to import Analysis Schema by passing "origCatalogName" to replace an existing catalog and the analysis schema doesn’t exist 
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists (SampleData.mondrian.xml)
	And "overwrite" is false
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	And "SteelWheels" analysis schema already exists
	And "origCatalogName" is "SteelWheels" (by passing this parameter, the test will replace existing analysis schema "SteelWheels" with "SampleData")
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created

Scenario: An authorized user (Admin) calls web service to import Analysis Schema using optional parameter "schemaFileInfo" and the analysis schema doesn’t exist 
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists (SampleData.mondrian.xml)
	And "overwrite" is false
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	And "schemaFileInfo" is "SampleTest" 
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created

Scenario: An authorized user (Admin) calls web service to import Analysis Schema using otional parameter “schemaFileInfo” and the analysis schema already exist 
	Given the user has "Manage Datasource", "Publish Content" and "Create Content" permissions
	And a valid analysis schema file exists (SampleData.mondrian.xml)
	And "overwrite" is true
	And "xmlaEnabledFlag" is false
	And "parameters" is "Datasource=SampleData"
	And "schemaFileInfo" is "SampleTest"
	When the user sends an HTTP PUT request to import the analysis schema
	Then the returned status code is 201 Created

# GET Method
Scenario: An authorized user attempts to download the analysis files for a given analysis id
	Given The desired analysis data source exists
	And The user has the required permissions
	When The user sends an HTTP GET to /pentaho/plugin/data-access/api/datasource/analysis/catalog/{catalogId}
	Then The returned status code is 200
	And The analysis data source data is returned
Examples:
	| catalogId						|
	| SampleData						|
	| SteelWheels					|
	| pentaho_operations_mart			|
	| !@#$%^&*()_-=+;:'"?<>,.`~[]{}||	|

Scenario: An unauthorized user attempts to download the analysis files for a given analysis id
	Given The desired analysis data source exists
	And The user does not have the required permissions
	When The user sends an HTTP GET to /pentaho/plugin/data-access/api/datasource/analysis/catalog/{catalogId}
	Then The returned status code is 401
	And The analysis data source data is not returned

Scenario: An authorized user attempts to download the analysis files for a data source that does not exist
	Given The desired analysis data source does not exist
	And The user has the required permissions
	When The user sends an HTTP GET to /pentaho/plugin/data-access/api/datasource/analysis/catalog/{catalogId}
	Then The returned status code is 404

Scenario: An unauthorized user attempts to download the analysis files for a data source that does not exist
	Given The desired analysis data source does not exist
	And The user does not have the required permissions
	When The user sends an HTTP GET to /pentaho/plugin/data-access/api/datasource/analysis/catalog/{catalogId}
	Then The returned status code is 401

# Delete Method
Scenario: An authorized user attempts to remove the analysis data for a given analysis ID
	Given The desired analysis data source exists
	And The user has the required permissions
	When The user sends an HTTP DELETE to /pentaho/plugin/data-access/api/datasource/analysis/catalog/{catalogId}
	Then The returned status code is 200
	And The analysis data source is deleted
Examples:
	| catalogId						|
	| csvDatasource1					|
	| dbtablesDatasource				|
	| sqlDatasource					|
	| !@#$%^&*()_-=+;:'"?<>,.`~[]{}||	|

Scenario: An unauthorized user attempts to remove the analysis data for a given analysis ID
	Given The desired analysis data source exists
	And The user does not have the required permissions
	When The user sends an HTTP DELETE to /pentaho/plugin/data-access/api/datasource/analysis/catalog/{catalogId}
	Then The returned status code is 401
	And The analysis data source is not deleted

Scenario: An authorized user attempts to remove the analysis data for a data source that does not exist
	Given The desired analysis data source does not exist
	And The user has the required permissions
	When The user sends an HTTP DELETE to /pentaho/plugin/data-access/api/datasource/analysis/catalog/{catalogId}
	Then The returned status code is 404

Scenario: An unauthorized user attempts to remove the analysis data for a data source that does not exist
	Given The desired analysis data source does not exist
	And The user does not have the required permissions
	When The user sends an HTTP DELETE to /pentaho/plugin/data-access/api/datasource/analysis/catalog/{catalogId}
	Then The returned status code is 401