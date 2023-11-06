

You can create a custom analytics rule to search for suspicious activities and threats at Contoso.

## Create a custom scheduled analytics rule

Creating a custom rule from a scheduled query rule type provides you with the highest level of customization. You can define your own KQL code, set a schedule to run an alert, and provide an automated action by associating the rule with a Microsoft Sentinel Playbook.

To create a scheduled query rule, in the Azure portal, under **Microsoft Sentinel**, select  **Analytics**. In the header bar, select  **+Create**, and then select  **Scheduled query rule.**

> [!NOTE]
> You can also create a scheduled rule by selecting a scheduled rule from the Rules and Templates list in the Analytics pane and then selecting **Create rule** in the details pane.

A scheduled query rule you create consists of the following elements:

## General tab

The following table lists the input fields on the **General** pane.

| Field | Description |
| --- | --- |
| Name | Provide a descriptive name to explain what type of suspicious activity the alert detects. |
| Description | Enter a detailed description that will help other security analysts understand what the rule does. |
| Tactics | From the **Tactics** dropdown list, choose one among the available categories of attacks to classify the rule following the MITRE tactics. |
| Severity | Select the **Severity** dropdown list to categorize the level of importance of the alert as one of four options: High, Medium, Low, or Informational. |
| Status | Specify the status of the rule. By default, the status is **Enable.** You can select **Disable** to disable the rule if it generates a large number of false positives. |

## Set rule logic tab

On the **Set rule logic** tab, you can define the detection method by specifying KQL code that will run against the Microsoft Sentinel workspace. The KQL query will filter the security data that is used to trigger and create an incident.

When you enter the KQL query string in the **Rule query** field, you can use the **Results simulation (preview)** section to review the results of the query. The **Results simulation (preview)** section will help you determine whether your query returned the expected results.

:::image type="content" source="../media/05-create-scheduled-rule.png" alt-text="Screenshot of wizard used to create a scheduled analytics rule." border="false":::

The following sample query alerts you when an anomalous number of resources is created in Azure Activity.

```kusto
AzureActivity
| where OperationName == "Create or Update Virtual Machine" or OperationName == "Create Deployment"
| where ActivityStatus == "Succeeded"

| make-seriesdcount(ResourceId)  default=0 on EventSubmissionTimestamp in range(ago(7d), now(), 1d) by Caller
```

> [!Tip]
> For assistance with KQL query language, see the [Kusto Query Language (KQL) overview](/azure/kusto/query/).

### Alert enrichment (Preview)

Alert enrichment enables you to further customize the result of your query.

#### Entity mapping

In the **Entity mapping** section, you can define up to five entities from your query results, and then use these entities to perform in-depth analysis. By selecting  **Add new entity** to add these entities in the query rule. These entities can help you perform a visual investigation because they'll appear as a group on the **Incident** tab. Some of the entities contain information that represents a user, a host, or an IP address.

#### Custom details

In the **Custom details** section, you can set key value pairs, which, if they appear in the query result, will display an event parameter in the results.  

#### Alert details

In the **Alert details** section, you can enter free text as parameters that can be represented in each instance of the alert; these can also contain the tactics and severity assigned to that instance of the alert.  

### Query Scheduling

In the **Query Scheduling** section, you can configure how often the query should run, and how far back in history the query should search the data. It's important that you don't search for data that is older than the query's run frequency because that can create duplicate alerts.

### Alert threshold

In the **Alert threshold** section, you can specify the number of a positive result that can be returned for the rule before it generates an alert. You can use the following logical operators to define an appropriate logical expression:

- Is greater than
- Is fewer than
- Is equal to
- Isn't equal to

### Event grouping

In the **Event grouping** section, you can select one of the following two options:

- **Group all events into a single alert**. This is the default option, and it creates a single alert if the query returns more results than that the specified alert threshold.
- **Trigger an alert for each event**. This option creates unique alerts for each event returned by the query.

### Suppression

In the **Suppression** section, you can set the **Stop running the Query after the alert is generated** option to  **On**  or  **Off**. When you select **On**, Microsoft Sentinel pauses the creation of additional incidents if the rule is triggered again for the duration you want the rule to be suppressed.

## Incident settings (Preview)

Use the **Incident settings** tab to create incidents, which are generated by grouping alerts based on triggers and time frames.

In the **Alert grouping** section, you can reduce the noise from multiple alerts by grouping them into one incident. When you enable grouping of related alerts, you can choose from the following options:

- **Grouping alerts into a single incident if all the entities match (recommended)**
- **Grouping all alerts triggered by this rule into a single incident**
- **Grouping alerts into a single incident if the selected entities match** (for example, source or target IP addresses).

You can also **Reopen closed matching incidents** if another alert is generated that  belongs to a previously closed incident.

## Automated response tab

Not used in this exercise.

## Set rule logic tab - Exercise

On the **Automated Response** tab, you can select a playbook to run automatically when the alert is generated. Only the playbooks that contain Logic App Microsoft Sentinel connector appear.

For more information about how to create a playbook and run the automated activity on an incident creation, see the "Threat response with Microsoft Sentinel Playbooks" module.

## Review and create tab

On the **Review and create** tab, review the settings you've configured in the wizard before creating a new rule.