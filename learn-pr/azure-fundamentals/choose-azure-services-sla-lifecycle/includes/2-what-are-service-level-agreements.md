A *service-level agreement* (SLA) is a formal agreement between a service company and the customer. For Azure, this agreement defines the performance standards that Microsoft commits to for you, the customer.

In this part, you'll learn more about Azure SLAs, including why SLAs are important, where you can find the SLA for a specific Azure service, and what you'll find in a typical SLA.

## Why are SLAs important?

Understanding the SLA for each Azure service you use helps you understand what guarantees you can expect.

When you build applications on Azure, the availability of the services that you use affect your application's performance. Understanding the SLAs involved can help you establish the SLA you set with your customers.

Later in this module, you'll learn about some strategies you can use when an Azure SLA doesn't meet your needs.

## Where can I access SLAs for Azure services?

You can access SLAs from [Service Level Agreements](https://azure.microsoft.com/support/legal/sla/?azure-portal=true).

> [!NOTE]
> You don't need an Azure subscription to review service SLAs.

Each Azure service defines its own SLA. Azure services are organized by category.

Open the SLA for Azure Database for MySQL, a managed database that makes it easy for developers to work with MySQL databases. You'll refer back to this SLA in a moment.

To do so:

1. Go to [Service Level Agreements](https://azure.microsoft.com/support/legal/sla/?azure-portal=true).
1. From the **Databases** category, select **Azure Database for MySQL**.

:::image type="content" source="../media/2-sla-home-database-mysql.png" alt-text="A screenshot of the SLA landing page showing the Databases category and the Azure Database for MySQL service.":::

## What's in a typical SLA?

A typical SLA breaks down into these sections:

* **Introduction**

    This section explains what to expect in the SLA, including its scope and how subscription renewals can affect the terms.
* **General terms**

    This section contains terms that are used throughout the SLA so that both parties (you and Microsoft) have a consistent vocabulary. For example, this section might define what's meant by downtime, incidents, and error codes.

    This section also defines the general terms of the agreement, including how to submit a claim, receive credit for any performance or availability issues, and limitations of the agreement.
* **SLA details**

    This section defines the specific guarantees for the service. Performance commitments are commonly measured as a percentage. That percentage typically ranges from 99.9 percent ("three nines") to 99.99 percent ("four nines").

    The primary performance commitment typically focuses on *uptime*, or the percentage of time that a product or service is successfully operational. Some SLAs focus on other factors as well, including *latency*, or how fast the service must respond to a request.

    This section also defines any additional terms that are specific to this service.

Take a moment to review the SLA for Azure Database for MySQL.

You see that this SLA focuses mainly on uptime. Azure Database for MySQL guarantees 99.99 percent, or "four nines", uptime. This means that the service is guaranteed to be running and available to process requests 99.99 percent of the time.

## How do percentages relate to total downtime?

*Downtime* refers to the time duration that the service is unavailable.

The difference between 99.9 percent and 99.99 percent might seem minor, but it's important to understand what these numbers mean in terms of total downtime.

Here's a table to give you a sense of how total downtime decreases as the SLA percentage increases from 99 percent to 99.999 percent:

| SLA percentage | Downtime per week | Downtime per month | Downtime per year |
| --- | --- | --- | --- |
| 99 |1.68 hours |7.2 hours |3.65 days |
| 99.9 |10.1 minutes |43.2 minutes |8.76 hours |
| 99.95 |5 minutes |21.6 minutes |4.38 hours |
| 99.99 |1.01 minutes |4.32 minutes |52.56 minutes |
| 99.999 |6 seconds |25.9 seconds |5.26 minutes |

These amounts are cumulative, which means that the duration of multiple different service outages would be combined, or added together.

## What are service credits?

A *service credit* is the percentage of the fees you paid that are credited back to you according to the claim approval process.

An SLA describes how Microsoft responds when an Azure service fails to perform to its specification. For example, you might receive a discount on your Azure bill as compensation when a service fails to perform according to its SLA.

Credits typically increase as uptime decreases. Here's how credits are applied for Azure Database for MySQL according to uptime:

| Monthly uptime percentage | Service credit percentage |
| --- | --- |
| < 99.99 | 10 |
| < 99 | 25 |
| < 95 | 100 |

## What's the SLA for free services?

Free products typically don't have an SLA.

For example, many Azure services provide a *free* or *shared* tier that provides more limited functionality. Services like Azure Advisor are always free. The [SLA for Azure Advisor](https://azure.microsoft.com/support/legal/sla/advisor/?azure-portal=true) states that because it's free, it doesn't have a financially backed SLA.

## How do I know when there's an outage?

[Azure status](https://status.azure.com/status?azure-portal=true) provides a global view of the health of Azure services and regions. If you suspect there's an outage, this is often a good place to start your investigation.

Azure status provides an RSS feed of changes to the health of Azure services that you can subscribe to. You can connect this feed to communication software such as Microsoft Teams or Slack.

From the Azure status page, you can also access Azure Service Health. This provides a personalized view of the health of the Azure services and regions that you're using, directly from the Azure portal.

## How can I request a service credit from Microsoft?

Typically, you need to file a claim with Microsoft to receive a service credit. If you purchase Azure services from a Cloud Solution Provider (CSP) partner, your CSP typically manages the claims process.

Each SLA specifies the timeline by which you must submit your claim and when Microsoft processes your claim. For many services, you must submit your claim by the end of the calendar month following the month in which the incident occurred.

Next, let's look at some other factors that Tailwind Traders needs to consider that might affect SLA performance targets.
