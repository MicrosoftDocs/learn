## Create an analytics rule from the wizard

You can create a custom analytics rule to search for suspicious activities and threats in your environment. Creating a custom rule from the scheduled query rule type provides you with the highest level of customization options. You can define your own KQL <!--Marjan we need to expand all acronyms at the first instance in the module.--> code, set a schedule to run the alerts, or provide an automated action by associating an Azure Sentinel Playbook.

To create an analytics rule, in the Azure portal, under **Azure Sentinel**, select  **Analytics**. In the top menu bar, select  **+Create**, and then select  **Scheduled query rule.**

## General page

The following table lists the inputs you must provide in the general section. <!--Marjan, we need to use consistent terminology for UI elements. Is this a page as in the heading or a section? And does the name General appear in the UI? if it is a named element, we need to match the casing as seen in the UI and bold it. Please advise.-->

|||
| --- | --- |
| Name | Provide a descriptive name to explain what type of suspicious activity the alert <!-- is it the alert taht detects the threat or the rule? We seem to be saying both--> detects |
| Description | Enter a detailed description that will help other security analysts understand what the rule does. |
| Tactics | From the **Tactics** drop-down menu,  choose one among the available categories of attacks to classify the rule following the MITRE tactics. <!--Marjan, shoudl this be "classify the rule based on MITRE tactics"?-- > |
| Severity | Select the **Severity** drop-down menu to categorize the level of importance of the alert as one of four options: High, Medium, Low, or Informational |
| Status | Specify the status of the rule. By default, the status is **Enabled.** You can select **Disable** <!--Marjan, is the option is the UI Disabled or Disable? We need to match the UI--> to disable the rule if it generates a large number of false positives. |

## Set rule logic

In the **Set rule logic** section <!--Marjan, where can we find this section? or is this a page?-->, you can define the detection method by specifying the KQL code that will run against the Azure Sentinel workspace. The KQL query will trigger and create an incident.

When you enter the KQL query string in the **Rule query** <!--Marjan, is this a field, dialog box?-->, the results of the query displays in the **Results preview** area to the right. The Results preview <!-- is this the name of the right side? if it is named element, it should be bolded as you have bolded in the previous sentence. If it is an unnamed section it should be results preview pane/section--> section helps you to determine whether your query is returning the expected results.

The following sample query alerts you when an anomalous number of resources is created in Azure Activity.

```kusto
AzureActivity
| where OperationName == &quot;Create or Update Virtual Machine&quot;or OperationName ==&quot;Create Deployment&quot;
| where ActivityStatus == &quot;Succeeded&quot;
| make-seriesdcount(ResourceId)  default=0 on EventSubmissionTimestamp inrange(ago(7d), now(), 1d) by Caller
```

> [!Tip]
> For assistance with the query language, refer to [Query Language Reference](https://docs.microsoft.com/azure/kusto/query/).

<!--Marjan, are Map entities, quey scheduling sub-sections under the Set rule logic page or section? If so, can we provide  heading level 3 for each of them to break up the long sections of text?I did it for the first. Please check.-->

### Map entities

In the  **Map entities**  section, you can define the entities that are returned as part of the query rule. You can then use these entities to perform in-depth analysis by <!--Marjan, please check edits to previous sentence--> selecting **Add**  to add these entities to the query rule. These entities can help you perform a visual investigation because they will appear as a group the **Incident settings** tab. Some of the entities contain information that represents a user, host, or IP address. <!--Marjan, I made several edits and bolded the tab name. Please check edits.-->

In the **Query Scheduling** section, you can configure how often the query should run and how far back in history the query should search the data. It's important that you don't search for data that is older than the query's run frequency because that can create duplicate alerts. <!--Marjan, made several edits. Please check for technical accuracy-->

In the **Alert threshold** section, you can specify the number of positive results that can be returned for a rule before it generates an alert. You can use the following logical operators to define an appropriate logical expression:

- Is greater than
- Is fewer than
- Is equal to
- Is not equal to

In the **Event grouping** section, you can select one of the following two options:

- **Group all events into a single alert**. This is the default option, and it creates a single alert if the query returns more results than the specified alert threshold.
- **Trigger an alert for each event**. This option creates unique alerts for each event returned by the query.

In the **Suppression** section, you can set the  **Stop running the Query after the alert is generated** option to  **On**  or  **Off**. When you select **On**, Azure Sentinel pauses the creation of additional incidents if the rule is triggered again for the duration you want the rule to be suppressed. <!--Marjan, please check all edits-->

## Incident settings

Use the **Incident settings** page <!--Marjan, page or section. This is a global question for all the UI names.--> to create an Incident from the alerts that are triggered by the analytics rule.

In the **Alert grouping** section, you can reduce the noise from multiple alerts by grouping them into one incident. When you enable grouping of related alerts, you can choose from the following options: <!--Marjan are the following UI options? If so the need to be bolded.-->

- Grouping alerts into a single incident if all the entities match (recommended)
- Grouping all alerts triggered by this rule into a single incident
- Grouping alerts into a single incident if the selected entities match, such as source or target IP addresses

In the **Re-open closed matching incidents** section, you can configure Azure Sentinel Analytics to open a previously closed incident again if another alert is generated that also belongs to the previously closed incident. <!--Marjan, please review edits-->

## Automated response

You can use the **Automated Response** section to select a playbook to run automatically when the alert is generated. Only the playbooks that contain Logic App Azure Sentinel connector are displayed.

For more details on how to create a Playbook <!--Marjan, playbook has been used in both lower case and upper case in various instances. Which one is correct?--> and run the automated activity on an incident creation, refer to the "Threat response with Sentinel Playbooks" module.

## Review and create

You can use the **Review and create** section to review the settings you have configured in the wizard before creating new rules.
