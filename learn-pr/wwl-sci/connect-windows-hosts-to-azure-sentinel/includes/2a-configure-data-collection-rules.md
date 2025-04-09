The Windows Security Events via AMA Connector uses Data Collection Rules (DCRs) to define the data to collect from each agent. Data collection rules offer you two distinct advantages:

- **Manage collection settings at scale** while still allowing unique, scoped configurations for subsets of machines. They're independent of the workspace and independent of the virtual machine, which means they can be defined once and reused across machines and environments. 

- **Build custom filters** to choose the exact events you want to ingest. The Azure Monitor Agent uses these rules to filter the data at the source and ingest only the events you want, while leaving everything else behind. 

## Prerequisites

- You must have read and write permissions on the Microsoft Sentinel workspace.

- To collect events from any system that isn't an Azure virtual machine, the system must have **Azure Arc** installed and enabled before you enable the Azure Monitor Agent-based connector.

These include:

    - Windows servers installed on physical machines
    - Windows servers installed on on-premises virtual machines
    - Windows servers installed on virtual machines in non-Azure clouds

## Connect Windows Hosts

1. From the Microsoft Sentinel navigation menu, select Data connectors.

1. Select the Windows Security Events via AMA connector from the list, and then select Open connector page on the details pane.

1. Verify that you have the appropriate permissions as described under the Prerequisites section on the connector page.

1. Under Configuration, select +Add data collection rule. The Create data collection rule wizard opens.

1. Under Basics, enter a Rule name and specify a Subscription and Resource group where the data collection rule (DCR) will be created. This doesn't have to be the same resource group or subscription the monitored machines and their associations are in, as long as they are in the same tenant.

1. In the Resources tab, select +Add resource(s) to add machines to which the Data Collection Rule will apply. The Select a scope dialog opens, and you see a list of available subscriptions. Expand a subscription to see its resource groups, and expand a resource group to see the available machines. You see Azure virtual machines and Azure Arc-enabled servers in the list. You can mark the check boxes of subscriptions or resource groups to select all the machines they contain, or you can select individual machines. Select Apply when you've chosen all your machines. At the end of this process, the Azure Monitor Agent is installed on any selected machines that don't already have the agent.

1. On the Collect tab, choose the events you would like to collect. Select:
    - All security events
    - Common
    - Minimal
    - Custom

    > [!NOTE]
    >Custom allows you to specify other logs or to filter events using XPath queries. For XPath queries you can enter up to 20 expressions in a single box, and up to 100 boxes in a rule. The Azure Monitor agent supports XPath queries for XPath version 1.0 only.

1. When you add all the filter expressions you want, select Next: Review + create.

1. When you see the "Validation passed" message, select Create.

You'll see all your data collection rules (including those created through the API) under Configuration on the connector page. From there you can edit or delete existing rules.

### Test the validity of an XPath query

Use the PowerShell cmdlet Get-WinEvent with the -FilterXPath parameter to test the validity of an XPath query. The following script shows an example:

```powershell
$XPath = '*[System[EventID=1035]]'
Get-WinEvent -LogName 'Application' -FilterXPath $XPath
```

- If events are returned, the query is valid.
- If you receive the message "No events were found that match the specified selection criteria," the query may be valid, but there are no matching events on the local machine.
- If you receive the message "The specified query is invalid," the query syntax is invalid.
