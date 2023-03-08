OK, now it's your chance to get hands on with data. In this lab, you'll use Microsoft Excel Online to explore a simple dataset.

## Before you start

If you don't already have a Microsoft account (for example a `hotmail.com`, `live.com`. or `outlook.com` account), sign up for one at [https://signup.live.com](https://signup.live.com).

## Lab overview

Rosie Reeves is an entrepreneurial middle-school student who sells homemade lemonade from a stand at the park near her house. To promote her lemonade stand, she distributes leaflets in the park. Rosie records details of her sales and flyer (leaflet) distribution, along with weather measurements including the temperature and rainfall each day.

In this lab, you'll explore and visualize the data Rosie recorded.

## Exercise 1: View a table of data in Excel

In this exercise, you'll upload the Excel workbook containing Rosie's data to the OneDrive cloud storage account associated with your Microsoft account, and then explore the data in Microsoft Excel Online.

### Upload the workbook to OneDrive

1. In your web browser, navigate to [https://onedrive.live.com](https://onedrive.live.com), and sign in using your Microsoft account credentials. You should see the files and folders in your OneDrive, like this:

    :::image type="content" source="../media/one-drive.png" alt-text="Screenshot showing One Drive My Files folder." lightbox="../media/one-drive.png":::

2. On the **&#65291; New** menu, select **Folder** to create a new folder. You can name this anything you like, for example **DataFund**. When your new folder appears, select it to open it.
3. In your new empty folder, on the **&#10514; Upload** menu, select **Files**. Then when prompted, in the **File name** box, enter the following address (you can copy and paste it from here!):

    ```
    https://github.com/MicrosoftLearning/mslearn-data-concepts/raw/main/labfiles/Lemonade.xlsx
    ```

    Then select **Open** to upload the Excel file containing Rosie's lemonade data, as shown here:

    :::image type="content" source="../media/upload-files.png" alt-text="Screenshot showing the file uploads dialog box." lightbox="../media/upload-files.png":::

    After a few seconds, the **Lemonade.xlsx** file should appear in your folder like this:

    :::image type="content" source="../media/lemonade-xlsx.png" alt-text="Screenshot of Lemonade x l s x file in One Drive." lightbox="../media/lemonade-xlsx.png":::

### Open the workbook in Excel Online

1. Select the **Lemonade.xlsx** file in your OneDrive folder to open it in Excel Online. When opened, it should look like this:

    :::image type="content" source="../media/lemonade-workbook.png" alt-text="Screenshot of Lemonade workbook in Excel." lightbox="../media/lemonade-workbook.png":::

2. The dates in column **A** may be too wide to be displayed, so the cells may contain ***#######*** as shown previously. To see the dates, double-click the line between the **A** and **B** column headers. The dates will then be shown in the format for the locale associated with your Microsoft account. For example, in the following image, the dates are shown in UK format (*dd/MM/yyyy*).

    :::image type="content" source="../media/widened-column.png" alt-text="Screenshot of Column A widened to show dates." lightbox="../media/widened-column.png":::

## Filter and sort the data

1. Select cell **A1**, and then on the **Insert** tab of the ribbon above the worksheet, select **Table**. Verify that Excel has automatically detected the data in the range **A1:G366**, and that the **My table has headers** checkbox is selected, and then select **OK**; as shown here:

    :::image type="content" source="../media/create-table.png" alt-text="Screenshot of creating a table in Excel." lightbox="../media/create-table.png":::

    Excel automatically formats the data as a table and adds drop-down buttons to the header row as shown here:

    :::image type="content" source="../media/excel-table.png" alt-text="Screenshot showing a table with data in Excel." lightbox="../media/excel-table.png":::

2. Select any cell to deselect the table, and then select the drop-down button for the **Day** column, clear the **(Select All)** checkbox, and then select only the **Saturday** and **Sunday** checkboxes as shown here before selecting **Apply**:

    :::image type="content" source="../media/filter-sat-sun.png" alt-text="Screenshot of a filter with only Saturday and Sunday selected." lightbox="../media/filter-sat-sun.png":::

    The table of data is filtered to show only the records for weekend days (Saturday and Sunday).

4. Select the drop-down arrow for the **Rainfall** column and select **Sort Largest to Smallest**. The table of data is sorted in descending order of rainfall, so the first row contains the data for the weekend day with the most rain. This was a Sunday on which there was 2.50 cm of rain as shown here:

    :::image type="content" source="../media/sorted-rainfall.png" alt-text="Screenshot of data sorted in descending order of rainfall." lightbox="../media/sorted-rainfall.png":::

5. Select the drop-down arrow for the **Day** column again and then select **Clear Filter from 'Day'**. The table now shows all the data.
6. Select the drop-down arrow for **Date** and select **Sort Oldest to Newest** to reorder the data into chronological order.

### Challenge: Find the weekday with the lowest temperature

1. Use the filter and sort capabilities in Excel Online to filter the data so that only weekdays (Monday to Friday) are shown, then sort the data so that the first row contains data for the weekday with the lowest temperature.
2. Make a note of the day and the temperature, and then clear the filter and resort the data back into chronological order.

## Exercise 2: Using formulas to explore data in Excel

In this exercise, you'll use formulas to create derived columns that extend the data recorded by Rosie.

### Add derived columns

1. On the **Home** tab, at the right side of the menu area, use the *Switch Ribbons* (**v**) button to expand the ribbon and show the full **Classic Ribbon** toolbar:

    :::image type="content" source="../media/ribbon.png" alt-text="Screenshot of the Insert Sheet Columns menu option with Switch Ribbon selected." lightbox="../media/ribbon.png":::

2. Select the **B** column header to select the entire **B** column. Then on the **Home** tab of the ribbon, in the **Cells** section, in the **Insert** drop-down menu, select **Insert Sheet Columns** (depending on the size of your browser window, you may need to expand a **Cells** menu to see the **Insert** menu.

    :::image type="content" source="../media/insert-sheet-columns.png" alt-text="Screenshot of the Insert Sheet Columns menu option with Insert selected." lightbox="../media/insert-sheet-columns.png":::

    This inserts a new **Column1** column between the **Date** and **Day** columns as shown here:

    :::image type="content" source="../media/column-1.png" alt-text="Screenshot of new Column 1 added to the worksheet." lightbox="../media/column-1.png":::

3. In cell **B1**, rename **Column1** to **Month**. Then with cell **B2**selected, in the ***fx*** bar above the data, enter the following formula:

    ```
    =TEXT(A2, "mmmm")
    ```

    After you enter the formula, it should be copied automatically to all the other **Month** cells in the table, and the name of the month for each record should be displayed as shown here:

    :::image type="content" source="../media/month-column.png" alt-text="Screenshot of a Month column containing month names." lightbox="../media/month-column.png":::

4. In cell **I1**, enter the text **Revenue** to add a new **Revenue** column to the table. Then with cell **I2** selected, in the ***fx*** bar above the data, enter the following formula:

    ```
    =G2*H2
    ```

    The formula is again automatically copied to the remaining rows in the table, and the **Revenue** (calculated as **Price** multiplied by **Sales**) is displayed as shown here:

    :::image type="content" source="../media/revenue-column.png" alt-text="Screenshot of a Revenue column containing calculated revenue values." lightbox="../media/revenue-column.png":::

5. Select the **I** column header to select the entire column, and then on the **Home** tab of the ribbon, in the **Number** section, in the **\$** drop-down list, select **\$ English (United States)**. This formats the revenue data as US dollars:

    :::image type="content" source="../media/format-revenue.png" alt-text="Screenshot of U S dollar format applied to revenue data." lightbox="../media/format-revenue.png":::

6. Scroll down to the bottom of the table of data, select cell **I367** (under the **Revenue** column). Then on the **Home** tab of the ribbon, in the **Editing** section, in the **AutoSum** (**&Sigma;**) drop-down menu, select **&Sigma; Sum**.

    :::image type="content" source="../media/autosum.png" alt-text="Screenshot showing the Auto Sum menu in Excel." lightbox="../media/autosum.png":::


    This enters the following formula:

    ```
    =SUBTOTAL(109,[Revenue])
    ```

    This formula references **Revenue** as a named column in the table and calculates the total of the values in that column. You could achieve the same result by entering `=SUM(I2:I366)` but by using the AutoSum function, the resulting value is included in the definition of the table (you may need to widen column **I** to see the value):

    :::image type="content" source="../media/revenue-total.png" alt-text=" Screenshot of revenue total in the table." lightbox="../media/revenue-total.png":::

7. Filter the **Month** column to show only the records for **July**, and then look at the subtotal at the bottom of the **Revenue** column (you may need to scroll to find it). It now shows the total revenue for July.

    :::image type="content" source="../media/july-revenue.png" alt-text="Screenshot showing the total revenue for July." lightbox="../media/july-revenue.png":::

8. Clear the filter on **Month** to show all the data, and verify that the revenue total reflects all months again.

### Challenge: Find the total number of flyers distributed

1. Add a cell under the **Flyers** column containing the total number of flyers Rosie distributed. Format this column using the **Comma Style (,)** number format so that the total is formatted like *00,000.00*.
2. Note the total amount for the year, and then filter the data to find the number of flyers distributed in the month of January. Don't forget to clear the filter when you're done!

## Exercise 3: Using conditional formatting to explore data

In this exercise, you'll apply conditional formatting to data to highlight key values of interest.

### Highlight extremes and outliers

1. Select cell **D2** and then hold the **Shift** and **Ctrl** keys and press the **Down-Arrow** key to select all the values in the **Temperature** column (if you're using a Mac OSX computer, hold the **Shift** and **&#8984;** keys, and press the **Down-Arrow** key).
2. On the **Home** tab of the ribbon, in the **Conditional Formatting** drop-down list, point to **Color Scales**, and select the **Red-White-Blue Color Scale** (with red at the top, white in the middle, and blue at the bottom). The **Temperature** cells are reformatted so that the hottest days are colored an intense red, and the coolest days are deep blue. Scrolling through the data now, it's easier to find days that are particularly hot or cool.

    :::image type="content" source="../media/temperature-colors.png" alt-text="Screenshot of color scaled temperatures." lightbox="../media/temperature-colors.png":::

3. Select all the values in the **Rainfall** column, and then in the **Conditional Formatting** drop-down list, point to **Data Bars**, and select the **Light Blue Data Bar** gradient fill. The cells are formatted with a visual indication of the comparative level of rainfall for each day.

    :::image type="content" source="../media/rainfall-data-bars.png" alt-text="Screenshot showing rainfall data bars in Excel." lightbox="../media/rainfall-data-bars.png":::

4. Select all the values in the **Sales** column, and then in the **Conditional Formatting** drop-down list, point to **Top/Bottom Rules**, and select **Top 10%**. Then in the **Top 10%** dialog box, select **Green Fill with Dark Green Text** and select **Done**. The cells containing sales values in the top 10% are highlighted in green (you may need to scroll to see them) and the **Conditional Formatting** pane remains open.

    :::image type="content" source="../media/conditional-top-ten.png" alt-text="Screenshot of conditional formatting highlighting the top 10% sales values." lightbox="../media/conditional-top-ten.png":::

5. Reselect the values in the **Sales** column if you deselected them, and then in the **Conditional Formatting** pane, select **&#65291;** to add a new rule with the following settings:
    - **Apply to range**: H2:H366
    - **If true then stop**: Unselected
    - **Rule type**: Top/Bottom
        - Bottom 10 percent
    - **Format with**: Light Red Fill with Dark Red Text 
    
    :::image type="content" source="../media/conditional-formatting.png" alt-text="Screenshot of the conditional formatting pane." lightbox="../media/conditional-formatting.png":::
    
    Select **Done** to apply the formatting and then close the **Conditional Formatting** pane with the **x** icon at its top right. The cells containing sales values in the bottom 10% are highlighted in red (again, you may need to scroll to see them).

    :::image type="content" source="../media/conditional-bottom-ten.png" alt-text="Screenshot of conditional formatting highlighting the bottom 10% sales values." lightbox="../media/conditional-bottom-ten.png":::

### Challenge: Compare temperature, rainfall, and sales

Now that you've highlighted the cells, you can more easily make visual comparisons between temperature, rainfall, and sales values.

Scroll through the data, and just by looking at the visual formatting you've added, try to see if you can spot any relationship between temperature, rainfall, and sales that might form the basis of a hypothesis you'll want to investigate more thoroughly.