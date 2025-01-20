Remember that VMware HCX deploys as an add-on option after Azure VMware Solution deploys in Azure. Before configuring site pairings for your migration, use the next steps for deployment and configuration of VMware HCX Connector on-premises. 

To complete the exercises, you need access to an Azure subscription with contributor rights assigned to configure an Azure VMware Solution environment.

## Download VMware HCX Connector

Before you deploy VMware HCX Connector in the on-premises vCenter Server, download the VMware HCX Connector OVA file from the Azure portal.

1. Search for and select the Azure VMware Solution private cloud in the [Azure portal](https://portal.azure.com).

1. Under **Manage**, select **Add-ons**.

1. Select the **Migration using VMware HCX** tab, place a check mark next to **I agree with terms and conditions**, and select **Enable and deploy**.

    :::image type="content" source="../media/3-enable-deploy-vmware-hcx.png" alt-text="Screenshot displaying how to enable the VMware HCX add-on within the Azure portal."lightbox="../media/3-enable-deploy-vmware-hcx.png":::

1. This action triggers a deployment of VMware HCX within the Azure VMware Solution private cloud.

1. After the deployment completes, you should see a similar screen to the following image:

    :::image type="content" source="../media/3-deploy-vmware-hcx-complete.png" alt-text="Screenshot displaying that the VMware HCX add-on installed after enabling the service within the Azure VMware Solution private cloud."lightbox="../media/3-deploy-vmware-hcx-complete.png":::

1. Within the Azure VMware Solution resource, under **Manage**, select **Add-ons** again.

1. In the **Migration using HCX** tab, you should now have **HCX plan**, **Configure HCX appliance**, and **Connect with on-premise using HCX keys**. These new options for configuration were built out during the HCX deployment on the private cloud.

    :::image type="content" source="../media/3-migration-vmware-hcx-configured.png" alt-text="Screenshot showing that the VMware HCX add-on is enabled and that there are more options to configure after the add-on finishes installing."lightbox="../media/3-migration-vmware-hcx-configured.png":::

1. Select **+ Add** under **Connect with on-premise using HCX keys** to generate a key that you use for the on-premises HCX Connector installation.

1. Supply a VMware HCX key name and you see the activation key shows up within this pane. This key is used to activate the on-premises VMware HCX Connector appliance.

    :::image type="content" source="../media/3-add-vmware-hcx-activation-key.png" alt-text="Screenshot that shows where to add the VMware HCX key in the Azure portal for use on-premises."lightbox="../media/3-add-vmware-hcx-activation-key.png":::

1. Next, under **Manage** on the Azure VMware Solution private cloud, select **Identity**.

1. The URLs and user credentials for the Azure VMware Solution vCenter and NSX-T Manager appears. Use the copy feature to paste the credential information into the web browser on the jump host VM.

     :::image type="content" source="../media/3-display-vmware-credentials.png" alt-text="Screenshot of where to find the vCenter Server and NSX sign-in information in the Azure portal."lightbox="../media/3-display-vmware-credentials.png":::

1. Open a browser window within the jump host behind Azure Bastion. Sign in to the Azure VMware Solution VMware HCX Manager on `https://x.x.x.9` over port 443. Replace the x's with the CIDR address block used to configure with Azure VMware Solution.

1. Use the *cloudadmin@vsphere.local* user credentials to sign in.

1. Within VMware HCX Cloud Manager, select **Administration** > **System Updates** > **Check for Updates**.

1. After VMware HCX checks for a software update, select **Request Download Link**.

    :::image type="content" source="../media/3-hcx-request-download-link.png" alt-text="Screenshot of where to request a download link to the VMware HCX Connector OVA file for the on-premises VMware environment."lightbox="../media/3-hcx-request-download-link.png":::

1. Select **VMware HCX** to download the VMware HCX Connector OVA file.

    :::image type="content" source="../media/3-download-hcx-vmware-ova.png" alt-text="Screenshot of selecting VMware HCX, which downloads the OVA file for deployment on-premises."lightbox="../media/3-download-hcx-vmware-ova.png":::

1. In the web browser you chose to use, you see a status bar. This status bar highlights how long it takes to download the OVA file.

    :::image type="content" source="../media/3-status-bar-ova-download.png" alt-text="Screenshot displaying the status of downloading the OVA file for deployment.":::

## Deploy the VMware HCX Connector OVA on-premises

Next, the VMware HCX Connector OVA file needs to be installed in the on-premises VMware vSphere environment. Sign in to the web GUI of vCenter Server and begin deployment of the OVA file on-premises.

1. Right-click the vCenter Server datacenter and select **Deploy OVF Template**.

    :::image type="content" source="../media/3-deploy-ovf-template.png" alt-text="Screenshot that shows how to deploy the OVA file downloaded for VMware HCX Connector on-premises in vCenter Server.":::

1. Select the local VMware HCX Connector OVA file already downloaded from the Azure VMware Solution vSphere Client.

    :::image type="content" source="../media/3-select-ovf-template-vmware-hcx.png" alt-text="Screenshot that shows how to select a local file when prompted, during the VMware HCX Connector deployment within vCenter Server on-premises."lightbox="../media/3-select-ovf-template-vmware-hcx.png":::

1. For **Select a name and folder**, provide a name for the VMware HCX Connector appliance, select the datacenter resource, and select **Next**.

    :::image type="content" source="../media/3-select-name-folder.png" alt-text="Screenshot of where to name the VMware HCX Connector appliance and where to select the datacenter within vCenter Server on-premises.":::

1. For **Select a compute resource**, select the vSphere cluster, then select **Next**.

    :::image type="content" source="../media/3-select-compute-resource.png" alt-text="Screenshot that selects the vSphere cluster to deploy the VMware HCX Connector appliance to during deployment on-premises.":::

1. Review the advanced configuration options and select **Next**.

    :::image type="content" source="../media/3-hcx-review-details.png" alt-text="Screenshot to review advanced configuration details of the VMware HCX Connector appliance."lightbox="../media/3-hcx-review-details.png":::

1. For **License agreements**, if you agree, select **I accept all license agreements**, then select **Next**.

    :::image type="content" source="../media/3-license-agreements.png" alt-text="Screenshot of accepting all license agreements during VMware HCX Connector deployment on-premises.":::

1. Select the right storage on which to deploy VMware HCX Connector, then select **Next**.

    :::image type="content" source="../media/3-select-storage.png" alt-text="Screenshot of selecting storage for the VMware HCX Connector appliance on-premises.":::

1. Select the VMware HCX management network segment, then select **Next**.

    :::image type="content" source="../media/3-select-networks.png" alt-text="Screenshot of selecting the right management network on-premises.":::

1. In **Customize template**, note the user account used to configure VMware HCX Connector is *admin*. Enter all required information, then select **Next**.

    :::image type="content" source="../media/3-customize-template-hcx-vmware.png" alt-text="Screenshot of customizing the OVA template file for the VMware HCX Connector deployment on-premises."lightbox="../media/3-customize-template-hcx-vmware.png":::

1. On **Ready to complete**, verify all configurations and select **Finish**.

    :::image type="content" source="../media/3-ready-to-complete-hcx-on-premises.png" alt-text="Screenshot that shows the appliance is ready to complete the installation on-premises."lightbox="../media/3-ready-to-complete-hcx-on-premises.png":::

1. After the appliance deploys, you'll need to power on the virtual appliance manually in vCenter Server. Then wait 10-15 minutes before finishing the configuration.

## Activate VMware HCX

After deploying and powering on the VMware HCX Connector appliance on-premises, you activate VMware HCX Connector. You need to get a license key from the Azure VMware Solution environment in Azure.

1. Under **Manage** > **Add-ons**, select the **Migration using VMware HCX tab**, then select **+ Add**.

    :::image type="content" source="../media/3-add-vmware-hcx-activation-key-portal.png" alt-text="Screenshot to add the VMware HCX Advanced key in the Azure portal."lightbox="../media/3-add-vmware-hcx-activation-key-portal.png":::

1. Provide a name for the key and wait for Azure to generate a VMware HCX Enterprise key for use on-premises.

    :::image type="content" source="../media/3-request-vmware-hcx-activation-key.png" alt-text="Screenshot after the VMware HCX Advanced key is requested from the Azure portal."lightbox="../media/3-request-vmware-hcx-activation-key.png":::

1. Use the admin credentials you configured earlier to sign in to the on-premises VMware HCX Manager at `https://x.x.x.x:9443`. Replace the x's with the IP address configured for the on-premises appliance.

1. When prompted, enter your **HCX License Key**, then select **Add**. If you receive any errors during activation, the on-premises environment might not have open internet access or a proxy configured for activation. Check internet connectivity if VMware HCX Connector on-premises doesn't activate.

    :::image type="content" source="../media/3-enter-hcx-license-key-to-activate-hcx-instance.png" alt-text="Screenshot of where to enter the VMware HCX Connector license key on-premises to activate it."lightbox="../media/3-enter-hcx-license-key-to-activate-hcx-instance.png":::

1. In **Datacenter Location**, provide the nearest location for installing VMware HCX Connector on-premises, then select **Continue**.

    :::image type="content" source="../media/3-hcx-on-premises-system-location.png" alt-text="Screenshot that specifies the location of VMware HCX Connector on-premises during deployment."lightbox="../media/3-hcx-on-premises-system-location.png":::

1. In **System Name**, modify the VMware HCX Connector appliance name or accept the default name, and select **Continue**.

    :::image type="content" source="../media/3-hcx-on-premises-system-name.png" alt-text="Screenshot of where to provide a system name for VMware HCX Connector on-premises."lightbox="../media/3-hcx-on-premises-system-name.png":::

1. On the next screen, select **Yes, Continue** to continue setting up VMware HCX Connector on-premises.

    :::image type="content" source="../media/3-successfully-set-up-continue.png" alt-text="Screenshot of VMware HCX being successfully activated in the on-premises vCenter environment.":::

1. For **Connect your vCenter**, provide the FQDN or IP address of your vCenter Server on-premises.

1. Use a username and password of an account that can access vCenter Server on-premises, then select **Continue**.

    :::image type="content" source="../media/3-hcx-on-premises-connect-vcenter-server.png" alt-text="Screenshot of where to configure a connection to the on-premises vCenter Server environment for the VMware HCX Connector appliance."lightbox="../media/3-hcx-on-premises-connect-vcenter-server.png":::
  
1. In **Configure SSO/PSC**, provide the FQDN or IP address of your Platform Services Controller, then select **Continue**.

    :::image type="content" source="../media/3-hcx-system-configure-sso-psc.png" alt-text="Screenshot for the configuration of single sign-on and Platform Services Controller for VMware HCX Connector on-premises."lightbox="../media/3-hcx-system-configure-sso-psc.png":::

1. On the next screen, verify that the information is correct and select **Restart**. A restart can take some time to complete.

    :::image type="content" source="../media/3-finish-configuration-hcx-on-premises.png" alt-text="Screenshot of the end of configuring VMware HCX Connector on-premises."lightbox="../media/3-finish-configuration-hcx-on-premises.png":::

1. After the appliance restarts, sign back in to the VMware HCX Connector on-premises.

1. If configured correctly, vCenter Server appears with a green circle after you sign in.

1. Additionally, SSO indicates that VMware HCX Connector is configured to use the Platform Services Controller on-premises.

    :::image type="content" source="../media/3-hcx-on-premises-configuration-restart-green.png" alt-text="Screenshot of vCenter and Platform Services Controller SSO configured correctly in the on-premises VMware HCX Connector appliance."lightbox="../media/3-hcx-on-premises-configuration-restart-green.png":::

In the next unit, we'll cover how to set up a site pairing, add networking profiles, and add a compute profile.
