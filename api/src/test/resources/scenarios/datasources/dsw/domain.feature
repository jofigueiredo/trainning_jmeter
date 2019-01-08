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
# GET method - Get the DSW datasource IDs - pentaho/plugin/data-access/api/datasource/dsw/domain
# ========================================================================================================
Scenario: Admin user calls web service to get the DSW Datasource IDs in XML format
	Given Admin user has "Manage Datasource" and "Read Content" permission
	When Admin user sends an HTTP GET request to list the Datasource IDs
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains the list of Datasource ID's in XML format

Scenario: Admin user calls web service to get the DSW Datasource IDs in JSON format
	Given Admin user has "Manage Datasource" and "Read Content" permission
	When Admin user sends an HTTP GET request to list the Datasource IDs
	And the Content-Type header is set to "application/json"
	Then the returned status code is 200 OK
	And the response body contains the list of Datasource ID's in JSON format
	
Scenario: Admin user calls web service to get the DSW Datasource IDs but there are no DSW Datasoruce ID's present
	Given there are no DSW Datasource IDs present
	When Admin user sends an HTTP GET request to list the Datasource IDs
	Then the returned status code is 200 OK
	And the response body contains empty list
	
Scenario: Suzy user calls web service to get the DSW Datasource IDs but do not have "Manage Datasource" permission
	Given Suzy has "Read Content" permission but not "Manage Datasource"
	When Suzy sends an HTTP GET request to list the Datasource IDs
	Then the returned status code is 401 Unauthorized
# Note: Getting 200 Ok response even if the user don't have "Manage Datasource" permission. This might be a bug. 

Scenario: Pat user calls web service to get the DSW Datasource IDs but do not have "Read Content" permission
	Given Pat has "Manage Datasoruce" permission but not "Read Content"
	When Pat user sends an HTTP GET request to list the Datasource IDs
	Then the returned status code is 200 OK
	And the response body contains an empty list
	
Scenario: Anonymous user calls web service to get the DSW Datasource IDs 
	Given the anonymous user doesn't provide User ID and password
	When anonymous user sends an HTTP GET request to list the Datasource IDs
	Then the returned status code is 401 Unauthorized

Scenario: Admin user calls web service to get the DSW Datasource IDs that contains valid special characters in XML format
	Given the Datasource ID's exists with following special characters in its name: "!@#$%^&*()_-=+;:'\""?<>,.`~[]{}|.prpti" (No backslash included. That is used as an escape for the double-quotes)
	When Admin user sends an HTTP GET request to list the Datasource IDs
	And the Content-Type header is set to "application/xml"
	Then the returned status code is 200 OK
	And the response body contains the list of Datasource ID's in XML format

Scenario: Admin user calls web service to get the DSW Datasource IDs that contains valid special characters in JSON format
	Given the Datasource ID's exists with following special characters in its name: "!@#$%^&*()_-=+;:'\""?<>,.`~[]{}|.prpti" (No backslash included. That is used as an escape for the double-quotes)
	When Admin user sends an HTTP GET request to list the Datasource IDs
	And the Content-Type header is set to "application/json"
	Then the returned status code is 200 OK
	And the response body contains the list of Datasource ID's in JSON format
	
# ==============================================================================================================================
# GET method - Export the DSW data source for the given DSW ID - pentaho/plugin/data-access/api/datasource/dsw/domain/{dswId }
# ==============================================================================================================================
Scenario: Admin user calls web service to export the DSW Datasource
	Given the DSW Datasoruce exists
	And the given DSW Datasoruce ID exist
	When Admin user sends an HTTP GET request to export the Datasource
	Then the returned status code is 200 OK
	And the response body contains an encrypted .XMI file

Scenario: Admin user calls web service to export the DSW Datasource when the given DSW Datasource doesn't exists
	Given the DSW Datasource "_CSV_negative_69065061.xmi" doesn't exist
	When Admin user sends an HTTP GET request to export the DSW Datasource
	Then the returned status code is 500 Internal Server Error
	And the <title> element in the XML response body contains word "Unavailable"
	
Scenario: Suzy user calls web service to export the DSW Datasource but do not have "Manage Datasource" permission
	Given Suzy has "Read Content" permission but not "Manage Datasource"
	And the given DSW Datasoruce eixsts
	When Suzy sends an HTTP GET request to export the DSW Datasource
	Then the returned status code is 401 Unauthorized
