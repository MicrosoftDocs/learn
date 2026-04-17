This walkthrough shows how to create a Data Loss Prevention policy in the Microsoft Purview portal and highlights the key decisions that shape how the policy behaves.

The example uses a file-based scenario to illustrate how detection, scope, and actions are configured. While the exact options vary by location, the overall policy creation flow remains consistent.

## Scenario

An organization stores sensitive business documents in Microsoft 365 and collaborates internally on a regular basis. In some cases, these files are shared outside the organization for legitimate reasons.

The security team wants visibility into risky sharing activity before enforcing restrictions. The goal is to reduce accidental data exposure without disrupting normal work.

### Before creating or managing DLP policies

Creating and managing data loss prevention (DLP) policies depends on having the appropriate Microsoft Purview roles assigned. Role assignment affects which policy options are visible, who can review simulation results and alerts, and who can change enforcement behavior or policy priority. Confirming roles up front helps avoid confusion during policy creation and clarifies administrative responsibilities.

**DLP administration requires one of these roles:**

- **Compliance Administrator**, which provides full administrative access to create, configure, enforce, and manage DLP policies across supported locations
- **Compliance Data Administrator**, which provides the ability to create and manage DLP policies and review policy results without broader compliance administration permissions

These roles are required to create, edit, and enforce DLP policies. They also allow administrators to review simulation results and alerts, and to manage policy mode, enforcement behavior, and policy priority.

Once the appropriate roles are assigned, policy creation and management decisions can be made consistently in the Microsoft Purview portal.

### Start a new data loss prevention (DLP) policy

Start by creating a new Data Loss Prevention policy in the Microsoft Purview portal.

1. Sign in to the Microsoft Purview portal.
1. From **Solutions**, select **Data Loss Prevention**.
1. Open **Policies**, then select **Create policy**.

   :::image type="content" source="../media/select-create-policy.png" alt-text="Screenshot of the Data Loss Prevention Policies page in Microsoft Purview showing the Create policy option." lightbox="../media/select-create-policy.png":::

This brings you into the policy creation flow, where configuration decisions are made step by step.

### Choose the policy type

Select the policy type that applies to data stored and shared across Microsoft 365.

- Select **Enterprise applications and devices** to continue.

   :::image type="content" source="../media/select-enterprise-apps.png" alt-text="Screenshot of the policy type selection page in Microsoft Purview showing Enterprise applications and devices selected." lightbox="../media/select-enterprise-apps.png":::

**Decision:** Choose the policy type that matches where enforcement should occur. The policy type determines which locations, conditions, and actions are available later in the setup process. Policies for enterprise applications and devices are used to protect Microsoft 365 data and support content-based detection and user-focused actions.

Other policy types follow different configuration paths and are designed for different scenarios.

### Choose how to start the policy

Decide whether to base the policy on a predefined template or define the behavior manually.

- Choose to create a **custom policy**.

   :::image type="content" source="../media/select-custom-policy.png" alt-text="Screenshot of the policy template selection page in Microsoft Purview showing the Custom policy option." lightbox="../media/select-custom-policy.png":::

**Decision:** Template or custom policy.
Templates provide predefined assumptions for common scenarios. A custom policy allows full control over detection logic, scope, and actions, which is useful when policies need to reflect specific workflows or risk tolerance.

### Name the policy and continue

Give the policy a name that clearly reflects its purpose and makes it easy to identify later. These details help distinguish the policy but don't affect how it behaves.

### Define where the policy applies

Define where the policy should evaluate activity based on where sensitive files are stored and shared.

1. Choose the location that matches where the sensitive data is stored or shared.
1. Deselect any locations that aren't relevant to the scenario.

   The image shows the location selection page. Select the image to view the locations used in this scenario.

   :::image type="content" source="../media/policy-locations.png" alt-text="Screenshot of the DLP location selection page in Microsoft Purview with several Microsoft 365 locations selected." lightbox="../media/policy-locations-selected.png":::

**Decision:** Policy scope by location. Location determines which content is evaluated and which conditions and actions are available. Selecting only relevant locations reduces noise and avoids applying enforcement where it isn't needed.

Rules are where detection logic and response behavior come together.

### Create a DLP rule

Rules define when the policy triggers and how it responds. For a custom policy, at least one rule is required. Without a rule, the policy doesn't evaluate activity or take action.

Open the advanced rule editor to define detection logic and response behavior.

#### Name the rule

Provide a name and optional description for the rule.

The rule name helps identify the specific scenario being evaluated, especially when a policy contains multiple rules. The name doesn't affect detection or enforcement.

#### Define detection logic

Configure the conditions that determine when the rule is triggered.

Detection typically combines:

- **Classification signals**, such as sensitive information types or sensitivity labels
- **Contextual conditions**, such as how content is shared or who it's shared with

For this scenario, detection focuses on identifying sensitive files and narrowing evaluation to risky sharing activity, such as sharing outside the organization.

**Decision:** Detection signals and context.
Using classification alone can generate noise. Adding context helps focus enforcement on higher-risk activity and improves accuracy.

#### Configure policy actions

