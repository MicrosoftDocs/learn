Azure VMware Solution (AVS) supports attaching Network File System (NFS) datastores as a persistent storage option to expand virtual machine storage without scaling the AVS cluster.

To complete the exercise, you will need access to an Azure subscription with an AVS private cloud, a dedicated VNet connected via an ExpressRoute gateway, an Azure NetApp Files capacity pool, and an Azure NetApp Files delegated subnet.

1. Navigate to the Azure NetApp Files capacity pool in the Azure portal.
    1. Select **Volumes** then **+Add Volume** to create a volume.
    1. In the **Basics** tab, enter the **Volume name**.
    1. In the **Basics** tab, provide a **Quota** (GiB) to set the size and performance of the datastore.
    1. In the **Basics** tab, ensure the Virtual network selected is connected to the AVS private cloud via an ExpressRoute gateway and has FastPath enabled.
    1. In the **Basics** tab, select the Delegated subnet.
    1. In the **Basics** tab, ensure you've selected **Standard network features**.
    1. In the **Basics** tab, select the **Availability zone (AZ)** that matches the AZ of your AVS private cloud.
    1. In the **Protocol** tab, ensure **Azure VMware Solution datastore** is selected.
    1. In the **Review + create** tab, select **Create** to create the volume.
1. Navigate to your Azure VMware Solution private cloud in the Azure portal.
    1. Select the **Storage** menu, then + Connect Azure NetApp Files volume.
    1. Select the **Subscription**, **NetApp account**, **Capacity pool** and **Volume** to be attached as a datastore.
    1. Select the Azure VMware Solution Client cluster to associate the volume as a datastore.
    1. Provide a personalized name for your **Datastore name**.
    1. Select **Review + create.**
    1. Navigate to the **Storage** menu to validate the datastore details.
1. Check that you can see the NFS datastore from vCenter.

Once you've created the AVS datastore backed by Azure NetApp Files, you can create VMs in the datastore or use storage vMotion to move VMs from other datastores.