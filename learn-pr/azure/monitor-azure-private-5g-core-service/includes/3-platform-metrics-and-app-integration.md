<!-- Need to verify these GA feature details before official publication -->

In addition to Log Analytics, Azure Private 5G Core provides platform metrics through the Azure portal. Platform metrics are dashboards that visualize the network health and performance information.

Azure Private 5G Core also allows you to use third-party applications to monitor a private mobile network. From the applications, you can use the Azure Monitor REST API to retrieve the metrics that Azure Private 5G Core shares.

## Platform metrics

Azure Private 5G Core displays the platform metrics on the **Overview** page of the Mobile Network Site resource that you use to manage the relevant site, as shown below:

TBD: Screenshot

The platform metrics provide the health and performance information for both the packet core instance and the RANs to which the packet core instance connects. For the packet core instance, you can check metrics like idle UEs connected or session establishment failures. For the RANs, you can check metrics like access point names and the longitude and latitude of each access point.

The platform metrics are automatically created when you deploy a site. No configuration is required.

For details in using the platform metrics, see the monitoring information in the [Azure Private 5G Core documentation](/azure/private-5g-core/).

## Application integration for network monitoring

Azure Private 5G Core offers you the flexibility to use third-party applications to monitor a private mobile network.

For third-party application integration, you can use one of the following methods:

- Use the [Azure Monitor REST API](/rest/api/monitor/) to retrieve the health and performance metrics that Azure Private 5G Core shares.
- Export the metrics to an application such as Azure Event Hubs or a storage account. For detailed exporting instructions, see [Stream Azure monitoring data to an event hub or external partner](/azure/azure-monitor/essentials/stream-monitoring-data-event-hubs).

  > [!NOTE]
  > Exporting the network metrics to another application for third-party application integration or longer data retention period may incur extra cost.

The [Supported metrics with Azure Monitor](/azure/azure-monitor/essentials/metrics-supported) article provides the latest list of metrics that you can use.

For details in using third-party applications to monitor a private mobile network, see the application integration information in the [Azure Private 5G Core documentation](/azure/private-5g-core/).
