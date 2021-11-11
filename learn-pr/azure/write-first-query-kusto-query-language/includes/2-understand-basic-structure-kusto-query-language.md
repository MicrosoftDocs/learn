Organizations in all sectors deal with a constant flow of data and need to turn this data into meaningful, actionable insights. In the meteorological scenario, you've obtained a dataset with storm data from the US. In this unit, you'll learn about the basic structure of the Kusto Query Language (KQL) so that you can use it to analyze and interpret this dataset.

## What is a Kusto query?

A Kusto query is a read-only request to process data and return results. The request is stated in plain text that is easy to read, author, and automate. A Kusto query has one or more query statements and returns data in a tabular or graph format.

## What is a query statement?

The most common kind of query statement is a tabular expression **statement**, which means both its input and output consist of tables or tabular datasets. Tabular statements contain zero or more **operators**, each of which starts with a tabular input and returns a tabular output. Operators are sequenced by a | (pipe). Data flows, or is piped, from one operator to the next. The data is filtered or manipulated at each step and then fed into the following step. It's like a funnel, where you start out with an entire data table. Each time the data passes through another operator, it is filtered, rearranged, or summarized. Because the piping of information from one operator to another is sequential, the query operator order is important. At the end of the funnel, you're left with a refined output.

These operators are KQL-specific, although often have parallels to SQL or other languages.

Let's look at an example query.

```kusto
StormEvents 
| where StartTime between (datetime(2007-11-01) .. datetime(2007-12-01))
| where State == "FLORIDA"  
| count 
```

This query has a single tabular expression statement. The statement begins with a reference to a table called *StormEvents* and contains several operators, `where` and `count`, each separated by a pipe. The data rows for the source table are filtered by the value of the *StartTime* column and then filtered by the value of the *State* column. In the last line, the query returns a table containing the count of the remaining rows.

In the next units, we'll connect to a dataset, learn about some of the most commonly used operators, and then use the operators to answer questions about a sample dataset containing US meteorological data.