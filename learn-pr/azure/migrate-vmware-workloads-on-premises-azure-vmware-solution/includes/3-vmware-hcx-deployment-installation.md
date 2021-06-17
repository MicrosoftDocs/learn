Remember that VMware HCX (HCX) Advanced deploys by default when Azure VMware Solution deploys in Azure. Before configuring site pairings for your migration, the next step involves deployment and configuration of the HCX Connector on-premises. 

## Download VMware HCX Connector
Before deploying the HCX Connector appliance in the on-premises vCenter, the VMware HCX Connector OVA file needs to be downloaded from the Azure portal.

1. Search for and select the Azure VMware Solution private cloud in the Azure portal.

1. Under **Manage** select **Connectivity**.

1. Select the HCX tab to locate the Azure VMware Solution HCX Cloud Manager's IP address.

    :::image type="content" source="../media/3-find-hcx-address.png" alt-text="Screenshot of where to find the HCX IP address in the Azure Resource Manager portal.":::

1. Then select **Identity** under **Manage**.

1. The URLs and user credentials for the Azure VMware Solution vCenter and NSX-T Manager will display. Use the copy feature to paste credential information into the web browser on the jump host VM.

     :::image type="content" source="../media/3-display-user-credentials.png" alt-text="Screenshot of where to find the vCenter and NSX sign-in information in the Azure portal.":::

1. Open a browser window within the jump host behind the Azure Bastion and sign in to the Azure VMware Solution HCX Manager on https://x.x.x.9 over port 443. Replace the x's with the CIDR address block used to configure with Azure VMware Solution.

1. Use the cloudadmin@vsphere.local user credentials to sign in.

1. Within HCX Cloud Manager, select **Administration > System Updates** and then select **Check for Updates**.

1. After HCX checks for a software update, select **Request Download Link**.

    :::image type="content" source="../media/3-request-hcx-download-link.png" alt-text="Screenshot of where to request a download link to the HCX Connector OVA file for the on-premises VMware environment.":::

1. Select **VMware HCX** to download the HCX Connector OVA file.

    :::image type="content" source="../media/3-download-vmware-hcx-ova.png" alt-text="Screenshot selecting VMware HCX, which downloads the OVA file for deployment on-premises.":::

1. A status bar will then display in the web browser you've chosen to use. This status bar highlights how long it takes to download the OVA file.

    :::image type="content" source="../media/3-status-bar-ova-download.png" alt-text="Screenshot displaying status of downloading the OVA file for deployment.":::

## Deploy the VMware HCX Connector OVA on-premises
Next, the HCX Connector OVA file needs to be installed in the on-premises VMware environment. Log into the web GUI of vCenter and begin deployment of the OVA file on-premises.

1. Right-click on the vCenter datacenter and select **Deploy OVF Template**.

    :::image type="content" source="../media/3-deploy-ovf-template.png" alt-text="Screenshot that shows how to deploy the OVA file downloaded for the HCX Connector on-premises in vCenter.":::

1. Select the local HCX Connector OVA file already downloaded from the Azure portal.

    :::image type="content" source="../media/3-select-local-file.png" alt-text="Screenshot that shows to select a local file when prompted during the HCX Connector deployment within vCenter on-premises.":::

1. For **Select a name and folder**, provide a name for the HCX Connector appliance, select the datacenter resource, and select **Next**.

    :::image type="content" source="../media/3-select-name-folder.png" alt-text="Screenshot of where to name the HCX Connector appliance and where to select the datacenter within vCenter on-premises.":::

1. For **Select a compute resource**, select the vSphere cluster and select **Next**.

    :::image type="content" source="../media/3-select-compute-resource.png" alt-text="Screenshot that selects the vSphere cluster to deploy the HCX Connector appliance to during deployment on-premises.":::

1. Next, you'll see advanced configuration options that need to be reviewed.

1. After details are reviewed, select **Next**.

    :::image type="content" source="../media/3-review-details.png" alt-text="Screenshot to review advanced configuration details of the HCX Connector appliance.":::

1. For **License agreements**, place a check mark in the box next to **I accept all license agreements** and select **Next**.

    :::image type="content" source="../media/3-license-agreements.png" alt-text="Screenshot of accepting all license agreements during HCX Connector deployment on-premises.":::

