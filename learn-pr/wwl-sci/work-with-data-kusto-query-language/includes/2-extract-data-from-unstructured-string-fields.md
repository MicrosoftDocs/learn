Security log data is often contained in unstructured string fields and requires parsing to extract data. There are multiple ways of pulling information from string fields in KQL.  The two primary operators used are extract and parse.

## Extract

Extract gets a match for a regular expression from a text string. You may optionally convert the extracted substring to the indicated type.

```kusto
print extract("x=([0-9.]+)", 1, "hello x=45.6|wo") == "45.6"

```

Arguments

- regex: A regular expression.

- captureGroup: A positive int constant indicating the capture group to extract. A "0" stands for the entire match, a "1" for the value matched by the first '('parenthesis')' in the regular expression, 2 or more for subsequent parentheses.

- text: A string to search.

- typeLiteral: An optional type literal (for example, typeof(long)). If provided, the extracted substring is converted to this type.

Returns

If regex finds a match in text: the substring matched against the indicated capture group captureGroup, optionally converted to typeLiteral.

If there's no match, or the type conversion fails: null.

The following example uses the extract function to pull out the Account Name from the Account field of the SecurityEvent table.

```kusto
SecurityEvent
| where EventID == 4672 and AccountType == 'User'
| extend Account_Name = extract(@"^(.*\\)?([^@]*)(@.*)?$", 2, tolower(Account))
| summarize LoginCount = count() by Account_Name
| where Account_Name != ""
| where LoginCount < 10

```

## Parse

Parse evaluates a string expression and parses its value into one or more calculated columns. The computed columns have nulls for unsuccessfully parsed strings.

Syntax

`T | parse [kind=regex [flags=regex_flags] |simple|relaxed] Expression with * (StringConstant ColumnName [: ColumnType]) *`

Arguments

- T: The input table.

- kind:

  - simple (the default): StringConstant is a regular string value and the match is strict. All string delimiters should appear in the parsed string, and all extended columns must match the required types.

  - regex: StringConstant may be a regular expression and the match is strict. All string delimiters, which can be a regex for this mode, should appear in the parsed string, and all extended columns must match the required types.

  - flags: Flags to be used in regex mode like U (Ungreedy), m (multi-line mode), s (match new line \n), i (case-insensitive) in RE2 flags.

  - relaxed: StringConstant is a regular string value and the match is relaxed. All string delimiters should appear in the parsed string, but extended columns may partially match the required types. Extended columns that didn't match the required types get the value null.

- Expression: An expression that evaluates to a string.

- ColumnName: The name of a column to assign a value to, extracted from the string expression.

- ColumnType: Optional. The scalar value that indicates the type to convert the value to. The default is the string type.

Returns

The input table extended according to the list of columns that are provided to the operator.

The following statement demonstrates the parse operator, which evaluates a string expression and parses its value into one or more calculated columns. Use for structuring unstructured data.


```kusto
let Traces = datatable(EventText:string)
[
"Event: NotifySliceRelease (resourceName=PipelineScheduler, totalSlices=27, sliceNumber=23, lockTime=02/17/2016 08:40:01, releaseTime=02/17/2016 08:40:01, previousLockTime=02/17/2016 08:39:01)",
"Event: NotifySliceRelease (resourceName=PipelineScheduler, totalSlices=27, sliceNumber=15, lockTime=02/17/2016 08:40:00, releaseTime=02/17/2016 08:40:00, previousLockTime=02/17/2016 08:39:00)",
"Event: NotifySliceRelease (resourceName=PipelineScheduler, totalSlices=27, sliceNumber=20, lockTime=02/17/2016 08:40:01, releaseTime=02/17/2016 08:40:01, previousLockTime=02/17/2016 08:39:01)",
"Event: NotifySliceRelease (resourceName=PipelineScheduler, totalSlices=27, sliceNumber=22, lockTime=02/17/2016 08:41:01, releaseTime=02/17/2016 08:41:00, previousLockTime=02/17/2016 08:40:01)",
"Event: NotifySliceRelease (resourceName=PipelineScheduler, totalSlices=27, sliceNumber=16, lockTime=02/17/2016 08:41:00, releaseTime=02/17/2016 08:41:00, previousLockTime=02/17/2016 08:40:00)"
];
Traces  
| parse EventText with * "resourceName=" resourceName ", totalSlices=" totalSlices:long * "sliceNumber=" sliceNumber:long * "lockTime=" lockTime ", releaseTime=" releaseTime:date "," * "previousLockTime=" previousLockTime:date ")" *  
| project resourceName, totalSlices, sliceNumber, lockTime, releaseTime, previousLockTime
```

