# Afiniti Custom Snmp Agent

What is SNMP?


Simple Network Management Protocol (SNMP) is a widely used protocol for monitoring the health and welfare of network equipment (eg. routers), computer equipment and even devices like UPSs. Net-SNMP is a suite of applications used to implement SNMP v1, SNMP v2c and SNMP v3 using both IPv4 and IPv6.

What is SNMP agent?

The SNMP Agent handles the SNMP network communication. When the agent receives a request from an SNMP manager, it checks the OID of the requested data object and if the OID is valid, the agent sends a response back to the SNMP manager. If the OID is not valid, the agent returns an error.


The scope of this project is the following:

- Set up SNMP on your operating system
- Create a custom MIB file
- Write Bash script for custom Oids
- Extend SNMP agent 
- Set up postgresql



<b>Set up SNMP:</b> 2 hour

Run Following commands in terminal.
>sudo apt-get update

>sudo apt-get install snmpd

<b>Create a MIB file:</b> 1 hour

What is a MIB file?\
A management information base (MIB) is a formal description of a set of network objects that can be managed using the Simple Network Management Protocol (SNMP). The format of the MIB is defined as part of the SNMP. 

The MIB tree helps define the OID by forming hierarchical structure.

The following MIB tree design is followed by this program.

- OidInfo
- - OidIndex
- - - Version .1.3.6.1.4.1.53864.1.1
- - - Data-Usage-folder .1.3.6.1.4.1.53864.1.2
- - - POSTgre-query .1.3.6.1.4.1.53864.1.3

The Oid for respective end nodes can be found using:

>snmptranslate -m +AFINITI-TASK_OID -IR -On Version

>snmptranslate -m +AFINITI-TASK-OID -IR -On Data-Usage-folder

>snmptranslate -m +AFINITI-TASK-OID -IR -On POSTgre-query

The enterprises is set to 53864

<b>Writing bash script:</b> 2 hours

The three bash scripts would be written as per requirements. The code is attached. 

<b>Extend SNMP Agent:</b> 3 hours

This part includes editing 'snmpd.conf' file according the requirements.

Three major edits are:

>AGENT BEHAVIOUR

>agentAddress udp:127.0.0.1:161

defines a list of listening addresses, on which to receive incoming SNMP requests. The requests in this program would generate from localhost.


> ACCESS CONTROL

> rocommunity public default

snmpd supports the View-Based Access Control Model (VACM) as defined in RFC 2575, to control who can retrieve or update information. The access is set public in our scope.

>EXTENDING SNMP AGENT

>OID to find version 

>extend .1.3.6.1.4.1.53864.1.1 /bin/bash /home/mahad_bajwa/Afinititask/Version

>OID to query postgresql table 'SNMPsignls'

>extend .1.3.6.1.4.1.53864.1.3 /bin/bash /home/mahad_bajwa/Afinititask/postGreQuery

>#OID to find disk space

>extend .1.3.6.1.4.1.53864.1.2 /bin/bash /home/mahad_bajwa/Afinititask/DiskUsage


The three extensions are made to integrate the bash scripts associated with each OID.

<b> Setting up Postgresql:</b> 2 hours

Following tutorial was used:

https://www.digitalocean.com/community/tutorials/how-to-create-remove-manage-tables-in-postgresql-on-a-cloud-server

# Qualitative Attributes:

The System has the following attributes:

<b>Scalibility:</b>

The new bash scripts can be developed for more functionalities. The mib file can accomodate more nodes, the snmpd.conf can be used to extend the agent and scale the system as per requirements.


<b> Robustness </b>

The system would run error prone, if oid is correctly put.




# Testing and running application:

After all things are set, you can send request and get response on oid.

PostgreSql Query:
>snmpget -v 2c -c public 127.0.0.1 SNMPv2-SMI::enterprises.53864.1.3.3.1.2.9.47.98.105.110.47.98.97.115.104

Version:
>snmpget -v 2c -c public 127.0.0.1   SNMPv2-SMI::enterprises.53864.1.2.3.1.1.9.47.98.105.110.47.98.97.115.104

Disk Usage:
>snmpget -v 2c -c public 127.0.0.1  SNMPv2-SMI::enterprises.53864.1.1.3.1.2.9.47.98.105.110.47.98.97.115.104

The output can be achieved using snmpwalk command as well. Any error can be displayed in terminal.


# Other Approaches:

The Following ways, the program could have been more dynamic and efficient:

- The Agent could listen from remote IP deployed on a server, like Nagios. This would require getting a cloud based linux server. 
- The functionalities can be extended if get, getNext and trap requests are enabled. This would enable dynamic behaviour of agents, the trap request can alert in case of any change in disk usage etc. 
- The mib2C framework was an alternate way to achieve this task, the skeleton template was made to implement extensible snmp agents but, the requirements of the system were primitive and they did not require complex solutions.


The time and resource constraint were the reasons to not extend the application scope. 

The Javascript and other languages solutions offered out of the box modules and they were not the best option for linux server. 

# Reference:

http://www.net-snmp.org/





