The count operator with its variations will create a new column with the calculated result for the specified fields.

The first statement below will return one column that is a unique list of Activity column values.

The second statement will return a count of SecurityEvent rows where EventID equals 4688, and the count is grouped by Process and Computer.  Because of the by clause, the result set will contain three columns: Process, Computer, Count.

Run each Query separately to see the results.

```kusto
SecurityEvent | summarize by Activity

SecurityEvent
| where EventID == "4688"
| summarize count() by Process, Computer

```

The following is a partial list of the most common simple aggregate functions used with the summarize operator.

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

The KQL statement will return three columns: <cnt>, <AccountType>, and <Computer>.  The <cnt> field name will replace the default "count_" name.

```kusto
SecurityEvent
| where TimeGenerated > ago(1h)
| where EventID == 4624
| summarize cnt=count() by AccountType, Computer

```

## <dcount> function example

The following example will return a count of unique IP Addresses.

```kusto
SecurityEvent
| summarize dcount(IpAddress)

```

## Let's take a look at a real-world example

The following statement is an Azure Sentinel Analytical rule to detect a password spray attempt.

The first three where operators will filter the result set to failed logins to disabled accounts.  Next, the statement "summarize" a distinct count of application name and group by User and IP Address.  Finally, there is a check against a variable created (threshold) to see if the number exceeds the allowed amount.

```kusto
let timeframe = 1d;

let threshold = 3;

SigninLogs
| where TimeGenerated >= ago(timeframe)
| where ResultType == "50057"
| where ResultDescription =~ "User account is disabled. The account has been disabled by an administrator."
| summarize applicationCount = dcount(AppDisplayName) by UserPrincipalName, IPAddress
| where applicationCount >= threshold

```

