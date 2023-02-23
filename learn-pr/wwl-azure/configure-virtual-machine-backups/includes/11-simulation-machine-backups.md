
## Lab scenario

Your organization has decided to use Azure Backup and Recovery Services. As the Azure Administrator you need to:
+ Determine how to back up and restore files hosted on Azure virtual machines and on-premises computers. 
+ Identify methods for protecting data stored in the Recovery Services vault.

## Architecture diagram

:::image type="content" source="../media/lab-10.png" alt-text="Architecture diagram as explained in the text." border="false":::

## Objectives

> [!NOTE]
> This interactive lab simulation covers two areas explored in this Learning Path. This module focuses on virtual machine backups, which is covered in Task 2 and Task 3. The simulation is also appropriate for the [Configure file and folder backups](/training/modules/configure-file-folder-backups/) module. 

+ **Task 1**: Establish the lab environment. 
    + Review an [Azure Resource Manager (ARM) template]( https://github.com/MicrosoftLearning/AZ-104-MicrosoftAzureAdministrator/blob/master/Allfiles/Labs/10/az104-10-vms-edge-template.json).
    + Use the ARM template to deploy two virtual machines. These virtual machines are used to test different backup scenarios.
+ **Task 2**: Create a Recovery Services vault.
    + Create a Recovery Services vault in the same region you deployed the virtual machines.
    + Configure the Recovery Services vault for Geo-redundant storage and soft delete. 
+ **Task 3**: Implement Azure virtual machine-level backup.
    + Configure the Recovery Services vault to back up Azure virtual machines.
    + Create a backup policy to run daily at 12:00 AM.
    + Enable backup for one of the virtual machines. 
+ **Task 4**: Implement file and folder backup.
    + Connect through remote desktop to a virtual machine and access the Azure portal.
    + Configure the Recovery Services vault to back up on-premises files and folders. 
    + Install the download agent for Windows Server or Windows Client.
    + Register the agent with the Recovery Services vault.
    + Create a backup schedule and back up local files.
    + Confirm the backed-up files are in the Recovery Services vault. 
+ **Task 5**: Perform file recovery by using the MARS agent.
    + Remove files that were backed up in the previous task.
    + Use the Recover Data Wizard to retrieve the deleted files.
+ **Task 6**: Perform file recovery by using Azure virtual machine snapshots (optional).
+ **Task 7**: Review the Azure Recovery Services soft delete functionality (optional).


> [!NOTE]
> Select the thumbnail image to start the lab simulation. When you're done, be sure to return to this page so you can continue learning. 

[![Screenshot of the simulation page.](../media/simulation-data-protection-thumbnail.jpg)](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%2016?azure-portal=true)