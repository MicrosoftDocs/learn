The arg_max() and arg_min() functions filter out top and bottom rows respectively.

## arg_max function

The following statement returns the most current row from the SecurityEvent table for the computer SQL10.NA.contosohotels.com.  The * in the arg_max function requests all columns for the row.

```kusto
SecurityEvent 
| where Computer == "SQL10.na.contosohotels.com"
| summarize arg_max(TimeGenerated,*) by Computer

```

## arg_min function

In this statement, the oldest SecurityEvent for the computer SQL10.NA.contosohotels.com is returned as the result set.

```kusto
SecurityEvent 
| where Computer == "SQL10.na.contosohotels.com"
| summarize arg_min(TimeGenerated,*) by Computer

```

## Revisiting the result pipe

The order results pass through the pipe character matters. Review the following two KQL statements. What is the difference between the result sets?

Run each Query separately to see the results.

```kusto
// Statement 1

SecurityEvent
| summarize arg_max(TimeGenerated, *) by Account
| where EventID == "4624"

// Statement 2

SecurityEvent
| where EventID == "4624"
| summarize arg_max(TimeGenerated, *) by Account

```

Statement 1 has Accounts for which the last activity was a Logon.

The SecurityEvent table is summarized and returns the most current row for each Account. Then only rows with EventID equal to 4624 (Login) are returned.

Statement 2 has the most recent Logon for Accounts that have logged in.

The SecurityEvent table is filtered to only include EventID = 4624. Then these results are summarized for the most current Logon row by Account.

