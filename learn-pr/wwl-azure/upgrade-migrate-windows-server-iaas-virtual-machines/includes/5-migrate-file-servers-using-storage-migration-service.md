After you've installed the service and opened any necessary firewall ports, you must complete the following additional migration steps:

- Inventory your servers
- Transfer data
- Cut over to the new servers

## Step 1: Install Storage Migration Service and check firewall ports

Before you get started, install Storage Migration Service and make sure that the necessary firewall ports are open. Then complete the following procedure:

1. Check the Storage Migration Service requirements, and install the Windows Admin Center on your PC or a management server if necessary. If migrating domain-joined source computers, you must install and run the Storage Migration Service on a server joined to the same domain or forest as the source computers.
2. In Windows Admin Center, connect to the Orchestrator server running Windows Server 2025. This is the server that you install Storage Migration Service on and use to manage the migration. If you're migrating only one server, you can use the destination server providing it's running Windows Server 2022. We recommend you use a separate orchestration server for any multi-server migrations.
3. In Windows Admin Center, select **Server Manager**, select **Storage Migration Service**, and then select **Install** to install Storage Migration Service and its required components.
4. Install the Storage Migration Service proxy on all destination servers running Windows Server 2025. This doubles the transfer speed when installed on destination servers.  To do so, connect to the destination server in Windows Admin Center. Go to **Server Manager**, select **Roles and features**, select **Features**, select **Storage Migration Service Proxy**, and then select **Install**.
5. If you intend to migrate to or from Windows Failover Clusters, install the Failover Clustering tools on the Orchestrator server.  To do so, connect to the Orchestrator server in Windows Admin Center and then go to **Server Manager** (in Windows Admin Center). Select **Roles and features**, select **Features**, select **Remote Server Administration Tools**, then **Feature Administration Tools**, select **Failover Clustering Tools**, and then select **Install**.
6. On all source servers and on any destination servers running Windows Server 2012 R2 or later, in Windows Admin Center, connect to each server. Go to **Server Manager** (in Windows Admin Center), select **Firewall**, select **Incoming rules**, and then check that the following rules are enabled:
   - File and Printer Sharing (SMB-In)
   - Netlogon Service (NP-In)
   - Windows Management Instrumentation (DCOM-In)
   - Windows Management Instrumentation (WMI-In)

    >[!TIP]
    > If you're using third-party firewalls, the inbound port ranges to open are TCP/445 (SMB), TCP/135 (RPC/DCOM endpoint mapper), and TCP 1025-65535 (RPC/DCOM ephemeral ports). The Storage Migration service ports are TCP/28940 (Orchestrator) and TCP/28941 (Proxy).

7. If you're using an Orchestrator server to manage the migration and you want to download events or a log of what data you transfer, check that the File and Printer Sharing (SMB-In) firewall rule is enabled on that server as well.

## Step 2: Create a job and inventory your servers

In this step, you specify what servers to migrate and then scan them to collect information on their files and configurations:

1. Select **New job**, name the job, and then select whether to migrate Windows servers and clusters or Linux servers that use Samba. Then select **OK**.
2. On the **Enter credentials** page, enter admin credentials that work on the servers you want to migrate from, and then select **Next**.
   If you're migrating from Linux servers, instead enter credentials on the Samba credentials and Linux credentials pages, including an SSH password or private key.
3. Select **Add a device**, type a source server name or the name of a clustered file server, and then select **OK**. Repeat this for any other servers that you want to inventory.
4. Select **Start scan**. The page updates to reflect when the scan is complete.
5. Select each server to review the shares, configuration, network adapters, and volumes that were inventoried.

    > [!NOTE]
    > Storage Migration Service won't transfer files or folders that we know could interfere with Windows operation, so in this release there will be warnings for any shares located in the Windows system folder. You have to skip these shares during the transfer phase.

6. Select **Next** to move on to transferring data.

