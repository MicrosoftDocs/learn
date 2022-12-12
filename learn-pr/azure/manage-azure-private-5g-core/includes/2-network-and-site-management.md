A private mobile network is a local 4G or 5G network that Azure Private 5G Core powers for an enterprise. Each private mobile network can have multiple geographically dispersed sites. A site represents a physical enterprise location containing an Azure Stack Edge (ASE) device that hosts a packet core instance. The packet core instance provides the 4G and 5G network functions for the site.

Azure Private 5G Core allows you to manage a private mobile network and its sites centrally through the Azure portal. Once a private mobile network is deployed, you'll need to manage it on a routine basis. For example, you may want to [reconfigure network slices](#configure-network-slices) or modify a site due to specific business needs. This unit introduces you to the network and site management tasks.

## Configure network slices

An enterprise may attach different UEs to its private mobile network. Applications for different UEs may have different network requirements. For example, while video analysis applications for monitoring cameras may require high band-width, control applications for robot communication may require low latency.

Azure Private 5G Core allows you to divide a private mobile network into multiple network slices, with each slice being a logical end-to-end network. You can configure unique SIM policies for a slice, and then add relevant UEs to the slice.

You can create new slices when you set up a private mobile network or modify existing slices after the network setup.

<!-- Need to verify the instructions before publication -->
For slice, you'll need to configure the following information:

- Slice name
- Slice service type (SST)
- Slice differentiator (SD)

To add a slice when you create a new private mobile network, specify appropriate values for fields in the **Slice configuration** section of the network creation screen.

To add or modify a slice for an existing private mobile network, take these steps:

1. On the Azure portal, open the **Mobile Network** resource representing the private mobile network.
1. Go to the slice details screen.

   - To create a new slice, select **Create** and then specify appropriate slice information.
   - To modify a slice, select the slice that you want to modify and then change the slice information appropriately.
   - To delete a slice, select the slice that you want to delete and then select **Delete**.

> [!NOTE]
>
> - In a private mobile network, slice names must be unique.
> - You can't delete a slice that is currently used by other components.

For detailed instructions on configuring network slices, see the relevant information in the [Azure Private 5G Core documentation](/azure/private-5g-core/).

## Modify the packet core instance in a site

Once a site is deployed and put into production, usually you don't need to modify the packet core instance in it. However, if your network requirements change or you get new requirements, you may need to reconfigure the packet core. For example, you may want to use a different ASE device to host the site or attach a new data network (DN) to the site.

To modify the packet core instance in a site, take these steps:

1. Open the **Mobile Network Site** resource that represents the site through the Azure portal.
1. Select the **Packet Core Control Plane** resource and open it.
1. On the **Overview** screen, select **Modify packet core**.

   The **Configuration** screen is displayed, as illustrated below:

   :::image type="content" source="../media/modify-packet-core-configuration.png" alt-text="A screenshot that shows an example packet core configuration screen." border="true":::

1. Edit the fields in each section appropriately.

   - In the packet core section, you can change the connected ASE device or the custom ARC location.
   - In the access network section, you can change the network interface information.
   - In the data networks section, you can edit attached DNs, define and attach a new DN, or delete a DN.

   The [Collect the required information for a site](/azure/private-5g-core/collect-required-information-for-a-site) article provides detailed information about each field.

For detailed instructions, see [Modify the packet core instance in a site](/azure/private-5g-core/modify-packet-core).

> [!NOTE]
> Power recycling an ASE device doesn't affect the packet core instance it hosts. Once the device is powered back on, all the network functions of the packet core instance should resume.

## Decommission a site

When you no longer need a site in a private mobile network, you can decommission it.

A typical decommission process is as follows:

1. Through the Azure portal, delete the **Mobile Network Site** resource that represents the site.

   1. Open the **Mobile Network** resource that contains the site you want to delete.
   1. Select **Sites** from the menu and then select the site.

      > [!TIP]
      >
      > You can delete multiple sites in a mobile network in a single operation.

   1. Select the **Delete** button and then confirm you deletion.

      When you delete a site, Azure Private 5G Core automatically detects and deletes all the dependent resources.

1. Power off the ASE device that hosts the deleted site or use it for another site.

   > [!NOTE]
   > When a site is deleted, Azure Private 5G Core keeps the resources for the corresponding ASE device intact. You can reuse the device for another site.
