This guided project consists of the following exercises:

 - Create an action group
 - **Create a Service Health alert**
 - Create an Activity Log alert

In this exercise, you create a Service Health alert that watches for platform incidents and planned maintenance in your regions. This free alert gives your team automatic visibility into Azure service issues that might affect your resources.

This exercise includes the following tasks:

 - Navigate to Service Health
 - Create the alert rule

**Outcome:** A Service Health alert that notifies the operations team about Azure platform incidents and planned maintenance.

## Task 1: Navigate to Service Health

Open Azure Service Health, which tracks the status of Azure services across the regions you use. Service Health alerts notify you automatically when Azure platform issues might affect your resources.

1.  In the portal search bar, search for **Service Health** and select **Service Health**.
2.  Select **Service issues** in the left menu. Review whether any active incidents are listed for your subscription. If none are active, that means all services are healthy in your regions.
3.  Select **Planned maintenance** and note any upcoming maintenance windows. These are the types of events your alert will notify you about.
4.  Select **Health advisories** to see any non-critical recommendations from Azure.
5.  Select **Health history** to view past incidents and their resolution timelines. This gives context for why proactive alerting matters.
6.  Select **Health alerts** in the left menu.

> [!NOTE]
> **Validation step:** Confirm you reviewed all four Service Health tabs (Service issues, Planned maintenance, Health advisories, Health history).

## Task 2: Create the alert rule

Configure an alert that watches for service incidents and planned maintenance events in the regions you use. This is a free alert that requires no running compute resources.

1.  Select **+ Create service health alert**.
2.  For **Subscription**, select your subscription.
3.  For **Service(s)**, leave the default to monitor all services, or select specific services you use.
4.  For **Region(s)**, select the region you used for the resource group (and any other regions you use).
5.  For **Event types**, check both **Service issue** and **Planned maintenance**.
6.  Select the **Actions** tab.
7.  Select **Select action groups** and choose **ag-gp-ops-email**.
8.  Select the **Details** tab.
9.  For **Resource group**, select **rg-gp-monitoring-alerts**.
10. For **Alert rule name**, enter **ar-gp-service-health**.
11. Make sure **Enable alert rule upon creation** is checked.
12. Select **Create**.

> [!NOTE]
> **Validation step:** Confirm the **ar-gp-service-health** alert rule is created and enabled.

> [!NOTE]
