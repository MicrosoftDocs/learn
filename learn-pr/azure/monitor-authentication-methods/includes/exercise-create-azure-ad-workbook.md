In this exercise, you'll:

- Create a new Microsoft Entra workbook from scratch.
- Include a query to your workbook.
- Select a visualization for your workbook.
- Create a new Microsoft Entra workbook using a template from the Azure gallery.

 


<a name='create-your-first-azure-ad-workbook'></a>

## Create your first Microsoft Entra workbook
 
In this exercise, you'll create your first Microsoft Entra workbook using the Quick start template. 
The objective of this workbook is to create a report of the client apps that were used in the past seven days.

:::image type="content" source="../media/example-client-apps-used-past-week.png" alt-text="Screenshot that shows an example report of client apps used in the past seven days.":::

This workbook is based on the following Kusto query: 


   ```kusto
    SigninLogs
    | where TimeGenerated > ago(7d)
    | project TimeGenerated, UserDisplayName, ClientAppUsed
    | summarize count() by ClientAppUsed
   ```


**To create your workbook:**

1. Navigate to [Workbooks](https://portal.azure.com/?feature.msaljs=false#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Workbooks).
 
2. In the **Quick start** section of the gallery, click **Empty**.
    :::image type="content" source="../media/create-empty-workbook.png" alt-text="Screenshot that shows how to create an empty workbook.":::

3. To add a title, in the menu, click **Add**, and then click **Add text**.
    :::image type="content" source="../media/add-text-to-workbook.png" alt-text="Screenshot that shows how to add text to a workbook.":::

4. In the **Markdown text** textbox, type: **# Client apps used in the past week** 
    :::image type="content" source="../media/edit-workbook-title.png" alt-text="Screenshot that shows how to edit the title of a workbook.":::

5. To add a query, in the menu, click **Add**, and then click **Add query**. 
    :::image type="content" source="../media/add-query-to-workbook.png" alt-text="Screenshot that shows how to add a query to a workbook.":::
 
6. Copy the query above, and then paste it into the **Log Analytics workspace Logs Query** textbox.
    :::image type="content" source="../media/add-query-to-workbook.png" alt-text="Screenshot that shows the sample query in the query textbox.":::

7. In the **Visualization** menu, select **Pie chart**.
    :::image type="content" source="../media/select-pie-chart.png" alt-text="Screenshot that shows how to select pie chart as visualization.":::

8. In the toolbar, click **Run Query**.


<a name='create-a-new-azure-ad-workbook-using-an-existing-workbook-template'></a>

## Create a new Microsoft Entra workbook using an existing workbook template

In the previous section, you've learned how to create a Microsoft Entra workbook from scratch. The Microsoft Entra workbooks gallery has various workbook templates you can use for your projects. Using a workbook template, enables you to save a lot of time and to reduce the risk of potential mistakes when developing a workbook. In the workbook gallery, you can find a workbook called "Sign-ins using legacy authentication". You can use this workbook template as starting point to solve the business problem outlined at the begin of this module.

The following exercise shows, how you can use this workbook template to create a new workbook.  

:::image type="content" source="../media/recently-modified-workbooks.png" alt-text="Screenshot that shows a newly created workbook that is based on a workbook template.":::
 

**To create your workbook:**

1. Navigate to [Workbooks](https://portal.azure.com/?feature.msaljs=false#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Workbooks).

2. In the **Usage** section, click **Sign-ins using Legacy Authentication**.
    :::image type="content" source="../media/select-sign-ins-using-legacy-authentication-workbook.png" alt-text="Screenshot that shows how to select the sign-ins using legacy authentication workbook.":::

3. In the toolbar, click **Edit**.

    :::image type="content" source="../media/select-edit-workbook.png" alt-text="Screenshot that shows how to select edit in an open workbook.":::

4. At the end of the first paragraph, click **Edit**.
    :::image type="content" source="../media/edit-workbook-introduction.png" alt-text="Screenshot that shows how to start the edit mode for a paragraph in a workbook.":::

5. Change the title to **## My sign-ins using legacy authentication**, and then click **Done Editing**.
    :::image type="content" source="../media/change-title-in-workbook.png" alt-text="Screenshot that shows how to update the first paragraph of a workbook.":::

6. In the toolbar on the top, click **Save**.
    :::image type="content" source="../media/save-workbook-updates.png" alt-text="Screenshot that shows how to save your workbook updates.":::

7. Update the **Title** to **My sign-ins using Legacy Authentication**, and then click **Save**.
    :::image type="content" source="../media/save-workbook-updates-to-gallery.png" alt-text="Screenshot that shows how to save your workbook updates to the gallery.":::

8. To return to the workbooks gallery, in the toolbar, click **Workbooks**.
    :::image type="content" source="../media/return-to-workbook-gallery.png" alt-text="Screenshot that shows how to return to the workbooks gallery.":::

You may have to refresh your browser window if your workbook doesn't show up. At this point, you should spend some time on reviewing your new workbook and test its capabilities.
