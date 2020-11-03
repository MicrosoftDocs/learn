In this exercise, you will explore an Azure Sentinel analytics rule. <!--Marjan, added a topic sentence>

## Exercise: Threat detection with Azure Sentinel Analytics

<!--Marjan as per the exercise template, we need to have setup section as described below. Can you please provide any content if applicable for the setup section for this exercise?  

Setup
<!-- Provide high level guidance on what needs to exist before tasks can be completed. Likely you'll point the students to a script to run. You might also have additional setup steps to include. -->
Download and run the setup script which will configure your Azure environment for this exercise. The script will <do X>, <do Y>, and <do Z>.
After running the script, create a resource group called ContosoResourceGroup. Details here.
Create a VM. Details here.
<!-- The following steps need to be detailed enough for someone to perform the task themselves - supposing they meet the prereq knowledge -->
>

## Task 1: Work with Azure Sentinel Analytics. Create an analytics rule from an existing template.** 

<!--Marjan both Task 1 and Task 2 have the exact same title. We need to have task titles that map to the objectives listed below.-- >

In this exercise, you will perform the following tasks: <!--Marjan, tweaked the lead in. I also made several edits throughout the steps. For instance I changed all instances of "click", "type" etc to inclusive language. Please review the steps to ensure that I have not introduced any inaccuracies. >

<!--Marjan, are these three tasks being performed in the entire exercise? I am not able to make out where they are doing task 2 and task 3. There is no mention of KQL code in the subsequent steps. We need to have Task 1, Task 2 Task 3 with a clear mapping to the objectives listed below.-->

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

1. In the  **Map entities**  section, you can define the entities that are returned as part of the query rule and that you can use to perform in-depth analysis.
2. In the **Query Scheduling** section, you can configure how often the query should run, and how far in history to look back. Accept the default values.
3. In the **Alert threshold** section, you can specify the number of positive results that can be returned for the rule before an alert gets generated. Accept the default values.
4. In the **Event grouping** section, accept the default selection to **Group all events into a single alert.**
5. In the **Suppression** section, you can configure **Stop running the Query after the alert is generated** to  **On**  or  **Off.** Accept the default values.

![](RackMultipart20201101-4-1ob6vhl_html_cc96bbbfb8b67b52.png)

1. Select **Next: Incident setting (preview)**.
2. In the **Incident setting (preview)** section, <!--Marjan is this a section or an option? --> ensure that **Enabled** is selected for creation of incidents from alerts triggered by this analytics rule.
3. In the **Alert grouping** section, select **Enabled** to group related alerts into incidents, and ensure that **Grouping alerts into a single incident if all the entities match (recommended)** is selected.
4. Ensure that **Re-open closed matching incidents** is **Disabled**, and then select **Next: Automated response**.

![](RackMultipart20201101-4-1ob6vhl_html_9a9b701b75728e2d.png)

1. In the **Automated response** <!--Marjan, is this a field, option, section?-->, you can select a playbook to run automatically when the alert is generated. Only the playbooks that contains Logic App Azure Sentinel connector are displayed.
2. Select **Next:Review**.
3. In the **Review and Create** <!--Marjan same question, we need to qualify what this is--> page, verify that the validation was successful, and then select **Create**.

**Task 2: Work with Azure Sentinel Analytics. Create Analytics rule from existing template.**

1. In the Azure portal, search for and select Azure Sentinel and select the previously created Sentinel workspace.
2. In the **Azure Sentinel** blade, on the menu bar, in the **Configuration** section, select **Analytics**.
3. In the **Azure Sentinel | Analytics** blade, select **Rule templates.**
4. In the search field, enter and select **Create incidents based on Azure Security Center alerts**.  
1. In the details pane, select **Create rule**.
1. In the **General** pane, observe the name of the analytics rule, and verify that the **Status** of the rule is **Enabled**.
1. In the **Analytics rule logic** section, verify that in the drop-down menu for the Microsoft security service, **Azure Security Center** is selected.
1. In the **Filter by severity** section, select **Custom**, and then in the drop-down menu, select **High** and **Medium**.
1. If you want to further filter the alerts from Azure Security Center, you can add additional text in **Include specific alerts** or **Exclude specific alerts**.

![](RackMultipart20201101-4-1ob6vhl_html_9cd22e1d731f6d21.png)

1. Select **Next:Review**, and then on the **Review and Create** page, select **Create**.

## Results

<!--Marjan I added this based on the template provided for exercises.   ... Also, provide cleanup instructions where needed -->

After completing this exercise, you will have created an incident rule from an existing template, created a scheduled query rule by using your own KQL code, and adjusted KQL from an existing analytic rule.
