After you install VMware HCX and you connect your on-premises VMware vSphere environment to Azure VMware Solution, you work on migrating virtual machines (VMs) running Windows Server and Linux operating systems. You migrate VMs running Windows Server and Linux from on-premises through the VMware HCX Connector migration web interface.

## Migrate virtual machines

VMware HCX provides several ways of migrating VMs running Windows Server and Linux into Azure VMware Solution: cold, live, Replication Assisted vMotion (RAV), and bulk migration. You configure migrations by using the VMware HCX Connector on-premises that initiated site pairing into Azure VMware Solution. The VMware HCX migration interface also provides a set of options for VMs. These options control behaviors and conditions on the VM. These behaviors and conditions can happen either before or after the migration operation.

One last thing to note is that taking snapshots of a VM during migration, either manually or via a third-party backup solution, can disrupt the migration process. To prevent any disruption, disable backups until the VM completely migrates into Azure VMware Solution.

### Steps to migrate virtual machines into Azure VMware Solution

1. From within the HCX dashboard on-premises, select **Services** > **Migration**.

1. The **Migration Tracking** page displays a summary of virtual machine migrations. This is your first migration, so no VMs will appear.

1. Select **Migrate**.

    :::image type="content" source="../media/6-migrate-virtual-machines.png" alt-text="Screenshot of where to start the migration for existing VMs in the on-premises VMware environment.":::

1. The list of virtual machines available for migration appears on the display. Check the **Name**(s) you want, then select **Add**.

    :::image type="content" source="../media/6-select-vms-migration.png" alt-text="Screenshot of how to select the VMs for migration.":::

1. Set the **Transfer and Placement**, **Switchover**, and **Extended Options** needed for the VM being migrated.

1. To set machine-specific **Transfer and Placement** and **Switchover** options, under **VM for Migration**, select a specific virtual machine and expand the entry.

    :::image type="content" source="../media/6-transfer-placement-switchover.png" alt-text="Screenshot of where to set the transfer, placement, and switchover options.":::

1. Select the destination network for each virtual machine to be migrated.

    :::image type="content" source="../media/6-select-network-vm-migration.png" alt-text="Screenshot of where to configure the network settings for the VMware VM.":::

1. After the network configuration finishes, select **Validate** or **Go**. **Validate** ensures the settings are configured correctly. **Go** starts the migration.

1. HCX Manager then migrates all VMs selected. If you see a warning or error when you validate, fix the configuration and select **Go** to start the migration again.
