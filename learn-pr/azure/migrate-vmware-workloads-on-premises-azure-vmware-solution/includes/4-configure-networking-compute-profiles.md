After VMware HCX Connector is installed on-premises, link it to VMware HCX Cloud in Azure VMware Solution. This unit and the next one go over the steps involved in this task.

## What is a site pair?  

The first step involves creating a *site pair*. A site pair provides network connectivity needed for management, authentication, and orchestration of VMware's HCX migration services across a source and destination VMware vSphere environment. In your scenario, the source is the on-premises VMware vSphere environment and the destination is Azure VMware Solution. The following table provides additional details:

| Component| Notes |
| :------- | :----- |
| HCX Connector (source) | - Deployed in the on-premises vSphere environment after Azure VMware Solution deploys. <br>- Creates a unidirectional site pairing to Azure VMware Solution. <br>- Starts migrations to Azure VMware Solution.
| HCX Cloud (destination) | - Provisioned with Azure VMware Solution when the private cloud deploys in Azure. <br>- Generally the destination for VMware HCX site pairing. <br>- VMware HCX Cloud site is always a software-defined datacenter. <br>- Supports network extension at layer 2 in the networking stack, which is optional.

## Add a site pair

1. Sign in to the on-premises vCenter Server.

1. Under **Menu**, select **HCX**.

    :::image type="content" source="../media/4-select-hcx.png" alt-text="Screenshot of where to find HCX in the menu within vCenter on-premises.":::

1. Under **Infrastructure**, select **Site Pairing**.

1. Under **Pair your first site**, select **Connect To Remote Site**.

    :::image type="content" source="../media/4-connect-remote-site.png" alt-text="Screenshot of where to pair your first site and connect to the remote site in HCX Connector on-premises.":::

1. Enter the Azure VMware Solution HCX Cloud Manager IP address that you obtained from the last unit.

1. Enter the Azure VMware Solution **cloudadmin@vsphere.local** username and the password from the Azure portal.

1. Select **Connect**. If you receive a message about a certificate warning, import the certificate to continue.

    :::image type="content" source="../media/4-connect-to-hcx-cloud-manager.png" alt-text="Screenshot of how to connect to the remote HCX URL from the on-premises HCX Connector.":::

1. For the connection to work, VMware HCX Connector needs to route to the VMware HCX Cloud Manager IP over port 443. Use Azure ExpressRoute, which you deployed on-premises.

1. You get a screen showing that VMware HCX Cloud Manager in Azure VMware Solution and the on-premises VMware HCX Connector are connected, or paired.

    :::image type="content" source="../media/4-site-pairing-complete.png" alt-text="Screenshot when site pairing is complete in the on-premises VMware environment.":::

## Create network profiles

VMware HCX Connector on-premises deploys a set of automated virtual appliances that require multiple IP segments. You need to first configure network profiles. You'll create these network profiles for each network intended for use with VMware HCX. When you create network profiles, you'll use the IP segments identified during the VMware HCX deployment planning phase.

1. Sign in to the on-premises VMware HCX Connector.

1. Create four network profiles:

    - Management
    - vMotion
    - Replication
    - Uplink

1. Under **Infrastructure**, select **Interconnect** > **Multi-Site Service Mesh** > **Network Profiles**. Then select **Create Network Profile**.

    :::image type="content" source="../media/4-create-network-profile.png" alt-text="Screenshot of creating the network profile within HCX Connector on-premises.":::

1. For each network profile, select the network and port group, provide a name, and create the segment's IP pool. Then select **Create**.

    :::image type="content" source="../media/4-example-configurations-network-profile.png" alt-text="Screenshot of how to create a network profile within HCX Connector on-premises.":::

## Create a compute profile

After the network profiles are created, you'll need to create a compute profile. The compute profile contains the compute, storage, and network settings that VMware HCX uses to configure the *service mesh*. The service mesh is what allows VM migrations from on-premises into Azure VMware Solution.

1. Under **Infrastructure**, select **Interconnect** > **Compute Profiles** > **Create Compute Profile**.

    :::image type="content" source="../media/4-create-compute-profile.png" alt-text="Screenshot of where to create an HCX compute profile in HCX Connector on-premises.":::

1. Enter a name for the profile and select **Continue**.

    :::image type="content" source="../media/4-name-compute-profile.png" alt-text="Screenshot that shows the entry of a compute profile name and the Continue button in HCX Connector on-premises.":::

1. On the next screen, you have services set for activation. Recall that VMware HCX Enterprise deploys with Azure VMware Solution. If you need HCX Enterprise, you must open a ticket with support.

1. Leave all default services checked that can be enabled with the HCX Enterprise key and select **Continue**.

    :::image type="content" source="../media/4-select-services-activated.png" alt-text="Screenshot of the services selected for activation with HCX Connector on-premises.":::

1. In **Select Service Resources**, select one or more service resources (clusters) to enable the selected VMware HCX services.

1. When you have the clusters in your on-premises datacenter, select **Continue**.

    :::image type="content" source="../media/4-select-service-resource.png" alt-text="Screenshot that shows selected service resources and the Continue button in HCX Connector on-premises.":::

1. On the **Select Datastore** pane, select the datastore storage resource for deploying the VMware HCX Interconnect appliances. Then select **Continue**. Note that when you select multiple resources, VMware HCX uses the first resource selected until its capacity is exhausted.

    :::image type="content" source="../media/4-deployment-resources-and-reservations.png" alt-text="Screenshot that shows a selected data storage resource and the continue button in the on-premises HCX Connector.":::

1. On the **Select Management Network Profile** pane, select the management network profile that you created in previous steps, then select **Continue**.

    :::image type="content" source="../media/4-select-management-network-profile.png" alt-text="Screenshot that shows the selection of a management network profile and the Continue button in the on-premises HCX Connector.":::

1. On the **Select Uplink Network Profile** pane, select the uplink network profile you created in the prior steps, then select **Continue**.

    :::image type="content" source="../media/4-select-uplink-network-profile.png" alt-text="Screenshot that shows the selection of an uplink network profile and the Continue button in the on-premises HCX Connector.":::

1. On the **Select vMotion Network Profile** pane, select the vMotion network profile that you created in prior steps, then select **Continue**.

    :::image type="content" source="../media/4-select-vmotion-network-profile.png" alt-text="Screenshot that shows the selection of a vMotion network profile and the Continue button in the on-premises HCX Connector.":::

1. On the **Select vSphere Replication Network Profile** pane, select the replication network profile that you created in prior steps, then select **Continue**.

    :::image type="content" source="../media/4-select-replication-network-profile.png" alt-text="Screenshot that shows the selection of a replication network profile and the Continue button in the on-premises HCX Connector.":::

1. Review the connection rules and select **Continue**.

    :::image type="content" source="../media/4-review-connection-rules.png" alt-text="Screenshot that shows the connection rules and the Continue button in the on-premises HCX Connector.":::

1. Select **Finish** to create the compute profile.

    :::image type="content" source="../media/4-compute-profile-done.png" alt-text="Screenshot that shows the compute profile information in the on-premises HCX Connector.":::

1. After the compute profile finishes creation, the compute profile is listed in the **Compute Profiles** within **Interconnect**.

:::image type="content" source="../media/4-finished-compute-profile.png" alt-text="Screenshot showing the compute profile completely configured in the on-premises HCX Connector.":::

In the next unit, we'll cover how to set up a service mesh to complete the on-premises configuration of VMware HCX Connector.
