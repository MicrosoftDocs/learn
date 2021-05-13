As part of the investigation or response process, you can collect an investigation package from a device. By collecting the investigation package, you can identify the current state of the device and further understand the tools and techniques used by the attacker.

To download the package (Zip file) and investigate the events that occurred on a device

- Select Collect investigation package from the row of response actions at the top of the device page.

- Specify in the text box why you want to do this action. Select Confirm.

- The zip file will download

Alternate way:

- Select Action center from the response actions section of the device page.

- In the Action center fly-out, select Package collection package available to download the zip file.

The package contains the following folders:

## Autoruns

Contains set of files that each represent the content of the registry of a known auto start entry point (ASEP) to help identify attacker’s persistency on the device.  If the registry key is not found, the file will contain the following message: “ERROR: The system was unable to find the specified registry key or value.”

## Installed programs

This .CSV file contains the list of installed programs that can help identify what is currently installed on the device. For more information, see Win32_Product class.

## Network connections

This folder contains a set of data points related to the connectivity information, which can help identify connectivity to suspicious URLs, attacker’s command and control (C&C) infrastructure, any lateral movement, or remote connections.

- ActiveNetConnections.txt – Displays protocol statistics and current TCP/IP network connections. It provides the ability to look for suspicious connectivity made by a process.

- Arp.txt – Displays the current address resolution protocol (ARP) cache tables for all interfaces.

- ARP cache can reveal other hosts on a network that have been compromised or suspicious systems on the network that might have been used to run an internal attack.

- DnsCache.txt - Displays the contents of the DNS client resolver cache, which includes both entries preloaded from the local Hosts file and any recently obtained resource records for name queries resolved by the computer. This can help in identifying suspicious connections.

- IpConfig.txt – Displays the full TCP/IP configuration for all adapters. Adapters can represent physical interfaces, such as installed network adapters, or logical interfaces, such as dial-up connections.

- FirewallExecutionLog.txt and pfirewall.log

## Prefetch files

Windows Prefetch files are designed to speed up the application startup process. It can be used to track all the files recently used in the system and find traces for applications that might have been deleted but can still be found in the prefetch file list.

- Prefetch folder – Contains a copy of the prefetch files from %SystemRoot%\Prefetch. It is suggested to download a prefetch file viewer to view the prefetch files.

- PrefetchFilesList.txt – Contains the list of all the copied files that can be used to track if there were any copy failures to the prefetch folder.

## Processes

Contains a .CSV file listing the running processes, which provide the ability to identify current processes running on the device. This can be useful when identifying a suspicious process and its state.

## Scheduled tasks

Contains a .CSV file listing the scheduled tasks, which can be used to identify routines performed automatically on a chosen device to look for suspicious code that was set to run automatically.

## Security event log

Contains the security event log, which contains records of login or logout activity or other security-related events specified by the system's audit policy.  You can open the event log file using the Event viewer.

## Services

Contains a .CSV file that lists services and their states.

## Windows Server Message Block (SMB) sessions

Lists shared access to files, printers, serial ports, and miscellaneous communications between nodes on a network. This can help identify data exfiltration or lateral movement. It also contains files for SMBInboundSessions and SMBOutboundSession.  If there are no sessions (inbound or outbound), you'll get a text file that tells you that there are no SMB sessions found.

## System information

Contains a SystemInformation.txt file that lists system information such as OS version and network cards.

## Temp directories

Contains a set of text files that lists the files located in %Temp% for every user in the system.  This can help to track suspicious files that an attacker may have dropped on the system.  If the file contains the following message: “The system cannot find the path specified”, it means that there is no temp directory for this user, and might be because the user didn’t sign in to the system.

## Users and groups

Provides a list of files that each represent a group and its members.

## WdSupportLogs

Provides the MpCmdRunLog.txt and MPSupportFiles.cab.

## CollectionSummaryReport.xls

This file is a summary of the investigation package collection, it contains the list of data points, the command used to extract the data, the execution status, and the error code if there is failure. You can use this report to track if the package includes all the expected data and identify if there were any errors.

