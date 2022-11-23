The arg_max() and arg_min() functions filter out top and bottom rows respectively.

## arg_max function

The following statement will return the most current row from the SecurityEvent table for the computer SQL12.NA.contosohotels.com.  The * in the arg_max function requests all columns for the row.

```kusto
SecurityEvent 
| where Computer == "SQL12.na.contosohotels.com"
| summarize arg_max(TimeGenerated,*) by Computer

```

## arg_min function

In this statement, the oldest SecurityEvent for the computer SQL12.NA.contosohotels.com will be returned as the result set.

```kusto
SecurityEvent 
| where Computer == "SQL12.na.contosohotels.com"
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

Statement 1 will have Accounts for which the last activity was a Logon.

The SecurityEvent table will first be summarized and return the most current row for each Account.  Then only rows with EventID equal to 4624 (Login) will be returned.

Statement 2 will have the most recent Logon for Accounts that have logged in.

The SecurityEvent table will be filtered to only include EventID = 4624. Then these results will be summarized for the most current Logon row by Account.

