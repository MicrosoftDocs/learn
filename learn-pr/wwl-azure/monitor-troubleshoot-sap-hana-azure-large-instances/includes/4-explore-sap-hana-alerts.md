As a first step, check the current SAP HANA alert logs. In SAP HANA Studio, navigate to **Administration Console** &gt; **Alerts** &gt; **Show: all alerts**. This interface will show all SAP HANA alerts for specific values (free physical memory, CPU utilization, etc.) that fall outside of the set minimum and maximum thresholds. By default, checks are auto-refreshed every 15 minutes.

For an alert triggered due to improper threshold setting, a resolution is to reset to the default value or a more reasonable threshold value.

> [!NOTE]
> For detailed troubleshooting steps for any of the following, refer to the [SAP HANA 2.0 Troubleshooting and Performance Analysis Guide](https://help.sap.com/saphelp_hanaplatform/helpdata/en/4f/bc915462db406aa2fe92b708b95189/content.htm).

## CPU

The following alerts may indicate CPU resource problems:

 -  Host CPU Usage (Alert 5)
 -  Most recent savepoint operation (Alert 28)
 -  Savepoint duration (Alert 54)

You may notice high CPU consumption on your SAP HANA database from one of the following:

 -  Alert 5 (Host CPU usage) is raised for current or past CPU usage
 -  The displayed CPU usage on the overview screen

The Load graph might show high CPU consumption or high consumption in the past.

An alert triggered due to high CPU utilization could be caused by several events, including, but not limited to: execution of certain transactions, data loading, jobs that are not responding, long-running SQL statements, and bad query performance (for example, with BW on HANA cubes).

## Operating system

One of the most important checks for SAP HANA on Linux is to make sure that Transparent Huge Pages are disabled, see [SAP Note \#2131662](https://launchpad.support.sap.com/#/notes/2131662).

You can check if Transparent Huge Pages are enabled through the following Linux command: `cat /sys/kernel/mm/transparent_hugepage/enabled`

 -  If **always** is enclosed in brackets, it means that the Transparent Huge Pages are enabled: `[always] madvise never;`
 -  If **never** is enclosed in brackets, it means that the Transparent Huge Pages are disabled: `always madvise [never]`

The following Linux command should return nothing: `rpm -qa | grep ulimit`. If it turns out that ulimit is installed, uninstall it immediately.

## Memory

You may observe that the amount of memory allocated by the SAP HANA database is higher than expected. The following alerts indicate issues with high memory usage:

 -  Host physical memory usage (Alert 1)
 -  Memory usage of name server (Alert 12)
 -  Total memory usage of Column Store tables (Alert 40)
 -  Memory usage of services (Alert 43)
 -  Memory usage of main storage of Column Store tables (Alert 45)
 -  Runtime dump files (Alert 46)

## Network<br>

Refer to [SAP Note \#2081065](https://launchpad.support.sap.com/#/notes/2081065) and perform the network troubleshooting steps in this SAP Note.

 -  Analyze round-trip time between server and client. Run the SQL script `HANA_Network_Clients`.
 -  Analyze internode communication. Run the SQL script `HANA_Network_Services`.
 -  Run Linux command `ifconfig`(the output shows if any packet losses are occurring).
 -  Run Linux command `tcpdump`.

Also, use the open-source IPERF tool (or similar) to measure real application network performance.

[SAP Note \#2081065](https://launchpad.support.sap.com/#/notes/2081065) offers a number of SAP HANA network troubleshooting procedures that help you determine the extent to which network latency contributes to performance degradation in an SAP landscape by analyzing the round trip time (RTT) between server and client as well as internode communication.

## Storage<br>

From an end-user perspective, an application (or the system as a whole) runs sluggishly, is unresponsive, or even seems to stop responding if there are issues with I/O performance. In the Volumes tab in SAP HANA Studio, you can see the attached volumes, and what volumes are used by each service.
