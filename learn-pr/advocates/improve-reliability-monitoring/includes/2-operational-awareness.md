In order for us begin to work on monitoring for reliability, there is a
predecessor step we have to take. First, we need to make sure we have a
reasonable level of operational awareness.

The simplest way to say this is that in order to work towards the
reliability of systems in production, we first have to have a decent
understanding of those systems and how they are functioning in production.

## Collect information about the present configuration

Though it may sound peculiar, in many environments the first question that
needs to get answered is "**What exactly is running in production?**" Our
production environments these days and the paths to deploying things to
them are sufficiently complex that it is not uncommon to first have to do a
bit of discovery first. Given a specific application, what are its
component parts? What parts talk to other parts? What are the obvious (and
not-so-obvious) dependencies for this application?

## Collect information about normal and past performance

Once we get that information, we can then attempt to get a baseline around
performance and "normal" behavior for the system. There's lots of reasons
we may need this information, the least of which is to help us when we have
to triage a problem with the application. The middle of an outage is a bad
time to be figuring out whether the database servers running at 80% cpu is
a good thing or a bad thing.

As part of obtaining that baseline, we'll want to dive into looking at past
performance. While it is true "Past performance is no guarantee of future
results", it can sometimes help us calibrate our expectations. Similarly,
if we have access to information about past outages or hiccups with a
service, those may give us at least some sense of potential failure modes
that we're going to need to incorporate into our thinking around
reliability.

## Collect information about the context

And finally, it will be useful for us to gain some contextual knowledge
around a system. Context can fall into a wide variety of buckets, much of
it socio-technical. For example, on the socio- side we'll want to gather
good information about the stakeholders associated with a service or an
application.

You might think "oh, it's obvious who owns or cares about a particular
app/service" but in enterprise situations or other complex organizations,
this can be much harder than it sounds.

The sad truth is we're not going to be able to make much headway on the
reliability of a system without a clear idea of who the stakeholders are
for reasons that will become clear later when we discuss SLIs and SLOs.

On the technical side of the context question, it will be really helpful
for us to pay attention to technical questions like "just how did this
application get in production?". Was it deployed manually during an "epic"
deployment or was it deployed via an automated CI/CD pipeline with a great
set of unit tests?

This information can have many ramifications including how easy it will be
to iterate if and when we have reliability improving updates to make. It
can also be a really useful indicator of work that we could be doing that
will make a real difference.

## Azure Tools for Operational Awareness

Gaining operational awareness is often not easy, but we are going to look
at a few tools provided by Azure that can assist with the process. This
will be a very shallow exploration--at the end of this module we will
include pointers to other Microsoft Learn modules and documentation if
you'd like to explore any of these in more depth.

### Application Insights

The first tools we will look at can help us with the "what is actually
running?" question. As operations people, it is not unusual to be asked to
work with an application that is already running in production. While
ideally we'd be part of the entire lifecycle of the software, starting at
the design phase, that is not always (or perhaps often) the case. When this
happens, especially with more complex multi-tiered or microservice based
applications, just being able to understand what all of the moving parts
can take effort.

One tool that can reduce that effort plus give us information about the
application's behavior in production is Application Insights. With minimal
effort, developers can instrument their application so that it
automatically sends telemetry information to collectors running in Azure.
With this information, Application Insights is able to create a visual map
of the components of the application and the communication between these
components.

Here's an example:

:::image type="content" source="../media/application-map.png" alt-text="Application map panel in Azure portal displaying several components and the stats for traffic between them":::

In this picture, you can see not only the components of the application,
but also the communication between those components. If we zoom into one of
the connections between components, we can see the number of calls made
between components and the average latency for those calls. You can also
see a representation of the number of successful and the number of failed
calls. If we were to click on any of these map elements, Application
Insights would allow us to drill into the information to see detailed
statistics on performance and success/failure metrics for those calls. This
can be a great way to get a good sense of the larger picture of the
application's components and how they function as a baseline. And just a
reminder, be sure to explore your application map and all that Application
Insights can offer _before_ you have an outage.

