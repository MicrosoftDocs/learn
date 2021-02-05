Security log data is often contained in unstructured string fields and requires parsing to extract data.  There are multiple ways of pulling information from string fields in KQL.  The two primary operators used are extract and parse.

## extract

Extract gets a match for a regular expression from a text string. You have the option to convert the extracted substring to the indicated type.

```kusto
print extract("x=([0-9.]+)", 1, "hello x=45.6|wo") == "45.6"

```

Arguments

- regex: A regular expression.

- captureGroup: A positive int constant indicating the capture group to extract. 0 stands for the entire match, 1 for the value matched by the first '('parenthesis')' in the regular expression, 2 or more for subsequent parentheses.

- text: A string to search.

- typeLiteral: An optional type literal (e.g., typeof(long)). If provided, the extracted substring is converted to this type.

Returns

If regex finds a match in text: the substring matched against the indicated capture group captureGroup, optionally converted to typeLiteral.

If there's no match, or the type conversion fails: null.

The following example uses the extract function to pull out the Account Name from the Account field of the SecurityEvent table.

```kusto
// Shows fail user logons divided in to account names in attempts. Shows 5 top account names and others are named 'Other'.

// Tags: #Initial Access #LateralMovement #Persistence

let top5 = SecurityEvent
| where EventID == 4625 and AccountType == 'User'
| extend Account_Name = extract(@"^(.*\\)?([^@]*)(@.*)?$", 2, tolower(Account))
| summarize Attempts = count() by Account_Name
| where Account_Name != ""
| top 5 by Attempts 
| summarize make_list(Account_Name);

SecurityEvent
| where EventID == 4625 and AccountType == 'User'
| extend Name = extract(@"^(.*\\)?([^@]*)(@.*)?$", 2, tolower(Account))
| extend Account_Name = iff(Name in (top5), Name, "Other")
| where Account_Name != ""
| summarize Attempts = count() by Account_Name

```

## parse

Evaluates a string expression and parses its value into one or more calculated columns. The computed columns will have nulls for unsuccessfully parsed strings.

Syntax

T | parse [kind=regex [flags=regex_flags] |simple|relaxed] Expression with * (StringConstant ColumnName [: ColumnType]) *...

Arguments

- T: The input table.

- kind:

  - simple (the default): StringConstant is a regular string value and the match is strict. All string delimiters should appear in the parsed string, and all extended columns must match the required types.

  - regex: StringConstant may be a regular expression and the match is strict. All string delimiters, which can be a regex for this mode, should appear in the parsed string, and all extended columns must match the required types.

  - flags: Flags to be used in regex mode like U (Ungreedy), m (multi-line mode), s (match new line \n), i (case-insensitive) in RE2 flags.

  - relaxed: StringConstant is a regular string value and the match is relaxed. All string delimiters should appear in the parsed string, but extended columns may partially match the required types. Extended columns that didn't match the required types will get the value null.

- Expression: An expression that evaluates to a string.

- ColumnName: The name of a column to assign a value to, extracted from the string expression.

- ColumnType: Optional. The scalar value that indicates the type to convert the value to. The default is the string type.

Returns

The input table extended according to the list of columns that are provided to the operator.

The following example uses a parse to SQL Audit events in the Application log of Windows Events.

```kusto
// KQL SQL Audit Event Parser

let SQlData = Event
| where Source has "MSSQL"
;

let Sqlactivity = SQlData
| where RenderedDescription !has "LGIS" and RenderedDescription !has "LGIF"
| parse RenderedDescription with * "action_id:" Action:string 
                                    " " * 
| parse RenderedDescription with * "client_ip:" ClientIP:string
" permission" * 
| parse RenderedDescription with * "session_server_principal_name:" CurrentUser:string
" " * 
| parse RenderedDescription with * "database_name:" DatabaseName:string
"schema_name:" Temp:string
"object_name:" ObjectName:string
"statement:" Statement:string
"." *
;

let FailedLogon = SQlData
| where EventLevelName has "error"
| where RenderedDescription startswith "Login"
| parse kind=regex RenderedDescription with "Login" LogonResult:string
                                            "for user '" CurrentUser:string 
                                            "'. Reason:" Reason:string 
                                            "provided" *
| parse kind=regex RenderedDescription with * "CLIENT" * ":" ClientIP:string 
                                            "]" *
;

let dbfailedLogon = SQlData
| where RenderedDescription has " Failed to open the explicitly specified database" 
| parse kind=regex RenderedDescription with "Login" LogonResult:string
                                            "for user '" CurrentUser:string 
                                            "'. Reason:" Reason:string 
                                            " '" DatabaseName:string
                                            "'" *
| parse kind=regex RenderedDescription with * "CLIENT" * ":" ClientIP:string 
                                            "]" *
;

let successLogon = SQlData
| where RenderedDescription has "LGIS"
| parse RenderedDescription with * "action_id:" Action:string 
                                    " " LogonResult:string 
                                    ":" Temp2:string
                                    "session_server_principal_name:" CurrentUser:string
                                    " " *
| parse RenderedDescription with * "client_ip:" ClientIP:string 
                                    " " *
;
(union isfuzzy=true
Sqlactivity, FailedLogon, dbfailedLogon, successLogon )
| project TimeGenerated, Computer, EventID, Action, ClientIP, LogonResult, CurrentUser, Reason, DatabaseName, ObjectName, Statement

```