1. Select the right storage to deploy the HCX Connector on and then select **Next**.

    :::image type="content" source="../media/3-select-storage.png" alt-text="Screenshot of selecting storage for the HCX Connector appliance on-premises.":::

1. Select the VMware HCX management network segment and then select **Next**.

    :::image type="content" source="../media/3-select-networks.png" alt-text="Screenshot of selecting the right management network on-premises.":::

1. In **Customize template**, note the user account used to configure the HCX Connector is admin. Enter all required information and then select **Next**.

    :::image type="content" source="../media/3-customize-template.png" alt-text="Screenshot of customizing the OVA template file for the HCX Connector deployment on-premises.":::

1. On **Ready to complete**, verify all configurations and select **Finish**.

    :::image type="content" source="../media/3-ready-to-complete.png" alt-text="Screenshot that shows the appliance is ready to complete the installation on-premises.":::

1. Once the appliance deploys, you'll need to power on the virtual appliance manually in vCenter. After powering on, wait 10-15 minutes before finishing the configuration.

## Activate VMware HCX
After deploying and powering on the VMware HCX Connector appliance on-premises, the HCX Connector service needs to be activated. You need to get a license key from the Azure VMware Solution environment in Azure.

1. Under **Manage > Connectivity**, select the HCX tab, and then select **+ Add**.

    :::image type="content" source="../media/3-add-hcx-key-portal.png" alt-text="Screenshot to add the HCX Advanced key in the Azure portal.":::

1. Provide a name for the key and wait for Azure to generate an HCX Advanced key for use on-premises.

    :::image type="content" source="../media/3-request-hcx-key.png" alt-text="Screenshot after the HCX Advanced key has been requested from the Azure portal.":::

1. Use the admin credentials configured earlier to sign in to the on-premises VMware HCX Manager at https://x.x.x.x:9443. Replace the x's with the IP address configured for the on-premises appliance.

1. When prompted, enter your key for **HCX License Key** and select **Add**.

    :::image type="content" source="../media/3-enter-hcx-license-key.png" alt-text="Screenshot of where to enter the HCX Connector license key on-premises.":::

1. In **Datacenter Location**, provide the nearest location for installing the VMware HCX Connector on-premises. Then select **Continue**.

    :::image type="content" source="../media/3-hcx-location.png" alt-text="Screenshot that specifies the location of the HCX Connector on-premises during deployment.":::

1. In **System Name**, modify the HCX Connector appliance name or accept the default name and select **Continue**.

    :::image type="content" source="../media/3-hcx-system-name.png" alt-text="Screenshot of where to provide a system name for the HCX Connector on-premises.":::

1. On the next screen, select **Yes, Continue** to continue setting up the HCX Connector on-premises.

    :::image type="content" source="../media/3-successfully-set-up-continue.png" alt-text="Screenshot of HCX being successfully activated in the on-premises vCenter environment.":::

1. For **Connect your vCenter**, provide the FQDN or IP address of your vCenter server on-premises.

1. Use a username and password of an account that can access vCenter on-premises. Select **Continue**.

    :::image type="content" source="../media/3-connect-vcenter-hcx.png" alt-text="Screenshot of where to configure a connection to the on-premises vCenter environment for the HCX Connector appliance.":::
  
1. In **Configure SSO/PSC**, provide the FQDN or IP address of your Platform Services Controller, and then select **Continue**.

    :::image type="content" source="../media/3-configure-sso-psc.png" alt-text="Screenshot for the configuration of single-sign on and Platform Services Controller for the HCX Connector on-premises.":::

1. On the next screen, verify information is correct and select **Restart**. A restart may take some time to complete.

    :::image type="content" source="../media/3-finish-configuration-hcx-manager.png" alt-text="Screenshot of the end of configuring HCX Manager on-premises.":::

1. After the appliance restarts, log back into the HCX Manager on-premises.

1. If configured correctly, vCenter will display with a green circle once you sign in.

1. Additionally, SSO will indicate the HCX Connector is configured to use the Platform Services Controller (PSC) on-premises.
    
    :::image type="content" source="../media/3-hcx-restart-green.png" alt-text="Screenshot of vCenter and Platform Services Controller SSO configured correctly in the on-premises HCX Connector appliance.":::

In the next unit, we'll cover how to set up a site pairing, add networking profiles, and add a compute profile. All steps will be outlined so you can successfully configure within your environment.
