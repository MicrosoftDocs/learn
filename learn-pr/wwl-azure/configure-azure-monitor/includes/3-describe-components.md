Monitoring is the act of collecting and analyzing data. The data can be used to determine the performance, health, and availability of your business application and the resources that it depends on.

An effective monitoring strategy helps you understand the detailed operation of the components of your application. Monitoring also helps you increase your uptime by proactively notifying you of critical issues. You can then resolve the issues before they become severe.

Azure includes multiple services that individually perform a specific role or task in the monitoring space. Together, these services deliver a comprehensive solution for collecting, analyzing, and acting on data from your application and the Azure resources that support them. The services also work to monitor critical on-premises resources to provide a hybrid monitoring environment. Understanding the tools and data that are available is the first step in developing a complete monitoring strategy for your application.

The next diagram gives a high-level view of Azure Monitor. At the center of the diagram, are the data stores for metrics and logs. Metrics and logs are the two fundamental types of data use by Azure Monitor. On the left side of the diagram, are the sources of monitoring data that populate these data stores. On the right side of the diagram, are the different functions that Azure Monitor performs with this collected data such as analysis, alerting, and streaming to external systems.

:::image type="content" source="../media/monitor-service-d0bdfd6d.png" alt-text="Diagram showing the different monitoring and diagnostic services available in Azure. Those services are divided into broad categories for monitoring such as Core, Application, Infrastructure, and Shared Capabilities.":::
