Azure Network Watcher provides a suite of tools to monitor, diagnose, view metrics, and enable or disable logs for Azure IaaS (Infrastructure-as-a-Service) resources. Network Watcher enables you to monitor and repair the network health of IaaS products like virtual machines (VMs), virtual networks (VNets), application gateways, load balancers, etc. Network Watcher isn't designed or intended for PaaS monitoring or Web analytics.

Network Watcher consists of three major sets of tools and capabilities:<br>

 -  Monitoring<br>
 -  Network diagnostic tools
 -  Traffic

:::image type="content" source="../media/new-azure-network-watcher-68640b41.png" alt-text="Screenshot showing an example of Azure network watcher.":::


## Flow logs<br>

Flow logs allows you to log information about your Azure IP traffic and stores the data in Azure storage.

Network security groups flow logging is a feature of Azure Network Watcher that allows you to log information about IP traffic flowing through a network security group. Flow data is sent to Azure Storage from where you can access it and export it to any visualization tool, security information and event management (SIEM) solution, or intrusion detection system (IDS) of your choice.

:::image type="content" source="../media/new-flow-logs-872fa189.png" alt-text="Screenshot showing an example of flow logs that allows you to log information about IP traffic flowing through a network security group.":::


## Traffic analytics<br>

Traffic analytics provides rich visualizations of flow logs data.

:::image type="content" source="../media/new-traffic-analytics-b77cd82a.png" alt-text="Screenshot showing an example of traffic analytics that provides rich visualizations of flow logs data.":::
