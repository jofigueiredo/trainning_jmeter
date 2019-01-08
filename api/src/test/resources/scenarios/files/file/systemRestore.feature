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

# POST Method
Scenario: The admin user calls the web service to restore the system.
	Given the "home/admin/testFile.txt" file was backed up and no longer exists
	And the schedule "testSchedule" was backed up and no longer exists
	And the user "testUser" was backed up and no longer exists
	And the role "testRole" was backed up and no longer exists
	And the user "testUser" was assigned to the role "testRole" at the time of the backup
	And the data source "testDataSource" was backed up and no longer exists
	And the file "home/admin/ModifiedFile.txt" was hidden at the time of the backup
	But the file "home/admin/ModifiedFile.txt" is now not hidden
	When the user calls the web service while excluding the overwrite parameter
	Then the status code is 200
	And "home/admin/testFile.txt" is restored
	And the schedule "testSchedule" is restored
	And the user "testUser" is restored
	And the role "testRole" is restored
	And the user "testUser" is assigned to the role "testRole"
	And the data source "testDataSource" is restored
	And the file "home/admin/ModifiedFile.txt" is hidden
	
Scenario: the admin user calls the web service to restore the system without overwriting existing content.
	Given the file "home/admin/testFile.txt" was hidden at the time of backup
	And the file "home/admin/testFile.txt" is no longer hidden
	And the schedule "testSchedule" had the output location set to "/public/reports" at the time of the backup
	And the schedule "testSchedule" now has the output location set to "/home/admin"
	And the user "testUser" was assigned to the roles "Business Analyst" and "Power User" at the time of the backup
	And the user "testUser" is now only assigned to the role "Business Analyst"
	And the role "ReportAuthor" had the "ReportUser" and "ReportUser2" users assigned to it at the time of the backup
	And the role "ReportAuthor" now only has "ReportUser" assigned to it
	And the XMI file of the data source "testDataSource" contained "SELECT * FROM CUSTOMERS" at the time of the backup
	And the XMI file of the data source "testDataSource" now contains "SELECT * FROM ORDERS"
	When the user calls the web service with the overwrite parameter's value set to "false"
	Then the status code is 200
	And the file "home/admin/testFile.txt" is not hidden
	And the schedule "testSchedule" has the output location set to "/home/admin"
	And the user "testUser" is only assigned to the role "Business Analyst"
	And the role "ReportAuthor" only has "ReportUser" assigned to it
	And the XMI file of the data source "testDataSource" contains "SELECT * FROM ORDERS"
	
Scenario: The admin user calls the web service to restore the system, but excludes the fileUpload parameter
	Given the fileUpload parameter is excluded
	When the user calls the web service
	Then the status code is 400

# The following test scenario was created out of an assumption that an invalid backup file should prevent an attempt to restore the system.
Scenario: The admin user calls the web service to restore the system, but the fileUpload parameter contains an invalid file
	Given the file within the fileUpload parameter is not a valid backup file
	When the user calls the web service
	Then the status code is 400
	
Scenario: The suzy user calls the web service to restore the system
	Given the suzy user is not an administrator
	When the user calls the web service
	Then the status code if 403
	
Scenario: The anonymous user calls the web service to restore the system
	Given all parameters and their values are valid
	When the anonymous user calls the web service
	Then the status code is 401