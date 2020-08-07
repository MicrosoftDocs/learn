


## Product options


### Azure Advisor

Advisor provides relevant best practices to help you improve reliability, security, and performance, achieve operational excellence, and reduce costs. Configure Advisor to target specific subscriptions and resource groups, to focus on critical optimizations. Access Advisor through the Azure portal, the Azure Command Line Interface (CLI), or the Advisor API. Or configure alerts to notify you automatically about new recommendations.

dvisor is designed to help you save you time on cloud optimization. The recommendation service includes suggested actions you can take right away, postpone, or dismiss. Advisor Quick Fix makes optimization at scale faster and easier by allowing users to remediate recommendations for multiple resources simultaneously and with only a few clicks. Recommendations are prioritized according to our best estimate of significance to your environment, and you can share them with your team or stakeholders.

Azure offers many services that provide recommendations, including Azure Security Center, Azure Cost Management, Azure SQL DB Advisor, Azure App Service, and others. Advisor pulls in recommendations from all these services so you can more easily review them and take action from a single place.

Advisor is a personalized cloud consultant that helps you follow best practices to optimize your Azure deployments. It analyzes your resource configuration and usage telemetry and then recommends solutions that can help you improve the cost effectiveness, performance, Reliability (formerly called High availability), and security of your Azure resources.

With Advisor, you can:

Get proactive, actionable, and personalized best practices recommendations.
Improve the performance, security, and reliability of your resources, as you identify opportunities to reduce your overall Azure spend.
Get recommendations with proposed actions inline.
You can access Advisor through the Azure portal. Sign in to the portal, locate Advisor in the navigation menu, or search for it in the All services menu.

The Advisor dashboard displays personalized recommendations for all your subscriptions. You can apply filters to display recommendations for specific subscriptions and resource types. The recommendations are divided into five categories:

Reliability (formerly called High Availability): To ensure and improve the continuity of your business-critical applications. For more information, see Advisor Reliability recommendations.

Security: To detect threats and vulnerabilities that might lead to security breaches. For more information, see Advisor Security recommendations.

Performance: To improve the speed of your applications. For more information, see Advisor Performance recommendations.

Cost: To optimize and reduce your overall Azure spending. For more information, see Advisor Cost recommendations.

Operational Excellence: To help you achieve process and workflow efficiency, resource manageability and deployment best practices. . For more information, see Advisor Operational Excellence recommendations.


### Azure Monitor

Azure Monitor is a platform for collecting, analyzing, visualizing, and potentially taking action based on the metric and logging data from your entire Azure and on-prem environment.  

The diagram below illustrates just how comprehensive Azure Monitor is.

First, on the left, you see the sources of logging and metric data can be collected at every layer in your application architecture from application to operating system and network.  

In the center, you see how that logging and metric data is stored in central repositories.  

On the right, the data is used in a number of different ways.  You can view real-time and historic performance across each layer of your architecture, or aggregated and detailed information. The data is displayed at different levels for different audiences. You can view high level reports on the Azure Monitor Dashboard or create custom views using Power BI and Kusto queries.  

Furthermore, the data can be used to help you react to critical events in real-time, whether through alerts delivered to teams via SMS, email and so on.  Or, you can use thresholds to trigger autoscaling functionality to scale up or down to meet the demand.

ovewview.png

Some products like Application Insights are using Azure Monitor under the hood.  This allows application developers to leverage the powerful data analysis platform in Azure Monitor to provide you with deep insights into your application's operations and diagnose errors without waiting for a user to report them.


### Azure Service Health

Azure Service Health provides a personalized view of the health of your Azure services, regions, and resources.  You can set up alerts that help you triage outages and planned maintenance.  It provides official incident reports that you can share with stakeholders. 



Service issues are rare, but it's important to be prepared for the unexpected.  

control and visibility that you have on-prem by provbiding you fast information about hte health of your azure services.

The Azure Service Health dashboard displays a list of the current service issues, planned maintance, and health advisories, including products that will be sunsetted in the future.  This one dashboard helps you understand the impact out outages on your architecture.

status.azure.com doesn't provide the full picture because it only shows major issues broadly impacting Azure customers. On the other hand, Service Health shows you everything impacting you, including major issues and smaller, localized issues.  

Event types:

Service issues are problems in azure tha affect you right now.  For example, outages.  You can drill into the impacted services, regions, updates from the engineering teams, and ways you can share and track the latest information.

Planned maintanence events can affect your availability.  You can drill into the impacted services, regions, and details on how that will impact you, and what you need to do.  Most of these events are performed without any impact to you and won't be shown here.  In the rare case that a reboot will be required, Service Health will allow you to choose when to perform the maintenance to minimize the impacted downtime.

Health advisories are issues that require you to act to avoid service interruption, including service retirements and breaking changes.  These are announced far in advance to allow you to plan.


You can set up service health alerts, which automatically notify you about health events via your preferred channel, including email, SMS, push notification, and Webhooks so you can know what's happening and take the necessary action.  

Before setting up your alerts, you'll want to think through your alerting strategy with your team.  A few key considerations: 

- criticality - how important is a given subscription, service, or region to you?  If it's production, you'll wnat to set up an alert for it.  Dev and test might be unecessary.

Service health is personalized so we won't trigger your alert if the service issue is affecting a service or region you aren't using. 

- who to inform? - who is the right person or team to tell about a service issue, so they can act?  For example, send SQL or CosmosDB issues to your database team.  

- how to inform them? - what is the right communication channel for the message? Email is noisy, so it might take longer for your teams to respond.  That's fine for planned maintenance that's weeks away but not for an outage affecting you right now.  In which case, you want to alert your on-call team using a channel that's immediately seen, like a push notification or SMS.

Can integrate with ServiceNow and PagerDuty so you can follow your team's existying ticketing workflow practices.

Health History

During an outage, Microsoft is committed to resolving the issue quickly and keeping you informed.  Now, after an issue is resolved, you can get an official report from Microsoft as a PDF.