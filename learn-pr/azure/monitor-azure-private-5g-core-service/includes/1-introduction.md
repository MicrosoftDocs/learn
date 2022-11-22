
In the private mobile networks powered with Azure Private 5G Core, enterprises usually run mission-critical applications that support their user equipment (UE). For example, robots on a factory floor rely on the network to communicate with each other, and IoT devices in a smart farm rely on the network to report status and adjust to environmental changes. If these UEs malfunctions or even stops functioning due to network connectivity or performance issues, the business of the enterprise will be severely impacted. Therefore, monitoring the health of the network continuously and making sure everything runs smoothly are of critical importance to the business continuity of enterprises. In addition, to minimize business impact, enterprises need to quickly diagnose and fix an issue once it's reported.

## Monitoring and troubleshooting capabilities

Azure Private 5G Core provides flexible monitoring options, which allow you to either monitor multiple network sites centrally from the cloud, or locally monitor each individual site from within the site.

- Remote monitoring
  - Remote monitoring with Azure Log Analytics: Log Analytics is a standard Azure tool that you can use through the Azure portal. Once you enable the Log Analytics tool for a private mobile network, each packet core instance in the network streams relevant logs to the tool. You can create queries to retrieve the log data, and use Log Analytics dashboards to visualize your saved log queries.
  - Remote monitoring with the platform dashboards: The site resource that you use to manage a site in your private mobile network offers a list of dashboards called platform dashboards. Through these dashboards, you can check site health information such as user plane packets dropped or session establishment failures.
  - Remote monitoring with other applications: Azure Private 5G Core can share network health metrics through [Azure Event Hub](/azure/event-hubs/). You can use the [Azure Monitor REST API](/rest/api/monitor/) to retrieve the metrics from Azure Event Hub and then integrate the metrics data into other applications.

- Local monitoring with packet core dashboards: The packet core instance that powers each site in a private mobile network provides the packet core dashboards by default. With these boards, you can monitor key network statistics in real time. These boards also allow you to view information on firing alerts, based on which you can quickly react to emerging issues.

For diagnosing issues that are reported during network monitoring, Azure Private 5G Core provides a distributed tracing tool on each packet core instance. This tool allows you to analyze the communication between network functions and identify the root cause of a certain issue. Once the root cause is identified, you can take relevant measures to fix the issue.

With these monitoring and troubleshooting tools, you can monitor the health of your private mobile network on a continuous basis and diagnose issues once they're reported. The monitoring and troubleshooting capabilities of Azure Private 5G Core help ensure the business continuity of enterprises and minimize possible business impact.

The following video introduces the monitoring and capabilities of Azure Private 5G Core. It also discusses the use of relevant tools and techniques.

TBD: Insert the monitoring introduction video here.

## Monitoring example

Suppose you're a network operation manager in logistic company, which has three sites deployed with Azure Private 5G Core in its private mobile network. You have a team member working at each site. One of the major responsibilities of your team is to monitor the entire mobile network and make sure everything runs smoothly. If an issue is reported during the monitoring, your team will need to diagnose the issue and take measure to fix it.

In this case, you can enable Log Analytics for each site and then create dashboards to monitor the sites remotely through the Azure portal. This way, you can monitor the health of the network no matter where you work. For the team member at each site, you can ask them to use the packet core dashboards to monitor the site locally in real time. If the monitoring tool reports an issue for a site, the team member at the site can use the distributed tracing tool to diagnose.

The following diagram illustrates this monitoring structure:

:::image type="content" source="../media/ap5gc-monitoring-structure.png" alt-text="A diagram that illustrates the monitoring structure of the warehouse private mobile network" border="true":::

## Key metrics to monitor

Based on the tool that you use, the types of the alerts may be divided into different levels. For example, in the packet core dashboards, you may see critical, major, or minor alerts. Among these alerts, the critical alerts have the highest priority and should be handled first.

In addition to the alert levels, you should also define the key metrics to monitor based on the business needs of the enterprise.

In general, pay special attention to the following metrics:

- Data plane metrics
  - Numbers of packets sent/received on the N3/N6 interfaces
  - Number of bytes sent/received on the N3/N6 interfaces
  - The distribution of packet sizes on the N3/N6 interfaces
  - The traffic type statistics, such as TCP vs. UDP or HTTP vs. HTTPs
- Subscriber metrics
  - Registration status
  - Connection status
  - Data throughput

## How you'll learn

In this module, we'll introduce the use of the following monitoring and troubleshooting tools to you:

- The remote monitoring tools, including Azure Log Analytics, the platform dashboards, and the application integration API.
- The packet core dashboards.
- The distributed tracing tool.

After the learning, you'll need to answer questions in the knowledge check unit to make sure that you've grasped these tools.

By the end of the session, you'll be able to use the tools to monitor the private mobile network in an enterprise and diagnose any issues detected during the monitoring.
