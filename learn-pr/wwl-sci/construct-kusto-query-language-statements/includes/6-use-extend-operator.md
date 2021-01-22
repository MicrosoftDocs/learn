Create calculated columns and append the new columns to the result set.

In the example below, the result set will contain a new column named severityOrder.

```kusto
SecurityAlert

| where TimeGenerated > ago(7d)

| extend severityOrder = case (

    AlertSeverity == "High", 3,

    AlertSeverity == "Medium", 2, 

    AlertSeverity == "Low", 1,

    AlertSeverity == "Informational", 0,

    -1)

```

## Let's take a look at a real-world example

The following is an Azure Sentinel detection rule.  The essential concepts to review are;

First, the use of **let** to define the timeframe variable enables maintenance and readability.

Second, the **dynamic** list creation is stored in the let variable DomainList.

Third, the use of **extend** to create two new columns HTTP_Status_Code and Domain.

Fourth, the results sets' progression via the pipe statement allows us to use the newly created columns as filters.

```kusto
let timeframe = 1d;

let DomainList = dynamic(["tor2web.org", "tor2web.com"]);

Syslog

| where TimeGenerated >= ago(timeframe)

| where ProcessName contains "squid"

| extend 

  HTTP_Status_Code = extract("(TCP_(([A-Z]+)…-9]{3}))",8,SyslogMessage),    

  Domain = extract("(([A-Z]+ [a-z]{4…Z]+ )([^ :\\/]*))",3,SyslogMessage)

| where HTTP_Status_Code == "200"

| where Domain contains "."

| where Domain has_any (DomainList)

```

