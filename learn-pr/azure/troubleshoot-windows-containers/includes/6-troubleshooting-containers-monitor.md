﻿Azure Monitor is a cloud-based monitoring and analytics service provided by Microsoft Azure. It helps organizations gain visibility into the performance, availability, and usage of their applications and infrastructure hosted on the Azure platform. With Azure Monitor, users can collect and analyze telemetry data from various sources such as logs, metrics, and traces. Users gain insights into the health of their resources, detect and diagnose issues, and optimize their applications for better performance and efficiency. Azure Monitor also provides tools for creating and configuring alerts, dashboards, and reports to help users quickly identify and respond to issues in real-time.

First, we need to understand what type of logs and metrics AKS generates. They can be structured as layers.

:::image type="complex" border="false" source="../media/6-aks-logs-structure.png" alt-text="Diagram that shows the different levels of components that need to be managed." lightbox="../media/6-aks-logs-structure.png":::
   Diagram that shows the different levels of components that need to be managed, their description, and the monitoring requirements for each one.
:::image-end:::

Out of the box, AKS offers some basic monitoring (CPU, disk, memory) around nodes. However, it's not useful to understand possible issues in your cluster or applications. Setting up Container insights is recommended to gain visibility across containerized application, cluster health, audit logs, etc.

Here are some of the components of an Azure Monitor solution that help you troubleshoot your environment.

## Container insights

Container insights is a feature designed to monitor the performance of container workloads deployed to the cloud. It gives you performance visibility by collecting memory and processor metrics from controllers, nodes, and containers that are available in Kubernetes through the Metrics API. After you enable monitoring from Kubernetes clusters, metrics and Container logs are automatically collected for you through a containerized version of the Log Analytics agent. Below you can see a high-level overview of the Container Insights architecture.

:::image type="complex" border="false" source="../media/6-container-insights.png" alt-text="Diagram that shows the different components managed by Container Insights." lightbox="../media/6-container-insights.png":::
   Diagram that shows the different components managed by Container Insights, where the data is stored, and actions that can be performed for troubleshooting purposes.
:::image-end:::

Enabling Container Insights requires having a Log Analytics workspace and an Azure Monitoring workspace with an Azure Managed Grafana.

## Log Analytics workspace

Log Analytics workspace is a unique environment for log data from Azure Monitor and other Azure services. It has its own data repository and configuration but might combine data from multiple services including AKS. You can either create your own, or let Azure create a default one for you. It's used to store all logs generated by your AKS cluster.

Make sure you enable LogMonitor for your Windows containers so the Log Analytics agent can collect them from STDOUT.

## Azure Monitoring workspace

Azure Monitoring workspace is a unique environment for Prometheus metrics. This workspace is used to store your AKS metrics.

## Azure managed Grafana

A managed Grafana instance to visualize the metrics stored in the Azure Monitoring workspace. You can also bring your own Grafana instance.

## Use Azure Monitor to debug containers

Azure Monitor can easily identify issues at all levels inside your AKS cluster. We go through them next.

The debugging process can be split in two: application/container issues or cluster problems. Let's go over troubleshooting the application/container first:

## Container

:::image type="complex" border="false" source=" ../media/6-application-container-insights.png" alt-text="Screenshot of the Azure portal showing the Container Insights pane." lightbox="../media/6-application-container-insights.png":::
   Webpage of the Azure portal showing the Container Insights pane. The Containers tab, the selected container, and the options on the Live Events tab are highlighted.
:::image-end:::

One way you can check your running container is going to the **Insights** tab on the left side blade, **Containers** view, and selecting your container. Navigating here, you gain quick information over the container, its logs, and events. For example, if you enabled Log Monitor on an IIS instance running on AKS, you can see the IIS events directly on the Azure portal.

## Control plane

To get the logs from the control plane components, you need to enable Diagnostic Settings as in the image here:

:::image type="content" source="../media/6-enable-diagnostic-settings.png" alt-text="Webpage of the Azure portal showing the Diagnostic settings pane. The link to + Add diagnostic setting is highlighted." lightbox="../media/6-enable-diagnostic-settings.png":::

Highlighted next are the most important control plane components. Make sure you select to push to the Log Analytics Workspace and select the desired one.

:::image type="complex" border="false" source="../media/6-control-plane-diagnostic-settings.png" alt-text="Screenshot of the Azure portal showing the Diagnostic setting configuration pane." lightbox="../media/6-control-plane-diagnostic-settings.png":::
   Webpage of the Azure portal showing the Diagnostic setting configuration pane. The categories Kubernetes API Server, Kubernetes Controller Manager, and Kubernetes Scheduler are highlighted along with the destination details of Send to Log Analytics workspace, and the workspace name.
:::image-end:::

After, you can query the logs in the Logs view:

:::image type="content" source="../media/6-container-logs-query.png" alt-text="Screenshot of the Azure portal showing the Logs pane. The query AzureDiagnostics | where Category == 'kube-scheduler' is highlighted." lightbox="../media/6-container-logs-query.png":::

## Windows Exporter on Azure Kubernetes Service

Another option to monitor your Windows AKS nodes is by using the *windows-exporter*. It's the Windows variant of the Prometheus node-exporter. You can directly apply it in your cluster with a YAML specification. Take note that it runs as Host Process Container, the Windows variant of privileged containers, and because of that it can query host services, metrics, etc.

Once you have Prometheus configured and windows-exporter enabled, the Windows node related data should be in your Azure Monitor Workspace. You can use a Grafana dashboard to see the relevant metrics you enabled for your Windows node:

:::image type="content" source="../media/6-grafana-dashboard.png" alt-text="Screenshot of the Grafana dashboard. The server name akswin000000 is highlighted." lightbox="../media/6-grafana-dashboard.png":::
