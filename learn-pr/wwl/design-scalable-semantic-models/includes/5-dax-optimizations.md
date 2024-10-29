## Write DAX for readability with complex calculations

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

Be cautious using iterator functions for large amounts of data due to the row by row processing, which can affect performance.

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

## Windowing Functions

Windowing functions, such as RANKX, TOPN, and EARLIER, allow you to perform calculations over a specified window of data. These functions are useful for creating rankings, running totals, and other calculations that depend on the order of data.

For example, to rank products based on their total sales, you can use the RANKX function:

```dax
Product Rank by Sales = 
RANKX(
    ALL(Products),
    SUM(Sales[Amount]),
    ,
    DESC
)
```

## Information Functions

Information functions, such as ISBLANK, ISNUMBER, and CONTAINS, allow you to perform checks and return information about the data. These functions are useful for creating conditional calculations and handling special cases.

For example, you can use the SWITCH function to create a measure that returns:

- "High" if the sales amount is greater than 1,000
- "Medium" if it's between 500 and 1,000
- "Low" otherwise

```dax
Sales Category = 
SWITCH(
    TRUE(),
    [Total Sales] > 1000, "High",
    [Total Sales] > 500, "Medium",
    "Low"
)
```

By using DAX variables and functions, you can create more efficient, readable, and powerful calculations that enhance your semantic model in Power BI.

> [!TIP]
> Be sure to favorite the [Data Analysis Expressions (DAX) reference](/dax/) for full details about syntax, different functions, statements, and more.
