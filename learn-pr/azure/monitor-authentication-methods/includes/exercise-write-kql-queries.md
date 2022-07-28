In this exercise, you'll:

- Write your first KQL query
- Test out a few common queries for sign-in logs


## Write your first query

Let's look at a sample of the data so you can get to know the columns and types of data in the table. You don't need to see all rows, just a few examples.

The `take` operator is perfect for this task, because it returns a specific number of arbitrary rows. 

1. Navigate to [Log Analytics](https://portal.azure.com/?feature.msaljs=false#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Logs).

2. In the toolbar on the top, click **Time Range**, and then select **Last 7 days**. 
   :::image type="content" source="../media/set-time-range-filter.png" alt-text="Screenshot that shows how to set a time range filter.":::

3. Copy the following query to your clipboard:

    ```kusto
    SigninLogs
    | take 10
    ```

4. Paste the query into the query editor.

5. In the toolbar on the top, click **Run**.


## Explore the results

What do you notice about the results? Scroll to view the whole dataset. Here are a few takeaways: 

* Each event has a start and end time, from the year 2007.
* The **EventType** column shows different kinds of storms.
* The state (in the **State** column) where each storm occurred is written in all capital letters.
* The damages associated with each storm are found in two separate columns: **DamageProperty** and **DamageCrops**.


## Test out the following queries

Review the results of the following queries:

- Look at the sign-ins where the Conditional Access was a success

    ```kusto
    SigninLogs
    | where ConditionalAccessStatus == "success"
    | project UserDisplayName, ConditionalAccessStatus
    ```

- Count how many successes there have been

    ```kusto
    SigninLogs  
    | where ConditionalAccessStatus == "success"
    | project UserDisplayName, ConditionalAccessStatus 
    | count
    ```

- Aggregate count of successful sign-ins by user by day

    ```kusto
    SigninLogs  
    | where ConditionalAccessStatus == "success"
    | summarize SuccessfulSignins = count()   
       by UserDisplayName, bin(TimeGenerated, 1d)
    ```

