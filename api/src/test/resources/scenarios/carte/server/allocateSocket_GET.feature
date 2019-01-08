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

Feature: /kettle/allocateSocket

  This API endpoint allows any client to ask for a port number to use for a Carte server using a HTTP GET request

Background:
  Given a default Carte slave server is actively running

@GET
Scenario Outline: An unauthorized user attempts to allocate a socket on a Carte server with a missing required URL parameter using GET
  Given an invalid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  And the "xml" URL parameter is set to <xml>
  And the "rangeStart" URL parameter is set to <rangeStart>
  And the "host" URL parameter is set to <ipAddress>
  And the "id" URL parameter is set to <carteContainerId>
  And the "trans" URL parameter is set to <transformationName>
  And the "sourceSlave" URL parameter is set to <sourceSlaveServerName>
  And the "sourceStep" URL parameter is set to <sourceStepPortNumber>
  And the "sourceCopy" URL parameter is set to <sourceStepCopyCount>
  And the "targetSlave" URL parameter is set to <targetSlaveServerName>
  And the "targetStep" URL parameter is set to <targetStepPortNumber>
  And the "targetCopy" URL parameter is set to <targetStepCopyCount>
  When a HTTP GET request is sent to "/kettle/allocateSocket" with valid parameters
  Then the response status code will be 401
  And the response will contain "Error 401 Unauthorized"

  Examples:
  | username | password | xml | rangeStart | ipAddress | carteContainerId | transformationName | sourceSlaveServerName | sourceStepPortNumber | sourceStepCopyCount | targetSlaveServerName | targetStepPortNumber | targetStepCopyCount |
  | admin | password | N | 55555 | null | id_empty | trans_empty | sourceSlave_empty | 200 | 1 | targetSlave_empty | 200 | 1 |
  | admin | password | N | 55555 | localhost | null | trans_empty | sourceSlave_empty | 200 | 1 | targetSlave_empty | 200 | 1 |
  | admin | password | N | 55555 | localhost | id_empty | null | sourceSlave_empty | 200 | 1 | targetSlave_empty | 200 | 1 |
  | admin | password | N | 55555 | localhost | id_empty | trans_empty | null | 200 | 1 | targetSlave_empty | 200 | 1 |
  | admin | password | N | 55555 | localhost | id_empty | trans_empty | sourceSlave_empty | null | 1 | targetSlave_empty | 200 | 1 |
  | admin | password | N | 55555 | localhost | id_empty | trans_empty | sourceSlave_empty | 200 | null | targetSlave_empty | 200 | 1 |
  | suzy | password | N | 55555 | localhost | id_empty | trans_empty | sourceSlave_empty | 200 | 1 | null | 200 | 1 |
  | pat | password | N | 55555 | localhost | id_empty | trans_empty | sourceSlave_empty | 200 | 1 | targetSlave_empty | null | 1 |
  | tiffany | password | N | 30000 | localhost | id_empty | trans_empty | sourceSlave_empty | 200 | 1 | targetSlave_empty | 200 | null |
  | null | null | null | null | null | null | null | null | null | null | null | null | null |

@GET
Scenario: An unauthorized user attempts to allocate a socket on a Carte server with accepted URL parameter combinations using GET
  Given an invalid encode for the Basic HTTP Authorization Request Header using the username "admin" and the password "password"
  And the "xml" URL parameter is set to "n"
  And the "rangeStart" URL parameter is set to 12300
  And the "host" URL parameter is set to "localhost"
  And the "id" URL parameter is set to "id_valid"
  And the "trans" URL parameter is set to "trans_valid"
  And the "sourceSlave" URL parameter is set to "sourceSlave_valid"
  And the "sourceStep" URL parameter is set to 10
  And the "sourceCopy" URL parameter is set to 1
  And the "targetSlave" URL parameter is set to "targetSlave_valid"
  And the "targetStep" URL parameter is set to 10
  And the "targetCopy" URL parameter is set to 1
  When a HTTP GET request is sent to "/kettle/allocateSocket" with valid parameters
  Then the response status code will be 401
  And the response will contain "Error 401 Unauthorized"


