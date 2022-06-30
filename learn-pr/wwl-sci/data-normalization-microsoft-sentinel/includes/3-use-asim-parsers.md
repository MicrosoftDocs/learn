In Microsoft Sentinel, parsing and normalizing happen at query time. Parsers are built as KQL user-defined functions that transform data in existing tables, such as CommonSecurityLog, custom logs tables, or Syslog, into the normalized schema.

Users use Advanced Security Information Model (ASIM) parsers instead of table names in their queries to view data in a normalized format, and to include all data relevant to the schema in your query.

## Built-in ASIM parsers and workspace-deployed parsers
Many ASIM parsers are built in and available out-of-the-box in every Microsoft Sentinel workspace. ASIM also supports deploying parsers to specific workspaces from GitHub, using an ARM template or manually. Both out-of-the-box and workspace-deployed parsers are functionally equivalent, but have slightly different naming conventions, allowing both parser sets to coexist in the same Microsoft Sentinel workspace.

Each method has advantages over the other:

| Compare | Built-in| Workspace-deployed |
| :--- | :--- | :--- |
| Advantages| Exist in every Microsoft Sentinel instance. Usable with other built-in content.| New parsers are often delivered first as workspace-deployed parsers.|
| Disadvantages| Can't be directly modified by users. Fewer parsers available.| Not used by built-in content.|
| When to use| Use in most cases that you need ASIM parsers.| Use when deploying new parsers, or for parsers not yet available out-of-the-box.|

It's recommended to use built-in parsers for schemas for which built-in parsers are available.

## Parser hierarchy
ASIM includes two levels of parsers: unifying parser and source-specific parsers. The user usually uses the unifying parser for the relevant schema, ensuring all data relevant to the schema is queried. The unifying parser in turn calls source-specific parsers to perform the actual parsing and normalization, which is specific for each source.

The unifying parser name is **_Im_Schema** for built-in parsers, and **imSchema** for workspace deployed parsers. Where **Schema** stands for the specific schema it serves. Source-specific parsers can also be used independently. For example, in an Infoblox-specific workbook, use the **vimDnsInfobloxNIOS** source-specific parser. 


## Unifying parsers
When using ASIM in your queries, use unifying parsers to combine all sources, normalized to the same schema, and query them using normalized fields. 

For example, the following query uses the built-in unifying DNS parser to query DNS events using the ResponseCodeName, SrcIpAddr, and TimeGenerated normalized fields:

```KQL
_Im_Dns(starttime=ago(1d), responsecodename='NXDOMAIN')
| summarize count() by SrcIpAddr, bin(TimeGenerated,15m)
```

The example uses filtering parameters, which improve ASIM performance. The same example without filtering parameters would look like this:

```KQL
_Im_Dns
| where TimeGenerated > ago(1d)
| where ResponseCodeName =~ "NXDOMAIN"
| summarize count() by SrcIpAddr, bin(TimeGenerated,15m)
```

The following table lists available unifying parsers:
| Schema | Unifying parser|
| :--- | :--- |
| Authentication | imAuthentication|
| Dns| _Im_Dns|
| File Event| imFileEvent|
| Network Session |_Im_NetworkSession |
| Process Event| imProcessCreate and imProcessTerminate|
| Registry Event | imRegistry|
| Web Session | _Im_WebSession|


## Optimizing parsing using parameters
Using parsers may impact your query performance, primarily from filtering the results after parsing. For this reason, many parsers have optional filtering parameters, which enable you to filter before parsing and enhance query performance. With query optimization and pre-filtering efforts, ASIM parsers often provide better performance when compared to not using normalization at all.

When invoking the parser, always use available filtering parameters by adding one or more named parameters to ensure optimal performance of the ASIM parsers.

Each schema has a standard set of filtering parameters documented in the relevant schema documentation. Filtering parameters are entirely optional. The following schemas support filtering parameters:

- Authentication
- DNS
- Network Session
- Web Session

Every schema that supports filtering parameters supports at least the starttime and enttime parameters and using them is often critical for optimizing performance.
