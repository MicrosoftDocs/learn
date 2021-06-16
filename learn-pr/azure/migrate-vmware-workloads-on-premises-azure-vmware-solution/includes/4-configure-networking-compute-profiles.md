After the HCX Connector installs on-premises, you need to link the HCX Connector on-premises to HCX Cloud in AVS. This task contains several steps that will be outlined in this unit and the next unit.

## What is a site pair?  

The first step involves creating a site pair. A site pair provides network connectivity needed for management, authentication, and orchestration of VMware's HCX migration services across a source and destination VMware environment. In your scenario, the source will be the on-premises VMware environment and the destination will be AVS. To better understand what both environments contain, please reference the following chart for more information:

| Component| Notes |
| :------- | :----- |
| HCX Connector (source) | - Deployed in the on-premises vSphere environment after AVS deploys. <br>- Creates a unidirectional site pairing to AVS. <br>- Starts migrations to AVS.
| HCX Cloud (destination) | - Provisioned with AVS when the private cloud deploys in Azure. <br>- Generally the destination for HCX site pairing. <br>- HCX Cloud site is always a Software Defined Data Center (SDDC). <br>- Supports network extension at layer 2 in the networking stack, which is optional.

## Add a site pair

1. Log into the on-premises vCenter.

1. After logging in, under **Menu**, select **HCX**.

    :::image type="content" source="../media/4-select-hcx.png" alt-text="Screenshot showing where to find HCX in the drop-down menu within vCenter on-premises.":::

1. Under **Infrastructure**, select **Site Pairing**.

1. Under **Pair your first site**, select the **Connect To Remote Site**.

    :::image type="content" source="../media/4-connect-remote-site.png" alt-text="Screenshot displaying where to pair your first site and connect to the remote site in the HCX Connector on-premises.":::

1. Enter the AVS HCX Cloud Manager IP address you obtained from the last unit.

1. Type the AVS **cloudadmin@vsphere.local** username and the password from the Azure portal.

1. Then select **Connect**. If you receive a messages about a certificate warning, import the certificate to continue.

    :::image type="content" source="../media/4-connect-to-avs-hcx-cloud-manager.png" alt-text="Screenshot showing how to connect to the remote HCX URL from the on-premises HCX Connector.":::

1. In order for the connection to work, the HCX Connector needs to route to the HCX Cloud Manager IP over port 443 via the ExpressRoute you have deployed on-premises.

1. You'll see a screen showing that the HCX Cloud Manager in AVS and the on-premises VMware HCX Connector are connected or paired.

    :::image type="content" source="../media/4-site-pairing-complete.png" alt-text="Screenshot showing site pairing is complete in the on-premises VMware environment.":::

## Create network profiles
The VMware HCX Connector on-premises deploys a set of automated virtual appliances that require multiple IP segments. You need to first configure network profiles. These network profiles will be created for each network intended for use with HCX. When creating network profiles, you'll use the IP segments identified during the HCX deployment planning phase.

1. Log into the on-premises HCX Connector.

1. You'll need to create four network profiles in the on-premises HCX Connector:

    - Management
    - vMotion
    - Replication
    - Uplink

1. Under **Infrastructure**, select **Interconnect > Multi-Site Service Mesh > Network Profiles > Create Network Profile**.

    :::image type="content" source="../media/4-create-network-profile.png" alt-text="Screenshot of creating the network profile within the HCX Connector on-premises.":::

1. For each network profile, select the network and port group, provide a name, and create the segment's IP pool. Then select **Create**.

    :::image type="content" source="../media/4-example-configurations-network-profile.png" alt-text="Screenshot showing how to create a network profile within the HCX Connector on-premises.":::

## Create a compute profile

After the network profiles are created, you'll need to create a compute profile. The compute profile contains the compute, storage, and network settings that HCX uses to configure the service mesh. The service mesh is what allows VM migrations from on-premises into AVS.

1. Under **Infrastructure**, select **Interconnect > Compute Profiles > Create Compute Profile**.

    :::image type="content" source="../media/4-create-compute-profile.png" alt-text="Screenshot showing where to create an HCX compute profile in the HCX Connector on-premises.":::

1. Enter a name for the profile and select **Continue**.

    :::image type="content" source="../media/4-name-compute-profile.png" alt-text="Screenshot that shows the entry of a compute profile name and the Continue button in the HCX Connector on-premises.":::

1. On the next screen, you'll see services set for activation. Recall that HCX Advanced deploys with AVS. If you need HCX Enterprise, a ticket needs to be open with support.

1. Leave all default services checked that can be enabled with the HCX Advanced key and select **Continue**.

    :::image type="content" source="../media/4-select-services-activated.png" alt-text="Screenshot showing the services selected for activation with the HCX Connector on-premises.":::

1. In **Select Service Resources**, select one or more service resources (clusters) to enable the selected VMware HCX services.

1. When you see the clusters in your on-premises datacenter, select **Continue**.

    :::image type="content" source="../media/4-select-service-resource.png" alt-text="Screenshot that shows selected service resources and the Continue button in the HCX Connector on-premises.":::

1. On the **Select Datastore** pane, select the datastore storage resource for deploying the VMware HCX Interconnect appliances. Then select **Continue**. Note, when multiple resources are selected, VMware HCX uses the first resource selected until its capacity is exhausted.

    :::image type="content" source="../media/4-deployment-resources-and-reservations.png" alt-text="Screenshot that shows a selected data storage resource and the continue button in the on-premises HCX Connector.":::

1. On the **Select Management Network Profile** pane, select the management network profile you created in previous steps. Then select **Continue**.

    :::image type="content" source="../media/4-select-management-network-profile.png" alt-text="Screenshot that shows the selection of a management network profile and the Continue button in the on-premises HCX Connector.":::

1. On the **Select Uplink Network Profile** pane, select the uplink network profile you created in the prior steps. Then select **Continue**.

    :::image type="content" source="../media/4-select-uplink-network-profile.png" alt-text="Screenshot that shows the selection of an uplink network profile and the Continue button in the on-premixes HCX Connector.":::

1. On the **Select vMotion Network Profile** pane, select the vMotion network profile that you created in prior steps. Then select **Continue**.

    :::image type="content" source="../media/4-select-vmotion-network-profile.png" alt-text="Screenshot that shows the selection of a vMotion network profile and the Continue button in the on-premises HCX Connector.":::

1. On the **Select vSphere Replication Network Profile** pane, select the replication network profile that you created in prior steps. Then select **Continue**.

    :::image type="content" source="../media/4-select-replication-network-profile.png" alt-text="Screenshot that shows the selection of a replication network profile and the Continue button in the on-premises HCX Connector.":::

1. Review the connection rules and select **Continue**.

    :::image type="content" source="../media/4-review-connection-rules.png" alt-text="Screenshot that shows the connection rules and the Continue button in the on-premises HCX Connector.":::

1. Select **Finish** to create the compute profile.

    :::image type="content" source="../media/4-compute-profile-done.png" alt-text="Screenshot that shows the compute profile information.":::

1. After the compute profile finishes creation, the compute profile will be listed in the **Compute Profiles** within **Interconnect**.

:::image type="content" source="../media/4-finished-compute-profile.png" alt-text="Screenshot showing the compute profile completely configured.":::

In the next unit, we'll cover how to set up a service mesh to complete the HCX Connector configuration on-premises. All steps will be outlined so you can successfully configure within your environment.