In order for us to begin to work on monitoring for reliability, there's a predecessor step we have to take. First, we need to make sure we have a reasonable level of operational awareness.

The simplest way to say this is that in order to work towards the reliability of systems in production, we first have to have a decent understanding of those systems and how they're functioning in production.

## Collect information about the present configuration

Though it may sound peculiar, in many environments the first question we need to answer is "**What exactly is running in production?**" Our production environments these days and the paths to deploying to them are sufficiently complex that it's not uncommon to first have to do a bit of discovery first. Given a specific application, what are its component parts? What parts talk to other parts? What are the obvious (and not-so-obvious) dependencies for this application?

## Collect information about normal and past performance

Once we get that information, we can then attempt to get a baseline around performance and "normal" behavior for the system. There's lots of reasons we might need this information, not the least of which is to help us when we have to triage a problem with the application. The middle of an outage is a bad time to be figuring out whether the database servers running at 80% CPU is a good thing or a bad thing.

As part of obtaining that baseline, we'll want to dive into looking at past performance. While it's true that past performance is no guarantee of future results, it can sometimes help us calibrate our expectations. Similarly, if we have access to information about past outages or hiccups with a service, those might give us at least some sense of potential failure modes that we're going to need to incorporate into our thinking around reliability.

## Collect information about the context

And finally, it's useful for us to gain some contextual knowledge around a system. Context can fall into a wide variety of buckets, much of it socio-technical. For example: on the socio- side, we'll want to gather good information about the stakeholders associated with a service or an application.

You might think *oh, it's obvious who owns or cares about a particular app/service*, but in enterprise situations or other complex organizations, this can be much harder than it sounds.

The sad truth is that we're not going to be able to make much headway on a system's reliability without a clear idea of who the stakeholders are (for reasons that will become clear later when we discuss SLIs and SLOs).

On the technical side of the context question, it's really helpful for us to pay attention to technical questions like *just how did this application get into production?* Was it deployed manually during an "epic" deployment, or was it deployed via an automated CI/CD pipeline with a great set of unit tests?

This information can have many ramifications, including how easy it will be to iterate if and when we have reliability improving updates to make. It's also possibly a useful indicator of work that we could be doing that will make a real difference.

## Azure Tools for operational awareness

Gaining operational awareness is often not easy, but we're going to look at a few tools Azure provides that can assist with the process. This will be a very shallow exploration; at the end of this module, we'll include pointers to other Microsoft Learn modules and documentation if you'd like to explore any of these in more depth.

### Application Insights

The first tools we'll look at can help us with the "what's actually running?" question. As operations people, it's not unusual to be asked to work with an application that's already running in production. While ideally we'd be part of the entire lifecycle of the software, starting at the design phase, that's not always (or perhaps often) the case. When this happens, especially with more complex multitiered or microservice-based applications, just being able to understand what all of the moving parts do can take effort.

One tool that can reduce that effort—plus give us information about the application's behavior in production—is Application Insights. Developers can instrument their application—ideally by using the Azure Monitor OpenTelemetry Distro, which is the recommended approach for new projects—and send telemetry to an Application Insights resource in Azure Monitor. When dependency telemetry is flowing and the application's cloud role names are configured correctly, Application Insights can create an Application map that shows the components of the application and the communication between those components.

Here's an example:

:::image type="content" source="../media/application-map.png" alt-text="Screenshot of the Application map panel in Azure portal displaying several components and the stats for traffic between them.":::

In the preceding picture, you can see not only the components of the application, but also the communication between those components. If you zoom into one of the connections between components, you can see the number of calls made between components and the average latency for those calls. You can also see a representation of the number of successful and the number of failed calls. If you select any of these map elements, Application Insights lets you drill into the information to see detailed statistics on performance and success/failure metrics for those calls. This can be a great way to get a good sense of the larger picture of the application's components and how they function as a baseline. As a reminder, be sure to explore your application map and all that Application Insights can offer *before* you have an outage.

