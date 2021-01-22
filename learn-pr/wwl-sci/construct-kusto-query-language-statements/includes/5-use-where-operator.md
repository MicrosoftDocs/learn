The where operator filters a table to the subset of rows that satisfy a predicate.

Try each of these queries separately to see the results.

```kusto
SecurityEvent

| where TimeGenerated > ago(1d)

SecurityEvent

| where TimeGenerated > ago(1h) and EventID == "4624"

SecurityEvent

| where TimeGenerated > ago(1h)

| where EventID == 4624

| where AccountType =~ "user"

SecurityEvent | where EventID in (4624, 4625)

```

