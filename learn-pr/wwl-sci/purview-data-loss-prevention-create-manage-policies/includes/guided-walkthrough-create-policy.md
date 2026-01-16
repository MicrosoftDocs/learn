This walkthrough shows how to create a Data Loss Prevention policy in the Microsoft Purview portal and highlights the key decisions that shape how the policy behaves.

The example uses a file-based scenario to illustrate how detection, scope, and actions are configured. While the exact options vary by location, the overall policy creation flow remains consistent.

## Scenario

An organization stores sensitive business documents in Microsoft 365 and collaborates internally on a regular basis. In some cases, these files are shared outside the organization for legitimate reasons.

The security team wants visibility into risky sharing activity before enforcing restrictions. The goal is to reduce accidental data exposure without disrupting normal work.

### Start a new DLP policy

Begin by navigating to the Data Loss Prevention area in the Microsoft Purview portal.

1. Sign in to the Microsoft Purview portal.
1. From **Solutions**, select **Data Loss Prevention**.
1. Open **Policies**, then select **Create policy**.

:::image type="content" source="../media/select-create-policy.png" alt-text="Screenshot of the Data Loss Prevention Policies page in Microsoft Purview showing the Create policy option." lightbox="../media/select-create-policy.png":::

This brings you into the policy creation flow where configuration decisions begin.

### Choose the policy type

When prompted to select the type of policy to create, choose **Enterprise applications and devices**.

1. Select **Enterprise applications and devices** to continue.

**Decision point**
Choose the policy type that matches where enforcement should occur.

**Why this matters**
The policy type determines which locations, conditions, and actions are available later in the setup process. Policies for enterprise applications and devices are used to protect Microsoft 365 data and support content-based detection and user-focused actions.

Other policy types follow different configuration paths and are designed for different scenarios.

### Choose how to start the policy

After selecting the policy type, choose how the policy will be created.

1. Choose to create a **custom policy**.

**Decision point**
Decide whether to start from a template or define the policy manually.

**Why this matters**
Templates provide predefined assumptions for common scenarios. A custom policy allows full control over detection logic, scope, and actions, which is useful when policies need to reflect specific workflows or risk tolerance.

### Name the policy and continue

Provide a name and optional description for the policy, then continue through the setup pages.

These details help identify the policy later but do not affect how it behaves.

### Define where the policy applies

Select the location where the policy should evaluate activity.

1. Choose the location that matches where the sensitive data is stored or shared.
2. Deselect any locations that are not relevant to the scenario.

**Decision point**
Policy location.

**Why this matters**
Location determines which content is evaluated and which conditions and actions are available. Selecting only relevant locations reduces noise and avoids applying enforcement where it is not needed.

### Define what the policy detects

Configure the conditions that determine when the policy is triggered.

1. Choose to create or customize advanced DLP rules.
2. Define detection using classification signals, such as sensitivity labels or sensitive information types.
3. Add contextual conditions to focus on risky activity, such as external sharing.

**Decision point**
Detection logic.

**Why this matters**
Effective DLP detection combines what the data is with how it is being used. Using both classification and context improves accuracy and reduces false positives.

### Choose how the policy responds

Define what happens when the policy conditions are met.

1. Configure actions that guide or restrict user behavior.
2. Decide whether users receive notifications.
3. Decide whether users can override the policy and under what conditions.

**Decision point**
Policy actions.

**Why this matters**
Actions determine the user experience. Starting with guidance or warnings allows the organization to understand behavior patterns before introducing stricter enforcement.

### Validate the policy using simulation mode

Before enforcing the policy, validate how it behaves.

1. Run the policy in **simulation mode**.
2. Review the results after activity is evaluated.

**Decision point**
Simulation versus enforcement.

**Why this matters**
Simulation mode evaluates policy logic without disrupting users. It provides insight into how often the policy would trigger and whether the conditions align with real-world behavior.

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
- Legitimate workflows are not disrupted
- User guidance is clear and actionable

At this point, enforcement can be introduced gradually based on confidence and risk tolerance.

## Summary

This walkthrough demonstrated how to create a DLP policy and highlighted where key design decisions appear in the Microsoft Purview portal.

By understanding how policy type, location, detection, actions, and simulation mode work together, administrators can create DLP policies that reduce risk while supporting normal business activity.