### Azure Resource Graph

Application Insights is a great way to gain some operational awareness for an application, but what if you want to get a view from even higher up and see all of the resources you have in play on Azure in a subscription? In the past, you'd download reports or write PowerShell to gather this information, but now there's a much easier way.

Azure Resource Graph Explorer provides an interactive query environment right from the Azure portal for the data you need. It lets you run queries against near-current inventory data for the resources in your subscriptions. For example, if you want to see all of the VMs you're currently running, you could run the following query:

:::image type="content" source="../media/resource-graph-explorer.png" alt-text="Resource graph panel in Azure portal with the query of where type == microsoft.compute/virtualmachines":::

and you'd get back a complete detailed list of the VMs being used in our subscription:

:::image type="content" source="../media/resource-graph-explorer-results.png" alt-text="Resource graph panel in the Azure portal with results of query showing table of results.":::

The query language used in this environment is based on Kusto Query Language (KQL). Azure Resource Graph supports a useful subset of KQL rather than every KQL feature. We'll be discussing KQL in more depth later in this module when we talk about Azure Monitor Log Analytics.

### Workbooks

Azure Monitor workbooks are the richest built-in visualization tool for operational awareness. They let you combine KQL queries, metrics, text, parameters, and links into interactive reports. They're especially useful when you want an end-to-end monitoring view across multiple resources or when you need to build things like reliability scorecards and SLI/SLO views with filters and drill-through.

### Dashboards

The most traditional operations tool for operational awareness is the venerable dashboard. Often when we think of people doing operations, we imagine them sitting in front of large monitors intensely peering into dashboards full of graphs, charts, and counters. In this module, we're not going to explore how you construct, edit, and use dashboards in detail. That's largely done by pinning content from other places in the portal and arranging tiles as you see fit.

Instead, let's look at a powerful idea: **dashboards as code**. Azure portal dashboards can be exported and imported as JSON files, and you can also deploy them by using ARM templates or Bicep. This means you can:

- **Version-control dashboard definitions** by checking the exported JSON into source control. This lets you track layout and configuration changes over time and share reusable dashboards with colleagues.

- **Reuse and deploy dashboards across environments.** The exported JSON captures the dashboard's layout, pinned content, and configuration. It doesn't freeze the live telemetry at a point in time, which makes it a good fit for repeatable deployment rather than for capturing historical evidence.

- **Build dashboards from Azure Resource Graph queries.** You can construct queries that count your virtual machines, storage accounts, and databases, pin those results to a dashboard, and then export the JSON for version control or reuse in another subscription. This gives you a live inventory dashboard driven by current resource data. If you select one of the tiles on that dashboard, you can inspect and refine the underlying query that produced it.

If you need to show a colleague the view you used during an outage, it's usually better to share a link to the dashboard or workbook with the relevant filters and time range than to treat exported JSON as a snapshot of the data.

:::image type="content" source="../media/dashboard.png" alt-text="Screenshot of an Azure portal dashboard showing export and sharing options.":::

### Grafana

If your team prefers Grafana-style operational dashboards, Azure offers two main paths. **Azure Monitor dashboards with Grafana** are a good fit when you're working only with Azure-native data sources. **Azure Managed Grafana** is the better option when you want broader Grafana capabilities, more advanced sharing, or non-Azure data sources.

> [!TIP]
> Azure Monitor offers several visualization options. Use [Workbooks](/azure/azure-monitor/visualize/workbooks-overview) for rich interactive reports, [Azure dashboards](/azure/azure-portal/azure-portal-dashboards-create-programmatically) when you want reusable portal dashboards defined as code, and [Grafana options in Azure](/azure/azure-monitor/visualize/visualize-grafana-overview) when you want Grafana-style dashboards, including **Azure Monitor dashboards with Grafana** and Azure Managed Grafana.

With that help for our operational awareness, let's begin to explore just what we'll want to monitor to assist us with improving our reliability.
