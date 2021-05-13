As a Contoso Windows Server administrator, you should understand how to configure and implement Hyper-V Replica and ascertain replication health. You need to be able to perform failover as required.

## Configure and implement Hyper-V Replica

Hyper-V Replica is available as part of the Hyper-V role. You can use it on standalone Hyper-V servers or on servers that are part of a failover cluster, in which case you should configure Hyper-V Replica Broker. Hyper-V, and thus Hyper-V Replica, has no dependencies on AD DS, except when Hyper-V Replica servers are part of the same failover cluster.

To enable Hyper-V Replica, two steps needs to be completed as follows:

1. Enable a Hyper-V host to act as a replica server:
    1. In **Hyper-V Settings** on the host server, in the **Replication Configuration** group of options, select the **Enable this computer as a Replica server** check box.
    1. Configure the Hyper-V server settings:
        1. Select and configure the **Authentication and ports** options.
        1. Select and configure the **Authorization and storage** options.
            - It's possible to allow replication from any server that successfully authenticates (which is convenient when all servers are part of the same domain) or allow replication only from specified servers. You also must configure a location to store the replica files as part of this configuration setting.

1. Enable replication on each VM that needs to be replicated on the primary Hyper-V host:
    1. Select the VM you wish to replicate and choose **Enable Replication**.
    1. In the **Enable Replication for \<VM_Name\>** Wizard, specify the replica server.
    1. Specify the connection parameters such as **Authentication type**.
    1. Select the VHDs to replicate; you can choose more than one if needed.
    1. Select one **Replication Frequency** option:
        - **30 seconds**
        - **5 minutes** (the default value)
        - **15 minutes**
    1. Configure the recovery points to **Maintain only the latest recovery point** or **Create additional hourly recovery points**.
    1. Select an initial replication method. Options include:
        - **Send initial copy over the network**
        - **Send initial copy using external media**
        - **Start replication immediately**
        - **Schedule replication on**
    1. After configuring these options, start replication.
    1. After you establish the replication relationship, the **Status** column in Hyper-V Manager displays the replication progress as a percentage of the total replication for the configured VM. The VM replica is in a turned-off state and will start only when you perform a failover.
    1. When the initial replication is complete, the replica updates regularly with changes from the primary VM.

### Manage Hyper-V Replica by using Windows PowerShell

You can also manage Hyper-V Replica by using Windows PowerShell. To obtain the list of available Windows PowerShell cmdlets, run the following command:

```powershell
Get-command *replication* -Module Hyper-V
```

### Failover TCP/IP

Failover TCP/IP is a feature that you can use to control the static IP address and other TCP/IP network settings that a VM uses when started as part of a failover.

There might be connectivity issues encountered after failover occurs if all the following occur:

- Failover TCP/IP isn't configured.
- The primary VM has a static IP address assigned.
- The replica VM is using IP settings different from the primary VM.

When replication is enabled, the Failover TCP/IP option appears as an additional configuration option in the **Hyper-V Settings** for both the primary and replica VM. It's available only for network adapters and not for legacy network adapters. Integration services need to be installed to be able to apply failover TCP/IP settings.

> [!NOTE]
> Replica VMs configured with a static IP address should be configured to use a different IP address from their primary VM counterpart in the event of failover.

### Replication health monitoring

When you enable replication for a VM, changes in the primary VM write to a log file that periodically transfers to the replica server and is then applied to a replica VM's VHD.

Replication health includes the following data:

- **Replication State**, which indicates whether replication is enabled for a VM.
- **Replication Mode**, which is either **Primary** or **Replica**.
- **Current Primary Server**, which is the server name.
- **Current Replica Server**, which is the server name.
- **Replication Health**, which indicates replication status. Replication Health can have one of three values:
  - **Normal**
  - **Warning**
  - **Critical**
- **Statistics**, which include data such as the following:
  - **From time**
  - **To time**
  - **Average size**
  - **Maximum size**
  - **Average latency**
  - **Errors encountered**
  - **Last synchronized at**
  - **Successful replication cycles**
- **Pending replication**, which displays information about the size of data that still needs to replicate and when the replica was last synced with the primary VM.

You can test the replication connection by using the following Windows PowerShell command:

```Powershell
Test-VMReplicationConnection -ReplicaServerName server01.domain01.contoso.com -ReplicaServerPort 80 -AuthenticationType Kerberos
```

You can get the status for all the VMs on the primary server by running the following Windows PowerShell command:

```Powershell
Get-VMReplication
```

### Failover options

Three types of failover are possible with Hyper-V Replica: Test Failover, Planned Failover, and Failover.

#### Test Failover

Test Failover is a non-disruptive task that enables you to test a VM on a replica server while the primary VM is running without interrupting the replication. You can only initiate it on the replica server on the replicated VM. Initiating a Test Failover on a replicated VM creates a new checkpoint, and you can use this checkpoint to select a recovery point from which to create a new test VM. This test VM has the same name as the replica, but with `- Test` appended to the end. The test VM stays disconnected by default to avoid potential conflicts with the running primary VM.

#### Planned Failover

You can start a Planned Failover to move the primary VM to a replica server, for example, before site maintenance or before an expected disaster. No data loss occurs, but the VM is unavailable for some time during startup. It can only be initiated from the primary site.

After the Planned Failover, the VM will run on the replica server, and it doesn't replicate its changes. If you want to set up replication again, you should reverse the replication and configure settings similar to when you enabled replication.

#### Failover

If a disruption occurs at the primary server and the primary VM has failed, you can perform a Failover. You can initiate a Failover only on the replica server on the replicated VM, and only when the primary VM is either unavailable or is turned off.

> [!IMPORTANT] 
> A Failover is an unplanned event that can result in data loss because changes at the primary VM might not have replicated before the disaster happened.

## Demonstration

The following video demonstrates how to:

- Configure Hyper-V Replica on two host machines.
- Configure replication by using Windows PowerShell.
- Validate failover.

The main steps in the process are:

- Configure **Hyper-V Replica** on two Hyper-V host machines.
- Enable **Windows Defender Firewall** with **Advanced Security** rules.
- Configure replication by using **Windows PowerShell** and **Kerberos** authentication.
- Validate that the failover completed successfully.

>[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MC7j]