@GET
Scenario Outline: An authorized user attempts to allocate a socket on a Carte server with missing required URL parameters using GET
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  And the "xml" URL parameter is set to <xml>
  And the "rangeStart" URL parameter is set to <rangeStart>
  And the "host" URL parameter is set to <ipAddress>
  And the "id" URL parameter is set to <carteContainerId>
  And the "trans" URL parameter is set to <transformationName>
  And the "sourceSlave" URL parameter is set to <sourceSlaveServerName>
  And the "sourceStep" URL parameter is set to <sourceStepPortNumber>
  And the "sourceCopy" URL parameter is set to <sourceStepCopyCount>
  And the "targetSlave" URL parameter is set to <targetSlaveServerName>
  And the "targetStep" URL parameter is set to <targetStepPortNumber>
  And the "targetCopy" URL parameter is set to <targetStepCopyCount>
  When a HTTP GET request is sent to "/kettle/allocateSocket" with valid parameters
  Then the response status code will be 400
  And the response will contain "Error 400 Bad Request"

  Examples:
  | username | password | xml | rangeStart | ipAddress | carteContainerId | transformationName | sourceSlaveServerName | sourceStepPortNumber | sourceStepCopyCount | targetSlaveServerName | targetStepPortNumber | targetStepCopyCount |
  | cluster | cluster | N | 55555 | null | id_empty | trans_empty | sourceSlave_empty | 200 | 1 | targetSlave_empty | 200 | 1 |
  | cluster | cluster | N | 55555 | localhost | null | trans_empty | sourceSlave_empty | 200 | 1 | targetSlave_empty | 200 | 1 |
  | cluster | cluster | N | 55555 | localhost | id_empty | null | sourceSlave_empty | 200 | 1 | targetSlave_empty | 200 | 1 |
  | cluster | cluster | N | 55555 | localhost | id_empty | trans_empty | null | 200 | 1 | targetSlave_empty | 200 | 1 |
  | cluster | cluster | N | 55555 | localhost | id_empty | trans_empty | sourceSlave_empty | null | 1 | targetSlave_empty | 200 | 1 |
  | cluster | cluster | N | 55555 | localhost | id_empty | trans_empty | sourceSlave_empty | 200 | null | targetSlave_empty | 200 | 1 |
  | cluster | cluster | N | 55555 | localhost | id_empty | trans_empty | sourceSlave_empty | 200 | 1 | null | 200 | 1 |
  | cluster | cluster | N | 55555 | localhost | id_empty | trans_empty | sourceSlave_empty | 200 | 1 | targetSlave_empty | null | 1 |
  | cluster | cluster | N | 30000 | localhost | id_empty | trans_empty | sourceSlave_empty | 200 | 1 | targetSlave_empty | 200 | null |
  | cluster | cluster | null | null | null | null | null | null | null | null | null | null | null |


@GET
Scenario Outline: An authorized user attempts to allocate a socket on a Carte server with an invalid port number using GET
  Given a valid encode for the Basic HTTP Authorization Request Header using the username "cluster" and the password "cluster"
  And the "xml" URL parameter is set to "N"
  And the "rangeStart" URL parameter is set to <invalidPort>
  And the "host" URL parameter is set to "localhost"
  And the "id" URL parameter is set to "id_valid"
  And the "trans" URL parameter is set to "trans_valid"
  And the "sourceSlave" URL parameter is set to "sourceSlave_valid"
  And the "sourceStep" URL parameter is set to 10
  And the "sourceCopy" URL parameter is set to 1
  And the "targetSlave" URL parameter is set to "targetSlave_valid"
  And the "targetStep" URL parameter is set to 10
  And the "targetCopy" URL parameter is set to 1
  When a HTTP GET request is sent to "/kettle/allocateSocket" with valid parameters
  Then the response status code will be 400
  And the response will contain "Error 400 Bad Request"

  Examples:
  | invalidPort |
  | abcdefg |
  | 99999 |
  | -1 |


