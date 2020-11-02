You can create a custom analytics rules to search for suspicious activities and threats in your environment. Creating a custom rule from the scheduled query rule type provides you with the highest level of customization. You can define, your own Kusto Query Language (KQL) code, set a schedule to run the alerts or provide automated action by associating an Azure Sentinel Playbook.

## Creating an analytics rule from Wizard

To start creating analytics rule, in the Azure portal, under Azure Sentinel, select  **Analytics**. In the top menu bar, select  **+Create**  and select  **Scheduled query rule.**

## General page

The following table lists the inputs you must provide in the **General** section.

|||
| --- | --- |
| Name | Provide descriptive name to explain what type of suspicious activity the alert detects |
| Description | A detailed description will help your security analysts to understand what the rule does |
| Tactics | From the **Tactics** drop-down menu, you can choose among the categories of attacks to classify the rule base on MITRE tactics |
| Severity | Select the **Severity** drop-down menu to categorize the level of importance of the alert as one of four options: High, Medium, Low, Informational |
| Status | Specify the status of the rule. By default is **Enable.** You can select **Disable** to disable the rule if it generate large number of fault positive |

## Set rule logic

In the **Set rule logic** page, you can define the detection method by specifying KQL code that will run against the Azure Sentinel workspace. The KQL query will filter the security data that is used to trigger and create an incident.

When you enter the KQL query string in the **Rule query** field, you can use **Results preview** area to the right to see the results of the query. The Results preview section will help you to determine that your query return expected results.

![Screenshot of the wizzard of creating scheduled analytics rule](../media/05-Create-scheduled-rule.PNG)

The following sample query alerts you when an anomalous number of resources is created in Azure Activity.

```kusto
AzureActivity
| where OperationName == &quot;Create or Update Virtual Machine&quot;or OperationName ==&quot;Create Deployment&quot;
| where ActivityStatus == &quot;Succeeded&quot;
| make-seriesdcount(ResourceId)  default=0 on EventSubmissionTimestamp inrange(ago(7d), now(), 1d) by Caller
```

> [!**Tip**]

> **For assistance with the query language, see the Query Language Reference at [**https://docs.microsoft.com/en-us/azure/kusto/query/**](https://docs.microsoft.com/en-us/azure/kusto/query/)

### Map entities

In the  **Map entities**  section, you can define the entities that are returned as part of query rule. You can then use these entities to perform in-depth analysis by selecting  **Add** to add these entities in the query rule. These entities can help you perform a visual investigation, because they will appear as a group into **Incident** tab. Some of the entities contain information that represents a user, host, or IP address.

In the **Query Scheduling** section, you can configure how often the query should run, and how far back in history the query should searc the data. It's important that you don't search for data that is older then the query's run frequency, because that can create duplicate alerts.

In the **Alert threshold** section, you can specify the number of a positive result that can be returned for the rule, before it generates an alert. You can use the following logical operators to define an appropriate logical expression:

- Is greater than
- Is fewer than
- Is equal to
- Is not equal to

In the **Event grouping** section, you can select one of the following two options:

- **Group all events into a single alert**. This is the default option, and it creates a single alert if the query returns more results than that the specified alert threshold.
- **Trigger an alert for each event**. This option create unique alerts for each event returned by the query.

In the **Suppression** section, you can set the **Stop running the Query after the alert is generated** option to  **On**  or  **Off**. When you select **On**, Azure Sentinel pauses the creation of additional incidents if the rule is triggered again for the duration you want the rule to be suppressed.

## Incident settings

Use the **Incident settings** page to create an Incident from the alerts that are triggered by the analytics rule.

In the **Alert grouping** section, you can reduce the noise from multiple alerts by grouping them into one incident. When you enable grouping of related alerts you can choose from the following options:

- **Grouping alerts into a single incident if all the entities match (recommended)**
- **Grouping all alerts triggered by this rule into a single incident**
- **Grouping alerts into a single incident if the selected entities match** - for example source or target IP addresses.

In the **Re-open closed matching incidents** section, you can configure Azure Sentinel Analytics to open a previously closed incident again if another alert is generated that also belongs to the previosly closed incident.

## Automated response

You can use the **Automated Response** section to select a playbook to run automatically when the alert is generated. Only the playbooks that contains Logic App Azure Sentinel connector are displayed.

For More details on how to create a playbopok  and run the automated activity on an incident creation, refer to the "Threat response with Sentinel Playbooks".

## Review and create

You can use the **Review and create** section to review the settings you have configured in the wizard before creating new rules.
