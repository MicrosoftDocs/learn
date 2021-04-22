Remember that HCX Advanced deploys by default when AVS provisions in Azure. Before configuring site pairings for your migration, the next step involves deployment and configuration of the HCX Connector on-premises. 

## Download VMware HCX Connector
Before deploying the virtual appliance in the on-premises vCenter, the VMware HCX Connector OVA needs to be downloaded.

1. Search for and select the Azure VMware Solution private cloud in the Azure portal.

1. Under **Manage** select **Connectivity**.

1. Select the HCX tab to identify the AVS HCX Manager's IP address.

    :::image type="content" source="../media/2-find-hcx-address.png" alt-text="Screen shot showcasing where to find the HCX IP address.":::

1. Then select **Identity** under Manage.

1. The URLs and user credentials for the AVS vCenter and NSX-T Manager will display.

     :::image type="content" source="../media/2-display-user-credentials-avs.png" alt-text="Screen shot highlighting where to find the vCenter and NSX login information.":::

1. Open a new browser window and sign in to the AVS HCX Manager on https://x.x.x.9 port 443 with the cloudadmin@vsphere.local user credentials.





1. Select Administration > System Updates and then select Request Download Link.

1. Select the option of your choice to download the VMware HCX Connector OVA file.

Deploy the VMware HCX Connector OVA on-premises
In your on-premises vCenter, select an OVF template to deploy the VMware HCX Connector to your on-premises vCenter.

 Tip

You'll select the OVA file that you downloaded in the previous section.

Screenshot of browsing to an OVF template.

Select a name and location, and select a resource or cluster where you're deploying the VMware HCX Connector. Then review the details and required resources and select Next.

Review license terms. If you agree, select the required storage and network, and then select Next.

Select storage and select Next.

Select the VMware HCX management network segment you previously defined in the IP addresses prerequisites section. Then, select Next.

In Customize template, enter all required information and then select Next.

Verify the configuration, and then select Finish to deploy the VMware HCX Connector OVA.

 Important

You will need to turn on the virtual appliance manually. After powering on, wait 10-15 minutes before proceeding to the next step.

For an end-to-end overview of this procedure, view the Azure VMware Solution: HCX Appliance Deployment video.

Activate VMware HCX
After you deploy the VMware HCX Connector OVA on-premises and start the appliance, you're ready to activate. First, you need to get a license key from the Azure VMware Solution portal.

In the Azure VMware Solution portal, go to Manage > Connectivity, select the HCX tab, and then select Add.

Use the admin credentials to sign in to the on-premises VMware HCX Manager at https://HCXManagerIP:9443.

 Tip

You defined the admin user password during the VMware HCX Manager OVA file deployment.

 Important

Make sure to include the 9443 port number with the VMware HCX Manager IP address.

In Licensing, enter your key for HCX Advanced Key and select Activate.

 Note

VMware HCX Manager must have open internet access or a proxy configured.

In Datacenter Location, provide the nearest location for installing the VMware HCX Manager on-premises. Then select Continue.

In System Name, modify the name or accept the default and select Continue.

Select Yes, Continue.

In Connect your vCenter, provide the FQDN or IP address of your vCenter server and the appropriate credentials, and then select Continue.

 Tip

The vCenter server is where you deployed the VMware HCX Connector in your datacenter.

In Configure SSO/PSC, provide the FQDN or IP address of your Platform Services Controller, and then select Continue.

 Note

Typically, it's the same as your vCenter FQDN or IP address.

Verify that the information entered is correct and select Restart.

 Note

You'll experience a delay after restarting before being prompted for the next step.

After the services restart, you'll see vCenter showing as green on the screen that appears. Both vCenter and SSO must have the appropriate configuration parameters, which should be the same as the previous screen.

Screenshot of the dashboard with green vCenter status.

For an end-to-end overview of this procedure, view the Azure VMware Solution: Activate HCX video.

 Important

Whether you're using HCX Advanced or HCX Enterprise, you may need to install the patch from VMware's KB article 81558.

**VMware HCX deployment and installation**

    - Log into HCX in AVS.
    - Use cloudadmin@vsphere.local account for HCX access.
    - Request download link and download OVA file for deployment.
    - Once OVA file is downloaded, deploy OVF template in on-premises vCenter.
    - Fill in all required fields for template deployment.
    - Activate VMware HCX: log into HCX, enter key in licensing field, configure SSO/PSC, restart HCX appliance.
