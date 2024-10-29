Static calculations and visuals can present issues for report performance. Introduce flexibility to your semantic model by using calculation groups, dynamic format strings, and field parameters. These features make your reports scalable and user-friendly by simplifying calculations and reducing report visualizations.

## Calculation groups

Calculation groups allow you to define reusable calculations that apply across multiple measures. This reduces redundancy and simplifies the maintenance of your semantic models. Use calculation groups to streamline complex calculations, such as time intelligence functions, across your entire model. The calculations defined in the calculation group are applied against the selected measure in a visual.

Remember our scenario where you need to improve the semantic model to scale for the major sales event. You're asked to include time intelligence calculations including Year-to-Date (YTD), Quarter-to-Date (QTD), and Month-to-Date (MTD) for the sales data. Instead of creating separate measures for each time intelligence function, you decide to use calculation groups to streamline these calculations.

For this example, we created a calculation group called **Time Intelligence** and the following DAX formulas as separate calculation items in the calculation group. Calculation groups are created in the Model view of Power BI Desktop.

```DAX
   Year-to-Date (YTD) = 
   CALCULATE(
       SELECTEDMEASURE(),
       DATESYTD('Date'[Date])
   )
//
   Quarter-to-Date (QTD) = 
   CALCULATE(
       SELECTEDMEASURE(),
       DATESQTD('Date'[Date])
   )
//
   Month-to-Date (MTD) = 
   CALCULATE(
       SELECTEDMEASURE(),
       DATESMTD('Date'[Date])
   )
```

Now you can use the calculation group in the filter pane, a slicer, a visual, and even in reference in a measure. The different calculation items (YTD, QTD, MTD) automatically appear to filter or expand in the visual.

In the following image, we have a matrix with the three fiscal years with the total sales across YTD, QTD, and MTD. There's also a slicer for the calculation group to allow users to toggle between the different choices. The visual is configured as:

- Rows: **Date[Year]** field
- Columns: **Time Calc** calculation group
- Values: **Total Sales** measure

![Screenshot of the matrix visual showing the Total Sales for YTD, QTD, and MTD for each year.](../media/calculation-group-matrix.png)

Now you can create another visual for Profit with the same calculation group and see Profit by MTD, QTD, and YTD. To complete this scenario without calculation groups, you need to measures for Profit, Profit MTD, Profit QTD, Profit YTD, Total Sales, Total Sales MTD, Total Sales QTD, and Total Sales YTD. The dynamic and reusable nature of calculation groups make them incredibly powerful to scale your semantic models.

> [!TIP]
> See the documentation to learn more about how to [Create calculations groups in Power BI](/power-bi/transform-model/calculation-groups).

## Field parameters

Field parameters allow you to create interactive reports by enabling users to select different fields or measures dynamically. This feature is useful for creating customizable reports where users can choose the data they want to see.

In our scenario, we created a new parameter to include the Product, Category, and Color fields. Now we use our Total Sales measure and add the parameter in a visual instead of those individual fields. We also add a slicer with the parameter so users can switch between the selected fields.

![Screenshot of a column chart for Total Sales by Category configured with the parameter in the X-axis and Total Sales in the Y-axis. A slicer is also present to dynamically switch between the Total Sales by Product, Category, and Color.](../media/column-chart-parameter-slicer.png)

Before field parameters, report developers might create a visual for Total Sales by Product and repeat for Category and Color. Users could switch between the different visuals in a similar experience by overlaying the visuals on top of each other and adding bookmarks and buttons. However, the more visuals you add to a report page might affect performance.

> [!TIP]
> See the documentation to learn more about how to [Let report readers use field parameters to change visuals](/power-bi/create-reports/power-bi-field-parameters).

## Dynamic format strings

Dynamic format strings enable you to change the format of a measure based on certain conditions, enhancing the readability and presentation of your data. For instance, you might want to display sales figures in different formats depending on their value. Dynamic format strings can also be used for calculation groups.

A report developer requested the following conditional formatting for the `Total Sales` measure, and you decide dynamic format strings solve this problem.

- Display values in millions (M) if the sales amount is greater than 1,000,000.
- Display values in thousands (K) if the sales amount is greater than 1,000 but less than 1,000,000.
- Display values as is if the sales amount is less than 1,000.

First you need to configure the measure properties to allow a dynamic format string, and then use the following code to define the format:

```DAX
Total Sales with Format = 
SWITCH(
    TRUE(),
    [Total Sales] > 1000000, FORMAT([Total Sales], "$#,##0,,M"),
    [Total Sales] > 1000, FORMAT([Total Sales], "$#,##0,K"),
    FORMAT([Total Sales], "$#,##0")
)
```

> [!TIP]
> See the documentation to learn more about how to [Create dynamic format strings for measures](/power-bi/create-reports/desktop-dynamic-format-strings).
