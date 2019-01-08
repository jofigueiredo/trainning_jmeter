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

Feature: /kettle/nextSequence

  This API endpoint allows any client to retrieve the pre-configured sequences on a Carte server.
  See https://wiki.pentaho.com/display/EAI/Get+ID+from+Slave+Server for more details.

Background:
  Given a default Carte slave server is actively running
  And the "TESTSEQ" database table containing the sequence_field and value_field is empty
  And the Carte configuration file contains the predetermined sequence
  """
  <sequence>
    <name>testSeq</name>
    <start>1000</start>
    <connection>testSeqConn</connection>
    <schema />
    <table>TESTSEQ</table>
    <sequence_field>SEQ_NAME</sequence_field>
    <value_field>SEQ_VALUE</value_field>
  </sequence>
  """

@POST
Scenario: An unauthorized user attempts to get a sequence from the Carte server without specifying any parameters
  Given an invalid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP POST Request is sent to "/kettle/nextSequence"
  Then the response status code will be 401
  And the response will contain "Error 401 Unauthorized"

@POST
Scenario: An unauthorized user attempts to get an existing sequence from the Carte server using only the name parameter
  Given an invalid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP POST Request is sent to "/kettle/nextSequence"
  And the "name" parameter is set to "testSeq"
  Then the response status code will be 401
  And the response will contain "Error 401 Unauthorized"

@POST
Scenario: An unauthorized user attempts to get an existing sequence from the Carte server using the name and increment parameters
  Given an invalid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP POST Request is sent to "/kettle/nextSequence"
  And the "name" parameter is set to "testSeq"
  And the "increment" parameter is set to "1000"
  Then the response status code will be 401
  And the response will contain "Error 401 Unauthorized"

@POST
Scenario: An authorized user attempts to get a sequence from the Carte server without specifying any parameters
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP POST Request is sent to "/kettle/nextSequence"
  Then the response status code will be 404
  And the response will contain "Slave sequence &#39;null&#39; could not be found."

@POST
Scenario: An authorized user attempts to get a nonexistent sequence from the Carte server using only the name parameter
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP POST Request is sent to "/kettle/nextSequence"
  And the "name" parameter is set to "seqDoesNotExist"
  Then the response status code will be 404
  And the response will contain "Slave sequence &#39;seqDoesNotExist&#39; could not be found."

@POST
Scenario Outline: An authorized user attempts to get an existing sequence from the Carte server using only the name parameter
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP POST Request is sent to "/kettle/nextSequence"
  And the "name" parameter is set to "testSeq"
  Then the response status code will be 200
  And the response "<value>" field will contain <responseValue>
  And the response "<increment>" field will contain <responseIncrement>

  Examples:
  | responseValue | responseIncrement |
  | 1000  | 10000 |
  | 11000 | 10000 |
  | 21000 | 10000 |

@POST
Scenario Outline: An authorized user attempts to get an existing sequence from the Carte server using the name and increment parameters
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP POST Request is sent to "/kettle/nextSequence"
  And the "name" parameter is set to "testSeq"
  And the "increment" parameter is set to <incrementBy>
  Then the response status code will be 200
  And the response "<value>" field will contain <responseValue>
  And the response "<increment>" field will contain <responseIncrement>

  Examples:
  | incrementBy | responseValue | responseIncrement |
  | 1000 | 1000  | 1000 |
  | 500  | 2000  | 500 |
  | 500  | 2500  | 500 |
  | 0    | 3000  | 0 |
  | 0    | 3000  | 0 |
  | 7000 | 3000  | 7000 |
  | empty | 10000 | 10000 |
  | empty | 20000 | 10000 |
  | 1     | 30000 | 1 |
  | 1     | 30001 | 1 |
