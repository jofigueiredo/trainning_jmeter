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

Feature: /kettle/listSocket

  This API endpoint allows any client to list the sockets used on a Carte server using a HTTP GET request.

Background:
  Given a default Carte slave server is actively running in a cluster configuration

@GET
Scenario: An unauthorized user attempts to list all the sockets of a Carte server without specifying any parameters
  Given an invalid encode for the Basic HTTP Authorization Request Header using the username "admin" and the password "password"
  When a HTTP GET Request is sent to "/kettle/listSocket"
  Then the response status code will be 401
  And the response will contain "Error 401 Unauthorized"

@GET
Scenario Outline: An unauthorized user attempts to list all the sockets of a Carte server with an abnormal host URL parameter
  Given an invalid encode for the Basic HTTP Authorization Request Header using the username "admin" and the password "password"
  When a HTTP GET Request is sent to "/kettle/listSocket"
  And the "host" URL parameter is set to <hostAddress>
  Then the response status code will be 401
  And the response will contain "Error 401 Unauthorized"

  Examples:
  | hostAddress |
  | <img src=%6A%61%76%61%73%63%72%69%70%74%3A%61%6C%65%72%74%28%27%58%53%53%27%29> |
  | this R4ndom $tring Works |
  | ~~~~~~~ |

@GET
Scenario: An unauthorized user attempts to list all the sockets of a Carte server with a valid host URL parameter
  Given an invalid encode for the Basic HTTP Authorization Request Header using the username "admin" and the password "password"
  When a HTTP GET Request is sent to "/kettle/listSocket"
  And the "host" URL parameter is set to "localhost"
  Then the response status code will be 401
  And the response will contain "Error 401 Unauthorized"

@GET
Scenario: An authorized user attempts to list all the sockets of a Carte server without specifying any parameters
  Given a valid encode for the Basic HTTP Authorization Request Header using the username "cluster" and the password "cluster"
  When a HTTP GET Request is sent to "/kettle/listSocket"
  Then the response status code will be 400
  And the response will contain "Error 400 Bad Request"

@GET
Scenario Outline: An authorized user attempts to list all the sockets of a Carte server with an abnormal host URL parameter
  Given a valid encode for the Basic HTTP Authorization Request Heade using the username "cluster" and the password "cluster"
  When a HTTP GET Request is sent to "/kettle/listSocket"
  And the "host" URL parameter is set to <hostAddress>
  Then the response status code will be 200
  And the response will contain "Found 0 ports for host <responseString>"

  Examples:
  | hostAddress | displayedString |
  | <img src=%6A%61%76%61%73%63%72%69%70%74%3A%61%6C%65%72%74%28%27%58%53%53%27%29> | &#39;&lt;img src=javascript:alert(&#39;XSS&#39;)&gt;&#39; |
  | this R4ndom $tring Works | &#39;this R4ndom $tring Works&#39; |
  | ~~~~~ | &#39;~~~~~&#39; |

@GET
Scenario Outline: An authorized user attempts to list all the sockets of a Carte server with a standard host URL parameter
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP GET Request is sent to "/kettle/listSocket"
  And the "host" URL parameter is set to <hostAddress>
  Then the response status code will be 200
  And the response will contain "Found 0 ports for &#39;<hostAddress>&#39;"

  Examples:
  | username | password | hostAddress |
  | cluster  | cluster  | localhost   |
  | cluster  | cluster  | 100.200.200.100 |
  | cluster  | cluster  | 8.8.8.8 |

@GET
Scenario Outline: An unauthorized user attempts to list only the open sockets of a Carte server with a standard host URL parameter
  Given an invalid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP GET Request is sent to "/kettle/listSocket"
  And the "host" URL parameter is set to <hostAddress>
  And the "onlyOpen" URL parameter is set to "Y"
  Then the response status code will be 401
  And the response will contain "Error 401 Unauthorized"

  Examples:
  | username | password | hostAddress |
  | cluster  | cluster  | localhost   |
  | cluster  | cluster  | 100.200.200.100 |
  | cluster  | cluster  | 8.8.8.8 |