### Azure Resource Graph

Application Insights is a great way to gain some operational awareness for
an application, but what if we wanted to get a view from even higher up and
see all of the resources we have in play on Azure in a subscription? In the
past, we would download reports or write PowerShell to gather this
information for us but now there is a much easier way.

Azure Resource Graph Explorer provides an interactive query environment
right from the Azure portal for the data we need. It lets you run arbitrary
queries that return real-time answers based on the resources currently in
use. For example, if we wanted to see all of the VMs we are currently
running, we could run the following query:

:::image type="content" source="../media/resource-graph-explorer.png" alt-text="Resource graph panel in Azure portal with the query of where type == microsoft.compute/virtualmachines":::

and we get back a complete detailed list of the VMs being used in our
subscription:

:::image type="content" source="../media/resource-graph-explorer-results.png" alt-text="Resource graph panel in the Azure portal with results of query showing table of results":::

The query language used in this environment is Kusto Query Language (KQL).
We'll be discussing it in more depth later in this module when we talk
about Azure Monitor Log Analytics.

### Dashboards

The most traditional operations tool for operational awareness is the
venerable dashboard. Often when we think of people doing operations, we
imagine them sitting in front of large monitors intensely peering into
dashboards full of graphs, charts and counters. In this module, we're not
going to explore how you construct, edit and use dashboards. That is
largely done by pinning content from other places in the portal and then
moving them around as you see fit.

Instead let's look at two dashboard features less commonly used that could
be of real benefit to you. These features can be found at the top of every
dashboard.

:::image type="content" source="../media/dashboard.png" alt-text="Dashboard panel in the Azure portal with the Upload and Download arrows highlighted":::

The two highlighted arrows allow you to upload and download JSON
representations of dashboards.

First let's start with the download functionality. If we click the down
arrow, a JSON file that represents the current dashboard will be downloaded
to your computer. If you'd like, try this now by logging into the portal,
choosing "Dashboard" from the product menu, and then click the download
arrow.

There are at least two things we can do with this file that you may find
handy:

-   We could check this file into our source control system. This allows us
    to keep track of our different versions of dashboards and also allow
    others to access them if they would like to use your dashboard. Some
    might call this "dashboards as code."

-   We can use this file as the basis of a new dashboard. Here's a concrete
    example we will revisit later in this learning path: let's say we need
    to show a colleague what a particular dashboard looked like for an hour
    during an outage that happened last week. We could publish our
    dashboard and ask them to go select the precise time and time period.
    But far easier and less error prone, we could download our dashboard
    set up exactly as we need and share that JSON file. If we want to
    highlight a second period from the same dashboard, let's say an hour in
    the future, it is easy to edit the JSON.

That's the download functionality, now let's focus on the uses for the
upload functionality. Besides being able to load the version-controlled or
edited files from the last section, we can use the upload functionality to
make use of other people's careful work when constructing dashboards.

Let's look at final example for this section that nicely ties together two
of the ideas from this unit. If you download this JSON file:

[AzureInventoryDashboard.json](https://raw.githubusercontent.com/microsoft/ignite-learning-paths-training-ops/main/ops10/demos/AzureInventoryDashboard.json)
to your computer and then upload it to a dashboard, you should see
something like this:

:::image type="content" source="../media/azure-inventory-dashboard.png" alt-text="Dashboard displaying inventory of Azure resources, one resource per tile":::

You now have a live dashboard that shows you a fairly comprehensible
inventory of your resources in use in a subscription. The data from this
dashboard is coming from the same source as the Azure Resource Graph
Explorer we looked at early. And in fact, if you click on one of tiles, you
can see (and edit if desired) the exact query that is being run to yield
the information show in that square. Excellent, no?

With that help for our operational awareness, let's begin to explore just
what we will want to monitor to assist us with improving our reliability.
