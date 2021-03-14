You can create a custom analytics rule to search for suspicious activities and threats at Contoso. 

## Create an analytics rule by using the wizard

Creating a custom rule from the scheduled query rule type provides you with the highest level of customization. You can define, your own KQL code, set a schedule to run the alerts, or provide an automated action by associating an Azure Sentinel Playbook.

To create an analytics rule, in the Azure portal, under **Azure Sentinel**, select  **Analytics**. In the top menu bar, select  **+Create**, and then select  **Scheduled query rule.**

## General page

The following table lists the inputs you must provide on the **General** page.

|||
| --- | --- |
| Name | Provide a descriptive name to explain what type of suspicious activity the alert detects. |
| Description | Enter a detailed description that will help other security analysts understand what the rule does. |
| Tactics | From the **Tactics** drop-down menu, choose one among the available categories of attacks to classify the rule following the MITRE tactics. |
| Severity | Select the **Severity** drop-down menu to categorize the level of importance of the alert as one of four options: High, Medium, Low, or Informational. |
| Status | Specify the status of the rule. By default, the status is **Enable.** You can select **Disable** to disable the rule if it generates a large number of false positives. |

## Set rule logic

On the **Set rule logic** page, you can define the detection method by specifying KQL code that will run against the Azure Sentinel workspace. The KQL query will filter the security data that is used to trigger and create an incident.

When you enter the KQL query string in the **Rule query** field, you can use the **Results simulation (preview)** section to review the results of the query. The **Results simulation (preview)** section will help you determine whether your query returned the expected results.

:::image type="content" source="../media/05-create-scheduled-rule.png" alt-text="Screenshot of the wizard used to create a scheduled analytics rule." border="false":::

The following sample query alerts you when an anomalous number of resources is created in Azure Activity.

```kusto
AzureActivity
| where OperationName == &quot;Create or Update Virtual Machine&quot;or OperationName ==&quot;Create Deployment&quot;
| where ActivityStatus == &quot;Succeeded&quot;
| make-seriesdcount(ResourceId)  default=0 on EventSubmissionTimestamp inrange(ago(7d), now(), 1d) by Caller
```

> [!Tip]
> For assistance with the query language, refer to the Query Language Reference at [**https://docs.microsoft.com/en-us/azure/kusto/query/**](https://docs.microsoft.com/azure/kusto/query/)

### Map entities

In the  **Map entities**  section, you can define the entities that are returned as part of the query rule, and then use these entities to perform in-depth analysis by selecting  **Add** to add these entities in the query rule. These entities can help you perform a visual investigation because they will appear as a group on the **Incident** tab. Some of the entities contain information that represents a user, a host, or an IP address.

### Query Scheduling

In the **Query Scheduling** section, you can configure how often the query should run, and how far back in history the query should search the data. It's important that you don't search for data that is older than the query's run frequency because that can create duplicate alerts.

### Alert threshold

In the **Alert threshold** section, you can specify the number of a positive result that can be returned for the rule before it generates an alert. You can use the following logical operators to define an appropriate logical expression:

- Is greater than
- Is fewer than
- Is equal to
- Is not equal to

### Event grouping

In the **Event grouping** section, you can select one of the following two options:

- **Group all events into a single alert**. This is the default option, and it creates a single alert if the query returns more results than that the specified alert threshold.
- **Trigger an alert for each event**. This option creates unique alerts for each event returned by the query.

### Suppression 

In the **Suppression** section, you can set the **Stop running the Query after the alert is generated** option to  **On**  or  **Off**. When you select **On**, Azure Sentinel pauses the creation of additional incidents if the rule is triggered again for the duration you want the rule to be suppressed.

## Incident settings

Use the **Incident settings** page to create an Incident from the alerts that are triggered by the analytics rule.

In the **Alert grouping** section, you can reduce the noise from multiple alerts by grouping them into one incident. When you enable grouping of related alerts, you can choose from the following options:

- **Grouping alerts into a single incident if all the entities match (recommended)**
- **Grouping all alerts triggered by this rule into a single incident**
- **Grouping alerts into a single incident if the selected entities match** - for example source or target IP addresses.

In the **Reopen closed matching incidents** section, you can configure Azure Sentinel Analytics to open a previously closed incident again if another alert is generated that also belongs to the previously closed incident.

## Automated response

You can use the **Automated Response** section to select a playbook to run automatically when the alert is generated. Only the playbooks that contain Logic App Azure Sentinel connector are displayed.

For more information on how to create a playbook and run the automated activity on an incident creation, see the "Threat response with Azure Sentinel Playbooks" module.

## Review and create

You can use the **Review and create** section to review the settings you have configured in the wizard before creating new rules.
