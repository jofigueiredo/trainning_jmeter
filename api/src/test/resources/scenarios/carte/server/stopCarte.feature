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

Feature: /kettle/stopCarte

  This API call returns a HTML response containing the status of the Carte server.

@GET
Scenario: An unauthorized user requests the endpoint of a previously running Carte server
  Given a Carte server has just been stopped
  When a HTTP GET request is sent to "/kettle/stopCarte"
  And the Authorization request header has username "testing" and password "fakePass"
  Then the response will fail with "net::ERR_EMPTY_RESPONSE"

@GET
Scenario: An authorized user requests the endpoint of a previously running Carte server
  Given a Carte server has just been stopped
  When a HTTP GET request is sent to "/kettle/stopCarte"
  And the Authorization request header has username "cluster" and password "cluster"
  Then the response will fail with "net::ERR_EMPTY_RESPONSE"

@GET
Scenario: An unauthorized user requests an available Carte server to stop
  Given a Carte server is running
  When a HTTP GET request is sent to "/kettle/stopCarte"
  And the Authorization request header has username "testing" and password "fakePass"
  Then the response status code will be 401

@GET
Scenario: An authorized user requests an available Carte server to stop
  Given a Carte server is running
  When a HTTP GET request is sent to "/kettle/stopCarte"
  And the Authorization request header has username "cluster" and password "cluster"
  Then the response status code will be 200
  And the response "responseText" on load end will be a HTML document with:
  """
  <HTML>
  <HEAD><TITLE>Shutdown of Carte requested</TITLE></HEAD>
  <BODY>
  <H1>Status</H1>
  <p>
  Shutting Down
  </p>
  </BODY>
  </HTML>
  """
