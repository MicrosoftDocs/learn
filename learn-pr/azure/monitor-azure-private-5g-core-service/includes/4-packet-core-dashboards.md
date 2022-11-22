In addition to Log Analytics, which allows you to monitor your private mobile network from the cloud, Azure Private 5G Core provides packet core dashboards for you to monitor the network locally at each site.

The packet core dashboards allow you to monitor key statistics related to your deployment in real time. For example, you can check information on firing alerts and quickly react to emerging issues. The dashboards are powered by [*Grafana*](https://grafana.com/grafana/), an open-source, metric analytics and visualization suite.

The packet core dashboards are available from the Azure Stack Edge (ASE) server on which the packet core instance is deployed. As they run locally on the ASE server, the impact of the network bandwidth and the cloud connectivity is minimized. With the packet core dashboards, you can monitor each site in your private mobile network continuously and in real time.

## Dashboard user interface and default dashboards

Each dashboard contains the following user interface components:

- Panels: Panels are for displaying statistics. Each statistic is displayed in a panel.

  The packet core dashboards provide *graph* panels and *single stat* panels. The *graph* panels display multiple statistics and/or recent changes in a statistic. The *single stat* panels display a single statistic.

- Rows: Rows are for organizing panels. Each dashboard has a minimum of one row.

The following example dashboard contains both *graph* and *single stat* panels that are arranged into three rows:

:::image type="content" source="../media/packet-core-uplink-downlink-stats-dashboard.png" alt-text="An example dashboard that shows the graph panels and single stat panels arranged into three rows" border="true":::

By default, Azure Private 5G Core provides the following packet core dashboards:

- The **Overview** dashboard: Displays important key performance indicators (KPIs), including the number of connected devices, throughput, and any alerts firing in the system.
- The **Alert** dashboard: Provides information on the severity and effect of each currently firing alert.
- The **Device and Session Statistics** dashboard: Provides information about the device and session procedures being processed by the packet core instance.
- The **Uplink and Downlink Statistics** dashboard: Provides detailed statistics on the user plane traffic being handled by the packet core instance.
- The **Debug** dashboards: Show detailed breakdowns of the request and response statistics for the packet core instance's interfaces. The **Debug** dashboards include the **System Statistics** dashboard, the **HTTP stats** dashboard, and the **4G Interfaces** dashboard.

For more information about the packet core dashboards, see [Dashboards](/azure/private-5g-core/packet-core-dashboards). If you want to add new dashboards or customize existing dashboards based on your business needs, refer to the [Grafana documentation](https://grafana.com/docs/grafana/).

> [!NOTE]
> Some packet core dashboards display different panels depending on whether the packet core instance supports 5G or 4G user equipment (UEs).

## Access the dashboards

The URL for accessing the packet core dashboards is as follows:

`https://<LocalMonitoringIP>/grafana`

Here *\<LocalMonitoringIP\>* is the IP address for accessing the local monitoring tools that you set up when you configure the management network during Azure Private 5G Core deployment.

<!-- Need to verify if the AAD feature will be delivered for GA -->
Azure Private 5G Core provides two authentication methods for the packet core dashboards:

- Username and password: The username/password method allows you to log in the packet core dashboards with a default account. If your site isn't always connected to Azure, use this method.

  You can use the following default account to sign in:

  - Username: *admin*
  - Password: *admin*
  
  Change the password for the account after the initial sign-in.

- Azure active directory (AD): The Azure AD method allows users to log in to the packet core dashboards with their Azure accounts. If your site isn't always connected to Azure, use this method.

  For more information about enabling and configuring the Azure AD authentication method, see [Packet core dashboards](/azure/private-5g-core/packet-core-dashboards).

You can select an authentication method when you create or modify a site through the Azure portal.

## Adjust the time range

To check specific data, you may need to adjust the time range of the data displayed on a dashboard. For example, to retrieve diagnostics for historical problems, you may need to change the time range to a period in the past.

You can use the **Time picker**, which is in the top right-hand corner of each packet core dashboard, to adjust the time range for which the dashboard will display statistics. The following screenshot shows the time picker:

:::image type="content" source="../media/packet-core-dashboard-time-picker.png" alt-text="A screeshot that shows the time picker" border="true":::
