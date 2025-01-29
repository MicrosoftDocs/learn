After you install VMware HCX and you connect your on-premises VMware vSphere environment to Azure VMware Solution, you work on migrating virtual machines (VMs) running Windows Server and Linux operating systems. You migrate VMs running Windows Server and Linux from on-premises through the VMware HCX Connector migration web interface.

## Migrate virtual machines

VMware HCX provides several ways of migrating VMs running Windows Server and Linux into Azure VMware Solution: cold, live, Replication Assisted vMotion (RAV), and bulk migration. You configure migrations by using the VMware HCX Connector on-premises that initiated site pairing into Azure VMware Solution. The VMware HCX migration interface also provides a set of options for VMs. These options control behaviors and conditions on the VM. These behaviors and conditions can happen either before or after the migration operation.

One last thing to note is that taking snapshots of a VM during migration, either manually or via a third-party backup solution, can disrupt the migration process. To prevent any disruption, disable backups until the VM completely migrates into Azure VMware Solution.

### Steps to migrate virtual machines into Azure VMware Solution using Bulk Migration

1. From within the HCX dashboard on-premises, select **Services** > **Migration**.

1. The **Migration Tracking** page displays a summary of virtual machine migrations. Since this is your first migration, no VMs are shown.

1. Select **Migrate**.

    :::image type="content" source="../media/6-hcx-migrate-virtual-machines.png" alt-text="Screenshot of where to start the migration for existing VMs in the on-premises VMware environment."lightbox="../media/6-hcx-migrate-virtual-machines.png":::

1. The list of virtual machines available for migration appears on the display. Check the **Name**(s) you want, then select **Add**.

    :::image type="content" source="../media/6-hcx-select-vms-migration-add.png" alt-text="Screenshot of how to select the VMs for migration."lightbox="../media/6-hcx-select-vms-migration-add.png":::

1. Set the **Transfer and Placement**, **Switchover**, and **Extended Options** needed for the VM being migrated.

1. To set machine-specific **Transfer and Placement** and **Switchover** options, under **VM for Migration**, select a specific virtual machine and expand the entry.

    :::image type="content" source="../media/6-hcx-select-vm-for-migration-extended-options.png" alt-text="Screenshot of where to select a virtual machine and expand the entry."lightbox="../media/6-hcx-select-vm-for-migration-extended-options.png":::

1. Select the destination network for each virtual machine to be migrated.

    :::image type="content" source="../media/6-hcx-migrate-select-destination-network-vm-migration.png" alt-text="Screenshot of where to configure the network settings for the VMware VM."lightbox="../media/6-hcx-migrate-select-destination-network-vm-migration.png":::

1. After the network configuration finishes, select **Validate** or **Go**. **Validate** ensures the settings are configured correctly. **Go** starts the migration.

1. HCX Manager then migrates all VMs selected. If you see a warning or error when you validate, fix the configuration and select **Go** to start the migration again.

### Steps to migrate virtual machines into Azure VMware Solution using Replication Assisted vMotion

1. From the HCX dashboard on-premises, select **Services** > **migration**.

    :::image type="content" source="../media/6-hcx-services-migration.png" alt-text="Screenshot shows where to start the migration process."lightbox="../media/6-hcx-services-migration.png":::

1. Under the **Select VMs for Migration** tab, add the desired virtual machines, then select **Add**.

    :::image type="content" source="../media/6-hcx-migration-add-virtual-machines.png" alt-text="Screenshot shows where to select VMs for Migration and add them."lightbox="../media/6-hcx-migration-add-virtual-machines.png":::

1. Configure the required fields then choose **Replicaton-Assisted vMotion**.

1. For each VM you're migrating, select the Destination Network, then select the **GO** button.

    :::image type="content" source="../media/6-hcx-migration-add-workload-mobility-rav-network.png" alt-text="Screenshot shows where to select destination networks and 'GO' to migrate them."lightbox="../media/6-hcx-migration-add-workload-mobility-rav-network.png":::

1. Verify migration has started.

    :::image type="content" source="../media/6-hcx-add-rav-migration-started.png" alt-text="Screenshot shows the migration started."lightbox="../media/6-hcx-add-rav-migration-started.png":::

## Configure Network Extension

Extend a network when you plan to vMotion virtual machines keeping the same IP addresses as the source vSphere environment.

Use the following steps to extend a Network:

1. From the HCX dashboard, to go **Services** > **Network Extension** > **Create a Network Extension**.

    :::image type="content" source="../media/6-hcx-create-network-extension.png" alt-text="Screenshot shows where to create a Network Extension."lightbox="../media/6-hcx-create-network-extension.png":::

1. Select the network you want to extend, then select **Next**.

    :::image type="content" source="../media/6-hcx-select-network-extension.png" alt-text="Screenshot shows where to select a Network Extension."lightbox="../media/6-hcx-select-network-extension.png":::

1. Under **Source Network to Extend**, select the required **mandatory fields**, then select **Submit**.

    :::image type="content" source="../media/6-hcx-select-source-network-mandatory-fields.png" alt-text="Screenshot shows where to select the required mandatory fields to extend networks."lightbox="../media/6-hcx-select-source-network-mandatory-fields.png":::

1. Verify a green check under **Status** indicating the Network Extension is completed.

    :::image type="content" source="../media/6-hcx-network-extension-complete-status-green.png" alt-text="Screenshot shows a green status check that the Network Extension is complete."lightbox="../media/6-hcx-network-extension-complete-status-green.png":::