[![A screenshot of the Windows Admin Center in Microsoft Edge. The administrator has selected the Storage Migration Service. In the details pane, the administrator is executing step 1: Inventory devices. A single server is listed: Engineering5.corp.contoso.com.](../media/m17-storage-migrate.png)](../media/m17-storage-migrate.png#lightbox)

## Step 3: Transfer data to the destination servers

In this step you transfer data from your old server to the destination server after specifying where to put it on the destination servers:

1. On the **Transfer data** page, select **Enter credentials**. Enter the admin credentials that work on the destination servers you want to migrate to, and then select **Next**.
2. On the **Add a destination device and mappings** page, the first source server is listed. Enter the name of the server or clustered file server to which you want to migrate, and then select **Scan device**.
   If you're migrating from a domain-joined source computer, the destination server must be joined to the same domain.
   You can also select **Create a new Azure VM** then use the wizard to deploy a new destination server in Azure. This will automatically size your VM, provision storage, format disks, join the domain, and add the Storage Migration Service proxy to a Windows Server 2025 destination. You can choose from Windows Server 2025 (recommended) or earlier versions of any size and use managed disks.

    [![A screenshot of the Windows Admin Center in Microsoft Edge. The administrator has selected the Storage Migration Service. In the details pane, the administrator is executing step 2: Transfer data. A single server is listed: Engineering5.corp.contoso.com.](../media/m17-storage-migrate-2.png)](../media/m17-storage-migrate-2.png#lightbox)

    > [!NOTE]
    > Using **Create a new Azure VM** requires that you have: A valid Azure subscription, an existing Azure Compute resource group where you have Create rights, an existing Azure VNet and subnet, an Azure Express Route or VPN solution tied to the VNet and subnet that allows connectivity from this Azure IaaS VM to your on-premises clients, domain controllers, the Storage Migration Service Orchestrator computer, the Windows Admin Center computer, and the source computer to be migrated.

3. Map the source volumes to destination volumes, clear the **Include** check box for any shares you don't want to transfer (including any administrative shares located in the Windows system folder), and then select **Next**.
4. Add a destination server and mappings for any more source servers, and then select **Next**.
5. On the **Adjust transfer settings** page, specify whether to migrate local users and groups on the source servers, and then select **Next**. This lets you recreate any local users and groups on the destination servers so that file or share permissions set to local users and groups aren't lost. The options when migrating local users and groups are:
   - **Rename accounts with the same name**. This option is selected by default and migrates all local users and groups on the source server. If it finds local users or groups with the same name on the source and destination servers, it renames them on the destination server unless they're built in (for example, the Administrator user and the Administrators group). Don't use this setting though, if your source or destination server is a domain controller.
   - **Reuse accounts with the same name**. This option maps identically named users and groups on the source and destination. Note that you shouldn't use this setting if your source or destination server is a domain controller.
   - **Don't transfer users and groups**. This option skips migrating local users and groups, which is required when your source or destination is a domain controller, or when seeding data for DFS Replication. Note that DFS Replication doesn't support local groups and users.

    > [!NOTE]
    > Migrated user accounts are disabled on the destination and assigned a 127-character password that's both complex and random, so you have to re-enable them and assign a new password when you're finished to so that users can keep using them. This helps ensure any old accounts with forgotten and weak passwords on the source don't continue to be a security problem on the destination. You might also want to consider Local Administrator Password Solution (LAPS) as a way to manage local Administrator passwords.

6. Select **Validate**, and then select **Next**.

7. Select **Start transfer** to start transferring data.
   The first time you transfer, you need to move any existing files in a destination to a backup folder. On subsequent transfers, by default you refresh the destination without backing it up first.
   Also, Storage Migration Service is smart enough to manage overlapping shares—we won't copy the same folders twice in the same job.
8. After the transfer completes, review the destination server to ensure everything transferred properly. If you want to download a log of any files that didn't transfer, select **Error log only**.

> [!NOTE]
> If you want to keep an audit trail of transfers or are planning to perform more than one transfer in a job, select either **Transfer log**, or the other log save options to save a copy in .csv format. Every subsequent transfer overwrites the database information of a previous run. 

At this point, you have three options:

- Go to the next step, cutting over so that the destination servers adopt the identities of the source servers.
- Consider the migration complete without taking over the source servers' identities.
- Transfer again, copying only files that were updated since the last transfer.

If your goal is to sync the files with Azure, you could set up the destination servers with Azure File Sync after transferring files, or after cutting over to the destination servers.

## Step 4: Cut over to the new servers

In this step you cut over from the source servers to the destination servers, moving the IP addresses and computer names to the destination servers. After this step is finished, apps and users access the new servers via the names and addresses of the servers you migrated from.

1. If you've navigated away from the migration job, in Windows Admin Center, go to **Server Manager**, select **Storage Migration Service**, and then select the job that you want to complete.
2. On the **Cut over to the new servers** page, select **Enter credentials**, and then select **Next** to use the credentials you typed previously.
   If your destination is a clustered file server, you might need to provide credentials with permissions to remove the cluster from the domain and then add it back with the new name.
3. On the **Configure cutover** page, specify which network adapter on the destination should take over the settings from each adapter on the source. This moves the IP address from the source to the destination as part of the cutover, giving the source server a new Dynamic Host Configuration Protocol (DHCP) or static IP address. You have the option to skip all network migrations or certain interfaces.

    [![A screenshot of the Windows Admin Center in Microsoft Edge. The administrator has selected the Storage Migration Service. In the details pane, the administrator is executing step 3: Cut over to the new server. A single server is listed: Engineering5.corp.contoso.com.](../media/m17-storage-migrate-3.png)](../media/m17-storage-migrate-3.png#lightbox)

4. Specify what IP address to use for the source server after cutover moves its address to the destination. You can use DHCP or a static address. If using a static address, the new subnet must be the same as the old subnet or cutover will fail.
5. Specify how to rename the source server after the destination server takes over its name. You can use a randomly generated name or enter one you choose yourself. Then select **Next**.
6. On the **Adjust cutover settings** page, select **Next**.
7. On the **Validate source and destination device** page, select **Validate**, and then select **Next**.
8. When you're ready to perform the cutover, select **Start cutover**.

Users and apps might experience an interruption while the address and names are moved, and the servers restart several times. However, they'll otherwise be unaffected by the migration. How long cutover takes depends on how quickly the servers restart, and AD DS and DNS replication times.