@GET
Scenario Outline: An authorized user attempts to allocate a socket on a Carte server with accepted URL parameter combinations using GET
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  And the "xml" URL parameter is set to <xml>
  And the "rangeStart" URL parameter is set to <rangeStart>
  And the "host" URL parameter is set to <ipAddress>
  And the "id" URL parameter is set to <carteContainerId>
  And the "trans" URL parameter is set to <transformationName>
  And the "sourceSlave" URL parameter is set to <sourceSlaveServerName>
  And the "sourceStep" URL parameter is set to <sourceStepPortNumber>
  And the "sourceCopy" URL parameter is set to <sourceStepCopyCount>
  And the "targetSlave" URL parameter is set to <targetSlaveServerName>
  And the "targetStep" URL parameter is set to <targetStepPortNumber>
  And the "targetCopy" URL parameter is set to <targetStepCopyCount>
  When a HTTP GET request is sent to "/kettle/allocateSocket" with valid parameters
  Then the response status code will be 200
  And the response will contain <allocatedPort>

Examples:
| username | password | xml | rangeStart | ipAddress | carteContainerId | transformationName | sourceSlaveServerName | sourceStepPortNumber | sourceStepCopyCount | targetSlaveServerName | targetStepPortNumber | targetStepCopyCount | allocatedPort |
| cluster | cluster | null | 1000 | localhost | id_zero | trans_zero | sourceSlave_zero | 200 | 1 | targetSlave_zero | 200 | 1 | 1000 |
| cluster | cluster | null | 1001 | localhost | id_one | trans_zero | sourceSlave_zero | 200 | 1 | targetSlave_zero | 200 | 1 | 1001 |
| cluster | cluster | null | 1002 | localhost | id_one | trans_one | sourceSlave_zero | 200 | 1 | targetSlave_zero | 200 | 1 | 1002 |
| cluster | cluster | null | 1003 | localhost | id_one | trans_one | sourceSlave_one | 200 | 1 | targetSlave_zero | 200 | 1 | 1003 |
| cluster | cluster | null | 1004 | localhost | id_one | trans_one | sourceSlave_one | 300 | 1 | targetSlave_zero | 200 | 1 | 1004 |
| cluster | cluster | null | 1005 | localhost | id_one | trans_one | sourceSlave_one | 300 | 2 | targetSlave_zero | 200 | 1 | 1005 |
| cluster | cluster | null | 1006 | localhost | id_one | trans_one | sourceSlave_one | 300 | 2 | targetSlave_one | 200 | 1 | 1006 |
| cluster | cluster | null | 1007 | localhost | id_one | trans_one | sourceSlave_one | 300 | 2 | targetSlave_one | 300 | 1 | 1007 |
| cluster | cluster | null | 1008 | localhost | id_one | trans_one | sourceSlave_one | 300 | 2 | targetSlave_one | 300 | 2 | 1008 |
| cluster | cluster | null | 7000 | localhost | id_one | trans_one | sourceSlave_one | 300 | 2 | targetSlave_one | 300 | 2 | 1008 |
| cluster | cluster | null | 7000 | localhost | id_two | trans_one | sourceSlave_one | 300 | 2 | targetSlave_one | 300 | 2 | 7000 |
| cluster | cluster | null | 7010 | localhost | id_two | trans_two | sourceSlave_one | 300 | 2 | targetSlave_one | 300 | 2 | 7010 |
| cluster | cluster | null | 7020 | localhost | id_two | trans_two | sourceSlave_two | 300 | 2 | targetSlave_one | 300 | 2 | 7020 |
| cluster | cluster | null | 7030 | localhost | id_two | trans_two | sourceSlave_two | 400 | 2 | targetSlave_one | 300 | 2 | 7030 |
| cluster | cluster | null | 7040 | localhost | id_two | trans_two | sourceSlave_two | 400 | 3 | targetSlave_one | 300 | 2 | 7040 |
| cluster | cluster | null | 7050 | localhost | id_two | trans_two | sourceSlave_two | 400 | 3 | targetSlave_two | 300 | 2 | 7050 |
| cluster | cluster | null | 7060 | localhost | id_two | trans_two | sourceSlave_two | 400 | 3 | targetSlave_two | 400 | 2 | 7060 |
| cluster | cluster | null | 7070 | localhost | id_two | trans_two | sourceSlave_two | 400 | 3 | targetSlave_two | 400 | 3 | 7070 |
| cluster | cluster | N    | 10000 | localhost | id_two | trans_two | sourceSlave_two | 400 | 3 | targetSlave_two | 400 | 3 | 7070 |
| cluster | cluster | N    | 10000 | localhost | id_three | trans_two | sourceSlave_two | 400 | 3 | targetSlave_two | 400 | 3 | 10000 |
| cluster | cluster | N    | 11111 | localhost | id_three | trans_three | sourceSlave_two | 400 | 3 | targetSlave_two | 400 | 3 | 11111 |
| cluster | cluster | N    | 12222 | localhost | id_three | trans_three | sourceSlave_three | 400 | 3 | targetSlave_two | 400 | 3 | 12222 |
| cluster | cluster | N    | 13333 | localhost | id_three | trans_three | sourceSlave_three | 500 | 3 | targetSlave_two | 400 | 3 | 13333 |
| cluster | cluster | N    | 14444 | localhost | id_three | trans_three | sourceSlave_three | 500 | 4 | targetSlave_two | 400 | 3 | 14444 |
| cluster | cluster | N    | 15555 | localhost | id_three | trans_three | sourceSlave_three | 500 | 4 | targetSlave_three | 400 | 3 | 15555 |
| cluster | cluster | N    | 16666 | localhost | id_three | trans_three | sourceSlave_three | 500 | 4 | targetSlave_three | 500 | 3 | 16666 |
| cluster | cluster | N    | 17777 | localhost | id_three | trans_three | sourceSlave_three | 500 | 4 | targetSlave_three | 500 | 4 | 17777 |
| cluster | cluster | Y    | 20000 | localhost | id_three | trans_three | sourceSlave_three | 500 | 4 | targetSlave_three | 500 | 4 | 17777 |
| cluster | cluster | Y    | 20000 | localhost | id_four | trans_three | sourceSlave_three | 500 | 4 | targetSlave_three | 500 | 4 | 20000 |
| cluster | cluster | Y    | 20100 | localhost | id_four | trans_four | sourceSlave_three | 500 | 4 | targetSlave_three | 500 | 4 | 20100 |
| cluster | cluster | Y    | 20200 | localhost | id_four | trans_four | sourceSlave_four | 500 | 4 | targetSlave_three | 500 | 4 | 20200 |
| cluster | cluster | Y    | 20300 | localhost | id_four | trans_four | sourceSlave_four | 600 | 4 | targetSlave_three | 500 | 4 | 20300 |
| cluster | cluster | Y    | 20400 | localhost | id_four | trans_four | sourceSlave_four | 600 | 5 | targetSlave_three | 500 | 4 | 20400 |
| cluster | cluster | Y    | 20500 | localhost | id_four | trans_four | sourceSlave_four | 600 | 5 | targetSlave_four | 500 | 4 | 20500 |
| cluster | cluster | Y    | 20600 | localhost | id_four | trans_four | sourceSlave_four | 600 | 5 | targetSlave_four | 600 | 4 | 20600 |
| cluster | cluster | Y    | 20700 | localhost | id_four | trans_four | sourceSlave_four | 600 | 5 | targetSlave_four | 600 | 5 | 20700 |
| cluster | cluster | Y    | null  | localhost | id_four | trans_four | sourceSlave_four | 600 | 5 | targetSlave_four | 600 | 5 | 20700 |
| cluster | cluster | Y    | null  | localhost | id_five | trans_four | sourceSlave_four | 600 | 5 | targetSlave_four | 600 | 5 | 40000 |
| cluster | cluster | Y    | null  | localhost | id_five | trans_five | sourceSlave_four | 600 | 5 | targetSlave_four | 600 | 5 | 40001 |
| cluster | cluster | Y    | null  | localhost | id_five | trans_five | sourceSlave_five | 600 | 5 | targetSlave_four | 600 | 5 | 40002 |
| cluster | cluster | Y    | null  | localhost | id_five | trans_five | sourceSlave_five | 700 | 5 | targetSlave_four | 600 | 5 | 40003 |
| cluster | cluster | Y    | null  | localhost | id_five | trans_five | sourceSlave_five | 700 | 6 | targetSlave_four | 600 | 5 | 40004 |
| cluster | cluster | Y    | null  | localhost | id_five | trans_five | sourceSlave_five | 700 | 6 | targetSlave_five | 600 | 5 | 40005 |
| cluster | cluster | Y    | null  | localhost | id_five | trans_five | sourceSlave_five | 700 | 6 | targetSlave_five | 700 | 5 | 40006 |
| cluster | cluster | Y    | null  | localhost | id_five | trans_five | sourceSlave_five | 700 | 6 | targetSlave_five | 700 | 6 | 40007 |
| cluster | cluster | N    | null  | localhost | id_five | trans_five | sourceSlave_five | 700 | 6 | targetSlave_five | 700 | 6 | 40007 |
| cluster | cluster | N    | null  | localhost | id_six | trans_five | sourceSlave_five | 700 | 6 | targetSlave_five | 700 | 6 | 40008 |
| cluster | cluster | N    | null  | localhost | id_six | trans_six | sourceSlave_five | 700 | 6 | targetSlave_five | 700 | 6 | 40009 |
| cluster | cluster | N    | null  | localhost | id_six | trans_six | sourceSlave_six | 700 | 6 | targetSlave_five | 700 | 6 | 40010 |
| cluster | cluster | N    | null  | localhost | id_six | trans_six | sourceSlave_six | 800 | 6 | targetSlave_five | 700 | 6 | 40011 |
| cluster | cluster | N    | null  | localhost | id_six | trans_six | sourceSlave_six | 800 | 7 | targetSlave_five | 700 | 6 | 40012 |
| cluster | cluster | N    | null  | localhost | id_six | trans_six | sourceSlave_six | 800 | 7 | targetSlave_six | 700 | 6 | 40013 |
| cluster | cluster | N    | null  | localhost | id_six | trans_six | sourceSlave_six | 800 | 7 | targetSlave_six | 800 | 6 | 40014 |
| cluster | cluster | N    | null  | localhost | id_six | trans_six | sourceSlave_six | 800 | 7 | targetSlave_six | 800 | 7 | 40015 |
| cluster | cluster | null | null  | localhost | id_six | trans_six | sourceSlave_six | 800 | 7 | targetSlave_six | 800 | 7 | 40015 |
| cluster | cluster | null | null  | localhost | id_seven | trans_six | sourceSlave_six | 800 | 7 | targetSlave_six | 800 | 7 | 40016 |
| cluster | cluster | null | null  | localhost | id_seven | trans_seven | sourceSlave_six | 800 | 7 | targetSlave_six | 800 | 7 | 40017 |
| cluster | cluster | null | null  | localhost | id_seven | trans_seven | sourceSlave_seven | 800 | 7 | targetSlave_six | 800 | 7 | 40018 |
| cluster | cluster | null | null  | localhost | id_seven | trans_seven | sourceSlave_seven | 900 | 7 | targetSlave_six | 800 | 7 | 40019 |
| cluster | cluster | null | null  | localhost | id_seven | trans_seven | sourceSlave_seven | 900 | 8 | targetSlave_six | 800 | 7 | 40020 |
| cluster | cluster | null | null  | localhost | id_seven | trans_seven | sourceSlave_seven | 900 | 8 | targetSlave_seven | 800 | 7 | 40021 |
| cluster | cluster | null | null  | localhost | id_seven | trans_seven | sourceSlave_seven | 900 | 8 | targetSlave_seven | 900 | 7 | 40022 |
| cluster | cluster | null | null  | localhost | id_seven | trans_seven | sourceSlave_seven | 900 | 8 | targetSlave_seven | 900 | 8 | 40023 |
| cluster | cluster | null | 1000 | 192.168.100.10 | id_zero | trans_zero | sourceSlave_zero | 200 | 1 | targetSlave_zero | 200 | 1 | 1000 |
| cluster | cluster | null | 1001 | 192.168.100.10 | id_one | trans_zero | sourceSlave_zero | 200 | 1 | targetSlave_zero | 200 | 1 | 1001 |
| cluster | cluster | null | 1002 | 192.168.100.10 | id_one | trans_one | sourceSlave_zero | 200 | 1 | targetSlave_zero | 200 | 1 | 1002 |
| cluster | cluster | null | 1003 | 192.168.100.10 | id_one | trans_one | sourceSlave_one | 200 | 1 | targetSlave_zero | 200 | 1 | 1003 |
| cluster | cluster | null | 1004 | 192.168.100.10 | id_one | trans_one | sourceSlave_one | 300 | 1 | targetSlave_zero | 200 | 1 | 1004 |
| cluster | cluster | null | 1005 | 192.168.100.10 | id_one | trans_one | sourceSlave_one | 300 | 2 | targetSlave_zero | 200 | 1 | 1005 |
| cluster | cluster | null | 1006 | 192.168.100.10 | id_one | trans_one | sourceSlave_one | 300 | 2 | targetSlave_one | 200 | 1 | 1006 |
| cluster | cluster | null | 1007 | 192.168.100.10 | id_one | trans_one | sourceSlave_one | 300 | 2 | targetSlave_one | 300 | 1 | 1007 |
| cluster | cluster | null | 1008 | 192.168.100.10 | id_one | trans_one | sourceSlave_one | 300 | 2 | targetSlave_one | 300 | 2 | 1008 |
| cluster | cluster | null | 7000 | 192.168.100.10 | id_one | trans_one | sourceSlave_one | 300 | 2 | targetSlave_one | 300 | 2 | 1008 |
| cluster | cluster | null | 7000 | 192.168.100.10 | id_two | trans_one | sourceSlave_one | 300 | 2 | targetSlave_one | 300 | 2 | 7000 |
| cluster | cluster | null | 7010 | 192.168.100.10 | id_two | trans_two | sourceSlave_one | 300 | 2 | targetSlave_one | 300 | 2 | 7010 |
| cluster | cluster | null | 7020 | 192.168.100.10 | id_two | trans_two | sourceSlave_two | 300 | 2 | targetSlave_one | 300 | 2 | 7020 |
| cluster | cluster | null | 7030 | 192.168.100.10 | id_two | trans_two | sourceSlave_two | 400 | 2 | targetSlave_one | 300 | 2 | 7030 |
| cluster | cluster | null | 7040 | 192.168.100.10 | id_two | trans_two | sourceSlave_two | 400 | 3 | targetSlave_one | 300 | 2 | 7040 |
| cluster | cluster | null | 7050 | 192.168.100.10 | id_two | trans_two | sourceSlave_two | 400 | 3 | targetSlave_two | 300 | 2 | 7050 |
| cluster | cluster | null | 7060 | 192.168.100.10 | id_two | trans_two | sourceSlave_two | 400 | 3 | targetSlave_two | 400 | 2 | 7060 |
| cluster | cluster | null | 7070 | 192.168.100.10 | id_two | trans_two | sourceSlave_two | 400 | 3 | targetSlave_two | 400 | 3 | 7070 |
| cluster | cluster | N    | 10000 | 192.168.100.10 | id_two | trans_two | sourceSlave_two | 400 | 3 | targetSlave_two | 400 | 3 | 7070 |
| cluster | cluster | N    | 10000 | 192.168.100.10 | id_three | trans_two | sourceSlave_two | 400 | 3 | targetSlave_two | 400 | 3 | 10000 |
| cluster | cluster | N    | 11111 | 192.168.100.10 | id_three | trans_three | sourceSlave_two | 400 | 3 | targetSlave_two | 400 | 3 | 11111 |
| cluster | cluster | N    | 12222 | 192.168.100.10 | id_three | trans_three | sourceSlave_three | 400 | 3 | targetSlave_two | 400 | 3 | 12222 |
| cluster | cluster | N    | 13333 | 192.168.100.10 | id_three | trans_three | sourceSlave_three | 500 | 3 | targetSlave_two | 400 | 3 | 13333 |
| cluster | cluster | N    | 14444 | 192.168.100.10 | id_three | trans_three | sourceSlave_three | 500 | 4 | targetSlave_two | 400 | 3 | 14444 |
| cluster | cluster | N    | 15555 | 192.168.100.10 | id_three | trans_three | sourceSlave_three | 500 | 4 | targetSlave_three | 400 | 3 | 15555 |
| cluster | cluster | N    | 16666 | 192.168.100.10 | id_three | trans_three | sourceSlave_three | 500 | 4 | targetSlave_three | 500 | 3 | 16666 |
| cluster | cluster | N    | 17777 | 192.168.100.10 | id_three | trans_three | sourceSlave_three | 500 | 4 | targetSlave_three | 500 | 4 | 17777 |
| cluster | cluster | Y    | 20000 | 192.168.100.10 | id_three | trans_three | sourceSlave_three | 500 | 4 | targetSlave_three | 500 | 4 | 17777 |
| cluster | cluster | Y    | 20000 | 192.168.100.10 | id_four | trans_three | sourceSlave_three | 500 | 4 | targetSlave_three | 500 | 4 | 20000 |
| cluster | cluster | Y    | 20100 | 192.168.100.10 | id_four | trans_four | sourceSlave_three | 500 | 4 | targetSlave_three | 500 | 4 | 20100 |
| cluster | cluster | Y    | 20200 | 192.168.100.10 | id_four | trans_four | sourceSlave_four | 500 | 4 | targetSlave_three | 500 | 4 | 20200 |
| cluster | cluster | Y    | 20300 | 192.168.100.10 | id_four | trans_four | sourceSlave_four | 600 | 4 | targetSlave_three | 500 | 4 | 20300 |
| cluster | cluster | Y    | 20400 | 192.168.100.10 | id_four | trans_four | sourceSlave_four | 600 | 5 | targetSlave_three | 500 | 4 | 20400 |
| cluster | cluster | Y    | 20500 | 192.168.100.10 | id_four | trans_four | sourceSlave_four | 600 | 5 | targetSlave_four | 500 | 4 | 20500 |
| cluster | cluster | Y    | 20600 | 192.168.100.10 | id_four | trans_four | sourceSlave_four | 600 | 5 | targetSlave_four | 600 | 4 | 20600 |
| cluster | cluster | Y    | 20700 | 192.168.100.10 | id_four | trans_four | sourceSlave_four | 600 | 5 | targetSlave_four | 600 | 5 | 20700 |
| cluster | cluster | Y    | null  | 192.168.100.10 | id_four | trans_four | sourceSlave_four | 600 | 5 | targetSlave_four | 600 | 5 | 20700 |
| cluster | cluster | Y    | null  | 192.168.100.10 | id_five | trans_four | sourceSlave_four | 600 | 5 | targetSlave_four | 600 | 5 | 40000 |
| cluster | cluster | Y    | null  | 192.168.100.10 | id_five | trans_five | sourceSlave_four | 600 | 5 | targetSlave_four | 600 | 5 | 40001 |
| cluster | cluster | Y    | null  | 192.168.100.10 | id_five | trans_five | sourceSlave_five | 600 | 5 | targetSlave_four | 600 | 5 | 40002 |
| cluster | cluster | Y    | null  | 192.168.100.10 | id_five | trans_five | sourceSlave_five | 700 | 5 | targetSlave_four | 600 | 5 | 40003 |
| cluster | cluster | Y    | null  | 192.168.100.10 | id_five | trans_five | sourceSlave_five | 700 | 6 | targetSlave_four | 600 | 5 | 40004 |
| cluster | cluster | Y    | null  | 192.168.100.10 | id_five | trans_five | sourceSlave_five | 700 | 6 | targetSlave_five | 600 | 5 | 40005 |
| cluster | cluster | Y    | null  | 192.168.100.10 | id_five | trans_five | sourceSlave_five | 700 | 6 | targetSlave_five | 700 | 5 | 40006 |
| cluster | cluster | Y    | null  | 192.168.100.10 | id_five | trans_five | sourceSlave_five | 700 | 6 | targetSlave_five | 700 | 6 | 40007 |
| cluster | cluster | N    | null  | 192.168.100.10 | id_five | trans_five | sourceSlave_five | 700 | 6 | targetSlave_five | 700 | 6 | 40007 |
| cluster | cluster | N    | null  | 192.168.100.10 | id_six | trans_five | sourceSlave_five | 700 | 6 | targetSlave_five | 700 | 6 | 40008 |
| cluster | cluster | N    | null  | 192.168.100.10 | id_six | trans_six | sourceSlave_five | 700 | 6 | targetSlave_five | 700 | 6 | 40009 |
| cluster | cluster | N    | null  | 192.168.100.10 | id_six | trans_six | sourceSlave_six | 700 | 6 | targetSlave_five | 700 | 6 | 40010 |
| cluster | cluster | N    | null  | 192.168.100.10 | id_six | trans_six | sourceSlave_six | 800 | 6 | targetSlave_five | 700 | 6 | 40011 |
| cluster | cluster | N    | null  | 192.168.100.10 | id_six | trans_six | sourceSlave_six | 800 | 7 | targetSlave_five | 700 | 6 | 40012 |
| cluster | cluster | N    | null  | 192.168.100.10 | id_six | trans_six | sourceSlave_six | 800 | 7 | targetSlave_six | 700 | 6 | 40013 |
| cluster | cluster | N    | null  | 192.168.100.10 | id_six | trans_six | sourceSlave_six | 800 | 7 | targetSlave_six | 800 | 6 | 40014 |
| cluster | cluster | N    | null  | 192.168.100.10 | id_six | trans_six | sourceSlave_six | 800 | 7 | targetSlave_six | 800 | 7 | 40015 |
| cluster | cluster | null | null  | 192.168.100.10 | id_six | trans_six | sourceSlave_six | 800 | 7 | targetSlave_six | 800 | 7 | 40015 |
| cluster | cluster | null | null  | 192.168.100.10 | id_seven | trans_six | sourceSlave_six | 800 | 7 | targetSlave_six | 800 | 7 | 40016 |
| cluster | cluster | null | null  | 192.168.100.10 | id_seven | trans_seven | sourceSlave_six | 800 | 7 | targetSlave_six | 800 | 7 | 40017 |
| cluster | cluster | null | null  | 192.168.100.10 | id_seven | trans_seven | sourceSlave_seven | 800 | 7 | targetSlave_six | 800 | 7 | 40018 |
| cluster | cluster | null | null  | 192.168.100.10 | id_seven | trans_seven | sourceSlave_seven | 900 | 7 | targetSlave_six | 800 | 7 | 40019 |
| cluster | cluster | null | null  | 192.168.100.10 | id_seven | trans_seven | sourceSlave_seven | 900 | 8 | targetSlave_six | 800 | 7 | 40020 |
| cluster | cluster | null | null  | 192.168.100.10 | id_seven | trans_seven | sourceSlave_seven | 900 | 8 | targetSlave_seven | 800 | 7 | 40021 |
| cluster | cluster | null | null  | 192.168.100.10 | id_seven | trans_seven | sourceSlave_seven | 900 | 8 | targetSlave_seven | 900 | 7 | 40022 |
| cluster | cluster | null | null  | 192.168.100.10 | id_seven | trans_seven | sourceSlave_seven | 900 | 8 | targetSlave_seven | 900 | 8 | 40023 |
