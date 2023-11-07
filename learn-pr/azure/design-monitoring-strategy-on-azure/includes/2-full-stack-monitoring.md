Your organization is moving all its systems from an on-premises location to Azure, and wants you to implement a monitoring strategy. This unit explains how a full-stack monitoring strategy can improve customer experience by providing the ability to identify and mitigate issues across all the layers of your applications and infrastructure.

## Use full-stack monitoring

Full-stack monitoring is a complete approach to monitoring, triaging, and diagnosing application, infrastructure, and security issues. Full-stack monitoring includes telemetry collection, tracking key performance indicators, isolating problems, and analyzing root causes.

Your applications and infrastructure might face different kinds of potentially damaging issues, such as poor response times, changing usage rates, exceptions, and security risks. Your response must be appropriate to the type of issue. You might respond by scaling up capacity to meet increased load, or with changes in your application or infrastructure to improve performance and reduce errors.

With the right tools, you can:

- Monitor your infrastructure and application performance.
- Monitor for security risks and suspicious activity.
- Collect information on issues as soon as they arise.
- Analyze and respond to the information you collect.

By monitoring your applications and infrastructure with a full-stack approach, you respond to changes and issues appropriately and on time. This strategy can help your organization become more productive, cost-effective, secure, and competitive.

## Monitor your applications

To improve your applications' health and build better applications in future, configure alerts and automated responses to help you deal with application issues.

Monitor your application for issues as you develop it to prevent errors and exceptions later in production. To improve your development lifecycle, ensure that your code gets pushed to the next stage of the development cycle only if it successfully passes the necessary checks.

Also monitor your application when it's live and in use. As the following charts show, you might be faced with failing requests, high server response times, or availability issues. By monitoring for live issues, you identify these types of problems and risks promptly, and can respond effectively to keep your application healthy.

![Screenshot of Application Key Performance Indicators (KPIs).](../media/2-full-stack-monitoring-01.png)

## Monitor your infrastructure

Different kinds of issues can affect your infrastructure. You might have to deal with performance issues or problems that could render your services unreachable or the entire infrastructure unavailable. Any of these issues can result in decreased productivity, financial loss, or damage to your organization's reputation.

To deal with any issues that arise in a timely and effective way, you can configure alerts on your infrastructure to monitor for various issues. For example, you can configure alerts for:

- Your infrastructure's resource utilization.
- Your infrastructure's availability and health.
- A specific event occurring at the operating-system level.

You can configure these alerts to start a process where a person receives a notification and takes appropriate action. You can also trigger automated responses to alerts with playbooks and webhooks.

You can also use infrastructure monitoring data for operational analysis and capacity planning. You can collect performance data from virtual machine (VM) guest operating systems into charts for comparison and trending purposes to inform decision making.

![Screenshot of VM KPIs.](../media/2-full-stack-monitoring-02.png)

## Monitor Azure platform resources

You can use Azure's built-in capabilities to monitor your Azure platform resources in addition to monitoring your deployed applications and infrastructure resources. Azure resources such as Storage Accounts, Key Vaults, and Azure Cosmos DB databases have performance metrics and resource logs that you can view and analyze to track performance and availability.

Many Azure resource types also have dedicated insights that offer predefined monitoring experiences across subscriptions, resource groups, and other resources. The following screenshot shows the Azure Monitor storage insight displaying usage and latency for multiple storage accounts across two subscriptions.

![Screenshot of Azure Storage KPIs.](../media/2-full-stack-monitoring-03.png)

You can also view and collect logs related to Active Directory for your Azure tenant, and Service Health and activity logs for Azure subscriptions. A full-stack monitoring solution includes visibility into the Azure platform resources your application and infrastructure depend on.

## Implement security monitoring

It's also essential to monitor the security of your applications and infrastructure to ensure that they always remain protected and available. For example, you should monitor and alert on:

- Risks to your infrastructure's security, such as suspicious user accounts or malicious IP addresses.
- Data exfiltration.

Your security monitoring solution should include strong, automated anomaly detection and event management to combine multiple related events into a single actionable alert.

## Summary

Taking a full-stack approach to monitoring your applications and infrastructure helps you respond appropriately and more effectively to issues. You can strengthen your protection and build improved applications and infrastructure. The full-stack approach also helps you gain situational awareness, and you learn from the issues that affect your environment.
