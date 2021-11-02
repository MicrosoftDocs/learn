Kusto queries can be used to filter data and return specific information.
Recall that in the storm events example, we've narrowed down events by time range, keywords, and values in a particular column. We've sorted results and projected specific columns.

Now it's your turn to try writing a query from scratch.

Use the table we've been exploring up until now, *StormEvents* to answer the following question:

In the month of April 2007, what were the top five damage-causing storms in the state of Virginia? In this case, damage refers to both property and crop damage.

>[!TIP]
> Use the operators `where`, `project`, and `sort`.
