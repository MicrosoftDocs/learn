After HCX installs and connectivity is established between your on-premises VMware environment and Azure VMware Solution, VM migration becomes the next task. You migrate VMs from on-premises through the HCX Connector migration web interface.

## Pre-requisites

Before beginning VM migration tasks, it's worth revisiting the previous configurations to ensure each migration completes successfully.  
- The migration service must be enabled in both the source and destination site Compute Profile.
- The migration service must be enabled in the HCX Service Mesh.

## Migrate virtual machines

As we covered earlier, HCX provides several ways of migrating VMs into AVS: cold, live, and bulk migration, each using vMotion. You configure migrations using the HCX Connector on-premises that initiated site pairing into AVS. The HCX migration interface also provides a set of options for VMs. These options control behaviors and conditions on the VM. These behaviors and conditions can happen either before or after the migration operation. One last thing to note is taking snapshots of a VM during migration, either manually or via a third-party backup solution, can disrupt the migration process. In order to prevent any problems, disable backups until the VM completely migrates into AVS.

## Steps to migrate virtual machines into AVS

1. From within the HCX dashboard on-premises, select the **Service > Migration**. The **Migrate Tracking** pane will display a summary of virtual machine migrations.

1. Select **Migrate Virtual Machines** then select **Remote Site Connection**. The list of virtual machines available for migration will appear in the display.

1. Select the virtual machines you want to migrate.

1. Set the **Transfer and Placement**, **Switchover**, and **Extended** options.

1. To apply default settings for all selected virtual machines, use the green area of the interface at the top of the window.

1. To set machine-specific **Transfer**, **Placement**, and **Switchover** options, select a specific virtual machine and expand the entry.

1. Select the destination network for each virtual machine to be migrated.

1. Expand each virtual machine selection. Next to each guest virtual machine NIC name, select the folder for a list of available target networks.

1. Select the check box next to the network you want the guest virtual machine to map to, select **Select**, and select **Finish**.

HCX Manager then validates all selections you made and starts the VM migration or migrations. If a warning is generated, select **Finish** again to continue with the migration.