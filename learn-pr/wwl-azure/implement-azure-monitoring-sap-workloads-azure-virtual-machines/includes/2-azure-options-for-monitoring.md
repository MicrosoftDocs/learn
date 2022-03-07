Azure Monitor is one of the core components of Microsoft's comprehensive cloud-based monitoring. It provides a solution for SAP workloads running in Azure, and for your on-premises datacenter. Other Azure manageability features that belong in the same category include:

- **Azure Advisor**. Uses resource usage telemetry to make recommendations for optimizing performance, security, and availability.

- **Azure Service Health**. Reports platform-related issues that might affect your resources.

- **Azure Activity Log**. Tracks events representing operations that alter the state of your resources; such as configuration changes, service health incidents, and autoscale operations.

These core features complement several other services that deliver more focused, deep monitoring:

- **Deep infrastructure monitoring**. Along with detailed monitoring, these services also provide analytics capabilities targeting Azure infrastructure. Some of the prime examples include:

    - **Log Analytics** combined with such management solutions as **Container Monitoring** and **Service Map**.

    - Network monitoring tools such as:

        - **Network Watcher**

        - **Network Performance Monitor**

        - **ExpressRoute Monitor**

        - **DNS Analytics**

        - **Service Endpoint Monitor**

- **Deep application monitoring**. This category includes **Azure Application Insights**, which monitors the performance, availability, and usage of web-based applications, regardless of their location.

Tasks like configuring alerts, designing custom dashboards, and analyzing metrics are carried out similarly in core and deep monitoring services. This means that you can view and configure performance-related settings for a wide range of Azure resources in the same consistent manner. With Azure Monitor, you have a single point of reference for most relevant configuration settings and monitoring data. This not only improves your user experience, but also helps you maintain a consistent configuration across your entire subscription.

## Azure monitor for SAP Solutions (preview)

Much of this module focuses on **Azure Monitor for SAP solutions** (in preview at the time of writing). With this Azure-native monitoring solution, customers running their SAP landscapes on Azure can access simplified monitoring, efficient troubleshooting, and flexible customizations.

Azure Monitor for SAP solutions supports SAP HANA databases and Microsoft SQL Server, and works with both [SAP on Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-get-started) and [SAP on Azure Large Instances](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-overview-architecture). With Azure Monitor for SAP solutions, you can collect telemetry data from your Azure infrastructure and databases in one central location, and visually correlate telemetry data for faster troubleshooting. You can monitor different components of an SAP landscape (such as Azure virtual machines, high-availability clusters, SAP HANA databases etc.) by adding the corresponding provider.

Azure Monitor for SAP solutions is offered through Azure Marketplace. Later in this training, we'll walk through the simple, intuitive setup experience. It takes only a few clicks to deploy the resource for Azure Monitor for SAP solutions.

