Advanced Security Information Model (ASIM) users use unifying parsers instead of table names in their queries, to view data in a normalized format and to include all data relevant to the schema in the query. Unifying parsers, in turn, use source-specific parsers to handle the specific details of each source.

Microsoft Sentinel provides built-in, source-specific parsers for many data sources. You may want to modify, or develop, these source-specific parsers in the following situations:

When your device provides events that fit an ASIM schema, but a source-specific parser for your device and the relevant schema isn't available in Microsoft Sentinel.

When ASIM source-specific parsers are available for your device, but your device sends events in a method or a format different than expected by the ASIM parsers. For example:

Your source device may be configured to send events in a non-standard way.

Your device may have a different version than the one supported by the ASIM parser.

The events might be collected, modified, and forwarded by an intermediary system.


## Custom parser development process
The following workflow describes the high level steps in developing a custom ASIM, source-specific parser:

1. Collect sample logs.

1. Identify the schemas or schemas that the events sent from the source represent. 

1. Map the source event fields to the identified schema or schemas.

1. Develop one or more ASIM parsers for your source. You'll need to develop a filtering parser and a parameter-less parser for each schema relevant to the source.

1. Test your parser.

1. Deploy the parsers into your Microsoft Sentinel workspaces.

1. Update the relevant ASIM unifying parser to reference the new custom parser. 

1. You might also want to contribute your parsers to the primary ASIM distribution. Contributed parsers may also be made available in all workspaces as built-in parsers.


### Collect sample logs

To build effective ASIM parsers, you need a representative set of logs, which in most case will require setting up the source system and connecting it to Microsoft Sentinel. If you don't have the source device available, cloud pay-as-you-go services let you deploy many devices for development and testing.

In addition, finding the vendor documentation and samples for the logs can help accelerate development and reduce mistakes by ensuring broad log format coverage.

A representative set of logs should include:

- Events with different event results.
- Events with different response actions.
- Different formats for username, hostname and IDs, and other fields that require value normalization.


### Mapping
Before you develop a parser, map the information available in the source event, or events to the schema you identified:

- Map all mandatory fields and preferably also recommended fields.
- Try to map any information available from the source to normalized fields. If not available as part of the selected schema, consider mapping to fields available in other schemas.
- Map values for fields at the source to the normalized values allowed by ASIM. The original value is stored in a separate field, such as EventOriginalResultDetails.

### Developing parsers
Develop both a filtering and a parameter-less parser for each relevant schema.

A custom parser is a KQL query developed in the Microsoft Sentinel Logs page. The parser query has three parts:

Filter > Parse > Prepare fields


### Filtering the relevant records

In many cases, a table in Microsoft Sentinel includes multiple types of events. For example:

- The Syslog table has data from multiple sources.
- Custom tables may include information from a single source that provides more than one event type and can fit various schemas.

Therefore, a parser should first filter only the records relevant to the target schema.

Filtering in KQL is done using the **where** operator. For example, **Sysmon event 1** reports process creation, and is therefore normalized to the **ProcessEvent** schema. The **Sysmon event 1** event is part of the **Event** table, so you would use the following filter:

```KQL
Event | where Source == "Microsoft-Windows-Sysmon" and EventID == 1
```

> [!IMPORTANT]
> A parser should not filter by time. The query which uses the parser will apply a time range.

### Filtering by source type using a Watchlist
In some cases, the event itself doesn't contain information that would allow filtering for specific source types.

For example, Infoblox DNS events are sent as Syslog messages, and are hard to distinguish from Syslog messages sent from other sources. In such cases, the parser relies on a list of sources that defines the relevant events. This list is maintained in the ASimSourceType watchlist.

To use the ASimSourceType watchlist in your parsers:
- Include the following line at the beginning of your parser:

```KQL
let Sources_by_SourceType=(sourcetype:string){_GetWatchlist('ASimSourceType') | where SearchKey == tostring(sourcetype) | extend Source=column_ifexists('Source','') | where isnotempty(Source)| distinct Source };
```
- Add a filter that uses the watchlist in the parser filtering section. For example, the Infoblox DNS parser includes the following in the filtering section:
```KQL
| where Computer in (Sources_by_SourceType('InfobloxNIOS'))
```

To use this sample in your parser:

- Replace Computer with the name of the field that includes the source information for your source. You can keep this as Computer for any parsers based on Syslog.

- Replace the InfobloxNIOS token with a value of your choice for your parser. Inform parser users that they must update the ASimSourceType watchlist using your selected value, and the list of sources that send events of this type.


### Filtering based on parser parameters

