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

Feature: /kettle/status

  This API call returns a response containing information about the server itself (OS, memory, etc) and information about jobs and transformations present on the server.

Background:
  Given a Carte server is running with the default configurations

@GET
Scenario: An unauthorized user requests the Carte server's status information without specifying a format.
  When a HTTP GET request is sent to "/kettle/status"
  And the Authorization request header has username "testing" and password "fakePass"
  Then the response status code will be 401

@GET
Scenario: An authorized user requests the Carte server's status information without specifying a format.
  When a HTTP GET request is sent to "/kettle/status"
  And the Authorization request header has username "cluster" and password "cluster"
  Then the response status code will be 200
  And the response "responseText" will be a HTML page with:
  """
  <HTML>
  <HEAD><TITLE>Kettle slave server status</TITLE>
  <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </HEAD>
  <BODY>
  <H1>PDI Status</H1>
  <table border="1">
  <tr> <th>Transformation name</th> <th>Carte Object ID</th> <th>Status</th> <th>Last log date</th> <th>Remove from list</th> </tr></table><p><table border="1">
  <tr> <th>Job name</th> <th>Carte Object ID</th> <th>Status</th> <th>Last log date</th> <th>Remove from list</th> </tr></table><p>
  <H1>Configuration details:</H1><p>
  <table border="1">
  <tr> <th>Parameter</th> <th>Value</th> </tr><tr> <td>The maximum size of the central log buffer </td> <td>No limit</td> </tr><tr> <td>The maximum age of a log line</td> <td>No limit</td> </tr><tr> <td>The maximum age of a stale object</td> <td>No limit</td> </tr><tr> <td>Repository name</td> <td></td> </tr></table><i>These parameters can be set in the slave server configuration XML file: (Using defaults)</i><br>
  </BODY>
  </HTML>
  """

@GET
Scenario: An unauthorized user requests the Carte server's status information in another format using a GET request.
  When a HTTP GET request is sent to "/kettle/status/?json=Y"
  And the Authorization request header has username "testing" and password "fakePass"
  Then the response status code will be 401

@GET
# The scenario below still returns a success code and html content even though the type is unsupported. Appears to be as designed.
Scenario: An authorized user requests the Carte server's status information in another format using a GET request.
  When a HTTP GET request is sent to "/kettle/status/?json=Y"
  And the Authorization request header has username "cluster" and password "cluster"
  Then the response status code will be 200
  And the response "responseText" will be a HTML page with:
  """
  <HTML>
  <HEAD><TITLE>Kettle slave server status</TITLE>
  <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </HEAD>
  <BODY>
  <H1>PDI Status</H1>
  <table border="1">
  <tr> <th>Transformation name</th> <th>Carte Object ID</th> <th>Status</th> <th>Last log date</th> <th>Remove from list</th> </tr></table><p><table border="1">
  <tr> <th>Job name</th> <th>Carte Object ID</th> <th>Status</th> <th>Last log date</th> <th>Remove from list</th> </tr></table><p>
  <H1>Configuration details:</H1><p>
  <table border="1">
  <tr> <th>Parameter</th> <th>Value</th> </tr><tr> <td>The maximum size of the central log buffer </td> <td>No limit</td> </tr><tr> <td>The maximum age of a log line</td> <td>No limit</td> </tr><tr> <td>The maximum age of a stale object</td> <td>No limit</td> </tr><tr> <td>Repository name</td> <td></td> </tr></table><i>These parameters can be set in the slave server configuration XML file: (Using defaults)</i><br>
  </BODY>
  </HTML>
  """

@GET
Scenario: An unauthorized user requests the Carte server's status information in the XML format using a GET request.
  When a HTTP GET request is sent to "/kettle/status/?xml=Y"
  And the Authorization request header has username "testing" and password "fakePass"
  Then the response status code will be 401

