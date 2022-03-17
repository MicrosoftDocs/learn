You can create an application dashboard using either an industry focused template or the Custom application template. If you create your application from one of the industry focused templates, your application will have a pre-defined dashboard to start. If you create your application from the Custom application template, your dashboard will display a blank layout that you can customize yourself.

> [!NOTE]
> Users can create multiple dashboards in addition to the default application dashboard. These dashboards can be personal to the user only, or shared across all users of the application.

As an administrator, you can create up to 10 application dashboards that are visible to all application users. Only administrators can create, edit, and delete application-level dashboards.

All users can create their own personal dashboards. Users can switch between application dashboards and personal dashboards.

## Add tiles to a dashboard

Open your Dashboard page from the left pane of the IoT Central application. To begin customizing the default dashboard for your application, select **Edit** at the top-left of the Dashboard page. Selecting **Edit** opens the **Edit dashboard** panel, which can be used to add and remove tiles in order to customize the dashboard. Selecting either **New dashboard** or **Copy** will also place the dashboard in edit mode.

You have two initial options when preparing to add a tile to your dashboard, **Start with a visual** and **Start with a device**.

For example, to add a line chart tile to track telemetry values reported by one or more devices over time:

1.  Select **Start with a Visual**, Line chart, and then **Add tile**, or just drag the tile onto the canvas..
2.  To edit the tile, select its **pencil** button. Enter a **Title** and select a **Device Group**. In the **Devices** list, select the devices to show on the tile.
3.  After you select all the devices to show on the tile, select **Update**.
4.  After you finish adding and customizing tiles on the dashboard, select **Save**.

    :::image type="content" source="../media/m12-l05-dashboard-add-tiles-a2d83481.png" alt-text="Screenshot that shows how to add a tile to the dashboard in the IoT Central application.":::


Each tile has a pre-selected graph, chart, etc. that will be displayed when the tile is created. However, users can choose to edit and change this visualization.

## Edit tiles

To edit a tile on the dashboard, first select **Edit** at the top left of the page, which will open edit mode for the dashboard and all its tiles. This provides you with the following options::

 -  The **square** button lets you resize the tile.
 -  The **pencil** button lets you edit the visualization. For example, for a line chart you can choose to show the legend and axes and choose the time range to plot.
 -  The **copy** button lets you create a duplicate of the tile.

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
    Line Chart
  :::column-end:::
  :::column:::
    Line chart tiles plot one or more aggregate telemetry values for one or more devices over a time period. For example, you can display a line chart to plot the average temperature and pressure of one or more devices during the past hour.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bar Chart
  :::column-end:::
  :::column:::
    Bar chart tiles plot one or more aggregate telemetry values for one or more devices over a time period. For example, you can display a bar chart to show the average temperature and pressure of one or more devices during the past hour.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Pie Chart
  :::column-end:::
  :::column:::
    Pie chart tiles display one or more aggregate telemetry values for one or more devices over a time period.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Heat Map
  :::column-end:::
  :::column:::
    Heat map tiles display information, represented in colors, about one or more devices.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event History
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


For more information about creating and customizing dashboards, see: [https://docs.microsoft.com/azure/iot-central/core/howto-manage-dashboards](/azure/iot-central/core/howto-manage-dashboards)
