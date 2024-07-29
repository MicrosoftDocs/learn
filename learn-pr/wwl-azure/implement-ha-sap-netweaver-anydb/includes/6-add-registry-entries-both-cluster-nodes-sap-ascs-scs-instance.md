Azure load balancer has an internal load balancer that closes connections when the connections are idle for a set period of time (an idle timeout). SAP work processes in dialog instances open connections to the SAP enqueue process as soon as the first enqueue/dequeue request needs to be sent. These connections usually remain established until the work process or the enqueue process restarts. However, if the connection is idle for a set period of time, the Azure internal load balancer closes the connections. While this isn't a problem because the SAP work process reestablishes the connection to the enqueue process if it no longer exists, these activities generate significant numbers of entries in developer traces of SAP processes. It's a good idea to change the TCP/IP KeepAliveTime and KeepAliveInterval on both cluster nodes. Combine these changes in the TCP/IP parameters with SAP profile parameters.

To add registry entries on both cluster nodes of the SAP ASCS/SCS instance, first add these Windows registry entries on both Windows cluster nodes for SAP ASCS/SCS:

| Path | Variable name | Variable type | Value | Documentation |
|--|--|--|--|--|
| HKLM\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters | KeepAliveTime | REG\_DWORD (Decimal) | 120000 | [KeepAliveTime](/previous-versions/windows/it-pro/windows-2000-server/cc957549%28v=technet.10%29) |
| HKLM\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters | KeepAliveInterval | REG\_DWORD (Decimal) | 120000 |[KeepAliveInterval](/previous-versions/windows/it-pro/windows-2000-server/cc957548%28v=technet.10%29) |

To apply the changes, restart both cluster nodes.
