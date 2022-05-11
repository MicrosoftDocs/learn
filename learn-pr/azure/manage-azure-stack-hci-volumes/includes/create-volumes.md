You have completed the planning stage and now are ready to create volumes in your Azure Stack HCI proof-of-concept environment. You’ll use Windows Admin Center for this purpose.

## Create a three-way mirror volume

To create a three-way mirror volume:

1. In Windows Admin Center, connect to a Storage Spaces Direct cluster.
1. In the **Tools** pane, select **Volumes**.
1. On the **Volumes** page, select the **Inventory** tab, and then select **Create volume**.
1. In the **Create volume** pane, enter a name for the volume, and from the **Resiliency** drop-down list, select the **Three-way mirror** option.
1. In the **Size on HDD** text box, specify the size of the volume (for example, **5 TB**), and then select **Create**.

:::image type="content" source="../media/4-create-volume-windows-admin-center.png" alt-text="Screenshot of Volumes page on Windows Admin Center, with a new volume being created." border="true":::


After the volume is created, Windows Admin Center will generate a notification and the new volume will appear in the **Inventory** list.

## Create a mirror-accelerated parity volume

To create a volume with mirror-accelerated parity:

1. In Windows Admin Center, connect to a Storage Spaces Direct cluster.
1. In the **Tools** pane, select **Volumes**.
1. On the **Volumes** page, select the **Inventory** tab, and then select **Create volume**.
1. In the **Create volume** pane, enter a name for the volume, and then from the **Resiliency** drop-down list, select **Mirror-accelerated parity**.
1. In the **Parity percentage** drop-down list, select the most suitable percentage of parity.
1. In the **Size on HDD** text box, specify the size of the volume (for example, **5 TB**), and then select **Create**.
