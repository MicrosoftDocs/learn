In IoT Central, dashboards are used primarily to view and assess the property, telemetry, and state information of devices.

Administrators create a default organization dashboard using either an industry focused application template or the custom application template when they create an Azure IoT Central application. If your application was created from one of the industry focused templates, your application will have a pre-defined organization dashboard to start. If your application was created from the custom application template, your default organization dashboard will display a blank layout that you can customize yourself.

As an administrator, you can create more organization dashboards that are associated with a specific organization. An organization dashboard is only visible to users who have access to the organization the dashboard is associated with.

> [!NOTE]
> Only users in a role that has organization dashboard permissions can create, edit, and delete organization dashboards. All users can create personal dashboards, visible only to themselves. Users can switch between organization and personal dashboards.

In addition to configuring dashboards, IoT Central administrators are often responsible for configuring UI customizations and managing security considerations. Application settings that affect security include settings for users, roles, and organizations (device authentication is normally configured by the solution builder or specified by the device developer). You can find detailed information about administering your IoT Central application in the following resources:

- [Customize your IoT Central application UI](/azure/iot-central/core/howto-customize-ui)
- [Manage users and roles](/azure/iot-central/core/howto-manage-users-roles)
- [Manage IoT Central organizations](/azure/iot-central/core/howto-create-organizations)

## Create a dashboard

Open your **Dashboards** page from the left pane of the IoT Central application. To create a new dashboard from scratch, select **Go to dashboard catalog** &gt; **+ New**. To create a new dashboard by copying the current dashboard, select **Copy**. In the **Create dashboard** or **Duplicate dashboard** panel, give your dashboard a name and select either **Organization** or **Personal** as the dashboard type. If you're creating an organization dashboard, choose the organization the dashboard is associated with. An organization dashboard and its tiles only show the devices that are visible to the organization and any of its suborganizations.

## Add tiles to a dashboard

If you're in a role with the appropriate permissions, you can customize an organization dashboard. All users can customize personal dashboards.

Open your Dashboard page from the left pane of the IoT Central application. To begin customizing the dashboard, select **Edit** at the top-left of the Dashboard page. Selecting **Edit** opens the dashboard in edit mode where you add, customize, and remove tiles in order to customize the dashboard. Selecting either **New dashboard** or **Copy** will also open a dashboard in edit mode.

You have two initial options when preparing to add a tile to your dashboard, **Start with a visual** and **Start with a device**.

For example, to add a line chart tile to track telemetry values reported by one or more devices over time:

1. Select **Start with a visual**, **Line chart**, and then **Add tile**, or just drag the tile onto the canvas.
1. To edit the tile, select its **pencil** icon. Enter a **Title** and select a **Device group**. In the **Devices** list, select the devices to show on the tile.
1. After you select all the devices to show on the tile, select **Update**.
1. After you finish adding and customizing tiles on the dashboard, select **Save**.

    :::image type="content" source="../media/dashboard-tiles.png" alt-text="Screenshot that shows how to add a tile to the dashboard in the IoT Central application.":::

## Edit tiles

To edit a tile on the dashboard, first select **Edit** at the top left of the page, which will open edit mode for the dashboard and all its tiles. This provides you with the following options:

- The **square** icon lets you resize the tile.
- The **pencil** icon lets you edit the visualization. For example, for a line chart you can choose to show the legend and axes and choose the time range to plot.
- The **copy** icon lets you create a duplicate of the tile.

## Tile types

The following table describes the types of tiles that you can add to a dashboard:

:::row:::
  :::column:::
    **Tile**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    KPI
  :::column-end:::
  :::column:::
    KPI tiles display aggregate telemetry values for one or more devices over a time period. For example, you can use them to show the maximum temperature and pressure reached for one or more devices during the past hour.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Last known value
  :::column-end:::
  :::column:::
    Last known value tiles display the latest telemetry values for one or more devices. For example, you can use this tile to display the most recent temperature, pressure, and humidity values for one or more devices.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Line chart
  :::column-end:::
  :::column:::
    Line chart tiles plot one or more aggregate telemetry values for one or more devices over a time period. For example, you can display a line chart to plot the average temperature and pressure of one or more devices during the past hour.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bar chart
  :::column-end:::
  :::column:::
    Bar chart tiles plot one or more aggregate telemetry values for one or more devices over a time period. For example, you can display a bar chart to show the average temperature and pressure of one or more devices during the past hour.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Pie chart
  :::column-end:::
  :::column:::
    Pie chart tiles display one or more aggregate telemetry values for one or more devices over a time period.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Heat map
  :::column-end:::
  :::column:::
    Heat map tiles display information, represented in colors, about one or more devices.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event history
  :::column-end:::
  :::column:::
    Event history tiles display the events for a device over a time period. For example, you can use them to show all the valve open and valve close events for one or more devices during the past hour.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    State history
  :::column-end:::
  :::column:::
    State history tiles list and display status changes for state telemetry.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event chart
  :::column-end:::
  :::column:::
    Event chart tiles display telemetry events for one or more devices over a time period. For example, you can use this tile to display properties like the temperature changes for a device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    State chart
  :::column-end:::
  :::column:::
    State chart tiles plot changes for one or more devices over a time period. For example, you can use this tile to display properties like the temperature changes for a device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Property
  :::column-end:::
  :::column:::
    Property tiles display the current values for properties and cloud properties for one or more devices. For example, you can use this tile to display device properties like the manufacturer or firmware version.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Map (property)
  :::column-end:::
  :::column:::
    Map tiles that display the location of one or more devices on a map.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Map (telemetry)
  :::column-end:::
  :::column:::
    Map tiles that display the location of one or more devices on a map. You can also display up to 100 points of a device's location history. For example, you can display a sampled route of where a device has been in the past week.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Image
  :::column-end:::
  :::column:::
    Image tiles display a custom image and can be clickable. The URL can be a relative link to another page in the application or an absolute link to an external site.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Label
  :::column-end:::
  :::column:::
    Label tiles display custom text on a dashboard. You can choose the size of the text. Use a label tile to add relevant information to the dashboard such descriptions, contact details, or Help.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Markdown
  :::column-end:::
  :::column:::
    Markdown tiles are clickable tiles that display a heading and description text formatted in Markdown. The URL can be a relative link to another page in the application or an absolute link to an external site.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    External content
  :::column-end:::
  :::column:::
    External content tiles allow you to load content from an external source.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Number of devices
  :::column-end:::
  :::column:::
    Number of devices tiles display the number of devices in a device group.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Data explorer query
  :::column-end:::
  :::column:::
    Data explorer query tiles display a saved data explorer query.
  :::column-end:::
:::row-end:::

For more information about creating and customizing dashboards, see: [Create and manage dashboards](/azure/iot-central/core/howto-manage-dashboards)
