For this module, a private mobile network is a local 4G or 5G network where the Azure Private 5G Core is deployed. Each private mobile network can have multiple geographically dispersed sites. A site represents a physical enterprise location containing an Azure Stack Edge (ASE) device that hosts a packet core instance. The packet core instance provides either the 4G or 5G network functions needed for that site.

Azure Private 5G Core allows you to manage a private mobile network and its sites centrally through the Azure portal. Once a private mobile network is deployed, you might need to manage it occasionally to support new applications or add/remove user equipment (UE) devices. For example, you might want to [reconfigure network slices](#configure-network-slices) or modify a site based on specific business needs. This unit introduces you to the network and site management tasks.

## Configure network slices

An enterprise can attach different UEs to its private mobile network. Applications for different UEs might have different network quality of service or bandwidth requirements. For example, video analysis applications for production line monitoring cameras might require high bandwidth, while control applications for robot communication might require high levels of priority.

Azure Private 5G Core allows you to divide a private mobile network into multiple network slices, with each slice being a logical end-to-end network. You can configure SIM policies with different slices available. Each SIM policy specifies how the network traffic from relevant UEs should be controlled on a per slice basis.

You can create new slices when you set up a private mobile network or modify existing slices after the network setup.

For each slice, you need to configure the following fields:

- Slice name: The name of the slice.

  In a private mobile network, slice names must be unique.

- Slice Service Type (SST): The service type of the slice.

  Valid values are 0 to 255, with 0-127 reserved for standards defined usages. For example, `1` is a typical default and is used for Enhanced Mobile Broadband (eMBB) devices like smartphones.

- Slice Differentiator (SD): Optional. A differentiator that helps identify slices of the same slice service type.

  Valid values are 0 to 16777216. For example, while two slices might both have `1` (eMBB) as the value of its service type, their slice differentiators are different, with one being `1` and the other being `2`, which identifies each slice uniquely.

  > [!NOTE]
  > The combination of SST and SD must be unique across the private mobile network.

For more information about these fields, see the documentation for relevant 5G standards.

To add or modify a slice for an existing private mobile network, take these steps:

1. On the Azure portal, open the **Mobile Network** resource representing the private mobile network.
1. From the resource menu, select **Slices**.

   The slice details screen is displayed, as shown in the following screenshot:

   :::image type="content" source="../media/slice-details.png" alt-text="A screenshot that shows an example slice details screen." border="true":::

1. Proceed with one of the following options:

   - To create a new slice, select **Create**, and then specify appropriate slice information.
   - To modify a slice, select the slice that you want to modify, and then select **Modify the selected slice**.
   - To delete a slice, select the slice that you want to delete, and then select **Delete**.

> [!NOTE]
>
> - Network slices are only supported in 5G networks. For 4G networks, all UEs are assigned to the slice with an SST value of 1 and no SD.
> - You can't delete a slice that is currently used by other components.

For detailed instructions on configuring network slices, see [Create and manage network slices - Azure portal](/azure/private-5g-core/create-manage-network-slices) and [Create a slice using an ARM template](/azure/private-5g-core/create-slice-arm-template).

## Modify the packet core instance in a site

You don't usually need to modify the packet core instance in a site, once the site is deployed and put into production. However, you might need to reconfigure the packet core instance if your network requirements change, or you get new requirements. For example, you might want to use a different ASE device to host the site or attach a new data network (DN) to the site.

To modify the packet core instance in a site, take these steps:

1. Open the **Mobile Network Site** resource that represents the site through the Azure portal.
1. Select the **Packet Core Control Plane** resource and open it.
1. On the **Overview** screen, select **Modify packet core**.

   The **Configuration** screen is displayed, as shown in the following screenshot:

   :::image type="content" source="../media/modify-packet-core-configuration.png" alt-text="A screenshot that shows an example packet core configuration screen." border="true":::

1. Edit the fields in each section appropriately.

   - In the packet core section, you can change the connected ASE device or the custom ARC location.
   - In the access network section, you can change the network interface information.
   - In the data networks section, you can edit attached data networks (DNs), define and attach a new DN, or delete a DN.

   The [Collect the required information for a site](/azure/private-5g-core/collect-required-information-for-a-site) article provides detailed information about each field.

For detailed instructions, see [Modify the packet core instance in a site](/azure/private-5g-core/modify-packet-core).

## Modify a site plan

For a site, the *site plan* determines the following information:

- The throughput and the number of radio access network (RAN) connections.
- The number of devices that each network supports.

You might need to update the site plan if your deployment requirements change.

To modify the site plan for a site, take these steps:

1. Open the **Mobile Network Site** resource that represents the site through the Azure portal.
1. Select **Overview**, and then select **Change Plan**.
1. Select the new site plan you want to use.

For detailed instructions, see [Modify a site plan](/azure/private-5g-core/modify-site-plan).

## Decommission a site

When you no longer need a site in a private mobile network, you can decommission it.

A typical decommission process is as follows:

1. Through the Azure portal, delete the **Mobile Network Site** resource that represents the site.

   1. Open the **Mobile Network** resource that contains the site you want to delete.
   1. Select **Sites** from the menu, and then select the site.

      > [!TIP]
      >
      > You can delete multiple sites in a mobile network in a single operation.

   1. Select the **Delete** button, and then confirm your deletion.

      When you delete a site, Azure Private 5G Core automatically detects and deletes all the dependent resources.

1. Power off the ASE device that hosts the deleted site or use it for another site.

   > [!NOTE]
   > When a site is deleted, the resources representing the ASE device for the site remain intact. You can reuse the device for another site.
