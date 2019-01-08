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

Scenario Outline: The user calls the web service to register a slave with the master Carte server.
	Given the slave <name> has not yet been registered with the server
	And the syntax is valid
	When the user calls the web service
	And the name field is set to <name>
	And the hostname field is set to <hostname>
	And the port field is set to <port>
	And the username field is set to <username>
	And the password field is set to <password>
	And the active field is set to <active>
	And the proxy_hostname field is set to <proxy_hostname>
	And the proxy_port field is set to <proxy_port>
	And the non_proxy_hosts field is set to <non_proxy_hosts>
	And the webAppName field is set to <webAppName>
	And the sslMode field is set to <sslMode>
	Then the status code is 200
	And the slave is registered with the server
Examples:
	| name | hostname | port | username | password | active | sslMode | master | proxy_hostname | proxy_port | non_proxy_hosts | webAppName |
	| Slave1 | 127.0.0.1 | 7071 | admin | password | Y | Y | N | null | null | null | null |
	| Slave 2 | 127.0.0.1 | 7072 | Admin2 | !@#$%^&amp;*()_-=+;:&#39;&quot;?&lt;&gt;,.`~[]{}| | N | Y | N | null | null | null | null |
	| Slave3 | 127.0.0.1 | 7073 | admin | P@ssword1 | Y | Y | N | null | null | null | null |
	| !@#$%^&amp;*()_-=+;:&#39;&quot;?&lt;&gt;,.`~[]{}|/\ | 127.0.0.1 | 7074 | admin | password | Y | Y | N | null | null | null | null |
	| Slave4 | 127.0.0.1 | 7074 | admin | password | Y | Y | N | null | null | null | null |
	| Slave5 | 127.0.0.1 | 7075 | admin | password | N | Y | N | null | null | null | null |
	| Slave6 | 127.0.0.1 | 7076 | admin | password | N | Y | N | null | null | null | null |
	| Slave7 | 127.0.0.1 | 7077 | admin | password | Y | N | N | null | null | null | null |
	| Slave8 | 127.0.0.1 | 7078 | admin | password | Y | N | N | 10.10.10.10 | 6060 | null | null |
	| Slave9 | 127.0.0.1 | 7079 | admin | password | Y | N | N | null | null | Non Proxy Host 5 | null |
	| Slave10 | 127.0.0.1 | 7080 | admin | password | Y | N | N | null | null | !@#$%^&amp;*()_-=+;:&#39;&quot;?&lt;&gt;,.`~[]{}|/\ | null |
	| Slave11 | 127.0.0.1 | 7081 | admin | password | Y | Y | N | null | null | null | Pent@h0 |
	| Slave12 | 127.0.0.1 | 7082 | admin | password | Y | Y | N | null | null | null | !@#$%^&amp;*()_-=+;:&#39;&quot;?&lt;&gt;,.`~[]{}|/\ |
	| Slave13 | 127.0.0.1 | 0 | admin | password | Y | Y | N | null | null | null | null |
	| Slave14 | 127.0.0.1 | 65535 | admin | password | Y | Y | N | null | null | null | null |
	| Slave15 | 127.0.0.1 | 7083 | admin | password | Y | Y | Y | null | null | null | null |
	| Slave16 | 127.0.0.1 | 7084 | admin | password | N | Y | Y | null | null | null | null |
	| Slave17 | 127.0.0.1 | 7085 | admin | password | N | N | Y | null | null | null | null |
	| s | 127.0.0.1 | 7085 | admin | password | N | N | Y | null | null | null | null |
	| Slave18 | 1.1.1.2 | 7086 | a | password | N | N | Y | null | null | null | null |
	| Slave19 | 1.1.1.3 | 7086 | admin | p | N | N | Y | null | null | null | null |
	| Slave20 | 1.1.1.3 | 7086 | admin | password | N | N | Y | 1.1.1.1 | 6060 | null | null |
	| Slave21 | 1.1.1.4 | 7086 | admin | password | N | N | Y | 1.1.1.1 | 0 | null | null |
	| Slave22 | 1.1.1.5 | 7086 | admin | password | N | N | Y | 1.1.1.1 | 65535 | null | null |
	| Slave23 | 1.1.1.6 | 7086 | admin | password | N | N | Y | null | null | a | null |
	| Slave24 | 1.1.1.7 | 7086 | admin | password | N | N | Y | null | null | null | a |
	
