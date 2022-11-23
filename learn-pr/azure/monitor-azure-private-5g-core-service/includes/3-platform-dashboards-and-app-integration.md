<!-- Need to verify these GA feature details before official publication -->

In addition to Azure Log Analytics, Azure Private 5G Core offers a list of platform metrics dashboards, which provides you visualized views of network performance health metrics.

Azure Private 5G Core also offers you the capability to use third-party applications to monitor a private mobile network. From the applications, you can use the Azure Monitor REST API to retrieve the health metrics that Azure Private 5G Core shares. You can also export the metrics to applications like Azure Event Hub.

## Platform metrics dashboards

Azure Private 5G Core displays the platform dashboards on the **Overview** page of the Azure site resource that you use to manage the relevant site, as shown below:

TBD: Screenshot

The platform metrics dashboards provide the performance and health information for both the packet core instance and the RANs to which the packet core instance connects. For the packet core instance, you can check metrics like idle UEs connected or session establishment failures. For the RANs, you can check metrics like access point names and the longitude and latitude of each access point.

Once a site is deployed, the platform dashboards are offered by default. No configuration is required.

For details in using the platform metrics dashboards, see the monitoring information in the [Azure Private 5G Core documentation](/azure/private-5g-core/).

## Application integration for network monitoring

In addition to the platform dashboards, Azure Private 5G Core offers you the flexibility to use third-party applications to monitor a private mobile network.

For third-party application integration, you can use one of the following approaches:

- Use the [Azure Monitor REST API](/rest/api/monitor/) to retrieve the performance and health metrics that Azure Private 5G Core shares.
- Export the metrics to applications like Azure Event Hub or a storage account. For detailed exporting instructions, see [Stream Azure monitoring data to an event hub or external partner](/azure/azure-monitor/essentials/stream-monitoring-data-event-hubs).

  > [!NOTE]
  > Exporting the network heath metrics to another application for third-party application integration or longer data retention period may incur extra cost.

The [Supported metrics with Azure Monitor](/azure/azure-monitor/essentials/metrics-supported) article provides the latest list of metrics that you can use.

For details in using third-party applications to monitor a private mobile network, see application integration information in the [Azure Private 5G Core documentation](/azure/private-5g-core/).
