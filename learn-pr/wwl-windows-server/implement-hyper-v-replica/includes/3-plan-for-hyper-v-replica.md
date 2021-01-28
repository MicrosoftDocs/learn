As the Windows Server administrator, you must understand Hyper-V Replica configuration and settings options, in addition to security considerations, so you can understand the decisions that need to be made prior to implementing Hyper-V Replica.

## Plan for Hyper-V Replica

When planning for Hyper-V Replica deployment, you must define several parameters used in Hyper-V Replica configuration. Careful planning is important before setting up replication between Hyper-V hosts.

### Hyper-V Replica host scenarios

You can set up Hyper-V Replica between Hyper-V hosts irrespective of whether they're nodes in a failover cluster. Also, you can set up Hyper-V Replica whether the Hyper-V hosts are members of the same AD DS forest or are in different AD DS forests without any trust between them.

You can use Hyper-V Replica in the following four configurations:

1. Both Hyper-V hosts are standalone servers. Typically, this configuration isn't the preferred option, unless it's used in test or development scenarios, because it includes only disaster recovery and not high availability.

1. The Hyper-V host at the primary location is a node in a failover cluster, and the Hyper-V host at the secondary location is on a standalone server. Many environments use this configuration. A failover cluster provides high availability for running VMs at the primary location. If a disaster occurs at the primary location, a replica of the VMs is still available at the secondary location.

1. Each Hyper-V host is a node in a different failover cluster. With this configuration, if a disaster occurs at the primary location, you can perform a manual failover and continue operations from a secondary location.

1. The Hyper-V host at the primary location is a standalone server, and the Hyper-V host at the secondary location is a node in a failover cluster. Although technically possible, this configuration is rare. Typically, you want VMs at the primary location to be highly available. Their replicas at the secondary location stay turned off and aren't used until a disaster occurs at the primary location.

### Replication settings

Because you must individually configure replication for each VM, you must plan resources on replication hosts for each VM. In addition to resources, you also must plan how to configure the following replication settings:

- Replica server. Specify the computer name or the fully qualified domain name (FQDN) of the replica server, because the IP address isn't allowed. If the Hyper-V host that you specify isn't configured to allow replication traffic, you can configure it here. If the replica server is a node in a failover cluster, you should enter the name or FQDN of the connection point for the Hyper-V Replica Broker.
- Connection Parameters. If the replica server is accessible, the Enable Replication Wizard automatically populates the authentication type and replication port fields with appropriate values. If the replica server isn't accessible, you can manually configure these fields. Be aware that you won't be able to enable replication if you can't create a connection to the replica server. On the **Connection Parameters** page, you can also configure Hyper-V to compress replication data before transmitting it over a network.
- Replication VHDs. By default, all VHDs are replicated. If some of the VHDs aren't required at the replica Hyper-V host (for example, a VHD that's dedicated to storing page files), exclude them from replication. Be aware that excluding VHDs that include operating systems or applications can result in that VM being unusable at the replica server.
- Replication frequency. Replication frequency controls how frequently data replicates to the Hyper-V host at the recovery site. If a disaster occurs at the primary site, a shorter replication frequency means less data loss, because changes are replicated to the recovery site more frequently. You can set replication frequency to one of the following:
  - 30 seconds
  - 5 minutes
  - 15 minutes

- Additional recovery points. You can configure the number and types of recovery points to send to a replica server. By default, the option to maintain only the latest point for recovery is selected, which means that only the parent VHD replicates and all changes merge into that VHD. You can create more hourly recovery points and set the number of additional recovery points to a maximum of 24. You can configure the Volume Shadow Copy Service snapshot frequency to save application-consistent replicas for the VM and not just the changes in the primary VM.
- Initial replication method and schedule. VMs have large virtual disks, and initial replication can take a long time and cause a lot of network traffic. Although the default option is to immediately send the initial copy over the network, if you don't want immediate replication, you can schedule it to start at a specific time. If you want an initial replication but want to avoid network traffic, you can opt to send the initial copy to external media or use an existing VM on the replica server. Use this option if you restored a copy of the VM at the replica server and you want to use it as the initial copy.

> [!NOTE]
> Hyper-V Replica allows the use of Microsoft Azure as a replica repository. This enables administrators to take advantage of Azure rather than having to build out a separate disaster recovery site, and to avoid incurring the associated administrative and cost overheads.

### Hyper-V Replica security considerations

You can set up Hyper-V Replica with a Hyper-V host regardless of its location and domain membership, providing you have network connectivity with the primary and replica Hyper-V hosts. Hyper-V hosts are not required to be part of the same AD DS forest.

You can implement Hyper-V Replica when Hyper-V hosts are members of un-trusted domains by configuring certificate-based authentication. Hyper-V Replica implements security at the following levels:

- Hyper-V creates a local security group named *Hyper-V Administrators*. Members of this group and local administrators can configure and manage Hyper-V Replica.
- You can configure a replica server to allow replication from any authenticated server or to limit replication to specific servers. Keep in mind that:
  - You must specify a FQDN for the primary server (for example, `lon-svr1.contoso.com`), or use a wildcard character with a domain suffix (for example, `*.contoso.com`).
  - Using IP addresses isn't allowed.
  - If the replica server is in a failover cluster, replication is allowed at the cluster level.
  - When you limit replication to specific servers, you also must specify a trust group that's used to identify the servers within which a VM can move. For example, if you provide disaster recovery services to partner organizations, the trust group prevents one organization from gaining access to another organization's replica machines.
- The replica Hyper-V host can authenticate a primary Hyper-V host by using Kerberos authentication or certificate-based authentication:
  - Kerberos authentication requires both Hyper-V hosts to be in the same AD DS forest, whereas you can use certificate-based authentication in any environment.
  - Kerberos authentication is used with HTTP traffic, which isn't encrypted, whereas certificate-based authentication is used with HTTPS traffic, which is encrypted.
- You can establish Hyper-V Replica only if network connectivity exists between the Hyper-V hosts.
- You should configure Windows Defender Firewall to allow HTTP or HTTPS Hyper-V Replica traffic as needed.

> [!TIP]
> To allow such incoming replication traffic, the built-in firewall rule for **Hyper-V Replica HTTP Listener (TCP-In)** on Windows Server should be enabled on the primary and replica Hyper-V hosts.
>
> For the primary Hyper-V host, it isn't essential to enable the rule unless you configure reverse replication from the replica Hyper-V host after you perform the failover. At that point, replication back to the former primary Hyper-V host might be required. This allows changes performed at the new primary VM to replicate back to the new replica, on what is the primary host. For this to be possible, enable incoming firewall rules on the former primary Hyper-V host.
