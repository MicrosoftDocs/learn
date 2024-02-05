The count operator with its variations creates a new column with the calculated result for the specified fields.

The first statement below returns one column that is a unique list of Activity column values.

The second statement returns a count of SecurityEvent rows where EventID equals 4688, and the count is grouped by Process and Computer.  Because of the by clause, the result set contains three columns: Process, Computer, Count.

Run each Query separately to see the results.

```kusto
SecurityEvent | summarize by Activity

SecurityEvent
| where EventID == "4688"
| summarize count() by Process, Computer

```

The example below is a partial list of the most common simple aggregate functions used with the summarize operator.

| Function(s)| Description|
| :--- | :--- |
| count(), countif()| Returns a count of the records per summarization group|
| dcount(), dcountif()| Returns an estimate for the number of distinct values taken by a scalar expression in the summary group.|
| avg(), avgif()| Calculates the average of Expr across the group.|
| max(), maxif()| Returns the maximum value across the group.|
| min(), minif()| Returns the minimum value across the group.|
| percentile()| Returns an estimate for the specified nearest-rank percentile of the population defined by *Expr*. The accuracy depends on the density of population in the region of the percentile.|
| stdev(), stdevif()| Calculates the standard deviation of Expr across the group, considering the group as a sample.|
| sum(), sumif()| Calculates the sum of Expr across the group.|
| variance(), varianceif()| Calculates the variance of Expr across the group, considering the group as a sample.|

## count function example

An aggregate function column can be explicitly named by including the "fieldname=" before the aggregate function.

The KQL statement returns three columns: "cnt", "AccountType", and "Computer".  The "cnt" field name replaces the default "count_" name.

```kusto
SecurityEvent
| where TimeGenerated > ago(1h)
| where EventID == 4624
| summarize cnt=count() by AccountType, Computer

```

## \<dcount\> function example

The following example returns a count of unique IP Addresses.

```kusto
SecurityEvent
| summarize dcount(IpAddress)

```

## Let's take a look at a real-world example

The following statement is a rule to detect Invalid Password failures across multiple applications for the same account.

The where operator for ResultDescription filters the result set for results including "Invalid password".  Next, the statement "summarize" produces a distinct count of application names and group by User and IP Address.  Finally, there's a check against a variable created (threshold) to see if the number exceeds the allowed amount.

```kusto
let timeframe = 30d;
let threshold = 1;
SigninLogs
| where TimeGenerated >= ago(timeframe)
| where ResultDescription has "Invalid password"
| summarize applicationCount = dcount(AppDisplayName) by UserPrincipalName, IPAddress
| where applicationCount >= threshold

```
