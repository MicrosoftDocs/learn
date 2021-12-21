Organizations in all sectors deal with a constant flow of data and need to turn this data into meaningful, actionable insights. In the meteorological scenario, you've obtained a dataset with storm data from the US. In this module, you'll learn about the how to aggregate data using the Kusto Query Language (KQL) so that you can gain meaningful insights from this dataset. For example, you'll use aggregate functions to gain insights in your data by comparing different groups of information. You'll explore ways to visualize this data in graphical format. To organize complex queries, you'll take advantage of let statements.

## What is an aggregate function?

The data in the storm events scenario is presented on an event level, meaning that each row represents a specific event and its associated information. It's easier to compare these events if you group them by certain fields, such as location, time, or event type.

An aggregation function groups values of multiple rows to form a single summary value.

ADD IMAGE

## Data visualization



## What is a let statement?

The `let` statement sets a variable name equal to an expression or a function, or to create views.

Let statements are useful for:

Breaking up a complex expression into multiple parts, each represented by a variable.
Defining constants outside of the query body for readability.
Defining a variable once and using it multiple times within a query.


In the next units, we'll learn about some of the most common aggregation functions, and then build complex queries using the let statement to gain insights into a sample dataset containing US meteorological data.