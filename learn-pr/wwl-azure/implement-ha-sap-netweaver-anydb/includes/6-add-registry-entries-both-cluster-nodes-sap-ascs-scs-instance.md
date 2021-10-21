Azure load balancer has an internal load balancer that closes connections when the connections are idle for a set period of time (an idle timeout). SAP work processes in dialog instances open connections to the SAP enqueue process as soon as the first enqueue/dequeue request needs to be sent. These connections usually remain established until the work process or the enqueue process restarts. However, if the connection is idle for a set period of time, the Azure internal load balancer closes the connections. While this isn't a problem because the SAP work process reestablishes the connection to the enqueue process if it no longer exists, these activities generate significant number of entries in developer traces of SAP processes. It's a good idea to change the TCP/IP KeepAliveTime and KeepAliveInterval on both cluster nodes. Combine these changes in the TCP/IP parameters with SAP profile parameters.

To add registry entries on both cluster nodes of the SAP ASCS/SCS instance, first add these Windows registry entries on both Windows cluster nodes for SAP ASCS/SCS:

:::row:::
  :::column:::
    **Path**
  :::column-end:::
  :::column:::
    **Variable name**
  :::column-end:::
  :::column:::
    **Variable type**
  :::column-end:::
  :::column:::
    **Value**
  :::column-end:::
  :::column:::
    **Documentation**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HKLM\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters
  :::column-end:::
  :::column:::
    KeepAliveTime
  :::column-end:::
  :::column:::
    REG\_DWORD (Decimal)
  :::column-end:::
  :::column:::
    120000
  :::column-end:::
  :::column:::
    [KeepAliveTime](/previous-versions/windows/it-pro/windows-2000-server/cc957549%28v=technet.10%29)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HKLM\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters
  :::column-end:::
  :::column:::
    KeepAliveInterval
  :::column-end:::
  :::column:::
    REG\_DWORD (Decimal)
  :::column-end:::
  :::column:::
    120000
  :::column-end:::
  :::column:::
    [KeepAliveInterval](/previous-versions/windows/it-pro/windows-2000-server/cc957548%28v=technet.10%29)
  :::column-end:::
:::row-end:::


To apply the changes, restart both cluster nodes.
