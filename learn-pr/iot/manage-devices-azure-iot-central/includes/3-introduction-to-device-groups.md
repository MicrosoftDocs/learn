A device group is a list of devices that are grouped together because they match some specified criteria. Device groups help you manage, visualize, and analyze devices at scale by grouping devices into smaller, logical groups. For example, you can create a device group to list all the air conditioner devices in Seattle to enable a technician to find the devices for which they're responsible.

## To create a device group

1. Select **Device groups** on the left pane.
1. Select **+ New**.
1. Give your device group a name. You can also add a description for the device group.

    > [!NOTE]
    > A device group can only contain devices from a single device template.
1. Create a query to identify the devices that will belong to the device group by adding filter criteria. The device group you create is accessible to anyone who has access to the application, so anyone can view, modify, or delete the device group.

    > [!NOTE]
    > The device group is a dynamic query. Every time you view the list of devices, there may be different devices in the list. The list depends on which devices currently meet the criteria of the query.
1. Select **Save**.

:::image type="content" source="../media/device-group.png" alt-text="Screenshot that shows a default device group.":::

## Data explorer and device groups

You can use the data explorer with a device group to analyze the telemetry from the devices in the group.

To analyze the telemetry for a device group:

1. Select **Data explorer** on the left pane.
1. Select a device group, and then select desired telemetry types. You can specify an aggregation type for telemetry values. The default aggregation type is **Average**. You can use **Group by** to change how the aggregate data is shown. For example, if you group by device ID you see a plot for each device when you select **Analyze**.
1. Select **Analyze** to view a plot of the specified telemetry values.

:::image type="content" source="../media/data-explorer.png" alt-text="Screenshot that shows the data explorer.":::
