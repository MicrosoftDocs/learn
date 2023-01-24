<!-- Need to verify these GA feature details before official publication -->
Azure Private 5G Core provides platform metrics through the Azure portal. Platform metrics are dashboards that visualize the network health and performance information.

Azure Private 5G Core also allows you to use an application of your choice to monitor a private mobile network. From the applications, you can use the Azure Monitor REST API to retrieve the metrics that Azure Private 5G Core shares.

## Platform metrics

On the **Overview** page of the **Mobile Network Site** resource that you use to manage a site, Azure Private 5G Core displays the platform metrics on the **Monitoring** tab, as shown in the following screenshot:

:::image type="content" source="../media/platform-metrics.png" alt-text="A screenshot that shows the platform metrics charts." lightbox="../media/platform-metrics.png":::

The platform metrics provide the health and performance information for the packet core instance. You can check metrics like user plane packets received or user plane packets dropped.

The platform metrics are automatically created when you deploy a site.

With the metrics data, you can configure alerts through the **Packet Core Control Plane** resource and get notified once an alert is triggered.

> [!NOTE]
> Currently, only one dashboard is provided for the platform metrics.

For details in using the platform metrics, see the platform metrics information in the [Azure Private 5G Core documentation](/azure/private-5g-core/).

## Application integration for network monitoring

Azure Private 5G Core offers you the flexibility to use an application of your choice to monitor a private mobile network.

To integrate an application with Azure Private 5G Core, you can use one of the following methods:

- Use the [Azure Monitor REST API](/rest/api/monitor/) to retrieve the health and performance metrics that Azure Private 5G Core shares.
- Use the Azure Monitor Metrics Explorer to analyze metrics through the Azure portal.

  The platform metrics data is stored by [Azure Monitor Metrics](/azure/azure-monitor/essentials/data-platform-metrics). You can use the Azure Monitor [Metrics Explorer](/azure/azure-monitor/essentials/metrics-getting-started) to analyze the data.

- Export the metrics to a data storage and processing service such as [Azure Monitor Log Analytics](/azure/azure-monitor/logs/log-analytics-overview), [Azure Storage](/azure/storage/), or [Azure Event Hubs](/azure/event-hubs/).

  For detailed exporting instructions, see [Stream Azure monitoring data to an event hub or external partner](/azure/azure-monitor/essentials/stream-monitoring-data-event-hubs).

The [Supported metrics with Azure Monitor](/azure/azure-monitor/essentials/metrics-supported) article provides the latest list of metrics that you can use.

To further enhance your monitoring experience, you can use [Azure Monitor Alerts](/azure/azure-monitor/alerts/alerts-overview) to alert people about the changes of important metrics. Once an alert rule is triggered, Azure Monitor Alerts take the specified actions, such as sending out a notification email or creating a support ticket.

> [!NOTE]
>
> - Exporting the network metrics to another application for application integration or longer data retention period may incur extra cost. For more information, see the documentation for the relevant application.
> - Using Azure Monitor Alerts may incur extra cost. For more information, see [Azure Monitor pricing](https://azure.microsoft.com/pricing/details/monitor/).

For details in using an application of your choice to monitor a private mobile network, see the application integration information in the [Azure Private 5G Core documentation](/azure/private-5g-core/).
