There are several basic questions or concerns that all companies face when using the cloud. 

- Are we using the cloud correctly? Can we squeeze more performance out of our cloud spend?
- Are we spending more than we need to? 
- Do we have our systems properly secured? 
- How resilient are our resources?  If there was a regional outage, could we failover to another region?
- How can we diagnose and fix issues that occur intermittently?
- How can we quickly determine the cause of an outage?
- How can we learn about planned downtime?

Fortunately, using a combination of monitoring solutions on Azure, you can gain answers, insights, and alerts that help you ensure that you've optimized your cloud usage, that you're able to ascertain the root cause of unplanned issues, and can prepare ahead of time for planned outages.

## Product options

At a high level, there are three primary monitoring offerings, each of which are aimed at a specific audience and use case, and provide a diverse set of tools, services, programmatic APIs, and more.

### Azure Advisor

Azure Advisor evaluates your Azure resources and makes recommendations to help you improve reliability, security, and performance, achieve operational excellence, and reduce costs.  Advisor is designed to help you save you time on cloud optimization. The recommendation service includes suggested actions you can take right away, postpone, or dismiss.

The recommendations are available via the Azure portal, as well as via API, and you can set up notifications to alert you to new recommendations.

When in the Azure portal, the Advisor dashboard displays personalized recommendations for all your subscriptions, and you can use filters to hone into recommendations for specific subscriptions, resource groups, or services. The recommendations are divided into five categories:

**Reliability** - Used to ensure and improve the continuity of your business-critical applications.

**Security** - Used to detect threats and vulnerabilities that might lead to security breaches.

**Performance** - Used to improve the speed of your applications.

**Cost** - Used to optimize and reduce your overall Azure spending.

**Operational Excellence** - Used to help you achieve process and workflow efficiency, resource manageability, and deployment best practices.

### Azure Monitor

Azure Monitor is a platform for collecting, analyzing, visualizing, and potentially taking action based on the metric and logging data from your entire Azure and on-prem environment.

The diagram below illustrates just how comprehensive Azure Monitor is.

![Diagram of the relationship between logging and metric data sources, and how that data is consumed in Azure Monitor. These relationships are explained in the next few paragraphs.](../media/2-identify-product-options-01.png)

First, on the left, you see the sources of logging and metric data can be collected at every layer in your application architecture from application to operating system and network.  

In the center, you see how that logging and metric data is stored in central repositories.  

On the right, the data is used in a number of different ways.  You can view real-time and historic performance across each layer of your architecture, or aggregated and detailed information. The data is displayed at different levels for different audiences. You can view high-level reports on the Azure Monitor Dashboard or create custom views using Power BI and Kusto queries.  

Furthermore, the data can be used to help you react to critical events in real time, whether through alerts delivered to teams via SMS, email and so on.  Or, you can use thresholds to trigger autoscaling functionality to scale up or down to meet the demand.

Some popular products like Azure Application Insights, a service for sending telemetry information from application source code to Azure, uses Azure Monitor under the hood.  Application Insights allows application developers to leverage the powerful data analysis platform in Azure Monitor to provide you with deep insights into an application's operations and diagnose errors without waiting for a user to report them.

### Azure Service Health

Azure Service Health provides a personalized view of the health of the Azure services, regions, and resources you rely on.  The site status.azure.com doesn't provide the full picture because it only shows major issues broadly impacting Azure customers. On the other hand, Service Health shows you everything impacting you, including major issues and smaller, localized issues.  Service issues are rare, but it's important to be prepared for the unexpected. You can set up alerts that help you triage outages and planned maintenance.  After an outage, it provides official incident reports that you can share with stakeholders called "root cause analyses", or RCAs.

There are several different event types that you can keep an eye on:

- **Service issues** are problems in Azure tha affect you right now. For example, outages. You can drill into the impacted services, regions, updates from the engineering teams, and ways you can share and track the latest information.

- **Planned maintenance** events can affect your availability.  You can drill into the impacted services, regions, and details on how that will impact you, and what you need to do.  Most of these events are performed without any impact to you and won't be shown here.  In the rare case that a reboot will be required, Service Health will allow you to choose when to perform the maintenance to minimize the impacted downtime.

- **Health advisories** are issues that require you to act to avoid service interruption, including service retirements and breaking changes.  Health advisories are announced far in advance to allow you to plan.