As a security engineer working for Contoso, you notice suspicious activities in your Azure subscription and you decide to analyze this activity by using Azure Sentinel workbooks.

## Exercise: Query and visualize data with Azure Sentinel Workbooks

You want to analyze the logs in Azure Sentinel from the Azure Activity connector. You want to then further implement visualization of this data and save it in a customized workbook.

In this exercise, you will explore logs and Azure Sentinel workbooks. You will perform the following tasks:

- Interact with logs data in the Azure Sentinel **Logs** page.
- Create and edit a custom workbook to visualize important data.

### Task 1: Work with Logs in Azure Sentinel

1. In the Azure portal, search for and select Azure Sentinel, and then select the previously created Azure Sentinel workspace.
2. On the **Azure Sentinel** page, on the menu bar on the left, in the **General** section, select **Logs**.
3. On the **Azure Sentinel | Logs** page, in the **Tables** pane, from the **Group by: Solution** drop-down menu, select **Category**.

> [!Note]
> When you open the **Logs** page for the first time, you may be redirected to the **Queries** window. Close the **Queries** window and return to the **New Query 1** section.

4. In the **Tables** pane, from the list of tables, expand the **Azure Resources** category, move the mouse<!-- This won't pass compliance, as not everyone uses a mouse. Suggest changing to "hover." --> over the **Azure Activity** table, and then select **Preview data**.
5. In the **AzureActivity** window, select **See in query editor**. This option enables you to preview the data and to check if the results will be as you expect before you actually run a query with it.

:::image type="content" source="../media/07-Tables-Pane.png" alt-text="Screenshot of the Tables pane." border="true":::

6. In the **Query** section, you can observe the query structure. This query searches and presents the last 10 events from the Azure Activity log. The first row in the query, **AzureActivity** specifies the table used in the query. The second line contains a **where** statement, which filters the records from the last day. The third line contains another statement **where** to filter only the last 10 events.
7. The query results section presents the results of the query. You can expand any of the records to review the values in the table. Select the name of any column to sort the results by that column. Select the filter icon next to it to provide a filter condition. This is similar to adding a filter condition to the query itself except that this filter is cleared if you run the query again. If you select the **Columns** drop-down menu, you can filter the columns from the table that you want to be displayed. By selecting **Group columns**, you can group records by a particular column.

:::image type="content" source="../media/07-Query-Result.png" alt-text="Screenshot of the Query results with the previous items called out." border="true":::

5. Select **Queries** in the left pane. This pane includes example queries that you can add to the query window. If you&#39;re using your own workspace, you should have a variety of queries in multiple categories, but if you&#39;re using the demonstration environment, you might only see a single **Log Analytics workspaces** category.

> [!Note]

> You can try to practice writing queries in the following [demonstration environment](https://ms.portal.azure.com/#blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade).

### Task 2: Work with Workbooks in Azure Sentinel

1. On the **Azure Sentinel** page, on the menu bar on the left, in the **Threat Management** section, select **Workbooks**.
2. On the **Azure Sentinel | Workbooks** page, select **Templates** tab.
3. In the **Search** field, enter and select **Azure Activity**.
4. In the details pane, review the information provided for the template, and then select **Save**. In the **Save workbook to…** window, select the same location that you selected in the preparation exercise, and then select **OK**.
5. On the **Azure Sentinel | Workbooks** page, select **My workbooks** tab. From the list of saved templates, select **Azure Activity**, and then in the details pane, select **View saved workbook**.
6. On **Azure Activity-** *sentinelname* page, review all the elements of the workbook.
7. You can interact with the workbook by selecting some of the elements.
8. Select the **Time range:** field to select a different time range for the records presented in the **Azure Activity** table. Select the **Caller:** drop-down menu to filter the records based on the user or service that generates the events. Select the **Resource Group:** drop-down menu to filter the events based on a specific resource group.

:::image type="content" source="../media/07-Default-workbook.png" alt-text="Screenshot of the Azure Activity page, with the previous elements called out." border="true":::

9. Scroll down to the **Caller activities** table, which displays the activities run by your users or security principals. By selecting every column, you can sort the results presented in the table.
10. Scroll up to the header bar in the **Azure Activity-** *sentinelname* page. Select the **Edit** option to switch the workbook in the editing mode. Observe the various **Edit** options that display on the page.
11. Select the first **Edit** option. That will bring editing pane for one of the steps in the workbook. You can further customize the presentation of the elements by adjusting the style and reordering them in different order.
12. You can add additional parameters with different types such as text, drop-down, multi-values, or similar.
13. Select **Add parameter**.
14. In the **New Parameter** page, enter the following values:

|||
|---| ---|
|**Parameter name***| Level|
|**Display name**| Level|
|**Parameter type**| From the drop-down menu, select **Drop down**|
|**Required?**| Select this check box.|
|**Allow multiple selections**| Select this check box.|
|**Limit multiple selections**| Do not select this check box.|
|**Delimiter**| Retain the default values.|
|**Quote with**| Retain the default values.|
|**Explanation**| This parameter will filter the events based on the level.|
|**Hide parameter in reading mode**| Do not select this check box.|
|**Get data from**| Query|

1. In the **Log Analytics workspace Logs Query** section, enter the following query, and then select **Run Query**.

```kusto
AzureActivity

|summarize by Level
```

17. Confirm that the query result returns two type of events based on the level: **Informational, Warning**.

:::image type="content" source="../media/07-Add-parameter.png" alt-text="Screenshot of the New Parameter pane, with steps for adding a new parameter. The Save, Query, Run query options and the AzureActivity section are highlghted in the screenshot." border="true":::

18. Select **Save** to commit the changes in the step.
19. Notice that the parameter step now includes one additional parameter name called **Level**.
20. When you are finished making all the changes in the step, select **Done Editing**.
21. If you select the three dots next to the **Edit** option, the new drop-down menu will appear. From that menu, you can move this step to different parts of the workbook. You can also clone or remove the step from the workbook.
22. On the header bar, select the **Save as** icon to save the customized workbook.
23. In the title, provide a name for the new workbook, and then select **Save**.
24. Your new workbook will be created in the **My workbooks** tab. If you don&#39;t observe the workbook listed, select the **Refresh** option.
