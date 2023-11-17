To complete the steps for protecting your VMware vSphere VMs, you now need to connect instances of VMware SRM on the protected and recovery sites, then configure a protection policy. The process of connecting VMware SRM instances is known as *site pairing*. You can configure site pairing from a Windows client VM, called a *jump box*, that’s deployed on the virtual network that has access to both Azure VMware Solution private clouds. 

## Configure site pairing in vCenter Server

To configure site pairing, perform the following steps:

1. Ensure that the jump-box device has connectivity to both Azure VMware Solution private clouds.

2. In the jump-box VM, open a browser and connect to the private cloud vCenter Server and NSX-T Manager using credentials that you can retrieve from the **Identity** pane in your Azure VMware Solution private cloud.

    > [!NOTE]
    > The first time you attempt to connect to vCenter Server, you’ll be prompted to use either a Flash-based vSphere web client or an HTML5-based client. We recommend you use the HTML5-based client.

3. In the vSphere web client, select **Menu**, then select **Site Recovery**.

4. In the **Site Recovery** window, verify that the status **OK** displays for both **vSphere Replication** and **Site Recovery Manager**, then select **Open Site Recovery**.

5. Select the **New Site Pair** button.

6. Select the first site from the list.

7. Enter the address of the Platform Services Controller for the Site Recovery Manager Server on the second site.

8. Provide the username and password, then select **Next**.

    :::image type="content"  source="../media/5-site-pair-details.png" alt-text="Screenshot of the Disaster recovery tab in Azure VMware Solution. The vSphere Replication option is selected under Setup replication.":::  

The address that you provide for the Platform Services Controller must exactly match the address that you provided when you installed Site Recovery Manager Server on the recovery site.

### Connect the Site Recovery Manager instances on the protected and recovery sites

After you configure the VMware SRM, you should connect both instances of VMware SRM on the protected and recovery sites.

> [!NOTE]
> The following ports should be open to provide cloud-to-cloud recovery: 80, 443, 902, 1433, 1521, 1526, 5480, 8123, 9086, 31031, 32032, 8043, and 10000-10010

### Configure mappings between sites

Before you start protecting the VMs, you first need to map the objects on the protected site to the corresponding objects in the recovery site. You can map the following objects to ensure the replicated VMs have proper functionality:

- Networks

- VM folders

- Compute resources

- Storage policy mappings

> [!NOTE]
> To enable bidirectional protection and reprotect, you can configure reverse mappings to map the objects on the recovery site back to their corresponding objects on the protected site.

:::image type="content"  source="../media/5-recovery-networks.png" alt-text="Screenshot of the Recovery networks window with relevant mappings set for objects between the protected site and the recovery site.":::

By configuring mappings, you can ensure that the VMs will have access to all resources available in the recovery site. If you don’t create the proper mapping, then you’ve to configure these settings for every VM individually.

### Configure replication on the VMs

Before you can create protection groups, you must configure replication on the VM that you want to protect. When you configure replication settings, you can select multiple point-in-time instances that are converted to snapshots during recovery.

Use the following procedure to configure replication for the VM:

1. In the vSphere client or the vSphere web client, select **Site Recovery**, then select **Open Site Recovery**.

2. On the **Site Recovery** home tab, select a site pair, then select **View Details**.

    > [!NOTE]
    > You might be prompted to sign in with **cloudadmin** credentials.

3. Select the **Replication** tab, then select **New**.

4. On the **Target site** page, ensure that you select a target site, and optionally, select a vSphere Replication Server that will manage the replication.

5. On the **Virtual machines** page, select one or multiple VMs that you want to protect, then select **Next**.

6. On the **Target datastore** page, configure the protected VM’s **Disk format** and **VM storage policy**, then select **Next**.

7. On the **Replication settings** page, select **Recovery point objective**, and optionally, enable point-in-time instances, network compression, or encryption of the data. Select **Next**.

8. On the **Protection group** tab, add the VMs to an existing or a new protection group. Alternately, you can choose not to add the VMs to any protection group at this stage. Select **Next**.

9. On the **Ready to complete** page, review your settings, and then select **Finish**.

    > [!NOTE]
    > You can configure replications for powered-off VMs, but the data synchronization begins when the VM is powered on. While the source VM is powered off, the replication displays a **Not active** status.

    :::image type="content"  source="../media/5-replication-settings.png" alt-text="Screenshot of the Replication settings window in Azure VMware Solution, with the configured RPO settings.":::

### Create and manage protection groups

You can create a protection group containing multiple VMs that VMware SRM protects collectively. Protection groups are included in the recovery plan that specifies how VMware SRM recovers the VMs contained in the protection group.

