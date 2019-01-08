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

Scenario: An admin user creates a directory in the /home/admin directory
	Given The new directory does not exist
	When The user sends an HTTP PUT to /repo/dirs/{pathId}
	Then The returned status code is 200
	And The directory is created

Scenario: An admin user creates a directory outside the /home/admin directory
	Given The new directory does not exist
	When The user sends an HTTP PUT to /repo/dirs/{pathId}
	Then The returned status code is 200
	And The directory is created

Scenario: A non-admin user creates a directory in his/her home directory
	Given The new directory does not exist
	When The user sends an HTTP PUT to /repo/dirs/{pathId}
	Then The returned status code is 200
	And The directory is created

Scenario: A non-admin user attempts to create a directory outside his/her home directory
	Given The new directory does not exist
	When The user sends an HTTP PUT to /repo/dirs/{pathId}
	Then The returned status code is 403
	And The directory is not created

Scenario: A user attempts to create a directory that already exists
	Given The new directory already exists
	When The user sends an HTTP PUT to /repo/dirs/{pathId}
	Then The returned status code is 409
	And The error message couldNotCreateFolderDuplicate is returned.

Scenario: A user attempts to create a directory in a parent directory which does not exist
	Given The new directory does not exist
	And The parent directory does not exist
	When The user sends an HTTP PUT to /repo/dirs/{pathId}
	Then The returned status code is 200
	And The directory and parent directory is created

Scenario: The anonymous user creates a directory in the /home/admin directory
	When The anonymous user sends an HTTP PUT to /repo/dirs/{pathId}
	Then The returned status code is 401
	And The directory is not created

Scenario: An admin user creates a directory in the /home/admin directory with valid special characters
	Given The new directory does not exist
	When The user sends an HTTP PUT to /repo/dirs/{pathId} including valid special characters in the name
	Then The returned status code is 200
	And The directory is created

Scenario: An admin user creates a directory in the /home/admin directory with invalid special characters
	Given The new directory does not exist
	When The user sends an HTTP PUT to /repo/dirs/{pathId} including invalid special characters in the name
	Then The returned status code is 400
	And The directory is not created