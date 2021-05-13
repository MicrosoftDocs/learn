Performance and operational issues are common in real-world environments. To analyze, evaluate, and remediate such issues affecting AD DS domain controller is a fundamental skill of any IT professional responsible for ensuring stability and availability of an AD DS environment.

## Monitor AD DS operational status

Insufficient system resources can lead to poor domain controller system performance. The four key system resources are the central processing unit (CPU), disk subsystem, memory, and network. Identifying and remediating bottlenecks involves close examination of system logs and performance counters to determine which resource is currently constrained. After augmenting that resource, performance will improve, but it might reach a plateau if it hits a new bottleneck in another system resource.

You can use several tools in Windows Server for various types of monitoring. Most of these tools are available by default as Windows Server components, and you can use them for real-time and historical monitoring of AD DS and other services. The most commonly used tools are Task Manager, Resource Monitor, Event Viewer, and Performance Monitor. With Performance Monitor, you can review current performance statistics or historical data gathered by using data collector sets.

There are many counters that you can review and analyze to address your specific requirements, including processor-, memory-, disk-, and network-specific counters. On a domain controller, you also should monitor NT Directory Service (NTDS) object counters.

- Security System-Wide Statistics\\Kerberos Authentications/sec. This counter tracks the number of Kerberos authentications per second.
- Security System-Wide Statistics\\NTLM Authentications. This counter tracks the number of Windows Network LAN Manager (NTLM) authentications processed per second.

If you use System Center Operations Manager in your environment, you also have the option to deploy the Active Directory Domain Services Management Pack for Operations Manager to monitor and analyze operations of your domain controllers. This management pack contains many alerts, views, tasks, and reports for a variety of AD DS functions.

## Tools for monitoring and troubleshooting replication

In any AD DS domain environment containing multiple domain controllers, it is essential to monitor AD DS replication and, in case of any issues, troubleshoot and resolve them. Performance monitor allows you to capture and analyze Directory Replication Agent (DRA) counters, including:

- NTDS\\DRA Inbound Bytes Total/sec. This counter depicts the total number of bytes replicated into the AD DS database.
- NTDS\\DRA Inbound Object. This counter depicts the number of Active Directory objects received from neighbors through inbound replication.
- NTDS\\DRA Outbound Bytes Total/sec. This counter depicts the total number of bytes replicated out.
- NTDS\\DRA Pending Replication Synchronizations. This is the number of directory synchronizations that are in this server's queue, waiting for processing.

Two additional tools are particularly useful for reporting and analyzing replication: the Replication Diagnostics Tool (Repadmin.exe) and the Domain Controller Diagnostics Tool (Dcdiag.exe).

### Repadmin.exe

Repadmin.exe is a command-line tool that enables you to report the status of replication on each domain controller. The information that Repadmin.exe produces can help you spot a potential replication problem in the forest. You can review levels of detail down to the replication metadata for specific objects and attributes, enabling you to identify where and when a problematic change was made to AD DS. You can even use Repadmin.exe to manage the replication topology and force replication between domain controllers.

Repadmin.exe supports several commands that perform specific tasks. You can learn about each command by running `repadmin /?` from the Command Prompt. Most commands take a DC_LIST parameter, which is simply a network label (DNS, NetBIOS name, or IP address) of a domain controller. Some of the replication monitoring tasks that you can perform by using Repadmin.exe include:

- Displaying the replication partners for a domain controller. To display the replication connections of a domain controller, enter `repadmin /showrepl DC_LIST . By default, Repadmin.exe lists intersite connections only. Add the /repsto argument also to list intersite connections.
- Displaying connection objects for a domain controller. Enter `repadmin /showconn DC_LIST` to list the connection objects for a domain controller.
- Displaying metadata about an object, its attributes, and replication. You can learn much about replication by examining an object on two different domain controllers to find out which attributes have or haven't replicated. Enter `repadmin /showobjmeta DC_LIST Object`, where DC_LIST indicates the domain controller or controllers to query. You can use an asterisk to indicate all domain controllers. The Object represents the GUID of an object, which is its unique identifier.

### Dcdiag.exe

Dcdiag.exe performs several tests and reports on the overall health of replication and operational status for AD DS. Run by itself, Dcdiag.exe performs summary tests and then reports the results. At the other extreme, Dcdiag.exe /c runs a comprehensive list of tests. You can redirect the output to files of various types, including XML. You also can specify one or more tests to perform by using the `/test:Test Name` parameter. Tests that relate directly to replication include:

- DFSREvent. Reports any operation errors in the Distributed File System (DFS).
- Intersite. Checks for failures that would prevent or delay intersite replication.
- KccEvent. Identifies errors in the Knowledge Consistency Checker.
- Replications. Checks for timely replication between domain controllers.
- Topology. Checks that the replication topology is connected fully for all domain controllers.
- VerifyReplicas. Verifies that all application directory partitions are instantiated fully on all domain controllers that host replicas.

### Monitoring replication with Microsoft System Center Operations Manager

Active Directory Domain Services Management Pack for Operations Manager includes replication monitoring functionality that collects AD DS replication alerts along with performance data representing replication latency, and the volume of both inbound and outbound replication traffic. The management pack offers replication topology dashboards that display site links, connection objects and broken connection objects. It also allows you to generate reports on replication connection objects, replication site links, replication bandwidth, and replication latency.

### Windows PowerShell AD DS replication cmdlets

Windows Server supports Windows PowerShell cmdlets that facilitate monitoring AD DS replication and reviewing its configuration. The following list describes some of them.

- ```Get-ADReplicationConnection```. Provides a specific AD DS replication connection or a set of AD DS replication connection objects based on a specified filter
- ```Get-ADReplicationFailure```. Provides a description of an AD DS replication failure
- ```Get-ADReplicationPartnerMetadata```. Provides replication metadata for a set of one or more replication partners
- ```Get-ADReplicationSite```. Provides a specific AD DS replication site or a set of replication site objects based on a specified filter
- ```Get-ADReplicationSiteLink```. Provides a specific Active Directory site link or a set of site links based on a specified filter
- ```Get-ADReplicationSiteLinkBridge```. Provides a specific Active Directory site link bridge or a set of site link bridge objects based on a specified filter
- ```Get-ADReplicationSubnet```. Provides an Active Directory subnet or a set of Active Directory subnets based on a specified filter.
