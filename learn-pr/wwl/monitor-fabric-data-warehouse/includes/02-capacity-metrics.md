When your organization uses Microsoft Fabric, the license used to purchase the service determines the *capacity* available. A capacity is a pool of resources that you can use to implement Fabric capabilities.

The cost of using Fabric is based on *capacity units* (CUs). Each action you perform in a Fabric resource can consume CUs, for which your organization is billed. It's therefore important to be able to monitor capacity usage to plan and manage costs. In data warehouse workloads, CUs are consumed by data read and write activities, so queries in your data warehouse and the underlying file operations to OneLake storage are a significant factor in the cost of your Fabric analytics solution.

## Using the Microsoft Fabric Capacity Metrics app

The Microsoft Fabric Capacity Metrics app is an app that an administrator can install in a Fabric environment and use to monitor capacity utilization. To monitor capacity utilization related to data warehousing, you can filter the interface to show only **warehouse** activity, like this:

![Screenshot of the Fabric Capacity Metrics app showing warehouse activity.](../media/fabric-capacity-metrics-app.gif)

By using the Fabric Capacity Metrics app, you can observe capacity utilization trends to determine what processes are consuming CUs in your Fabric environment and whether any *throttling* is occurring (which indicates that your processes require more capacity than is available within the constraints of your purchased capacity license). With this information, you can optimize your capacity license for your needs.

> [!TIP]
> For more information about Microsoft Fabric Capacity Metrics app, refer to **[Billing and utilization reporting in Synapse Data Warehouse](/fabric/data-warehouse/usage-reporting)** in the Microsoft Fabric documentation.