Scenario Outline: The user calls the web service to register a slave with the master Carte server, but does not use the master, active, sslMode, proxy_hostname, proxy_port, and non_proxy_hosts parameters.
	Given the slave <name> has not yet been registered with the server
	And the syntax is valid
	When the user calls the web service
	But the master field is not present
	And the active field is not present
	And the sslMode field is not present
	And the proxy_hostname field is not present
	And the proxy_port field is not present
	And the non_proxy_hosts field is not present
	Then the status code is 200
	And the value of master is "N" for the newly registered slave
	And the value of active is "N" for the newly registered slave
	And the value of sslMode is "Y" for the newly registered slave
	And the value of proxy_hostname is "" for the newly registered slave
	And the value of proxy_port is "" for the newly registered slave
	And the value of non_proxy_hosts is "" for the newly registered slave
	
Scenario Outline: The user calls the web service to register a slave with the master Carte server, but the slave <name> already exists.
	Given all parameter values are different from the existing slave's values except for <name>
	And the slave <name> is already registered with the server
	And the syntax is valid
	When the user calls the web service
	And the name field is set to <name>
	And the hostname field is set to <hostname>
	And the port field is set to <port>
	And the username field is set to <username>
	And the password field is set to <password>
	And the active field is set to <active>
	And the proxy_hostname field is set to <proxy_hostname>
	And the proxy_port field is set to <proxy_port>
	And the non_proxy_hosts field is set to <non_proxy_hosts>
	And the sslMode field is set to <sslMode>
	Then the status code is 200
	And all parameter values have been updated for the registered slave
Examples:
	| name | hostname | port | username | password | active | sslMode | master | proxy_hostname | proxy_port | non_proxy_hosts |
	| Slave1 | localhost | 5071 | administrator | MyP@ssw0rd | N | N | N | 20.20.20.20 | 6070 | Updated Non Proxy Host 4 |
	| Slave 2 | localhost | 5072 | administrator | MyP@ssw0rd | Y | N | N | 20.20.20.20 | 6070 | Updated Non Proxy Host 4 |
	| Slave7 | localhost | 5077 | administrator | MyP@ssw0rd | N | Y | N | 20.20.20.20 | 6070 | Updated Non Proxy Host 4 |
	| Slave14 | 127.0.0.1 | 65535 | admin | password | Y | Y | Y | null | null | null | null |
	| Slave15 | 127.0.0.1 | 7083 | admin | password | Y | Y | N | null | null | null | null |
	
Scenario: The user calls the web service to register a slave with the master Carte server using malformed XML.
	Given the syntax is invalid
	When the user calls the web service
	Then the status code is 400
	And the response body indicates that the XML syntax is invalid
	
Scenario: The user calls the web service to register a slave with the master Carte server without specifying a value for the required field <paramName>
	Given The syntax is valid
	When the user calls the web service
	Then the status code is 400
	And the response body indicates that <paramName> must be specified
Examples:
	| paramName |
	| name |
	| hostname |
	| port |
	| username |
	| password |
	
Scenario Outline: The user calls the web service to register a slave with the master Carte server, but uses the invalid value <port> for the port parameter.
	Given the syntax is valid
	When the user calls the web service
	Then the status code is 400
	And the response body indicates that the port is invalid
Examples:
	| port |
	| -1 |
	| 65536 |
	| myPort |
	| 7O7O |
	| 7070! |
	
Scenario Outline: The user calls the web service to register a slave with the master Carte server, but uses the invalid value <proxy_port> for the proxy_port parameter.
	Given the syntax is valid
	When the user calls the web service
	Then the status code is 400
	And the response body indicates that the proxy_port is invalid
Examples:
	| proxy_port |
	| -1 |
	| 65536 |
	| myPort |
	| 7O7O |
	| 7070! |
	
Scenario Outline: The user calls the web service to register a slave with the master Carte server, but uses the invalid value <master> for the master parameter.
	Given the syntax is valid
	When the user calls the web service
	Then the status code is 400
	And the response body indicates that the value for master is invalid
Examples:
	| master |
	| 0 |
	| 1 |
	| @ |
	| Yes |
	| No |
	| A |
	| asdf |
	
Scenario Outline: The user calls the web service to register a slave with the master Carte server, but uses the invalid value <active> for the active parameter.
	Given the syntax is valid
	When the user calls the web service
	Then the status code is 400
	And the response body indicates that the value for active is invalid
Examples:
	| active |
	| 0 |
	| 1 |
	| @ |
	| Yes |
	| No |
	| A |
	| asdf |
	
Scenario Outline: The user calls the web service to register a slave with the master Carte server, but uses the invalid value <sslMode> for the sslMode parameter.
	Given the syntax is valid
	When the user calls the web service
	Then the status code is 400
	And the response body indicates that the value for sslMode is invalid
Examples:
	| sslMode |
	| 0 |
	| 1 |
	| @ |
	| Yes |
	| No |
	| A |
	| asdf |
	
Scenario: The anonymous user calls the web service to register a slave with the master Carte server
	Given the syntax is valid
	And the XML contains valid values
	When the anonymous user calls the web service
	Then the status code is 401
	And the slave is not registered