# Note: Getting 200 Ok response even if the user don't have "Manage Datasource" permission. This might be a bug. 
	
Scenario: Pat user calls web service to export the DSW Datasource but do not have "Read Content" permission
	Given Pat has "Manage Datasoruce" permission but not "Read Content"
	When Pat user sends an HTTP GET request to export the Datasource
	Then the returned status code is 401 Unauthorized
	And the response body is empty
	
Scenario: Anonymous user calls web service to export the DSW Datasource 
	Given the anonymous user doesn't provide User ID and password
	When anonymous user sends an HTTP GET request to export the Datasource
	Then the returned status code is 401 Unauthorized

Scenario: Admin user calls web service to export the DSW Datasource that contains valid special characters
	Given the Datasource ID exists with following special characters in its name: "!@#$%^&*()_-=+;:'\""?<>,.`~[]{}|.prpti" (No backslash included. That is used as an escape for the double-quotes)
	When Admin user sends an HTTP GET request to export the Datasource IDs
	Then the returned status code is 200 OK
	And the response body contains an encrypted .XMI file
	
# ==============================================================================================================================
# DELETE method - Remove the DSW data source for a given DSW ID - pentaho/plugin/data-access/api/datasource/dsw/domain/{dswID}
# ==============================================================================================================================
Scenario: Admin calls web service to remove the DSW Datasource
	Given the DSW Datasoruce exist
	When Admin user sends an HTTP DELETE request to remove the Datasource
	Then the returned status code is 200 OK
	And the DSW Datasoruce is removed from the DSW Datasoruce list
	
Scenario: Admin user calls web service to remove the DSW Datasource which doesn't exists
	Given the DSW Datasoruce doesn't exist
	When Admin user sends an HTTP DELETE request to remove the Datasource
	Then the returned status code is 500 Internal Server Error
	And the "title" tag in response shows "Unavailable"
	And the DSW Datasoruce wasn't removed from the list

Scenario: Suzy user (non admin) calls web service to remove the DSW Datasource
	Given the DSW Datasoruce exists
	And Suzy user has "Manage Datasoruce" and "Read Content" permission to remove DSW Datasoruce
	When Suzy user sends an HTTP DELETE request to remove the Datasource
	Then the returned status code is 200 OK
	And the DSW Datasoruce is removed from the list

Scenario: Pat user (non admin) calls web service to remove the DSW Datasource, but do not have "Read Content" permission
	Given Pat user has "Manage Datasoruce" permission but do not have "Read Content" permission 
	And the DSW Datasoruce exists
	When Suzy user sends an HTTP DELETE request to remove the Datasource
	Then the returned status code is 500 Internal Server Error
	And the "title" tag in response shows "Unavailable"
	And the DSW Datasoruce wasn't removed from the list
# Note: Not sure if the above case should return 401 Unauthorized or 500 Internal Server Error. Postman test results shows 500 code for the above test.

Scenario: Pat user (non admin) calls web service to remove the DSW Datasource, but do not have "Manage Datasoruce" permission
	Given Pat user has "Read Content" permission but do not have "Manage Datasource" permission 
	And the DSW Datasoruce exists
	When Suzy user sends an HTTP DELETE request to remove the Datasource
	Then the returned status code is 401 Unauthorized
	And the DSW Datasoruce wasn't removed from the list
# Note: Expected response code is 401 Unauthorized. But Postman test returned 200 code and the DSW Datasoruce was removed. This might be a product bug.

Scenario: Anonymous user calls web service to remove the DSW Datasource 
	Given the Anonymous user do not provide User ID and Password 
	And the DSW Datasoruce exists
	When Anonymous user sends an HTTP DELETE request to remove the Datasource
	Then the returned status code is 401 Unauthorized
	And the DSW Datasoruce wasn't removed from the list

Scenario: Admin user calls web service to remove the DSW Datasource which contain valid special characters in its name
	Given the DSW Datasoruce exists with valid special characters "!@#$%^&*()_-=+;:'\"?"<>,.`~[]{}|" in its name
	When Admin user sends an HTTP DELETE request to remove the Datasource
	Then the returned status code is 200 OK
	And the DSW Datasoruce is removed from the DSW Datasoruce list