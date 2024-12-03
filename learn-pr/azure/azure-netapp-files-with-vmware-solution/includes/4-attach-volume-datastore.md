Azure VMware Solution (AVS) supports attaching Network File System (NFS) datastores as a persistent storage option to expand virtual machine storage without scaling the AVS cluster.

To attach your NFS datastore as a persistent storage option in AVS, you need the following resources:

- Access to an Azure subscription with an AVS private cloud.
- A dedicated VNet connected via an ExpressRoute gateway.
- An Azure NetApp Files capacity pool, and an Azure NetApp Files delegated subnet.

Then use the following steps to configure Azure NetApp Files and Azure VMware Solution:

1. Navigate to the Azure NetApp Files capacity pool in the Azure portal.
    1. Select **Volumes** then **+Add Volume** to create a volume.
    1. In the **Basics** tab, enter the **Volume name**.
    1. In the **Basics** tab, provide a **Quota** (GiB) to set the size and performance of the datastore.
    1. In the **Basics** tab, ensure the Virtual network selected is connected to the AVS private cloud via an ExpressRoute gateway and has FastPath enabled.
    1. In the **Basics** tab, select the Delegated subnet.
    1. In the **Basics** tab, ensure that **Standard network features** is selected.
    1. In the **Basics** tab, select the **Availability zone** that matches the availability zone of your AVS private cloud.
    1. In the **Protocol** tab, ensure **Azure VMware Solution datastore** is selected.
    1. In the **Review + create** tab, select **Create** to create the volume.

1. Navigate to your Azure VMware Solution private cloud in the Azure portal.
    1. Select the **Storage** menu, then + Connect Azure NetApp Files volume.
    1. Select the **Subscription**, **NetApp account**, **Capacity pool**, and **Volume** to be attached as a datastore.
    1. To associate the volume as a datastore, select the Azure VMware Solution Client cluster.
    1. Provide a personalized name for your **Datastore name**.
    1. Select **Review + create.**
    1. Navigate to the **Storage** menu to validate the datastore details.
1. Check that you can see the NFS datastore from vCenter.

Once you create the AVS datastore backed by Azure NetApp Files, you can create VMs in the datastore or use storage vMotion to move VMs from other datastores.