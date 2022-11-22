Parsers are functions that define a virtual table with already parsed unstructured strings fields such as Syslog data.

In the Logs window, you create a query, select the Save button, enter the Name, and select Save As Function from the drop-down. In this case, if we name the function "PrivLogins", I can then access the table using the name PrivLogins.

```kusto
SecurityEvent
| where EventID == 4672 and AccountType == 'User'

```

```kusto
PrivLogins

```
