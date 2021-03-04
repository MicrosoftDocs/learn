The DHCP Failover feature allows two DHCP servers to work together to provide IP address information to clients. The two DHCP servers replicate lease information between them. If one of the DHCP servers fails, the remaining DHCP server continues to use the scope information to provide IP addresses to clients.

> [!NOTE]
> You can configure only two DHCP servers in a failover relationship, and you can configure these only for IPv4 scopes.

## Configure DHCP Failover

To configure DHCP Failover, establish a failover relationship between the two DHCP servers and give the relationship a unique name. The failover partners exchange this name during configuration.

> [!TIP]
> This enables a single DHCP server to have multiple failover relationships with other DHCP servers, so long as they all have unique names.

To configure failover in the DHCP Management console, use the Configuration Failover Wizard, which you launch by accessing the context menu for the IPv4 node or the scope node.

:::image type="content" source="../media/m11-failover-1.png" alt-text="A screenshot of the Create a new failover relationship page in the Configure Failover wizard. The Mode is Load balance.":::

> [!NOTE]
> DHCP Failover is time sensitive. If the time difference between the partners is greater than one minute, the failover process halts with a critical error.

You can configure failover in one of the two modes described in the following table.

| Mode         | Characteristics                                              |
| ------------ | ------------------------------------------------------------ |
| Load balance | This is the default mode. In this mode, both servers supply IP configuration to clients simultaneously. Which server  responds to IP configuration requests depends on how the administrator configured the load distribution ratio. The default ratio is 50:50. |
| Hot standby | In this mode, one server is the primary server and the other is the secondary server. The primary server actively assigns IP configurations for the scope or subnet. The secondary DHCP server assumes this role only if the primary server becomes unavailable. A DHCP server can act simultaneously as the primary server for one scope or subnet, and the secondary server for another. Hot standby mode is best for deployments in which a disaster-recovery site is at a different location. This way the DHCP server won't service clients unless there is a main server outage.|

### Standby mode considerations

As an administrator, you must configure a percentage of the scope addresses to be assigned to the standby server. These addresses are supplied during the Maximum Client Lead Time (MCLT) interval if the primary server is down.

:::image type="content" source="../media/m11-failover-2.png" alt-text="A screenshot of the Create a new failover relationship page in the Configure Failover wizard. The Mode is Hot standby.":::

The default failover configuration reserves five percent of the scope addresses for the standby server. The secondary server takes control of the entire IP range after the MCLT interval has passed.

### MCLT

Configure the MCLT parameter to specify the amount of time that a DHCP server should wait when a partner is unavailable before it assumes control of the address range. The default value is one hour, and it can't be zero. If required, you can adjust the MCLT by using Windows PowerShell.

### Auto state switchover interval

A communication-interrupted state occurs when a server loses contact with its partner. Because the server has no way of knowing what is causing the communication loss, it remains in this state until the administrator manually changes it to a **partner down** state. You can enable automatic transition to **partner down** state by configuring the auto state switchover interval. The default value for this interval is 60 minutes.

### Message authentication

Windows Server enables you to authenticate the failover message traffic between the replication partners. The administrator can establish a shared secret—similar to a password—in the **Configuration Failover Wizard** for DHCP Failover. This validates that the failover message comes from the failover partner.

### Firewall considerations

DHCP uses TCP port 647 to listen for failover traffic. The DHCP installation creates the following inbound and outbound firewall rules:

- Microsoft-Windows-DHCP-Failover-TCP-In
- Microsoft-Windows-DHCP-Failover-TCP-Out