@GET
Scenario Outline: An authorized user attempts to list only the open sockets of a Carte server with a standard host URL parameter
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP GET Request is sent to "/kettle/listSocket"
  And the "host" URL parameter is set to <hostAddress>
  And the "onlyOpen" URL parameter is set to "Y"
  Then the response status code will be 200
  And the response will contain "Found 0 ports for &#39;<hostAddress>&#39;"

  Examples:
  | username | password | hostAddress |
  | cluster  | cluster  | localhost   |
  | cluster  | cluster  | 100.200.200.100 |
  | cluster  | cluster  | 8.8.8.8 |

@GET
Scenario Outline: An authorized user attempts to list all the sockets of a Carte server with a single socket allocated to it via the API
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  And no transformations are active or have been run on the cluster at <hostAddress>
  And a single socket was allocated to <hostAddress> via the "/kettle/allocateSocket" API end point with these <urlParameters>
  When a HTTP GET Request is sent to "/kettle/listSocket"
  And the "host" URL parameter is set to <hostAddress>
  And the "onlyOpen" URL parameter is set to <isOnlyOpen>
  Then the response status code will be 200
  And the response will contain "Found 1 ports for &#39;<hostAddress>&#39;"
  And the response will contain "id=allocatedSocket"

  Examples:
  | username | password | hostAddress | isOnlyOpen | urlParameters |
  | cluster  | cluster  | localhost   | N | xml=N&rangeStart=1000&id=allocatedTestSocket&trans=myTestTranss&sourceSlave=mySourceSlave&sourceStep=100&sourceCopy=1&targetSlave=myTargetSlave&targetStep=100&targetCopy=1 |
  | cluster  | cluster  | localhost   | Y | xml=N&rangeStart=1000&id=allocatedTestSocket&trans=myTestTranss&sourceSlave=mySourceSlave&sourceStep=100&sourceCopy=1&targetSlave=myTargetSlave&targetStep=100&targetCopy=1 |

@GET
Scenario: An authorized user attempts to list all the sockets of a Carte server with sockets allocated to it via Spoon
  Given a valid encode for the Basic HTTP Authorization Request Header using using the username "cluster" and the password "cluster"
  And a transformation is active or has been run on the cluster at "localhost
  And no sockets have been allocated to "localhost" via the API end point
  When a HTTP GET Request is sent to "/kettle/listSocket"
  And the "host" URL parameter is set to "localhost"
  Then the response status code will be 200
  And the response will contain "Found {int} ports for &#39;localhost&#39;"

@GET
Scenario: An authorized user attempts to list only the open sockets of a Carte server with sockets allocated to it via Spoon
  Given a valid encode for the Basic HTTP Authorization Request Header using the username "cluster" and the password "cluster"
  And a transformation is active on the cluster at "localhost"
  And no sockets have been allocated to "localhost" via the API end point
  When a HTTP GET Request is sent to "/kettle/listSocket"
  And the "host" URL parameter is set to "localhost"
  And the "onlyOpen" URL parameter is set to "Y"
  Then the response status code will be 200
  And the response will contain "Found {int} ports for &#39;localhost&#39;"

@GET
Scenario: An authorized user attempts to list only the open sockets of a Carte server with sockets allocated to it via Spoon but no active transformations are running
  Given a valid encode for the Basic HTTP Authorization Request Header using  using the username "cluster" and the password "cluster"
  And no transformations are active on the cluster at "localhost"
  But a transformation has been run on the cluster at "localhost"
  And no sockets have been allocated to "localhost" via the API end point
  When a HTTP GET Request is sent to "/kettle/listSocket"
  And the "host" URL parameter is set to "localhost"
  And the "onlyOpen" URL parameter is set to "Y"
  Then the response status code will be 200
  And the response will contain "Found 0 ports for &#39;localhost&#39;"
