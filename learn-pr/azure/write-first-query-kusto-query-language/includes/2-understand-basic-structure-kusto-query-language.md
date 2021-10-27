<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format)
-->

Organizations in all sectors deal with a constant flow of data, and need to be able to turn this data into meaningful, actionable insights. From our meterological example, you've obtained a dataset with storm data from the US. In this unit, you'll learn about the basic structure Kusto Query Language (KQL) so that you can use KQL to analyze and interpret this data set.

## What is a Kusto query?

A Kusto query is a read-only request to process data and return results. The request is stated in plain text that is easy to read, author, and automate. A Kusto query begins with a reference to a data table, has one or more query statements, and returns data in a tabular or graph format.

## What is a query statement?

The most common kind of query statement is a tabular expression statement, which means both its input and output consist of tables or tabular data sets. Tabular statements contain one more operator, each of which starts with a tabular input, and returns a tabular output. Operators are sequenced by a | (pipe). Data flows (is piped) from one operator to the next, is filtered or manipulated at each step, and then fed into the following step. It's like a funnel, where you start out with an entire data table. Each time you pass through another operator, the data is filtered, rearranged, or summarized. At the end of the funnel, you're left with a refined output.

These operators are KQL-specific, although often have parallels to SQL or other languages.

Let's look at an example query.

```kusto
StormEvents 
| where StartTime >= datetime(2007-11-01) and StartTime < datetime(2007-12-01)
| where State == "FLORIDA"  
| count 
```

For example, this query has a single tabular expression statement. The statement begins with a reference to a table called *StormEvents* (the database that hosts this table is implicit, and part of the connection information) and contains several operators, each separated by a pipe. The data (rows) for the source table is filtered by the value of the StartTime column, and afterwards filtered by the value of the State column. The query then returns the count of "surviving" rows.

In the next units, we'll learn about some of the most commonly used operators, and how to use them to answer questions about a sample dataset containing US meterological data.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->