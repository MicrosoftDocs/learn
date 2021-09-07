
## How Azure Service Health works

Each one of the three services, of which Azure Service Health is composed, has different ways to work.

### Azure Status

The Azure Status Page is where you can find public information about the health of Azure services across all regions.

On the page, you can set the automatic refresh period to:
* 2 minutes
* 5 minutes
* 10 minutes
* 30 minutes

This would be useful if you want to have this information displayed in monitors at your NOC (Network Operation Center). The refresh rate will allow you to customize the information displayed, based on your service review needs.

The status page has all products and services listed by geographies and regions. There are four types of status indicators available. These indicators allow you to easily identify the service health by determing if the service is good, if there is some specific information available on that service, or an indication of a warning or critical issue.

> [!TIP]
> You will also notice blank areas in the table. These indicate that a service is not available in the region listed.

You can also choose to get an RSS feed that will provide updates on the service health as well. You can find the RSS tag on this page in the top right section of the title area.

:::image type="content" source="../media/3-azure-status.png" alt-text="Screenshot of Azure Service Status Page":::

### Service Health

Service Health is what you will be using to get information on outages, planned maintenance, health, and security advisories.

It allows you to create customized views, filtering among subscription, region, and services. The level of details will include:

* Issue Name.
* Subscription, service, and region impacted.
* Start time.
* Summary and issue updates.
* Root cause analysis.
* Downloadable PDF with explanations.

Also Service Health will allow you to create health alerts to notify you when something happens.

### Resource Health

The Resource Health executes some checks, minute-by-minute, across the resources and makes the information available to you. There is a specific type of resource that runs the health checks. You can see the [full list here](/azure/service-health/resource-health-checks-resource-types).

As an example, for Virtual Machines the type of checks executed include:

* Is the server hosting this virtual machine up and running?
* Has the host operating system (OS) booting completed?
* Is there ongoing planned maintenance?
* Is the host hardware degraded and predicted to fail soon?

The Resource Health is available through the **Support + troubleshooting** blade at Azure Portal for the specific resource types on Azure.

:::image type="content" source="../media/3-azure-resource-health.png" alt-text="Screenshot of Azure Resource Health":::
