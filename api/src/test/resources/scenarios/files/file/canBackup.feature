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

Scenario Outline: A user with certain permissions can do or not calls for system backup
  Given the browser 'user-agent'
  When a 'userRole' perform a backup call
  Then the response status code is 'statusCode'
  And the response body can be 'responseBody'
Examples:
  | user-agent | userRole | statusCode | responseBody             | #notes | #TC1               |
  | FireFox    | admin    | 200        | application/xml          |        | #TC1.1# GET Method |
  | FireFox    | admin    | 200        | application/octet-stream |        | #TC1.2# GET Method |
  | FireFox    | suzy     | 403        |                          |        | #TC1.3# GET Method |
  | FireFox    | unknown  | 403        |                          |        | #TC1.4# GET Method |
  | Chrome     | admin    | 200        | application/xml          |        | #TC1.5# GET Method |
  | Chrome     | admin    | 200        | application/octet-stream |        | #TC1.6# GET Method |
  | Chrome     | suzy     | 403        |                          |        | #TC1.7# GET Method |
  | Chrome     | unknown  | 403        |                          |        | #TC1.8# GET Method |
  | IE         | admin    | 200        | application/xml          |        | #TC1.9# GET Method |
  | IE         | admin    | 200        | application/octet-stream |        | #TC1.10# GET Method |
  | IE         | suzy     | 403        |                          |        | #TC1.12# GET Method |
  | IE         | unknown  | 403        |                          |        | #TC1.13# GET Method |
  | Edge       | admin    | 200        | application/xml          |        | #TC1.14# GET Method |
  | Edge       | admin    | 200        | application/octet-stream |        | #TC1.15# GET Method |
  | Edge       | suzy     | 403        |                          |        | #TC1.16# GET Method |
  | Edge       | unknown  | 403        |                          |        | #TC1.17# GET Method |

Scenario Outline: It is not possible to do a call without parameters
  Given the browser parameter 'user-agent'
  When a 'userRole' perform a backup call
  Then the response status code is 'statusCode'
Examples:
  | user-agent | userRole | statusCode | #TC2               |
  |            | admin    | 404        | #TC2.1# GET Method |
  |            | suzy     | 404        | #TC2.2# GET Method |
  |            | unknown  | 404        | #TC2.3# GET Method |
