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

Scenario: An authorized user gets a list of analysis data source ids with XML format
	Given The existence of at least one analysis data source
	And The user has the required permissions
	When The user sends an HTTP GET to /pentaho/plugin/data-access/api/datasource/analysis/catalog using the header "Accept: application/xml"
	Then The returned status code is 200
	And A list of analysis data sources is returned

Scenario: An authorized user gets a list of analysis data source ids with JSON format
	Given The existence of at least one analysis data source
	And The user has the required permissions
	When The user sends an HTTP GET to /pentaho/plugin/data-access/api/datasource/analysis/catalog using the header "Accept: application/json"
	Then The returned status code is 200
	And A list of analysis data sources is returned

Scenario: An unauthorized user gets a list of analysis data source ids
	Given The existence of at least one analysis data source
	And The user does not have the required permissions
	When The user sends an HTTP GET to /pentaho/plugin/data-access/api/datasource/analysis/catalog
	Then The returned status code is 403

Scenario: Anonymous user gets a list of analysis data source ids
	Given The existence of at least one analysis data source
	When The anonymous user sends an HTTP GET to /pentaho/plugin/data-access/api/datasource/analysis/catalog
	Then The returned status code is 401