Remember that VMware HCX (HCX) Advanced deploys by default when Azure VMware Solution deploys in Azure. Before configuring site pairings for your migration, the next step involves deployment and configuration of HCX Connector on-premises. 

To complete the exercises, you'll need access to an Azure subscription with contributor rights assigned to configure an Azure VMware Solution environment.

## Download VMware HCX Connector

Before you deploy HCX Connector in the on-premises vCenter, download the VMware HCX Connector OVA file from the Azure portal.

1. Search for and select the Azure VMware Solution private cloud in the [Azure portal](https://portal.azure.com).

1. Under **Manage**, select **Add-ons**.

1. Select the **Migration using HCX** tab, place a check mark next to **I agree with terms and conditions**, and select **Enable and deploy**.

    :::image type="content" source="../media/3-enable-deploy-hcx.png" alt-text="Screenshot displaying how to enable the HCX add-on within the Azure portal.":::

1. This action triggers a build of VMware HCX Advanced within the Azure VMware Solution private cloud.

1. After the build completes, you should get a similar screen to the following:

    :::image type="content" source="../media/3-hcx-deployment-complete.png" alt-text="Screenshot displaying that the HCX add-on installed after enabling the service within the Azure VMware Solution private cloud.":::

1. Within the Azure VMware Solution resource, under **Manage**, select **Add-ons** again.

1. In the **Migration using HCX** tab, you should now have **HCX plan**, **Configure HCX appliance**, and **Connect with on-premise using HCX keys**. All of these new options for configuration built out during the HCX Advanced deployment on the private cloud.

    :::image type="content" source="../media/3-migration-hcx-start.png" alt-text="Screenshot showing that the HCX add-on is enabled and that there are more options to configure after the add-on finishes installing.":::

1. Select **+ Add** under **Connect with on-premise using HCX keys** to generate a key that you'll use for the on-premises HCX Connector installation.

1. Supply an HCX key name and you'll see the activation key show up within this pane. This is the key you'll use to activate the on-premises HCX Connector appliance.

    :::image type="content" source="../media/3-add-hcx-key-portal.png" alt-text="Screenshot that shows where to add the HCX key in the Azure portal for use on-premises.":::

1. Next, under **Manage** on the Azure VMware Solution private cloud, select **Identity**.

1. The URLs and user credentials for the Azure VMware Solution vCenter and NSX-T Manager will appear. Use the copy feature to paste the credential information into the web browser on the jump host VM.

     :::image type="content" source="../media/3-display-user-credentials.png" alt-text="Screenshot of where to find the vCenter and NSX sign-in information in the Azure portal.":::

1. Open a browser window within the jump host behind Azure Bastion. Sign in to the Azure VMware Solution HCX Manager on `https://x.x.x.9` over port 443. Replace the x's with the CIDR address block used to configure with Azure VMware Solution.

1. Use the *cloudadmin@vsphere.local* user credentials to sign in.

1. Within HCX Cloud Manager, select **Administration** > **System Updates** > **Check for Updates**.

1. After HCX checks for a software update, select **Request Download Link**.

    :::image type="content" source="../media/3-request-hcx-download-link.png" alt-text="Screenshot of where to request a download link to the HCX Connector OVA file for the on-premises VMware environment.":::

1. Select **VMware HCX** to download the HCX Connector OVA file.

    :::image type="content" source="../media/3-download-vmware-hcx-ova.png" alt-text="Screenshot of selecting VMware HCX, which downloads the OVA file for deployment on-premises.":::

1. In the web browser you've chosen to use, you'll see a status bar. This status bar highlights how long it takes to download the OVA file.

    :::image type="content" source="../media/3-status-bar-ova-download.png" alt-text="Screenshot displaying the status of downloading the OVA file for deployment.":::

## Deploy the VMware HCX Connector OVA on-premises

Next, the HCX Connector OVA file needs to be installed in the on-premises VMware environment. Sign in to the web GUI of vCenter and begin deployment of the OVA file on-premises.

1. Right-click the vCenter datacenter and select **Deploy OVF Template**.

    :::image type="content" source="../media/3-deploy-ovf-template.png" alt-text="Screenshot that shows how to deploy the OVA file downloaded for HCX Connector on-premises in vCenter.":::

1. Select the local HCX Connector OVA file already downloaded from the Azure portal.

    :::image type="content" source="../media/3-select-local-file.png" alt-text="Screenshot that shows how to select a local file when prompted, during the HCX Connector deployment within vCenter on-premises.":::

1. For **Select a name and folder**, provide a name for the HCX Connector appliance, select the datacenter resource, and select **Next**.

    :::image type="content" source="../media/3-select-name-folder.png" alt-text="Screenshot of where to name the HCX Connector appliance and where to select the datacenter within vCenter on-premises.":::

1. For **Select a compute resource**, select the vSphere cluster, then select **Next**.

    :::image type="content" source="../media/3-select-compute-resource.png" alt-text="Screenshot that selects the vSphere cluster to deploy the HCX Connector appliance to during deployment on-premises.":::

1. Review the advanced configuration options and select **Next**.

    :::image type="content" source="../media/3-review-details.png" alt-text="Screenshot to review advanced configuration details of the HCX Connector appliance.":::

1. For **License agreements**, if you agree, select **I accept all license agreements**, then select **Next**.

    :::image type="content" source="../media/3-license-agreements.png" alt-text="Screenshot of accepting all license agreements during HCX Connector deployment on-premises.":::

1. Select the right storage on which to deploy HCX Connector, then select **Next**.

    :::image type="content" source="../media/3-select-storage.png" alt-text="Screenshot of selecting storage for the HCX Connector appliance on-premises.":::

1. Select the VMware HCX management network segment, then select **Next**.

    :::image type="content" source="../media/3-select-networks.png" alt-text="Screenshot of selecting the right management network on-premises.":::

1. In **Customize template**, note that the user account used to configure HCX Connector is *admin*. Enter all required information, then select **Next**.

    :::image type="content" source="../media/3-customize-template.png" alt-text="Screenshot of customizing the OVA template file for the HCX Connector deployment on-premises.":::

1. On **Ready to complete**, verify all configurations and select **Finish**.

    :::image type="content" source="../media/3-ready-to-complete.png" alt-text="Screenshot that shows the appliance is ready to complete the installation on-premises.":::

1. After the appliance deploys, you'll need to power on the virtual appliance manually in vCenter. Then wait 10-15 minutes before finishing the configuration.

## Activate VMware HCX

After deploying and powering on the VMware HCX Connector appliance on-premises, you activate HCX Connector. You need to get a license key from the Azure VMware Solution environment in Azure.

1. Under **Manage** > **Connectivity**, select the HCX tab, and then select **+ Add**.

    :::image type="content" source="../media/3-add-hcx-key-portal.png" alt-text="Screenshot to add the HCX Advanced key in the Azure portal.":::

1. Provide a name for the key and wait for Azure to generate an HCX Advanced key for use on-premises.

    :::image type="content" source="../media/3-request-hcx-key.png" alt-text="Screenshot after the HCX Advanced key has been requested from the Azure portal.":::

1. Use the admin credentials you configured earlier to sign in to the on-premises VMware HCX Manager at `https://x.x.x.x:9443`. Replace the x's with the IP address configured for the on-premises appliance.

1. When prompted, enter your key for **HCX License Key**, then select **Add**. If you receive any errors during activation, the on-premises environment might not have open internet access or a proxy configured for activation. Check internet connectivity if HCX Connector on-premises won't activate.

    :::image type="content" source="../media/3-enter-hcx-license-key.png" alt-text="Screenshot of where to enter the HCX Connector license key on-premises.":::

1. In **Datacenter Location**, provide the nearest location for installing VMware HCX Connector on-premises, then select **Continue**.

    :::image type="content" source="../media/3-hcx-location.png" alt-text="Screenshot that specifies the location of HCX Connector on-premises during deployment.":::

1. In **System Name**, modify the HCX Connector appliance name or accept the default name, and select **Continue**.

    :::image type="content" source="../media/3-hcx-system-name.png" alt-text="Screenshot of where to provide a system name for HCX Connector on-premises.":::

1. On the next screen, select **Yes, Continue** to continue setting up HCX Connector on-premises.

    :::image type="content" source="../media/3-successfully-set-up-continue.png" alt-text="Screenshot of HCX being successfully activated in the on-premises vCenter environment.":::

1. For **Connect your vCenter**, provide the FQDN or IP address of your vCenter server on-premises.

1. Use a username and password of an account that can access vCenter on-premises, then select **Continue**.

    :::image type="content" source="../media/3-connect-vcenter-hcx.png" alt-text="Screenshot of where to configure a connection to the on-premises vCenter environment for the HCX Connector appliance.":::
  
1. In **Configure SSO/PSC**, provide the FQDN or IP address of your Platform Services Controller, then select **Continue**.

    :::image type="content" source="../media/3-configure-sso-psc.png" alt-text="Screenshot for the configuration of single sign-on and Platform Services Controller for HCX Connector on-premises.":::

1. On the next screen, verify that the information is correct and select **Restart**. A restart can take some time to complete.

    :::image type="content" source="../media/3-finish-configuration-hcx-manager.png" alt-text="Screenshot of the end of configuring HCX Manager on-premises.":::

1. After the appliance restarts, sign back in to the HCX Manager on-premises.

1. If configured correctly, vCenter appears with a green circle after you sign in.

1. Additionally, SSO indicates that HCX Connector is configured to use the Platform Services Controller on-premises.

    :::image type="content" source="../media/3-hcx-restart-green.png" alt-text="Screenshot of vCenter and Platform Services Controller SSO configured correctly in the on-premises HCX Connector appliance.":::

In the next unit, we'll cover how to set up a site pairing, add networking profiles, and add a compute profile.
