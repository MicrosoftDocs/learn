Managing data privacy across an organization requires ongoing assessments to track how personal data is processed. Without an automated way to assign assessments, privacy teams might struggle to keep up with evolving data practices, leading to gaps in documentation and compliance risks.

Privacy rules in **Microsoft Priva Privacy Assessments (preview)** solve this challenge by automatically assigning assessments when data meets predefined conditions. These rules scan the Microsoft Purview Data Map, evaluating **business assets** (such as projects) or **active data processes** (such as pipelines) based on metadata like **data classifications** and **sensitive information types (SITs)**. When a match is found, an assessment is assigned without requiring manual input.

## How privacy rules work

Privacy rules function as automated triggers that monitor your data estate and determine whether an assessment is needed. They help organizations:

- **Ensure assessments are assigned promptly** when personal or sensitive data is detected.
- **Reduce manual workload** for privacy teams by automatically identifying assets that require evaluation.
- **Maintain consistency** by applying structured rules across business assets and processes.

There are two main types of privacy rules:

- **Business asset evaluation**: Assigns assessments based on data associated with business assets, such as projects or business processes.
- **Active process identification**: Identifies ongoing data processing activities, such as data pipelines, and assigns assessments based on their data classification or SITs.

## Privacy rule components

Each privacy rule consists of three key parts:

- **Purpose**: Defines whether the rule applies to business assets or active data processes.
- **Target**: Identifies the type of asset or process that will be evaluated.
- **Conditions**: Specifies the criteria that determine when an assessment is assigned.

## Creating a privacy rule

Privacy rules are configured in **Privacy Assessments** and can be customized to align with your organization's data governance framework.

To create a rule:

1. Navigate to the **Privacy rules** page and select **New**.
1. Enter a name and description to define the rule's purpose.
1. Define the rule's purpose:
   - Select **Identify business uses of personal or sensitive data that require assessment** to assign assessments based on business assets.
   - Select **Identify active processes across your data estate that use personal or sensitive data** to assign assessments based on active data processing.

### Selecting the type of asset or process

- If evaluating **business assets**, select the type of asset to monitor. Custom asset types appear alongside Microsoft Purview defaults.
- If evaluating **active processes**, choose between:
  - All active data processes
  - **Azure Data Factory processes only** (for pipeline-based data movement)

> [!NOTE]
> Privacy rules can only apply to one asset type at a time. To evaluate multiple asset types, create separate rules.

### Defining rule conditions

Conditions determine when a privacy rule applies. These can be based on:

- **Data classifications**: Matches known data classifications in an asset.
- **Sensitive information types (SITs)**: Identifies specific types of sensitive data.
- **Attributes**: Uses metadata fields like asset name, description, or custom attributes.
- **Managed attributes**: Incorporates custom attributes defined by your organization.

Privacy rules can be structured to apply when all conditions or any condition is met. Conditions can also be refined by scope:

- **Includes**: Applies to all relevant data.
- **Processes only as input**: Only evaluates data being ingested.
- **Processes only as output**: Evaluates data being written or exported.

This example shows the interface for defining conditions in a privacy rule. Here, you can specify the condition type, scope, and operator to refine when an assessment is assigned.

:::image type="content" source="../media/create-privacy-rule.png" alt-text="Screenshot of the Create privacy rule interface, showing how to define conditions for rule evaluation." lightbox="../media/create-privacy-rule.png":::

After defining conditions, select an assessment to assign when conditions are met.

## Running and validating privacy rules

Once configured, privacy rules can be activated immediately or saved as a draft for review.

- **Create and activate rule**: The rule runs automatically, assigning assessments as conditions are met.
- **Create as draft and run impact assessment**: The rule remains inactive while generating a preview of its impact.

## Viewing impact history

For draft rules, the **Impact History** tab provides insights into how many assets met rule conditions. This allows privacy teams to review potential assignments before activating a rule.

### Reviewing rule impact estimation

The **Rule impact estimation** pane provides a detailed breakdown of how many business activities match rule conditions. This helps validate that the rule is correctly configured before assessments are assigned.

To review impact estimation:

1. Navigate to Privacy rules and select a draft rule.
1. Open the **Impact History** tab.
1. Review the **Results** column to see how many business activities met the rule's conditions.
1. Select **See results** to open the **Rule impact estimation** pane.

The **Rule impact estimation** pane shows:

- The number of impacted business activities that will receive assessments if the rule is activated.
- A breakdown of in-scope and out-of-scope activities based on rule conditions.
- A historical log of rule runs, including scheduled and on-demand executions.

The example screenshot shows one impacted business activity, meaning it will receive an assessment if the rule is turned on.

:::image type="content" source="../media/rule-impact-estimation.png" alt-text="Screenshot of the Rule impact estimation pane, showing a breakdown of impacted business activities." lightbox="../media/rule-impact-estimation.png":::

If the estimation results don't match expectations, edit the rule’s conditions to refine its scope before activation.

> [!NOTE]
> Draft rules don't assign assessments until they're activated.

### Verifying assigned assessments

To confirm that a rule is working as expected:

1. Open **Assessment management** and select the **Assets** tab.
1. Choose an asset and navigate to its **Privacy** page.
1. Verify that the expected assessment appears.

If an assessment is missing, review the rule's conditions and asset relationships to ensure proper configuration.

> [!TIP]
> Privacy rules run on a schedule. If an assessment doesn't appear immediately, check back later.

Privacy rules help organizations maintain structured and automated privacy assessments across their data estate. By defining clear criteria, organizations can ensure that assessments are assigned efficiently, reducing manual oversight and improving compliance tracking. Once configured, privacy teams can rely on privacy rules to provide continuous oversight of personal and sensitive data usage.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
