Several basic questions or concerns face all companies that use the cloud. 

- Are we using the cloud correctly? Can we squeeze more performance out of our cloud spend?
- Are we spending more than we need to? 
- Do we have our systems properly secured? 
- How resilient are our resources?  If we experience a regional outage, could we fail over to another region?
- How can we diagnose and fix issues that occur intermittently?
- How can we quickly determine the cause of an outage?
- How can we learn about planned downtime?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWHb7u]

Fortunately, by using a combination of monitoring solutions on Azure, you can:
- Gain answers, insights, and alerts to help ensure that you've optimized your cloud usage.
- Ascertain the root cause of unplanned issues.
- Prepare ahead of time for planned outages.

## The product options

At a high level, there are three primary Azure monitoring offerings. Each one is aimed at a specific audience and use case and provides a diverse set of tools, services, programmatic APIs, and more.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWGw3I]

### Azure Advisor

[Azure Advisor](https://azure.microsoft.com/services/advisor/?azure-portal=true) evaluates your Azure resources and makes recommendations to help improve reliability, security, and performance, achieve operational excellence, and reduce costs. Advisor is designed to help you save time on cloud optimization. The recommendation service includes suggested actions you can take right away, postpone, or dismiss.

The recommendations are available via the Azure portal and the API, and you can set up notifications to alert you to new recommendations.

When you're in the Azure portal, the Advisor dashboard displays personalized recommendations for all your subscriptions, and you can use filters to select recommendations for specific subscriptions, resource groups, or services. The recommendations are divided into five categories:

- **Reliability**: Used to ensure and improve the continuity of your business-critical applications.
- **Security**: Used to detect threats and vulnerabilities that might lead to security breaches.
- **Performance**: Used to improve the speed of your applications.
- **Cost**: Used to optimize and reduce your overall Azure spending.
- **Operational Excellence**: Used to help you achieve process and workflow efficiency, resource manageability, and deployment best practices.

### Azure Monitor

[Azure Monitor](https://azure.microsoft.com/services/monitor/?azure-portal=true) is a platform for collecting, analyzing, visualizing, and potentially taking action based on the metric and logging data from your entire Azure and on-premises environment.

The following diagram illustrates just how comprehensive Azure Monitor is.

![Diagram of the relationship between logging and metric data sources, and how that data is consumed in Azure Monitor.](../media/2-identify-product-options-01.png)

- On the left is a list of the sources of logging and metric data that can be collected at every layer in your application architecture, from application to operating system and network.  

- In the center, you can see how the logging and metric data is stored in central repositories.  

- On the right, the data is used in several ways. You can view real-time and historical performance across each layer of your architecture, or aggregated and detailed information. The data is displayed at different levels for different audiences. You can view high-level reports on the Azure Monitor Dashboard or create custom views by using Power BI and Kusto queries.  

Additionally, you can use the data to help you react to critical events in real time, through alerts delivered to teams via SMS, email, and so on. Or you can use thresholds to trigger autoscaling functionality to scale up or down to meet the demand.

Some popular products such as Azure Application Insights, a service for sending telemetry information from application source code to Azure, uses Azure Monitor under the hood. With Application Insights, your application developers can take advantage of the powerful data-analysis platform in Azure Monitor to gain deep insights into an application's operations and diagnose errors without having to wait for users to report them.

### Azure Service Health

[Azure Service Health](https://azure.microsoft.com/features/service-health/?azure-portal=true) provides a personalized view of the health of the Azure services, regions, and resources you rely on. The status.azure.com website, which displays only major issues that broadly affect Azure customers, doesn't provide the full picture. But Azure Service Health displays both major and smaller, localized issues that affect you. Service issues are rare, but it's important to be prepared for the unexpected. You can set up alerts that help you triage outages and planned maintenance. After an outage, Service Health provides official incident reports, called root cause analyses (RCAs), which you can share with stakeholders.

Service Health helps you keep an eye on several event types:

- **Service issues** are problems in Azure that affect you right now, such as outages. You can drill down to the affected services and regions, receive updates from your engineering teams, and find ways to share and track the latest information.

- **Planned maintenance** events can affect your availability. You can drill down to the affected services, regions, and details to show how a planned event affects you and what you need to do. Most of these events occur without any effect to you and aren't shown here. In the rare case that a reboot is required, Service Health allows you to choose when to perform the maintenance to minimize the downtime.

- **Health advisories** are issues that require you to act to avoid service interruption, including service retirements and breaking changes. Health advisories are announced far in advance to allow you to plan.
