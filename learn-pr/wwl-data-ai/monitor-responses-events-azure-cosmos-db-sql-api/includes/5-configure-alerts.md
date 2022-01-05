Azure Cosmos DB uses the Azure Monitor Service to set up and send alerts. Alerts monitor the availability and responsiveness of Azure Cosmos DB resources and send notification when monitored metrics hit specified thresholds. Alerts can take the form of emails or even execute Azure Functions when they're triggered. Alerts also monitor the activity log events of your Azure Cosmos DB account.

Alerts can be set up from either your Azure Cosmos DB account page or from Azure Monitor.  From both places, you'll set up the alerts in similar fashions.  

## Setting up an alert

Let's take a look at an example of setting alerts when over *one thousand* **429 exceptions** are triggered within *15 minutes*.  The alert should check every *5 minutes* for the condition. Finally it should send an email to *admins@contoso.com* when the condition is met.

1. In your Azure Cosmos DB account page, under the *Monitoring* section choose **Alerts**.

1. Select **+ Create**  and select **Alert rule** to create a new alert. You should see your current Azure Cosmos DB account,  subscription, and Resource Group already selected.

1. Select **Add condition**. This condition will define the trigger for this alert.

    1. Time to pick the Signal type. Signals are either Metrics or Activity Logs. Since 429 exceptions can occur when requests are made, search for the signal name **Total Request Units**. We should see a graph that shows us the total request units in the last 6 hours.

    1. Currently if you add an *Alert Logic*, it will be measured against all the request units for this account. What you need is only to create a condition against the Requests that returned a status code of 429. To create that filter, under **Split by dimension** choose:

        1. Select `StatusCode` under the *Dimension name* pulldown.

        1. Select **=** under *Operator*.

        1. If a **429** exception has occurred within the last 6 hours, you could see it under the *Dimension values* options. If 429 isn't an option under *Dimension values*, Select **Add custom value** and add the value **429**. You could add extra filters like database, collection, region, or operation type if you needed an even more precise filter.

    1. Set the *Alert Logic* **Threshold** value to **1000**.

    1. Under *Evaluated based on*, set the **Aggregation granularity (Period)** to **15 minutes** and the **Frequency of Evaluation** to **5 minutes**. 

    1. Select **Done** to complete the *Condition* setup.

1. The alert needs to know what to do when the condition is met. Let's send out the email. Under *Actions*, select **Add action group**.

    1. If you already had some action create, you could reuse it. We'll create a new Action, select + **Create action group**.

    1. Under the **Basic** tab:
        1. Give the Action group a name.

        1. If needed, change the Display name.

    1. Under the **Notification** Tab:

        1. Choose **Email/SMS message/Push/Voice** under *Notification type*.

        1. Give the Notification a *Name*.

        1. Select the **pencil icon** to add the notification recipient.

            1. Select the **Email** checkbox.

            1. Set the *Email* to  **admins@contoso.com** and select **OK**.

    1. Select the **Review + create** button and then the **Create** button

1. Finally we need to fill out the alert's general information in the **Alert Rule details**.  You can change any of the preselected options as needed, but you need to at least set the **Alert rule name**, so give the alert a name. 

1. Select the **Create alert rule** button to create the alert.

Once the alert is created, it can take up to 10 minutes to activate.

## Common alerting scenarios
The following are some scenarios where you can use alerts:

- When the keys of an Azure Cosmos account are updated.
- When the data or index usage of a container, database, or a region exceeds a certain number of bytes.
- When the normalized RU/s consumption is greater than certain percentage.
- When a region is added, removed, or if it goes offline.
- When a database or a container is created, deleted, or updated.
- When the throughput of your database or the container is changed.