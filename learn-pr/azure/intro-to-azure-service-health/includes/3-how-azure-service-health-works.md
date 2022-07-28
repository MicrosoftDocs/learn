
## How Azure Service Health works

Each one of the three services that comprise Azure Service Health works in different ways.

### Azure Status

The Azure Status Page is where you can find public information about the health of Azure services across all regions.

On the page, you can set the automatic refresh period to:

* 2 minutes
* 5 minutes
* 10 minutes
* 30 minutes

You may find this useful if you want to have this information displayed in monitors at your NOC (Network Operation Center). The refresh rate will allow you to customize the information displayed based on your service review needs.

The status page has all products and services listed by geographies and regions. There are four types of status indicators available. The indicators allow you to easily identify the service health by determining if the service is good, if there is some specific information available on that service, or an indication of a warning or critical issue.

> [!TIP]
> You will also notice blank areas in the table. These indicate that a service is not available in the region listed.

You can also choose to get an RSS feed that will provide updates on the service health. You can find the RSS tag on this page in the upper right section of the title area.

:::image type="content" source="../media/3-azure-status.png" alt-text="Screenshot of Azure Service Status Page displaying the public information about the health of Azure services among the different geographies." lightbox="../media/3-azure-status-expanded.png":::

### Service Health

You'll use Service Health to get information on outages, planned maintenance, health, and security advisories.

It allows you to create customized views, filtering among subscription, region, and services. The level of details will include:

* Issue Name
* Subscription, service, and region impacted
* Start time
* Summary and issue updates
* Root-cause analysis
* Downloadable PDF with explanations

Service Health will also allow you to create health alerts to notify you when something happens.

### Resource Health

The Resource Health executes some minute-by-minute checks across the resources and makes the information available to you. There is a specific type of resource that runs the health checks. You can see the [full list of resource types on this page](/azure/service-health/resource-health-checks-resource-types).

As an example, for Virtual Machines the type of checks executed include:

* Is the server hosting this virtual machine up and running?
* Has the host operating system (OS) booting completed?
* Is there ongoing planned maintenance?
* Is the host hardware degraded and predicted to fail soon?

The Resource Health is available through the **Support + troubleshooting** blade in the Azure portal for the specific resource types on Azure.

:::image type="content" source="../media/3-azure-resource-health.png" alt-text="Screenshot of Azure Resource Health with the health history of a specific virtual machine" lightbox="../media/3-azure-resource-health-expanded.png":::

## What are the main features of Azure Service Health?

The main features from Azure Service Health are listed in this section. We'll review some details for each one.

### Personalized dashboards

With Azure Service Health, you can create a personalized dashboard (view) that allows you to filter on subscription, region, and service. Doing so allows you to customize the information available for review, based on what is more important/critical to your environment.

:::image type="content" source="../media/4-personalized-dashboard.png" alt-text="Screenshot depicting an example of a Personalized Dashboard with multiple subscriptions selected across two regions." lightbox="../media/4-personalized-dashboard-expanded.png":::

### Configurable cloud alerts

Based on the selections you make, you can add a service health alert and choose which type of events about which you would like to be notified.

:::image type="content" source="../media/4-create-alert.png" alt-text="Screenshot depicting configuration of an alert rule. The image shows four event types selected for a single subscription." lightbox="../media/4-create-alert-expanded.png":::

### Shareable documents with details about issues

For any service issue, planned maintenance, health, or security advisories, you can download a PDF document containing the relevant information. By selecting the issue, you can see the summary information along with the option to download all information as a PDF document. You may find it useful when you need to share the details by e-mail, for example. Among other detailed information, the PDF will contain the event type, status, service impacted, region, impacted subscriptions, update history and more.

:::image type="content" source="../media/4-shareable-documents.png" alt-text="Screenshot with a summary of a Log Analytics issue showing details such as Tracking ID, Impacted regions, Impacted subscription, Last updates, Preliminary Root Cause, and a link to Download the summary as PDF." lightbox="../media/4-shareable-documents-expanded.png":::

### Guidance and support during incidents

If there are incidents, you can find guidance and related information about workarounds or actions you can take to minimize impact, as well all issue updates.

:::image type="content" source="../media/4-guidance-support.png" alt-text="Screenshot of an issue showing the guidance and workaround suggested." lightbox="../media/4-guidance-support-expanded.png":::
