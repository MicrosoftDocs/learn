After HCX installs and connectivity is established between your on-premises VMware environment and Azure VMware Solution, VM migration becomes the next task. You migrate VMs from on-premises through the HCX Connector migration web interface.

## Migrate virtual machines

As we covered earlier, HCX provides several ways of migrating VMs into AVS: cold, live, and bulk migration. You configure migrations using the HCX Connector on-premises that initiated site pairing into AVS. The HCX migration interface also provides a set of options for VMs. These options control behaviors and conditions on the VM. These behaviors and conditions can happen either before or after the migration operation. One last thing to note is taking snapshots of a VM during migration, either manually or via a third-party backup solution, can disrupt the migration process. In order to prevent any disruption, disable backups until the VM completely migrates into AVS.

## Steps to migrate virtual machines into AVS

1. From within the HCX dashboard on-premises, select the **Services > Migration**.

1. The **Migrate Tracking** pane will display a summary of virtual machine migrations. This is your first migration, so no VMs will display.

1. Select **Migrate**.

    :::image type="content" source="../media/6-migrate-virtual-machines.png" alt-text="Screenshot of where to start the migration for existing VMs in the on-premises VMware environment.":::

1. The list of virtual machines available for migration will appear in the display. Make the selections and select **Add**.

    :::image type="content" source="../media/6-select-vms-migration.png" alt-text="Screenshot of how to select the VMs for migration.":::

1. Next, you need to set the **Transfer and Placement**, **Switchover**, and **Extended** options for the VM being migrated.

1. To set machine-specific **Transfer**, **Placement**, and **Switchover** options, select a specific virtual machine and expand the entry.

    :::image type="content" source="../media/6-transfer-placement-switchover.png" alt-text="Screenshot of where to set the transfer, placement, and switchover options.":::

1. Select the destination network for each virtual machine to be migrated.

    :::image type="content" source="../media/6-select-network-vm-migration.png" alt-text="Screenshot of where to configure the network settings for the VMware VM.":::

1. After the network configuration completes, select **Validate** or **Go**. **Validate** ensures the settings are configured correctly. **Go** starts the migration.

1. HCX Manager then migrates all VMs selected. If a warning or error generates during **Validate**, fix the configuration and select **Go** to start the migration again.