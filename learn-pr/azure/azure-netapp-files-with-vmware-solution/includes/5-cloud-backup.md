Cloud Backup for Virtual Machines is a vSphere plug-in for Azure VMware Solution (AVS) that provides backup and restore capabilities for Azure NetApp Files datastores.

To complete the exercise, you will need access to an Azure subscription with an AVS private cloud, an Azure NetApp Files volume deployed as an AVS datastore, and a service principal with the "contributor" role assigned.

1. Install Cloud Backup for Virtual Machines
    1. From the Azure portal, navigate to your AVS private cloud.
    1. From the menu, select **Run**.
    1. From the Packages tab, expand `NetApp.CBS.AVS` then select `Install-NetAppCBSApplianceUsingDHCP`.
    1. Provide the required values then select **Run**.
1. Add your Azure Subscription to Cloud Backup for Virtual Machines.
    1. Sign into the VMware vSphere client. From the left navigation, select **Cloud Backup for Virtual Machines**.
    1. From the Settings page, select the **Cloud Subscription** tab.
    1. Select **Add** then provide the **Subscription ID**, **Tenant ID**, **Client ID**, and **Client secret key**.
    1. Select **Add** to save your settings.
1. Add your Azure NetApp Files subscription to Cloud Backup for Virtual Machines.
    1. Navigate to the VMware vSphere client. Select **Cloud Backup for Virtual Machines**.
    1. Select **Storage Systems**.
    1. Select **Add** and provide the Azure NetApp Files cloud subscription account details.
    1. Select **Add** to save your settings.
1. Configure a Backup Policy for Cloud Backup for Virtual Machines.
    1. Navigate to the VMware vSphere client. Select **Cloud Backup for Virtual Machines**.
    1. Select the **Policies** page then **+ Create** to initiate the wizard.
    1. Specify settings for policy name, retention, and backup frequency
    1. Select **Add** to save the policy.
1. Configure a Resource Group for Cloud Backup for Virtual Machines to protect an Azure NetApp Files datastore or VM within a datastore.
    1. Navigate to the VMware vSphere client. Select **Cloud Backup for Virtual Machines**.
    1. Select **Resource Groups**.
    1. Select **+Create** to initiate the wizard.
    1. On the **Resource** page, select the Azure NetApp Files datastore. Use **>** to move your selection to the **Selected** entities list.
    1. On **Spanning disks**, select an option for VMs with multiple VMDKs across multiple datastores.
    1. On the **Policies** page, select the Backup Policy you created earlier.
    1. On the **Schedules** page, configure the backup schedule for the selected policy.
    1. Select **Finish** to save your settings.
1. Create an on-demand backup of a Resource Group.
    1. Navigate to the VMware vSphere client. Select **Cloud Backup for Virtual Machines**.
    1. Select the **Resource Group** you created earlier.
    1. Select **Run Now** to start the backup.
    1. Select **OK** to initiate the backup.

You've created a backup of an AVS datastore using Cloud Backup for Virtual Machines.