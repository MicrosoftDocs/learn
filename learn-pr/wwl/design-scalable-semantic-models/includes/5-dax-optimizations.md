DAX provides a powerful set of functions that allow you to create basic to complex calculations to measure the data in your semantic model in Power BI. By using filtering conditions, variables, and iterator, window, and information functions, you can create efficient and readable formulas.

### Variables

Variables in DAX help you simplify your expressions and improve performance by storing the result of an expression and reusing it multiple times. This reduces the need for repeated calculations and makes your code easier to read and maintain.

Consider the scenario where you need to calculate the average sales amount per customer. You can use a variable to store the total sales amount and then use it in the calculation:

```DAX
Average Sales per Customer = 
VAR Total Sales = SUM(Sales[Amount])
RETURN
    Total Sales / COUNTROWS(Sales)
```

While this example is still readable without the variable, complex formulas can use multiple variables and increase readability in your code significantly.

## Iterators

Iterator functions in DAX, such as SUMX, AVERAGEX, and MAXX, perform row-by-row calculations over a table and return a single value. These functions are useful for performing calculations that depend on the context of each row.

For example, to calculate the total profit for each product, you can use the SUMX function:

```DAX
Total Profit = 
SUMX(
    Sales,
    Sales[Quantity] * (Sales[Price] - Sales[Cost])
)
```

Be cautious using iterator functions for large amounts of data due to the row-by-row processing, which can affect performance.

## Table Filtering

Table filtering functions, such as FILTER, ALL, and CALCULATETABLE, allow you to create filtered tables based on specific conditions. These functions are useful for creating dynamic calculations that depend on the filtered context.

For example, to calculate the total sales for a specific product category, you can use the CALCULATETABLE function:

```DAX
Total Sales for Category = 
CALCULATETABLE(
    SUMMARIZE(
        Sales,
        Sales[Amount]
    ),
    FILTER(
        Products,
        Products[Category] = "Electronics"
    )
)
```

The CALCULATETABLE function modifies the filter context to include only the rows where the product category is “Electronics.” The SUMMARIZE function then lists the sales amounts within this filtered context. As a result, when using this measure in a visual showing total sales by category, each row will only show the total sales for “Electronics,” regardless of the actual category in the visual.

These table filtering functions help you create dynamic and context-sensitive calculations, enabling more precise and insightful data analysis.

## Windowing Functions

Windowing functions in DAX, such as INDEX, OFFSET, and WINDOW, allow you to perform calculations over a specified window of data. These functions are useful for creating rankings, running totals, and other calculations that depend on the order of data.

For example, to compare the sales of the current product with the previous product, you can use the OFFSET function:

```dax
Previous Product Sales = 
CALCULATE(
    SUM(Sales[Amount]),
    OFFSET(-1, ORDERBY(Sales[Date], ASC))
)
```

In this example, the OFFSET function is used to shift the context to the previous row based on the order of the Sales[Date] column. This allows you to compare the sales amount of the current product with the previous one, which can be useful for trend analysis and other comparative calculations.

## Information Functions

Information functions, such as ISBLANK, ISNUMBER, and CONTAINS, allow you to perform checks and return information about the data. These functions are useful for creating conditional calculations and handling special cases.

For example, you can use the HASONEVALUE function to check if a column has a single distinct value. This is useful in scenarios where you want to perform calculations only when a single value is selected in a filter context.

Consider the scenario where you want to calculate the total sales amount only if a single product category is selected:

```DAX
Total Sales for Single Category = 
IF(
    HASONEVALUE(Products[Category]),
    SUM(Sales[Amount]),
    BLANK()
)
```

The HASONEVALUE function checks if there is only one distinct value in the Products[Category] column. If a single category is selected, the formula calculates the total sales amount, and if more than one category is selected, the formula returns BLANK().

By using DAX variables and functions, you can create more efficient, readable, and powerful calculations that enhance your semantic model in Power BI.

> [!TIP]
> Be sure to favorite the [Data Analysis Expressions (DAX) reference](/dax/) for full details about syntax, different functions, statements, and more.
