Parsers are functions that define a virtual table with already parsed unstructured strings fields such as Syslog data.

In the Logs window, you create a query, select the Save button, enter the Name, and select Save As Function from the drop-down. In this case, if we name the function "PrivLogins," I can then access the table using the name PrivLogins.

```kusto
SecurityEvent
| where EventID == 4672 and AccountType == 'User'

```

```kusto
PrivLogins

```

## ASIM parsers

Microsoft Sentinel extends this concept with **Advanced Security Information Model (ASIM) parsers** — pre-built functions that normalize data from different log sources into a common schema. ASIM parsers follow the same saved-function mechanism described in this unit but are deployed at the workspace level and maintained by Microsoft.

To learn how to use and create ASIM parsers, see [Normalize and analyze data with ASIM in Microsoft Sentinel](/training/modules/data-normalization-microsoft-sentinel/).
