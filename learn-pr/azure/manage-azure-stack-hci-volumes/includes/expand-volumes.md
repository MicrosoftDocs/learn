Another common management action you intend to assess as part of your Azure Stack HCI evaluation is expanding volumes. Here as well, you intend to simplify your task by using Windows Admin Center.

Before you expand a volume, make sure you have enough capacity in the storage pool to accommodate its new, larger footprint. For example, if you resize a three-way mirror volume from 1 TB to 2 TB, its footprint grows from 3 TB to 6 TB. For the resize to succeed, you would need at least 3 TB (based on the new 6 TB minus the currently existing 3 TB) of available capacity in the storage pool.

To expand a volume by using Windows Admin Center:

1. In Windows Admin Center, connect to a Storage Spaces Direct cluster.
1. In the **Tools** pane, select **Volumes**.
1. On the **Volumes** page, select the **Inventory** tab, and then select the volume you intend to expand.
1. On the **Volumes** page toolbar, select **Expand**. Specify the new, larger size, and then select **Expand** again.