When developing filtering parsers, make sure that your parser accepts the filtering parameters for the relevant schema, as documented in the reference article for that schema. Using an existing parser as a starting point ensures that your parser includes the correct function signature. In most cases, the actual filtering code is also similar for filtering parsers for the same schema.

When filtering, make sure that you:

- **Filter before parsing using physical fields**. If the filtered results aren't accurate enough, repeat the test after parsing to fine-tune your results. For more information, see filtering optimization.
- **Do not filter if the parameter is not defined and still has the default value.**


The following examples show how to implement filtering for a string parameter, where the default value is usually '*', and for a list parameter, where the default value is usually an empty list.

```KQL
srcipaddr=='*' or ClientIP==srcipaddr
array_length(domain_has_any) == 0 or Name has_any (domain_has_any)
```

### Filtering optimization
To ensure the performance of the parser, note the following filtering recommendations:

- **Always filter on built-in rather than parsed fields**. While it's sometimes easier to filter using parsed fields, it dramatically impacts performance.
- **Use operators that provide optimized performance**. In particular, ==, has, and startswith. Using operators such as contains or matches regex also dramatically impacts performance.

Filtering recommendations for performance may not always be easy to follow. For example, using has, is less accurate than contains. In other cases, matching the built-in field, such as SyslogMessage, is less accurate than comparing an extracted field, such as DvcAction. In such cases, we recommend that you still pre-filter using a performance-optimizing operator over a built-in field and repeat the filter using more accurate conditions after parsing.

For an example, see the following Infoblox DNS parser snippet. The parser first checks that the SyslogMessage field has the word client. However, the term might be used in a different place in the message, so after parsing the Log_Type field, the parser checks again that the word client was indeed the field's value.

```KQL
Syslog | where ProcessName == "named" and SyslogMessage has "client"
…
      | extend Log_Type = tostring(Parser[1]),
      | where Log_Type == "client"
```

### Parsing
Once the query selects the relevant records, it may need to parse them. Typically, parsing is needed if multiple event fields are conveyed in a single text field.

The KQL operators that perform parsing are listed below, ordered by their performance optimization. The first provides the most optimized performance, while the last provides the least optimized performance.


| Operator	 | Description| 
| :--- | :--- | 
|split| Parse a string of delimited values.|
| parse_csv| Parse a string of values formatted as a CSV (comma-separated values) line.|
| parse| Parse multiple values from an arbitrary string using a pattern, which can be a simplified pattern with better performance, or a regular expression.|
| extract_all| Parse single values from an arbitrary string using a regular expression. extract_all has a similar performance to parse if the latter uses a regular expression.|
| extract| Extract a single value from an arbitrary string using a regular expression. Using extract provides better performance than parse or extract_all if a single value is needed. However, using multiple activations of extract over the same source string is less efficient than a single parse or extract_all and should be avoided.|
|parse_json	| Parse the values in a string formatted as JSON. If only a few values are needed from the JSON, using parse, extract, or extract_all provides better performance.|
|parse_xml|Parse the values in a string formatted as XML. If only a few values are needed from the XML, using parse, extract, or extract_all provides better performance.|


In addition to parsing string, the parsing phase may require more processing of the original values, including:

- **Formatting and type conversion**. The source field, once extracted, may need to be formatted to fit the target schema field. For example, you may need to convert a string representing date and time to a datetime field. Functions such as todatetime and tohex are helpful in these cases.

- **Value lookup**. The value of the source field, once extracted, may need to be mapped to the set of values specified for the target schema field. For example, some sources report numeric DNS response codes, while the schema mandates the more common text response codes. The functions iff and case can be helpful to map a few values.

    For example, the Microsoft DNS parser assigns the EventResult field based on the Event ID and Response Code using an iff statement, as follows:

    ```KQL
    extend EventResult = iff(EventId==257 and ResponseCode==0 ,'Success','Failure')
    ```

    For several values, use datatable and lookup, as demonstrated in the same DNS parser:

    ```KQL
    let RCodeTable = datatable(ResponseCode:int,ResponseCodeName:string) [ 0, 'NOERROR', 1, 'FORMERR'....];
    ...
     | lookup RCodeTable on ResponseCode
     | extend EventResultDetails = case (
     isnotempty(ResponseCodeName), ResponseCodeName,
     ResponseCode between (3841 .. 4095), 'Reserved for Private Use',
     'Unassigned')
    ```



### Mapping values

In many cases, the original value extracted needs to be normalized. For example, in ASIM a MAC address uses colons as separator, while the source may send a hyphen delimited MAC address. The primary operator for transforming values is extend, alongside a broad set of KQL string, numerical and date functions, as demonstrated in the Parsing section above.

