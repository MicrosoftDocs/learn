After installing the HCX Connector on-premises, next you need to link the HCX Connector on-premises to HCX Cloud in AVS. This task contains several steps that will be outlined in this unit and the next unit.

## What is a site pair?  

The first step you need to take involves creating a site pair. A site pair provides network connectivity needed for management, authentication, and orchestration of VMware's HCX migration services across a source and destination VMware environment. In your scenario, the source will be the on-premises VMware environment and the destination will be AVS. In order to better understand what both environments contain, please reference the following chart for more information:

| Component| Notes |
| :------- | :----- |
| HCX Connector (source) | - Deployed in the on-premises vSphere environment. <br>- Creates a unidirectional site pairing to AVS. <br>- Initiates migrations to AVS.
| HCX Cloud (destination) | - Provisioned with AVS when the private cloud deploys in Azure. <br>- Generally the destination for HCX site pairing. <br>- HCX Cloud site is always a Software Defined Data Center (SDDC). <br>- Supports network extension at layer 2 in the networking stack.

## Add a site pair

1. Sign in to the on-premises vCenter.

1. Under **Menu**, select **HCX**.

    :::image type="content" source="../media/4-select-hcx.png" alt-text="Screen shot showing where to find HCX in the drop down menu within vCenter.":::

1. Under **Infrastructure**, select **Site Pairing**.

1. Under **Pair your first site**, select the **Connect To Remote Site**.

    :::image type="content" source="../media/4-connect-remote-site.png" alt-text="Screen shot displaying where to pair your first site and connect to the remote site in the on-premises vCenter.":::

1. Enter the AVS HCX Cloud Manager IP address you obtained from the last unit.

1. Type the Azure VMware Solution **cloudadmin@vsphere.local** username and the password from the Azure portal.

1. Then select **Connect**.

    :::image type="content" source="../media/4-connect-to-avs-hcx-cloud-manager.png" alt-text="Screeh shot showing how to connect to the remote HCX URL from the on-premises vCenter HCX Connector.":::

1. In order for the connection to work, VMware HCX Connector must be able to route to the HCX Cloud Manager IP over port 443.

1. You'll see a screen showing that the VMware HCX Cloud Manager in Azure VMware Solution and the on-premises VMware HCX Connector are connected (paired).

    :::image type="content" source="../media/4-site-pairing-complete.png" alt-text="Screen shot showing site pairing is complete.":::

## Create network profiles
The VMware HCX Connector deploys a set of automated virtual appliances that require multiple IP segments. You need to first configure network profiles. These network profiles need to be created for each network intended for use with HCXWhen creating network profiles, you use the IP segments identified during the HCX deployment planning period.

1. Log into the on-premises HCX Connector.

1. You'll need to create four network profiles in the on-premises HCX Connector:

    - Management
    - vMotion
    - Replication
    - Uplink

1. Under **Infrastructure**, select **Interconnect > Multi-Site Service Mesh > Network Profiles > Create Network Profile**.

    :::image type="content" source="../media/4-create-network-profile.png" alt-text="Screen shot of creating the network profile within the HCX Connector in the on-premises vCenter.":::

1. For each network profile, select the network and port group, provide a name, and create the segment's IP pool. Then select **Create**.

    :::image type="content" source="../media/4-example-configurations-network-profile.png" alt-text="Screen shot showing how to create a network profile in the on-premises HCX Connector.":::

## Create a compute profile

