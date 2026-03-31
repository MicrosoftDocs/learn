In your sales role, you're preparing for a team meeting and want to understand how different regions performed last quarter. You have the data in a spreadsheet but need a quick summary you can share. In this exercise, you'll copy a small dataset into Excel, format it as a table, and use Copilot to summarize and visualize it.

>[!IMPORTANT]
> ​​​​​​​If you have a work or school account and a qualifying Microsoft 365 business subscription, Copilot Chat is now available for you to use in Word, Excel, PowerPoint, Outlook, and OneNote. How you use Copilot in the apps can depend on what you're licensed for.
> For the content in this module, an eligible Microsoft 365 Copilot license is required. See [Where can I get Microsoft 365 Copilot?](https://support.microsoft.com/en-us/topic/where-can-i-get-microsoft-copilot-40a622db-6d25-4266-b008-4bbcb55cf52f)

Copy the following data and paste it into a blank Excel worksheet starting at cell A1.

| **Region** | **Product** | **Quarter** | **Revenue** | **Units Sold** |
| :---: | :---: | :---: | :---: | :---: |
| North | Widget A | Q1 | 125000 | 230 |
| North | Widget A | Q2 | 118000 | 212 |
| South | Widget A | Q1 | 95000 | 180 |
| South | Widget A | Q2 | 99000 | 192 |
| East | Widget B | Q1 | 110000 | 205 |
| East | Widget B | Q2 | 104000 | 198 |
| West | Widget B | Q1 | 102000 | 194 |
| West | Widget B | Q2 | 115000 | 216 |

## Format data as a table

- Select any cell in the dataset.
- Go to **Insert > Table**, confirm the headers, select **OK**.
:::image type="content" border="true" source="../media/microsoft-excel-insert-table-inline.png" alt-text="Screenshot showing where to find Insert Table in Microsoft Excel." lightbox="../media/microsoft-excel-insert-table-expanded.png":::

- Under the **Table Design** ribbon, select the **Table Name** and name the table SalesData.

Doing this helps Copilot recognize the structure.

>[!IMPORTANT]
> You must save your file to cloud storage like OneDrive before using Copilot in Excel.

## Access and use Copilot

Now that you have your table properly set up, let's involve Copilot.

:::image type="content" border="true" source="../media/microsoft-excel-copilot-pane-inline.png" alt-text="Screenshot showing the location of the Copilot pane in Excel, as well as the Work/Web toggle buttons and the message box." lightbox="../media/microsoft-excel-copilot-pane-expanded.png":::

- In the **Home Ribbon**, choose **Copilot** to open the Copilot chat pane.
- If you have a Microsoft 365 Copilot license, you should see a choice between two icons at the top of the Copilot pane. The **briefcase** icon brings you to the Work experience, which can access and use certain information from your work documents when answering prompts. The **globe** icon brings you to the Web experience, which uses web-based data to answer questions and provide insights. For this exercise, select the Work experience.
- Enter the following prompt in the **Message Copilot** box.

```copilot-prompt

Summarize total revenue by region.

```

Copilot returns a simple summary table with totals and a short description.

## Refine your insights

Follow up with a new request:

```copilot-prompt

Add a column that shows quarter-over-quarter change for each region.

```

Then try:

```copilot-prompt

Create a chart that compares revenue by region.

```

While Copilot currently can't directly insert charts created via chat prompts into open Excel documents, it provides you with an easy way to copy the chart to the clipboard. You can then paste it into your Excel document, an email, or Teams message.

Select the image icon on the chart Copilot produces. This will copy the preview to the clipboard.

:::image type="content" border="true" source="../media/microsoft-excel-insert-chart-from-copilot.png" alt-text="Screenshot showing where to find the button to insert charts from Copilot in Excel.":::

You can also ask Copilot to save any tables it creates in a new file, which can then be added to your original document.

## Use Copilot Suggestions to do more

Right click on any cell in your table and find **Copilot Suggestions**. These provide data that can be directly inserted into your existing Excel workbook.

- Select **Get Deeper Analysis Results using Python**. Copilot uses Python to perform a deeper analysis of your table's data. It provides you with data or charts that you can directly add into your workbook.
- Select **Summarize using PivotTable or Chart** to have Copilot create a PivotTable with the data in your table. This PivotTable can be directly added to a new chart in the same Excel workbook.
- Select **Suggest a Formula Column**. Copilot analyzes your table and suggest a new column using your table's data. This new column can also be directly added to the table in your existing workbook.
- Select **Suggest Conditional Formatting**. Copilot suggests a conditional formatting rule that makes sense given the context of your table's data. You can then apply it directly from the Copilot chat.
