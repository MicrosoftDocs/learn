Organizations in all sectors deal with a constant flow of data and need to turn this data into meaningful, actionable insights. In the meteorological scenario, you've obtained a dataset with storm data from the US. In this module, you'll learn about the how to aggregate data using the Kusto Query Language (KQL) so that you can gain meaningful insights from this dataset. 

You'll use aggregate functions to compare different groups of information. You'll explore ways to visualize this data in graphical format. To further organize complex queries, you'll learn how to use let statements.

## What is an aggregate function?

The data in the storm events scenario is presented on an event level, meaning that each row represents a specific event and its associated information. If you group these individual events by common fields, such as location, time, or event type, you can then make meaningful comparisons across groups.

An aggregate function allows you to make these comparisons by grouping values of multiple rows to form a single summary value. The type of summary value depends on the specific function you use, and could be an average, maximum, minimum, or median value, just to name a few.

ADD SCHEMATIC IMAGE

## Visualize your data

An essential part of data analysis is communicating the results. Graphical representations can often be a powerful way to communicate and understand data analysis. We'll explore some of the ways to convert Kusto query results to graphical visualizations using the `render` operator.

For example, the following query returns the total damage caused by each type of storm. The results are then represented as a pie chart. This visualization allows you to quickly compare and find the most and least damaging types of storms.

:::image type="content" source="../media/5-pie-chart.png" alt-text="Screenshot of sample query with pie chart result." lightbox="../media/5-pie-chart.png":::

## What is a `let` statement?

The `let` statement sets a variable name equal to an expression or a function, or to create views.

`let` statements are useful for breaking up a complex expression into multiple parts, defining constants outside of the query body for readability, or defining a variable once and using it multiple times within a query. We'll use `let` statements to practice creating well-organized complex queries.

In the next units, we'll learn about some of the most common aggregate functions, visualize their results using the `render` operator, and then build complex queries using the `let` statement. These KQL skills will help you gain insights into a sample dataset containing US meteorological data.