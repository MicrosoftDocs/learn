Now let's put some of the data analysis principles and techniques you've learned into action. In this lab, you'll use Excel Online to analyze and visualize data.

In this lab, you analyze Rosie's lemonade sales, and create visualizations to help you gain insights from the data.

## Before you start

> [!NOTE]
> If you have completed the previous module in this learning path, you can skip the **Before you start** section.

If you don't already have a Microsoft account (for example a `hotmail.com`, `live.com`. or `outlook.com` account), sign up for one at [https://signup.live.com](https://signup.live.com).

### Upload the workbook to OneDrive

1. In your web browser, navigate to [https://onedrive.live.com](https://onedrive.live.com), and sign in using your Microsoft account credentials. You should see the files and folders in your OneDrive, like this:

    :::image type="content" source="../media/one-drive.png" alt-text="Screenshot of One Drive My Files folder." lightbox="../media/one-drive.png":::

2. On the **&#65291; New** menu, select **Folder** to create a new folder. You can name this anything you like, for example **DAT101**. When your new folder appears, select it to open it.
3. In your new empty folder, on the **&#10514; Upload** menu, click **Files**. Then when prompted, in the **File name** box, enter the following address (you can copy and paste it from here!):

    ```
    https://github.com/MicrosoftLearning/mslearn-data-concepts/raw/main/labfiles/Lemonade.xlsx
    ```

    Then click **Open** to upload the Excel file containing Rosie's lemonade data, as shown here:

    :::image type="content" source="../media/upload-files.png" alt-text="Screenshot of uploading a file to One Drive." lightbox="../media/upload-files.png":::

    After a few seconds, the **Lemonade.xlsx** file should appear in your folder like this:

    :::image type="content" source="../media/lemonade-xlsx.png" alt-text="Screenshot of Lemonade x l s x file in One Drive." lightbox="../media/lemonade-xlsx.png":::

### Open the workbook in Excel Online

1. Click the **Lemonade.xlsx** file in your OneDrive folder to open it in Excel Online. When opened, it should look like this:

    :::image type="content" source="../media/lemonade-workbook.png" alt-text="Screenshot of Lemonade workbook in Excel." lightbox="../media/lemonade-workbook.png":::

2. The dates in column **A** may be too wide to be displayed, so the cells may contain ***#######*** as previously shown. To see the dates, double-click the line between the **A** and **B** column headers. The dates are now shown in the format for the locale associated with your Microsoft account. For example, in the following image, the dates are shown in UK format (*dd/MM/yyyy*).

    :::image type="content" source="../media/widened-column.png" alt-text="Screenshot of column A widened to show dates." lightbox="../media/widened-column.png":::

## Exercise 1: Analyze data with a PivotTable

PivotTables are an excellent way to *slice and dice* data, summarizing numeric measures by one or more dimensions. In this exercise, you'll use a PivotTable to view the lemonade data, aggregated in various ways.

### Create a PivotTable

1. If you havn't already done so, in your web browser, navigate to [https://onedrive.live.com](https://onedrive.live.com), and sign in using your Microsoft account credentials. Then open the **Lemonade.xlsx** workbook in the folder where you uploaded it in the **Before you start** section. Your workbook should look like this:

    :::image type="content" source="../media/conditional-bottom-ten.png" alt-text="Screenshot of Lemonade workbook in Excel Online.":::

2. Select any cell in the table of data, and on the **Insert** tab of the ribbon, click **PivotTable**, and create a PivotTable from your table of data in a new worksheet. Excel adds a new worksheet with a PivotTable that looks like this:

    :::image type="content" source="../media/pivot-table.png" alt-text="Screenshot of an empty Pivot Table in Excel Online.":::

3. In the **PivotTable Fields** pane, select **Month**. Excel automatically adds **Month** to the **Rows** area of the PivotTable and displays the month names in chronological order.
4. In the **PivotTable Fields** pane, select **Sales**. Excel automatically adds **Sum of Sales** to the **Values** area of the PivotTable and displays the total number (sum) of lemonade sales for each month, like this:

    :::image type="content" source="../media/pivot-monthly-sales.png" alt-text="Screenshot of a Pivot Table showing sales summed by month.":::

    You can now see the sales aggregated by month – so for example, there were 1,056 sales in June.

### Add a second dimension

1. In the **PivotTable** Fields pane, select **Day**. Excel automatically adds **Day** to the **Rows** area of the PivotTable and displays the total number (sum) of lemonade sales for each weekday within each month, like this:

    :::image type="content" source="../media/pivot-month-day.png" alt-text="Screenshot of a Pivot Table showing sales grouped by month and day.":::

    Now you can see monthly sales aggregated by weekday. For example, 57 of the sales in January were made on a Saturday. You can also expand/collapse months to *drill-up*/*drill-down* the levels of the hierarchy.

2. In the **PivotTable Fields** pane, drag **Day** from the **Rows** area to the **Columns** area. Excel now shows total sales for each month on rows, broken down by weekday in columns; like this:

    :::image type="content" source="../media/pivot-day-columns.png" alt-text="Screenshot of a Pivot Table showing sales grouped by month on rows and day on columns.":::

    You can still see monthly sales broken down by weekday, but you can also see (in the bottom row) the totals for each weekday across the entire year. For example, a total of 1,324 sales were made on a Monday.

### Change the aggregation

1. In the **PivotTable Fields** pane, in the **Values** area, click the drop-down arrow next to **Sum of Sales**, and then click **Value Field Settings**.
2. In the **Value Field Settings** dialog box, select **Average** as shown here:

    :::image type="content" source="../media/field-values-summary.png" alt-text="Screenshot of setting field value settings to summarize value by average.":::

    The table of data now shows the average number of sales for each month and weekday, as shown here:

    :::image type="content" source="../media/pivot-average-sales.png" alt-text="Screenshot of a Pivot Table showing average sales grouped by month on rows and day on columns.":::
 
    You can now see the average number of sales for each weekday by month. For example, the average number of sales on a Wednesday in February is 19.75.

### Challenge: PivotTable analysis

1. Modify the fields in the PivotTable to find the following information:
    - The total sum of revenue for August.
    - The temperature on the hottest Saturday in July.
    - The lowest number of flyers distributed in a day during November.

## Exercise 2: Visualizing data with charts

It can often be easier to identify trends and relationships in data by creating data visualizations such as charts.

### View the sales trend for the year

1. Modify the PivotTable you created in the previous exercise so that it shows **Date** in the **Rows** area and the sum of **Sales** and sum of **Temperature** (in that order) in the **Values** area, like this:

    :::image type="content" source="../media/pivot-date-sales-temperature.png" alt-text="Screenshot of a Pivot Table showing sales and temperature totals by date.":::

    Make sure your table looks like the one shown, before you proceed (note that the date may be formatted differently for your location).

2. Using the following instructions, select the cells containing the date, daily sales, and temperature values only, but **not** the **Date**, **Sum of Sales**, and **Sum of Temperature** header cells or the **Grand Total** footer cells:
    - Click cell **A4**, which should contain the date value for January 1 2017.
    - Then press SHIFT + CTRL + **&#8680;** (SHIFT + **&#8984;** + **&#8681;** on Mac OSX) to extend the selection to include the sales and temperature values.
    - Then press SHIFT + CTRL + **&#8681;** (SHIFT + **&#8984;** + **&#8681;** on Mac OSX) to select the rows beneath the current selection.
    - Finally press SHIFT + **&#8679;** to de-select the grand totals.

3. On the **Home** tab of the ribbon, click the **Copy** button (&#128464;) to copy the selected cells to the clipboard.
4. Under the worksheet, click the **New Sheet** button (**+**) to add a new worksheet to the workbook.
5. In the new sheet, select cell **A2**, and then on the **Home** tab click the **Paste** button (&#128203;) to paste the copied cells into the new worksheet. You may need to widen the **A** column to see the dates.
6. In cells **A1** to **C1**, add the columns headers **Date**, **Sales**, and **Temperature**. Your new worksheet should look like this:

    :::image type="content" source="../media/new-sheet-sales-date-temp.png" alt-text="Screenshot of a new worksheet showing sales and temperature totals by date.":::

7. Select the **Date** and **Sales** data, including the headers (but **not** the temperature data). Then on the **Insert** tabs of the ribbon, in the Line drop-down list, click the first line chart format. Excel inserts a line chart like this:

    :::image type="content" source="../media/sales-line-chart.png" alt-text="Screenshot of a line chart showing sales by date.":::

    Note that the line chart shows daily fluctuations in sales, but the general trend seems to indicate that sales are higher during the summer months and lower at the beginning and end of the year.

8. Delete the chart, and then select all the data and headers, including **Temperature** and insert a new line chart. This inserts a chart like this:

    :::image type="content" source="../media/sales-temperature-line-chart.png" alt-text="Screenshot of a line chart showing sales and temperature by date.":::

    This time, the chart includes separate series for **Sales** and **Temperature**. Both series show a similar pattern; it seems sales and temperature both increase over the summer months.

9. Select the chart and double-click the chart title. Then in the **Chart** pane on the **Format** tab, expand **Chart Title** and change the chart title to *Sales and Temperature*:

    :::image type="content" source="../media/edit-chart-title.png" alt-text="Screenshot of editing the chart title in Excel Online.":::

10. Close the **Chart** pane.

### View revenue by weekday

1. Return to the worksheet containing the PivotTable, and modify it to show **Day** on rows with the *average* of **Revenue**. Your result should look like this although your days of the week may not be ordered:

    :::image type="content" source="../media/pivot-day-average-revenue.png" alt-text="Screenshot of a Pivot Table showing average revenue by day.":::

2. Copy the day and average revenue values (but **not** the headers or total) to the clipboard, and then add a new worksheet, paste the copied data in cell **A2**, and add **Day** and **AverageRevenue** headers like this:

    :::image type="content" source="../media/new-sheet-day-average-revenue.png" alt-text="Screenshot of a new worksheet showing average revenue by day.":::

3. Select the **B** column header and on the **Home** ribbon tab, use the **\$** menu to format the revenue data as **\$ English (United States)**, like this:

    :::image type="content" source="../media/format-average-revenue.png" alt-text="Screenshot of a worksheet showing average revenue by day formatted as U S currency.":::

4. Select all the data, including the **Day** and **AverageRevenue** headers, and on the **Insert** tab of the ribbon, in the **Column** drop-down list, select the first column chart format. A chart like this is created:

    :::image type="content" source="../media/average-revenue-column-chart.png" alt-text="Screenshot of a column chart showing average revenue by day.":::

    At first glance, this chart appears to show some significant variation between average revenue of different days of the week; with revenue on Thursdays much higher than on Sundays. However, look more closely at the scale on the vertical (Y) axis – The difference is less than 30 cents.

5. Select the column chart, and on the **Chart** tab of the ribbon, in the **Pie** drop-down list select the **2D Pie chart** format. The chart changes to a pie chart like this:

    :::image type="content" source="../media/average-revenue-pie-chart.png" alt-text="Screenshot of a pie chart showing average revenue by day.":::

    Note that the pie segments are more or less the same size for each day.

6. Select the pie chart and on the **Chart** tab, in the **Data Labels** drop-down list, select **Inside End**. This displays the actual data amounts in the chart, like this:

    :::image type="content" source="../media/average-revenue-pie-chart-labels.png" alt-text="Screenshot of a pie chart showing average revenue by day with data labels.":::

    Now it's clearer that there's little apparent variation in average revenue for different days of the week.

### View sales by flyers

1. Return to the worksheet containing the PivotTable, and modify it to show **Date** on rows with the sum of **Flyers** and the sum of **Sales**, like this:

    :::image type="content" source="../media/pivot-date-flyers-sales.png" alt-text="Screenshot of a Pivot Table showing flyers and sales totals by date.":::

2. Copy the date, flyers, and sales values (but **not** the headers or totals) to a new worksheet and add **Date**, **Flyers**, and **Sales** headers like this:

    :::image type="content" source="../media/new-sheet-date-flyers-sales.png" alt-text="Screenshot of a new worksheet showing total flyers and sales by date.":::

3. Select the **Flyers** and **Sales** data and headers (but not the dates). Then on the **Insert** tab, in the **Scatter** drop-down list, select the first scatter-plot format. This creates a scatter-plot chart like this:

    :::image type="content" source="../media/flyers-sales-scatter-plot.png" alt-text="Screenshot of a scatter plot showing total flyers by sales.":::

    > [!Note]
    > The chart shows the number of flyers distributed each day on the horizontal (X) axis, and the number of sales each day on the vertical (Y) axis. The plot forms a roughly diagonal line (with some variance), indicating a general trend where the number of sales tends to increase in-line with the number of flyers distributed.

### View sales by rainfall

1. Return to the worksheet containing the PivotTable, and modify it to show **Date** on rows with the sum of **Rainfall** and the sum of **Sales** as values, like this:

    :::image type="content" source="../media/pivot-date-rainfall-sales.png" alt-text="Screenshot of a Pivot Table showing rainfall and sales totals by date.":::

2. Copy the date, rainfall, and sales values (but **not** the headers or totals) to a new worksheet and add **Date**, **Rainfall**, and **Sales** headers like this:

    :::image type="content" source="../media/new-sheet-date-rainfall-sales.png" alt-text="Screenshot of a new worksheet showing total rainfall and sales by date.":::
 
3. Select the **Rainfall** and **Sales** data and headers (but **not** the dates). Then on the **Insert** tab, in the **Scatter** drop-down list, select the first scatter-plot format. This creates a scatter-plot chart like this:

    :::image type="content" source="../media/rainfall-sales-scatter-plot.png" alt-text="Screenshot of a scatter plot showing total rainfall by sales.":::
 
    This plot seems to indicate some kind of relationship between rainfall and sales, with sales falling as rainfall increases. However, the line formed by the plots is curved. This often means there's a non-linear, possibly logarithmic relationship.

4. Delete the chart so you can see the empty **D** and **E** columns after the daily rainfall and sales data.
5. In **D1**, add the column header **LogRainfall**, and then select cell **D2** and enter the following formula in the ***fx*** box above the worksheet to calculate the base 10 log of the rainfall value:

    ```
    =log(B2)
    ```

6. Copy the formula to the other cells in the **LogRainfall** column. The easiest way to do this is to select the cell containing the formula and double-click on the small square "handle" (**&#9642;**) at the bottom right of the selected cell.
7. In **E1**, add the column header **LogSales**, and then select cell **E2** and enter the following formula in the ***fx*** box above the worksheet to calculate the base 10 log of the sales value:

    ```
    =log(C2)
    ```

8. Copy the formula to the other cells in the **LogSales** column. 
9. Select the **LogRainfall** and **LogSales** data and headers. Then on the **Insert** tab, in the **Scatter** drop-down list, select the first scatter-plot format. This creates a scatter-plot chart like this:

    :::image type="content" source="../media/log-rainfall-sales-scatter-plot.png" alt-text="Screenshot of a scatter plot showing log rainfall by log sales.":::
 
    Note that this plot shows a linear relationship between the log of rainfall and the log of sales. This is potentially useful as we explore relationships in the data, as it's easier to calculate a linear equation that relates rainfall to sales than to define a logarithmic equation to do the same.

### Challenge: Visualizing data

1. Create a column chart showing the sum of flyers distributed on each day of the week, and note the days on which the highest and lowest number of flyers were distributed.
2. Create a scatter plot showing daily temperature and rainfall and examine the apparent relationship between these fields.
