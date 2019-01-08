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

Feature: /session/workspaceDirForUser

  This API call returns the workspace folder path for the given user only when a valid Basic Authorization Request Header is provided.

@GET
Scenario Outline: A non-existent user requests the workspace directory of a non-existent user
  Given an invalid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP GET request is sent to "/session/workspaceDirForUser/<requestDirFor>"
  Then the response status code will be 401

  Examples:
    | username | password | requestDirFor |
    | joe | password | batman |
    | notHome | fakePass | $uperman! |
    | ignoreMe | wrongPass | w0nderw0man |
    | n0tR3al  | 3mptyP@a$$ | thor |


@GET
Scenario Outline: A non-existent user requests the workspace directory of an existing user
  Given an invalid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP GET request is sent to "/session/workspaceDirForUser/<requestDirFor>"
  Then the response status code will be 401

  Examples:
    | username | password | requestDirFor |
    | joe | password | admin |
    | notHome | fakePass | suzy |
    | ignoreMe | wrongPass | pat |
    | n0tR3al  | 3mptyP@a$$ | tiffany |


@GET
Scenario Outline: A valid user with an incorrect password requests the workspace directory of a non-existing user
  Given an invalid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP GET request is sent to "/session/workspaceDirForUser/<requestDirFor>"
  Then the response status code will be 401

  Examples:
    | username | password | requestDirFor |
    | admin | fakePass | batman |
    | suzy | wrongPass | $uperman! |
    | pat | 3mptyP@a$$ | w0nderw0man |
    | tiffany  | reallylongpasswordthatdoesnotwork | thor |


@GET
Scenario Outline: A valid user with the correct password requests the workspace directory of a non-existing user
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP GET request is sent to "/session/workspaceDirForUser/<requestDirFor>"
  Then the response responseText will be "/home/<requestDirFor>/workspace"
  And the response status code will be 200

  Examples:
    | username | password | requestDirFor |
    | admin | password | batman |
    | suzy | password | $uperman |
    | pat | password | w0nderw0man |
    | tiffany  | password | thor |


@GET
Scenario Outline: A valid user with an incorrect password requests the workspace directory of an existing user
  Given an invalid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP GET request is sent to "/session/workspaceDirForUser/<requestDirFor>"
  Then the response status code will be 401

  Examples:
    | username | password | requestDirFor |
    | admin | fakePass | tiffany |
    | suzy | wrongPass | pat |
    | pat | 3mptyP@a$$ | suzy |
    | tiffany | reallylongpasswordthatdoesnotwork | admin |


@GET
Scenario Outline: A valid user with the correct password requests the workspace directory of an existing user
  Given a valid encode for the Basic HTTP Authorization Request Header using <username> and <password>
  When a HTTP GET request is sent to "/session/workspaceDirForUser/<requestDirFor>"
  Then the response responseText will be "/home/<requestDirFor>/workspace"
  And the response status code will be 200

  Examples:
    | username | password | requestDirFor |
    | admin | password | tiffany |
    | suzy | password | pat |
    | pat | password | suzy |
    | tiffany  | password | admin |
