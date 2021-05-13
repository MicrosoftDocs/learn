Parsers are functions that define a virtual table with already parsed unstructured strings fields such as Syslog data.

The following is a KQL query created by the community for Mailbox forwarding monitoring.

In the Logs window, you create a query, click the Save button, enter the Name, and select Save As Function from the drop-down.   In this case, if we name the function "MailboxForward."  I can then access the table using the name MailboxForward.

```kusto
OfficeActivity
    | where TimeGenerated >= ago(30d)
    | where Operation == 'New-InboxRule'
    | extend details = parse_json(Parameters)
    | where details contains 'ForwardTo' or details contains 'RedirectTo'
    | extend ForwardTo = iif(details[0].Name contains 'ForwardTo', details[0].Value,
        iif(details[1].Name contains 'ForwardTo', details[1].Value,
            iif(details[2].Name contains 'ForwardTo', details[2].Value,
                iif(details[3].Name contains 'ForwardTo', details[3].Value,
                    iif(details[4].Name contains 'ForwardTo', details[4].Value,
                        'Check Parameters')))))
    | extend RedirectTo = iif(details[0].Name contains 'RedirectTo', details[0].Value,
        iif(details[1].Name contains 'RedirectTo', details[1].Value,
            iif(details[2].Name contains 'RedirectTo', details[2].Value,
                iif(details[3].Name contains 'RedirectTo', details[3].Value,
                    iif(details[4].Name contains 'RedirectTo', details[4].Value,
                        'Check Parameters')))))
    | extend RuleName = iif(details[3].Name contains 'Name', details[3].Value,
         iif(details[4].Name contains 'Name', details[4].Value,
            iif(details[5].Name contains 'Name', details[5].Value,
                'Check Parameters')))
    | extend RuleParameters = iif(details[2].Name != 'ForwardTo' and  details[2].Name != 'RedirectTo',
        strcat(tostring(details[2].Name), '-', tostring(details[2].Value)),
        iif(details[3].Name != 'ForwardTo' and  details[3].Name != 'RedirectTo' and details[3].Name != 'Name',
            strcat(tostring(details[3].Name), '-', tostring(details[3].Value)),
                iff(details[4].Name != 'ForwardTo' and details[4].Name != 'RedirectTo' and details[4].Name != 'Name' and details[4].Name != 'StopProcessingRules',
                strcat(tostring(details[4].Name), '-', tostring(details[4].Value)),
                'All Mail')))
    | project TimeGenerated, Operation, RuleName, RuleParameters, iif(details contains 'ForwardTo', ForwardTo, RedirectTo), ClientIP, UserId
    | project-rename Email_Forwarded_To = Column1, Creating_User = UserId

```

```kusto
MailboxForward

```

