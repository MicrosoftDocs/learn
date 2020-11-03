In this exercise, you will explore an Azure Sentinel analytics rule. <!--Marjan, added a topic sentence>

## Exercise: Threat detection with Azure Sentinel Analytics

**Task 1: Work with Azure Sentinel Analytics. Create an analytics rule from an existing template.**

In this exercise, you will perform the following tasks: <!--Marjan, tweaked the lead in. I also made several edits throught the steps. For instance I changed all instances of "click", "type" etc to inclusive language. Please review the steps to ensure that I have not introduced any inaccuracies. >

- Create an incident rule from an existing template.
- Create a scheduled query rule by using your own KQL code.
- Adjust KQL from an existing analytic rule.

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Sentinel workspace.
2. In the **Azure Sentinel** blade, on the menu bar, in the **Configuration** section, select **Analytics**.
3. In the **Azure Sentinel | Analytics** blade, select **Rule templates**.
4. In the search field, enter and select **Suspicious number of resource creation or deployment activities**.
5. In the details pane, select **Create rule**.

![](RackMultipart20201101-4-1ob6vhl_html_a3a95526685ba175.png)

1. On the **Analytics rule wizard - Create new rule from template** tab, review the default values, and then select **Next:Set rule logic.**

>[!Note]
> In the **General** pane, you can identify the Tactics that specify techniques and methodologies in the MITRE ATT&amp;CK model used by different kinds of malware. <!--Marjan, I am not sure if the user is selecting any UI element in the General pane. Is Tactics a UI option?  >

1. On the **Set rule logic** page, you can review the predefined rule query. You can select **Result simulation** to test the query and preview the real data. Select **Test with current data** and observe the results.

![](RackMultipart20201101-4-1ob6vhl_html_9c81b2f9e4b14735.png)

1. In the  **Map entities**  section, you can define the entities that are returned as part of query rule and can be used to perform in-depth analysis.
2. In the **Query Scheduling** section, you can configure how often the query should run, and how far in history to look back. Accept the default values.
3. In the **Alert threshold** section, you can specify the number of positive results that can be returned for the rule before an alert gets generated. Accept the default values.
4. In the **Event grouping** section, accept the default selection to **Group all events into a single alert.**
5. In the **Suppression** section, you can configure **Stop running the Query after the alert is generated** to  **On**  or  **Off.** Accept the default values.

![](RackMultipart20201101-4-1ob6vhl_html_cc96bbbfb8b67b52.png)

1. Select **Next: Incident setting (preview)**.
2. In the **Incident setting (preview),** ensure that **Enabled** is selected for creation of incidents from alerts triggered by this analytics rule.
3. In the **Alert grouping** section, click **Enabled** to group related alerts into incidents, and ensure that **Grouping alerts into a single incident if all the entities match (recommended)** is selected.
4. Ensure that **Re-open closed matching incidents** is **Disabled** and then click **Next: Automated response**

![](RackMultipart20201101-4-1ob6vhl_html_9a9b701b75728e2d.png)

1. In the **Automated response** you can select a playbook to run automatically when the alert is generated. Only the playbooks that contains Logic App Azure Sentinel connector are displayed.
2. Click on the **Next:Review**
3. In the **Review and Create,** page verify that validation passed and click **Create.**

**Task 2: Work with Azure Sentinel Analytics. Create Analytics rule from existing template.**

1. In the Azure portal, search for and select Azure Sentinel and select the previously created Sentinel workspace.
2. In the **Azure Sentinel** blade, on the left side in the menu bar, in the **Configuration** section, select **Analytics.**
3. In the **Azure Sentinel | Analytics** blade, click **Rule templates.**
4. In the search field type and select **Create incidents based on Azure Security Center alerts.** From the detailed pane on the right side click **Create rule.**
5. In the **General** pane, observe the Name of the Analytics rule, and verify that the **Status** of the rule is **Enabled.**
6. In the **Analytics rule logic** section, verify that in the drop-down menu for the Microsoft security service, **Azure Security Center** is selected.
7. In the **Filter by severity** section, select **Custom,** and then in the drop-down menu select **High** and **Medium.**
8. If you want to further filter the alerts from Azure Security Center, you can add additional text in **Include specific alerts** or **Exclude specific alerts.**

![](RackMultipart20201101-4-1ob6vhl_html_9cd22e1d731f6d21.png)

1. Click **Next:Review,** and then in the **Review and Create** page click **Create.**
