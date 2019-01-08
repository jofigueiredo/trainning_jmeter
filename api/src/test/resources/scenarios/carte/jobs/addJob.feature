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

Scenario Outline: The user calls the web service to upload a job to Carte server with the parameter <paramName> having the value <paramValue>.
	Given the job is valid
	When the user calls the web service
	And the parameter <paramName> is set with the value <paramValue>
	Then the status code is 200
	And the job is present on Carte server
	And the response indicates a success in <responseFormat> format
Examples:
	| paramName | <paramValue> | responseFormat |
	| xml | N | HTML |
	| xml | Y | XML |
	| null | null | HTML |
	
Scenario: The user calls the web service to upload a job that is identical to one that is already present  on Carte server.
	Given the job is valid
	And an identical job is already present on Carte server
	When the user calls the web service
	Then the status code is 200
	And the new job is present on Carte server with the same name as the original
	And the new job is present on Carte server with a different id
	
Scenario: The user calls the web service to upload a job that contains HTML injection that displays an image for the job name.
	Given the job is valid
	When the user calls the web service with the request body containing the following name for the job name:
	"""
	&lt;img src=&#39;http://www.pentaho.com/sites/all/themes/pentaho_resp/hlogo.gif&#39;/&gt;
	"""
	Then the status code is 200
	And job name is displayed as the following:
	"""
	&lt;img src=&#39;http://www.pentaho.com/sites/all/themes/pentaho_resp/hlogo.gif&#39;/&gt;
	"""
		
Scenario: The user calls the web service to upload a job where the name contains HTML injection that redirects to a different page.
	Given the job is valid
	When the user calls the web service with the request body containing the following name for the job name:
	"""
	&lt;html&gt;&lt;head&gt;&lt;meta http-equiv=&#34;refresh&#34; content=&#34;0; url=http://www.pentaho.com&#34; /&gt;&lt;/head&gt;&lt;/html&gt;
	"""
	Then the status code is 200
	And job name is displayed as the following:
	"""
	&lt;html&gt;&lt;head&gt;&lt;meta http-equiv=&#34;refresh&#34; content=&#34;0; url=http://www.pentaho.com&#34; /&gt;&lt;/head&gt;&lt;/html&gt;
	"""
	
Scenario: The user calls the web service to upload a job with malformed syntax to Carte server.
	Given the job's syntax is malformed
	When the user calls the web service
	Then the status code is 400
	And the job is not uploaded
	
# Note: this test is to make sure that this endpoint does not allow uploading jobs.
Scenario: The user calls the web service to upload a transformation instead of a job.
	Given the transformation's syntax is valid
	When the user calls the web service
	Then the status code is 400
	And the transformation is not uploaded
	
Scenario: The user calls the web service using the following valid XML syntax that is unrelated to a Kettle file (transformation or job): <test></test>
	When the user calls the web service
	Then the status code is 400
	And the XML is not uploaded 
	
Scenario: The anonymous user calls the web service to upload a job to Carte server.
	Given the job is valid
	When the anonymous user calls the web service
	Then the status code is 401
	And the job is not uploaded