Define what happens when the rule conditions are met.

Actions can guide users, restrict activity, or both. Common actions include showing policy tips, restricting sharing, or blocking access.

For this scenario, actions are configured to surface visibility into risky behavior before enforcing hard restrictions.

**Decision:** How the policy responds.
Actions shape the user experience. Starting with guidance allows the organization to understand behavior patterns before introducing stricter enforcement.

#### Configure user notifications and overrides

Choose whether users are notified when the rule is triggered and whether they can override restrictions.

Notifications help users understand why an action occurred. Overrides allow work to continue in legitimate scenarios while capturing justification.

**Decision:** User flexibility and accountability.
Overrides balance protection with productivity. Requiring justification helps reduce misuse while preserving flexibility.

#### Configure incident reporting

Specify how rule matches appear in alerts and reports.

Incident settings control administrative visibility and reporting. These settings don't change detection or enforcement behavior.

### Rule configuration reference

The rule editor groups related decisions into sections. The tabs show where detection, actions, and user experience are defined during rule creation.

#### [Rule name and conditions](#tab/name-conditions)

This section defines what the rule detects and when it triggers.

:::image type="content" source="../media/names-conditions.png" alt-text="Screenshot of the Create rule page in Microsoft Purview showing the rule name, description, and content conditions." lightbox="../media/names-conditions.png":::

#### [Actions](#tab/actions)

This section determines how the policy responds when the rule conditions are met.

:::image type="content" source="../media/actions.png" alt-text="Screenshot of the Actions section in the Create rule page in Microsoft Purview showing restrict access options with external users blocked." lightbox="../media/actions.png":::

#### [Notifications and reporting](#tab/notifications-reporting)

This section controls user guidance and how rule activity is surfaced to administrators.

:::image type="content" source="../media/notifications-reports.png" alt-text="Screenshot of the Create rule page in Microsoft Purview showing user notifications, overrides, incident reporting settings, and the Save button." lightbox="../media/notifications-reports.png":::

---

### Choose the policy mode

Decide how the policy should run after it's created.

- Select **Run the policy in simulation mode**.

Simulation mode evaluates activity using the policy conditions without enforcing restrictions. It allows you to understand how the policy behaves and identify potential noise before enabling enforcement.

Leave **Show policy tips while in simulation mode** selected so users can see guidance without being blocked.

You can change the policy mode later after reviewing results.

:::image type="content" source="../media/policy-mode-selection.png" alt-text="Screenshot of the Policy mode page in Microsoft Purview showing simulation mode selected with policy tips enabled." lightbox="../media/policy-mode-selection.png":::

### Review and finish the policy

Review the policy configuration before creating it.

This page summarizes the key decisions made during setup, including the policy type, locations, rules, and policy mode.

1. Review the policy name and description.
1. Confirm the locations where the policy applies.
1. Verify the rule and policy mode settings.
1. Select **Submit** to create the policy.

This step acts as a final checkpoint. If anything doesn't align with the intended behavior, you can return to earlier pages to make adjustments.

Once submitted, the policy is created using the selected mode and begins evaluating activity based on the configuration.

:::image type="content" source="../media/review-finish.png" alt-text="Screenshot of the Review and finish page in Microsoft Purview showing policy details, selected locations, rule settings, and the Submit button." lightbox="../media/review-finish.png":::

### Validate the policy using simulation mode

Before enforcing the policy, validate how it behaves.

- Run the policy in **simulation mode**.
- Review results after activity is evaluated.

**Decision:** Simulation versus enforcement.  
Simulation mode evaluates policy logic without disrupting users and helps confirm whether conditions align with real-world behavior.

### Refine the policy if needed

Use simulation results to adjust the policy.

Common refinements include:

- Narrowing or expanding scope
- Adjusting detection conditions
- Revisiting actions or notifications

After making changes, rerun the policy in simulation mode to confirm improvements.

### Prepare the policy for enforcement

A policy is ready to move toward enforcement when:

- Triggers align with expected risk scenarios
- Legitimate workflows aren't disrupted
- User guidance is clear and actionable

At that point, enforcement can be introduced gradually based on confidence and risk tolerance.

## Summary

This walkthrough demonstrated how to create a DLP policy and showed where key design decisions appear in the Microsoft Purview portal.

Understanding how policy type, location, detection, actions, and simulation mode work together helps ensure policies are validated before enforcement and aligned with real-world behavior.

---

## Additional scenarios

This walkthrough uses a file-sharing scenario to illustrate how DLP policy decisions come together during creation.

The same decision process applies to other locations and data types. Microsoft documentation includes guided scenarios that show how these concepts translate to email, SharePoint, OneDrive, and other common risk patterns.

These scenarios apply the same policy decision patterns in different contexts:

- [Create and deploy data loss prevention policies](/purview/dlp-create-deploy-policy?azure-portal=true)
- [Help prevent sharing sensitive items via SharePoint and OneDrive with external users](/purview/dlp-create-policy-spo-odb-external?azure-portal=true)
- [Help prevent sharing credit card numbers through email](/purview/dlp-create-policy-cc-email?azure-portal=true)
