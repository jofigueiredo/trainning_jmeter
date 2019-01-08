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

Feature: Root endpoint ( / )

  This API enpdoint returns a HTML response containing the content of the initial Carte page.

Background:
  Given a Carte slave server is running

@GET
Scenario: An unauthorized user requests the root page of an active Carte server
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  And the Authorization request header has username "testing" and password "fakePass"
  Then the response status code will be 401

@GET
Scenario: An authorized user requests the root page of an active Carte server
  When a HTTP GET request is sent to the root endpoint of the Carte slave server
  Then the response status code will be 200
  And the response responseText will be a HTML page with:
  """
  <HTML>
  <HEAD><TITLE>Kettle slave server</TITLE>
  <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </HEAD>
  <BODY>
  <H2>Slave server menu</H2>
  <p>
  <a href="/kettle/status">Show status</a><br>
  <p>
  </BODY>
  </HTML>
  """