@GET
Scenario: An authorized user requests the Carte server's status information in the XML format using a GET request.
  When a HTTP GET request is sent to "/kettle/status/?xml=Y"
  And the Authorization request header has username "cluster" and password "cluster"
  Then the response status code will be 200
  And the response "responseXML" will be a XML document with:
  """
  <?xml version="1.0" encoding="UTF-8"?>
  <serverstatus>
    <statusdesc>Online</statusdesc>
    <memory_free></memory_free>
    <memory_total></memory_total>
    <cpu_cores></cpu_cores>
    <cpu_process_time></cpu_process_time>
    <uptime></uptime>
    <thread_count></thread_count>
    <load_avg></load_avg>
    <os_name></os_name>
    <os_version></os_version>
    <os_arch></os_arch>
    <transstatuslist></transstatuslist>
    <jobstatuslist></jobstatuslist>
  </serverstatus>
  """

@POST
Scenario: An unauthorized user requests the Carte server's status information in another format using a POST request.
  When a HTTP POST request is sent to "/kettle/status/"
  And the Authorization request header has username "testing" and password "fakePass"
  And the Content-Type request header is set to "application/x-www-form-urlencoded"
  And the HTTP POST request body contains "json=Y"
  Then the response status code will be 401

@POST
# The scenario below still returns a success code and html content even though the type is unsupported. Appears to be as designed.
Scenario: An authorized user requests the Carte server's status information in another format using a POST request.
  When a HTTP POST request is sent to "/kettle/status/"
  And the Authorization request header has username "cluster" and password "cluster"
  And the Content-Type request header is set to "application/x-www-form-urlencoded"
  And the HTTP POST request body contains "json=Y"
  Then the response status code will be 200
  And the response "responseText" will be a HTML page with:
  """
  <HTML>
  <HEAD><TITLE>Kettle slave server status</TITLE>
  <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </HEAD>
  <BODY>
  <H1>PDI Status</H1>
  <table border="1">
  <tr> <th>Transformation name</th> <th>Carte Object ID</th> <th>Status</th> <th>Last log date</th> <th>Remove from list</th> </tr></table><p><table border="1">
  <tr> <th>Job name</th> <th>Carte Object ID</th> <th>Status</th> <th>Last log date</th> <th>Remove from list</th> </tr></table><p>
  <H1>Configuration details:</H1><p>
  <table border="1">
  <tr> <th>Parameter</th> <th>Value</th> </tr><tr> <td>The maximum size of the central log buffer </td> <td>No limit</td> </tr><tr> <td>The maximum age of a log line</td> <td>No limit</td> </tr><tr> <td>The maximum age of a stale object</td> <td>No limit</td> </tr><tr> <td>Repository name</td> <td></td> </tr></table><i>These parameters can be set in the slave server configuration XML file: (Using defaults)</i><br>
  </BODY>
  </HTML>
  """

@POST
Scenario: An unauthorized user requests the Carte server's status information in the XML format using a POST request.
  When a HTTP POST request is sent to "/kettle/status/"
  And the Authorization request header has username "testing" and password "fakePass"
  And the Content-Type request header is set to "application/x-www-form-urlencoded"
  And the HTTP POST request body contains "xml=Y"
  Then the response status code will be 401

@POST
Scenario: An authorized user requests the Carte server's status information in the XML format using a POST request.
  When a HTTP POST request is sent to "/kettle/status/"
  And the Authorization request header has username "cluster" and password "cluster"
  And the Content-Type request header is set to "application/x-www-form-urlencoded"
  And the HTTP POST request body contains "xml=Y"
  Then the response status code will be 200
  And the response "responseXML" will be a XML document with:
  """
  <?xml version="1.0" encoding="UTF-8"?>
  <serverstatus>
    <statusdesc>Online</statusdesc>
    <memory_free></memory_free>
    <memory_total></memory_total>
    <cpu_cores></cpu_cores>
    <cpu_process_time></cpu_process_time>
    <uptime></uptime>
    <thread_count></thread_count>
    <load_avg></load_avg>
    <os_name></os_name>
    <os_version></os_version>
    <os_arch></os_arch>
    <transstatuslist></transstatuslist>
    <jobstatuslist></jobstatuslist>
  </serverstatus>
  """
