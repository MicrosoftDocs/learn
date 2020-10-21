## Creating an Analytics rule from Wizard

You can create a custom analytics rules to search for suspicious activities and threats in your environment. Creating a custom rule from scheduled query rule type will provide you with the highest level of customization. You can define, your own KQL code, set a schedule to run the alerts or provide automated action by associating an Azure Sentinel Playbook.

Here is a summary of how to create a custom analytic rule.

1. In the Azure portal under Azure Sentinel, select  **Analytics**.
2. In the top menu bar, select  **+Create**  and select  **Scheduled query rule.**

## General page

In the general section, you are required to provide the following inputs:

|||
| --- | --- |
| Name | Provide descriptive name to explain what type of suspicious activity the alert detects |
| Description | A detailed description will help your security analysts to understand what the rule does |
| Tactics | From the **Tactics** drop-down menu, you can choose among the categories of attacks to classify the rule following the MITRE tactics |
| Severity | The **Severity** drop-down menu categorize the level of importance of the alert and you can choose from the following four options: High, Medium, Low, Informational |
| Status | Status of the rule by default is **Enabled.** You can also **Disable** the rule if it generate large number of fault positive |

## Set rule logic

In the **Set rule logic** section, you can define the detection method by specifying KQL code that will run against the Azure Sentinel workspace. The KQL query will trigger and create an incident.

You are entering the KQL query string in the **Rule query** and then in the **Results preview** area to the right, you can see the results that query will generate. The Results preview section will help you to determine that your query return expected results.

Here&#39;s a sample query that would alert you when an anomalous number of resources is created in Azure Activity.

Kusto

AzureActivity

| where OperationName == &quot;Create or Update Virtual Machine&quot;or OperationName ==&quot;Create Deployment&quot;

| where ActivityStatus == &quot;Succeeded&quot;

| make-seriesdcount(ResourceId)  default=0 on EventSubmissionTimestamp inrange(ago(7d), now(), 1d) by Caller

_ **Tip** _

**For assistance with the query language, see the Query Language Reference at [**https://docs.microsoft.com/en-us/azure/kusto/query/**](https://docs.microsoft.com/en-us/azure/kusto/query/)

In the  **Map entities**  section, you can define the entities that are returned as part of query rule and can be used to perform in-depth analysis. You can **Add** these entities in the query rule, and they can provide visual investigation, because they will appear as a group into Incident settings tab. Some of the entities can contains information that represents a user, host, or IP address.

In the **Query Scheduling** section, you can configure how often the query should run, and how far in history to look back. It&#39;s important that you don&#39;t look back further than the frequency of the query run, because that would create duplicate alerts.

**Alert threshold** specify the number of a positive result that is returned for the rule, before an alert gets generated. You can use the following logical operator to define the logical expression:

- Is greater than
- Is fewer than
- Is equal to
- Is not equal to

In the **Event grouping** section, you can select either:

- **Group all events into a single alert** – This is default option and create a single alert if the query returns more result that the specified alert threshold.
- **Trigger an alert for each event** – Create unique alerts for each event returned by the query.

In the **Suppression** section, you can configure **Stop running the Query after the alert is generated** to  **On**  or  **Off**. You can pause the creation of additional incidents if the rule is triggered again for the time you want it suppressed.

## Incident settings

The **Incident settings** page can create an Incident from the alerts that are triggered by the analytic rule.

In the **Alert grouping** section, you can reduce the noise from multiple alerts by grouping them into one incident. When you enable grouping of related alerts you can choose from:

- Grouping alerts into a single incident if all the entities match (recommended)
- Grouping all alerts triggered by this rule into a single incident
- Grouping alerts into a single incident if the selected entities match: - for example source or target IP addresses.

R **e-open closed matching incidents** section can open again previously closed incident, if another alert is generated that should belong to that incident.

## Automated response

The **Automated Response** section allows you to select a playbook to run automatically when the alert is generated. Only the playbooks that contains Logic App Azure Sentinel connector are displayed.

The module Threat response with Sentinel Playbooks cover more details how to create a Playbook and run the automated activity on an incident creation.

## Review and create

The **Review and create** section, allows you to review the settings you have configured in the wizard before creating new rules.