Use case, iff, and lookup statements when there's a need to map a set of values to the values allowed by the target field.

When each source value maps to a target value, define the mapping using the datatable operator and lookup to map. For example

```KQL
let NetworkProtocolLookup = datatable(Proto:real, NetworkProtocol:string)[
        6, 'TCP',
        17, 'UDP'
   ];
    let DnsResponseCodeLookup=datatable(DnsResponseCode:int,DnsResponseCodeName:string)[
      0,'NOERROR',
      1,'FORMERR',
      2,'SERVFAIL',
      3,'NXDOMAIN',
      ...
   ];
   ...
   | lookup DnsResponseCodeLookup on DnsResponseCode
   | lookup NetworkProtocolLookup on Proto

```

Notice that lookup is useful and efficient also when the mapping has only two possible values.

When the mapping conditions are more complex use the **iff** or **case** functions. The **iff** function enables mapping two values:

```KQL
| extend EventResult = 
      iff(EventId==257 and ResponseCode==0,'Success','Failure’)
```
The **case** function supports more than two target values. The example below shows how to combine **lookup** and **case**. The **lookup** example above returns an empty value in the field DnsResponseCodeName if the lookup value isn't found. The **case** example below augments it by using the result of the **lookup** operation if available, and specifying additional conditions otherwise.

```KQL
| extend DnsResponseCodeName = 
      case (
        DnsResponseCodeName != "", DnsResponseCodeName,
        DnsResponseCode between (3841 .. 4095), 'Reserved for Private Use',
        'Unassigned'
      )
```

### Prepare fields in the result set
The parser must prepare the fields in the results set to ensure that the normalized fields are used.

The following KQL operators are used to prepare fields in your results set:


| Operator | Description | When to use in a parser |
| :--- | :--- | :--- |
|project-rename| Renames fields.	| If a field exists in the actual event and only needs to be renamed, use project-rename. The renamed field still behaves like a built-in field, and operations on the field have much better performance.|
| project-away| Removes fields.	|Use project-away for specific fields that you want to remove from the result set. We recommend not removing the original fields that aren't normalized from the result set, unless they create confusion or are very large and may have performance implications.|
|project	|Selects fields that existed before, or were created as part of the statement, and removes all other fields.| Not recommended for use in a parser, as the parser shouldn't remove any other fields that aren't normalized. If you need to remove specific fields, such as temporary values used during parsing, use project-away to remove them from the results.|
| extend	|Add aliases.|Aside from its role in generating calculated fields, the extend operator is also used to create aliases.|


### Handle parsing variants
In many cases, events in an event stream include variants that require different parsing logic. To parse different variants in a single parser either use conditional statements such as iff and case, or use a union structure.

To use union to handle multiple variants, create a separate function for each variant, and use the union statement to combine the results:

```KQL
let AzureFirewallNetworkRuleLogs = AzureDiagnostics
    | where Category == "AzureFirewallNetworkRule"
    | where isnotempty(msg_s);
let parseLogs = AzureFirewallNetworkRuleLogs
    | where msg_s has_any("TCP", "UDP")
    | parse-where
        msg_s with           networkProtocol:string 
        " request from "     srcIpAddr:string
        ":"                  srcPortNumber:int
    …
    | project-away msg_s;
let parseLogsWithUrls = AzureFirewallNetworkRuleLogs
    | where msg_s has_all ("Url:","ThreatIntel:")
    | parse-where
        msg_s with           networkProtocol:string 
        " request from "     srcIpAddr:string
        " to "               dstIpAddr:string
    …
union parseLogs,  parseLogsWithUrls…

```

To avoid duplicate events and excessive processing, make sure each function starts by filtering, using native fields, only the events that it's intended to parse. Also, if needed, use project-away at each branch, before the union.

### Deploy parsers
Deploy parsers manually by copying them to the Azure Monitor Log page and saving the query as a function. This method is useful for testing. For more information, see Create a function.

To deploy a large number of parsers, we recommend using parser ARM templates, as follows:

1. Create a YAML file based on the relevant template for each schema and include your query in it. Start with the YAML template relevant for your schema and parser type, filtering or parameter-less.

1. Use the ASIM Yaml to ARM template converter to convert your YAML file to an ARM template.

1. If deploying an update, delete older versions of the functions using the portal or the function delete PowerShell tool.

1. Deploy your template using the Azure portal or PowerShell.

You can also combine multiple templates to a single deploy process using linked templates.

