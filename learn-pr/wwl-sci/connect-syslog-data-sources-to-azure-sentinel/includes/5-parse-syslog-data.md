The Syslog collector writes log data to the Syslog table. One difference from the CEF Collector is that the message's data is stored in a string field named SyslogMessage. The Common Event Format (CEF) Connector writes to the CommonSecurityLog with the fields already parsed. For Syslog, you'll need to parse fields on every query that uses the Syslog table or write a Parser. A Parser is a KQL Function that is a query saved as a function and then referenced with the function name. The reference to the function name is like accessing any other table. By creating parses, you only need to write the SyslogMessage parsing once.

In the Logs window, create a query, select the Save button, and select Function from the drop-down.  Then specify function name and alias.   In this case, if we create the Function named MyParser,  I then can access the table using the name MyParser.

```kusto
Syslog
| where ProcessName contains "squid"
| extend URL = extract("(([A-Z]+ [a-z]{4,5}:\\/\\/)|[A-Z]+ )([^ :]*)",3,SyslogMessage), 
         SourceIP = extract("([0-9]+ )(([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3}))",2,SyslogMessage), 
         Status = extract("(TCP_(([A-Z]+)(_[A-Z]+)*)|UDP_(([A-Z]+)(_[A-Z]+)*))",1,SyslogMessage), 
         HTTP_Status_Code = extract("(TCP_(([A-Z]+)(_[A-Z]+)*)|UDP_(([A-Z]+)(_[A-Z]+)*))/([0-9]{3})",8,SyslogMessage),
         User = extract("(CONNECT |GET )([^ ]* )([^ ]+)",3,SyslogMessage),
         RemotePort = extract("(CONNECT |GET )([^ ]*)(:)([0-9]*)",4,SyslogMessage),
         Domain = extract("(([A-Z]+ [a-z]{4,5}:\\/\\/)|[A-Z]+ )([^ :\\/]*)",3,SyslogMessage)
| extend TLD = extract("\\.[a-z]*$",0,Domain)

```

```kusto
MyParser

```

