Your organization will have servers, applications, services, and data. You'll need to monitor your network continuously to protect your organization's assets and resources.

In this unit, you'll learn about networking and the different tools involved. You'll explore best practices, like how to separate your monitoring tasks and functions. And you'll look at what tools to use for alerting and monitoring on Azure.

## What is network monitoring?

Network monitoring is when you monitor all the components of your network, like switches, routers, servers, and firewalls. You monitor your network for performance and faults, and continuously analyze the information you gather. When you monitor a network, you're taking a proactive approach to issues. As a result, you're improving the availability of your network, reducing downtime and failures.

### Agent-based monitoring

Network monitoring solutions are often agent-based. An agent is a piece of software that runs on the device being monitored. The agent monitors and gathers information on the device then sends information to the appropriate network monitoring solution that employed it.

The agent helps gather granular data on the monitored device, such as the processes running and its hardware performance. For example, an agent could gather information on the processes running on the device, or its hardware performance. However, an agent needs time to install and configure. The agent might also require its own maintenance and update tasks.
If you have many agents, these tasks could be time consuming.

### Agentless monitoring

Here, an agent isn't deployed to monitor devices. The networking solution gathers information on the device by looking at things like data packets that are being transferred. The networking solution could also look at APIs that the device uses to send information about itself. Agentless monitoring helps you avoid having to configure and maintain agents on devices. However, the information you gather might not be as granular as when you're using agent-based monitoring. Some devices might not expose the information you need.

### Monitoring intervals

Monitoring intervals show how frequent you want to poll for information on one of your network devices.

The interval frequency depends on what you want to monitor. For example, you'd use the shortest interval possible if you're monitoring to see if a particular device is available or not. If you're monitoring for things like memory and CPU usage, you could have intervals of a few minutes. You don't necessarily want to monitor every device at the shortest intervals possible for each metric because you'd add unnecessary load to your network.

### Protocols

To monitor your network, you'll need to use a secure network management protocol that consumes minimum bandwidth. You want to keep your network secure and prevent unnecessary load on network performance.

- **SNMP (Simple Network Management Protocol)**

Like switches and routers, the majority of Linux servers and network devices use SNMP. An SNMP-based agent is usually already preinstalled on the device. You'll enable and configure it for your use. The SNMP agent collects things like traffic on your network switch, memory usage, or even printer queues. Information about your device is then communicated through the SNMP protocol to your network monitoring and management solution (NMS).

- **WMI (Windows Management Instrumentation)**

Windows devices use WMI to provide information about the status of your device. You also use WMI to make changes to devices, such as scheduling processes to trigger, or updating system properties and settings. Windows Management Infrastructure is a newer version of WMI that has upgraded capabilities, such as better integration with PowerShell to run commands and scripts.

- **Syslog**

Syslog is a protocol that lets your device send event messages. Syslog is used for event logging. For example, your web server might use Syslog to log events about failed attempts to access it, or your router could log events on user activities.

## Best practices

### FCAPS

When you manage a network, you deal with many different tasks and functions. To help you do them effectively, these tasks and functions have been categorized. The categories are: fault management, configuration management, accounting/administration and performance management, or FCAPS.

 - **Fault management**

    Fault management relates to the processes and tasks used to identify and resolve faults on the network. Dealing with issues that could cause problems later is also classified as fault management.

 - **Configuration management**

    Configuration management encompasses things like collecting information on the changes made to the configurations of your devices, and making your own configuration updates.

 - **Accounting/administration**

    Accounting applies when you're dealing with a network that's used as a service provider, and all the tasks and functions that apply. With service provider networks, usage needs to be monitored so utilization is tracked and billed accordingly. Any of the tasks involving usage and billing monitoring is included. If the network isn't a service provider, administration is applicable, and tasks like managing permissions and user passwords are included.

 - **Performance management**

    Performance management covers anything that's done to manage the performance of your network. The list includes monitoring throughput, utilization, improving response times, and more.

 - **Security**

    Security encompasses all the tasks you perform to secure your network. These tasks include protecting devices, restricting access to network resources, or protecting user activity in the network.

### Alerting and reporting

As you're monitoring the network, you collect data. You take that data through reporting and put it into a format you can use to understand your network better and make informed decisions.  You'll also use alerts to capture information about events and issues. These alerts help you respond better to issues and risks as they arise.
Here's some of the Azure network monitoring solutions you can use for reporting and alerts.

**Azure Monitor**

Azure Monitor is a unifying solution that collects log data for analysis, helping you take appropriate action for resources across your on-premises and Azure networks. Azure Monitor varies in the scope of its capabilities. For example, Azure Monitor uses its integration with Application Insights to check and diagnose any risks and issues in your applications and their dependencies. You use Azure Monitor to configure alerts before taking further action.

![Configuring an alert](../media/3-alerts.png)
<!-- Please feel free to format according to learn standards Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/platform/media/alerts-log/alertspreviewcreate.png -->

**Log Analytics**

You can use Azure Monitor's Log Analytics tool to query and aggregate large amounts of log data for comprehensive analysis. This tool helps you gain a better understanding of the resources and services across your network.

![Log analytics](../media/3-log-analytics.png)
<!-- Please feel free to format according to learn standards Original image: https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/media/log-query-overview/log-analytics.png -->
