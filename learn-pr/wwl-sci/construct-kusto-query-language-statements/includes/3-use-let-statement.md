Let statements bind names to expressions. For the rest of the scope, where the let statement appears, the name refers to its bound value.  Let statements improve modularity and reuse since they allow you to break a potentially complex expression into multiple parts. Each part is bound to a name through the let statement, and together they compose the whole. The let statement allows for the creation of user-defined functions and views. The views are expressions whose results look like a new table.

## Declare and reuse variables

The let statement allows for the creating variables to be used in later statements.  In this example, timeOffSet and discardEventId are created and used as part of the SecurityEvent "where" clause.

```kusto
let timeOffset = 7d;
let discardEventId = 4688;

SecurityEvent
| where TimeGenerated > ago(timeOffset*2) and TimeGenerated < ago(timeOffset)
| where EventID != discardEventId

```

> [!TIP]
> "ago()" is a function that will take the current Date and Time and subtract the value provided.

## Declare dynamic tables or lists

The let statement allows for the creation of dynamics tables or lists.

```kusto
let suspiciousAccounts = datatable(account: string) [
    @"\administrator", 
    @"NT AUTHORITY\SYSTEM"
];

SecurityEvent | where Account in (suspiciousAccounts)
```
```kusto
let LowActivityAccounts =
    SecurityEvent 
    | summarize cnt = count() by Account 
    | where cnt < 10;

LowActivityAccounts | where Account contains "Mal"

```

