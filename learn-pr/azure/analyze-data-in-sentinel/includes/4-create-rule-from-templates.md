## Create an analytics rule from templates

Analytics section in Azure Sentinel contains rule templates that are pre-loaded from Azure Sentinel&#39;s GitHub repository. You can use these templates to create a rule for detection of security threat. Some of these templates allows you to create a single rule. Templates that are in use will have visible indication **IN USE** in the template page (see picture).

## Exploring the existing rule templates

By selecting one of the rules in the **Rule Template** tab, you can observe the properties of the rule. For each rule you can view:

- Severity level – Indicates the importance of the alert. There are 4 severity levels,
  - High
  - Medium
  - Low
  - Informational
- Name of the rule – Provide meaningful name of the alert rule
- Rule type – Define the type of the rule:
  - Fusion
  - Microsoft Security
  - ML Behavior Analytics
  - Scheduled
- Data Source – Specify the data source connector that generate the alert
- Tactics – Specify techniques and methodologies in MITRE ATT&amp;CK model used by different kinds of malware

> [!NOTE]

> MITRE ATT&amp;CK is a globally accessible knowledge base of adversary tactics and techniques based on real-world observations. The ATT&amp;CK knowledge base is used as a foundation for the development of specific threat models and methodologies in the private sector, in government, and in the cybersecurity product and service community.

Details pane of selected rule is displayed right of the listing and provide more information for the rule. Depending on the type of the rule that you select, the details pane can contain different fields of information. For Fusion and ML behavior analytics rules, Microsoft does not provide any additional information, but for example for the scheduled rule, you can view the query rule used in detection of the threat.

## Creating an analytic rule from rule template

When you select a predefined rule template, in the detailed pane, you will have a button **Create rule.** By clicking this button, you start the creation of the analytic rule from that template. The composition of the analytic rules from template depends on the rule type that you select.

Alert rule is created by default using Fusion rule template, and for Machine Learning Behavior Analytics, you can only create the rule as enabled or disabled, without the possibility to further customize.

Creation of the rule from Microsoft security templates consist of the following elements:

- **Name** – Prepopulated from the name of the rule template
- **Description** – Explain more details on the creation of the alerts
- **Status** – Whether the analytic rule is enabled or disabled
- **Analytic rule logic** – Indicate the source of the alert from one of the Microsoft security services
- **Filter by severity** – You can tune alerts from the source based on the severity level: High, Medium, Low, Informational
- **Include specific alerts** – You can filter the alerts that contains specific text in the name
- **Exclude specific alerts** - You can filter the alerts that do not contains specific text in the name

Creating of the analytics rule from the scheduled template rule type will be explained in the next unit Creating an Analytics rule from the wizard.

> [!NOTE]

> For some rule templates, the button **Create rule** will be grayed out, that indicates that you cannot create a rule from selected template due to missing data source.
