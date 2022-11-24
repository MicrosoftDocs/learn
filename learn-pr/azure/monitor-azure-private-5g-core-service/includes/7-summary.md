To ensure the availability and the performance of a private mobile network, Azure Private 5G Core allows you to monitor the private mobile network either centrally from Azure or locally at each site of the network. 

From Azure, you can use the platform metrics dashboards or Log Analytics to do the monitoring. Additionally, Azure Private 5G Core supports monitoring with third-party applications. These applications can use the Azure Monitor REST API to retrieve the health and performance metrics data from Azure Private 5G Core. You can also export the metrics data to another application like Azure Event Hub or a storage account.

Locally at each site, you can use the packet core dashboards to do real-time monitoring.

To diagnose network issues for a site in your network, you can use the distributed tracing tool.

Once a private mobile network is in operation, you can use a tool of your choice to monitor the sites in the network either centrally from Azure or locally at each site. If an issue is detected during the monitoring, you can use the distributed tracing tool to diagnose the issue and then take appropriate actions to fix it.

## References

- [Azure Private 5G Core documentation](/azure/private-5g-core/)
- [Azure Private 5G Core product information](https://azure.microsoft.com/products/private-5g-core/)
- [Azure Monitor documentation](/azure/azure-monitor/overview)
- [Azure Monitor REST API documentation](/rest/api/monitor/)