You must assign the VMs that are part of the replication plan to an existing resource pool, folder, and network on the recovery site. You can configure these settings in the inventory mappings or individually for every VM in the protection groups.

VMware Site Recovery Manager creates placeholder VMs on the recovery site, and then applies the inventory mappings to each VM in the group. vSphere Replication then synchronizes the disk files of the replication target VM according to the recovery point objective that you set when you configured vSphere Replication on the VM.

Use the following procedure to create vSphere Replication protection groups:

1. In the vSphere Client or the vSphere web client, select **Site Recovery**, and then select **Open Site Recovery**.

2. On the **Site Recovery** home tab, select a site pair, and then select **View Details**.

    > [!NOTE]
    > You might be prompted to sign in with **cloudadmin** credentials.

3. Select the **Protection Groups** tab, and then select **New** to create a protection group.

4. On the **Name and direction** page, enter a name and description for the protection group, select a direction, then select **Next**.

5. On the **Protection group type** pane, select **Individual VMs (vSphere Replication)**, then select **Next**.

6. Select VMs from the list to add to the protection group, then select **Next**.

    > [!NOTE]
    > Only VMs that you configure for vSphere Replication and that aren’t already in a protection group are in the list.

7. On the **Recovery plan** page, you can optionally add the protection group to a recovery plan by selecting one of the options listed in the following table.

    | **Option**                          | **Description**                                              |
    | ----------------------------------- | ------------------------------------------------------------ |
    | **Add to existing recovery plan**   | Adds  the protection group to an existing recovery plan.     |
    | **Add to new recovery plan**        | Adds  the protection group to a new recovery plan. If you select this option, you  must enter a recovery plan name. |
    | **Do not add to recovery plan now** | Select  this option if you don’t want to add the protection group to a recovery plan. |

8. Review your settings and select **Finish**.

   :::image type="content"  source="../media/5-protection-group-type.png" alt-text="Screenshot of the Type window in Azure VMware Solution with the Individual VMs (vSphere replication) option selected.":::

### Create, test, and run recovery plans

Recovery plans control every step of the recovery process. They control the sequence in which VMware SRM powers VMs on and off. You can create a recovery plan that contains one or multiple protection groups. You can also include a protection group in multiple recovery plans. This enables you to choose between recovery plans to decide how to recover the VM.

Use the following procedure to create a recovery plan:

1. In the vSphere Client or the vSphere web client, select **Site Recovery**, then select **Open Site Recovery**.

2. On the **Site Recovery** home tab, select a site pair, then select **View Details**.

    > [!NOTE]
    > You might be prompted to sign in with **cloudadmin** credentials.

3. Select the **Recovery Plans** tab, and then select **New** to create a recovery plan.

4. On the **Name and direction** page, enter the name and description of the recovery plan, select the direction of the replication, then select **Next**.

5. On the **Protection Groups** page, select **Protection groups for individual VMs or datastore groups**, select one of the previously created protection groups, then select **Next**.

6. On the **Test Networks** page, select the networks to use while running tests on this plan, then select **Next**.

7. On the **Ready to complete** page, review the settings, then select **Finish**.

### Testing the recovery plan

After you've created a recovery plan, you can test or run the recovery plan. When you test the recovery plan, the source VM continues to operate in the source Azure VMware Solution, and a replica of that VM is created in the recovery site in the test network.

Use the following procedure to test the recovery plan:

1. Select the recovery plan, then select **Test**.
2. On the **Confirmation options** page, ensure that you select the **Replicate recent changes to recovery site** check box, then select **Next**.
3. On the **Ready to complete** page, review the selected settings, then select **Finish**.

After a successful test, don’t forget to clean up the test environment.

### Run the recovery plan

When you select to run the replication plan, you initiate a planned migration. *Planned migration* is the orderly migration of VMs from the protected site to the recovery site. Planned migration prevents data loss when migrating workloads in an orderly fashion. For planned migration to succeed, both sites must be running and fully functional. Then, if the protected site fails, you can initiate disaster recovery to recover the failed VMs. VMware SRM orchestrates the recovery process with the replication mechanisms to minimize data loss and system downtime.

Use the following procedure to run a recovery plan:

1. Select the recovery plan, then select **Run**.
2. On the **Confirmation options** page, select the **I understand that this process will permanently alter the virtual machines and infrastructure of both the protected and recovery datacenters** check box.
3. Choose between the recovery types **Planned migration** or **Disaster Recovery**, then select **Next**.
4. On the **Ready to complete** page, review your selected settings, then select **Finish**.

    :::image type="content"  source="../media/5-recovery-plan-confirmation-options.png" alt-text="Screenshot of the Confirmation options window in Azure VMware Solution with the selected recovery confirmation options.":::
