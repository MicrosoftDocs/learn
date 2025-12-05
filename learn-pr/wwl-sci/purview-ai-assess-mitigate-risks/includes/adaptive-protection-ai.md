As organizations adopt generative AI tools, traditional security policies might not provide enough flexibility to manage evolving risks. Microsoft Purview Adaptive Protection helps address this challenge by adjusting data loss prevention (DLP) policy enforcement based on user risk signals. These signals can come from browsing behavior or how users handle data in AI environments. This dynamic approach helps protect sensitive information without blocking productivity across the organization.

The next example shows how a financial technology company uses Adaptive Protection to safeguard sensitive data while enabling responsible use of AI tools.

## Learning objectives

In this example, you'll learn how to:

- Use Adaptive Protection to manage data security risks related to AI tool usage.
- Link insider risk policies and DLP policies through dynamic user risk levels.
- Configure protections that block or restrict risky actions based on those levels.

## Example: Protecting financial data in generative AI tools

Contoso, a financial software company, uses external generative AI tools in both R&D and marketing workflows. These tools support productivity, but they also raise risks, including:

- Sharing of sensitive financial data
- Exposure of proprietary algorithms
- Disclosure of confidential product information

To manage these risks, Contoso uses Adaptive Protection to adjust DLP enforcement based on each user's behavior. This example walks through how they configure Microsoft Purview to support that goal.

## Step 1: Create an insider risk policy for browsing behavior

Contoso begins by creating an insider risk policy using the **Risky browser usage (preview)** template. The policy includes the **browsed to generative AI websites** indicator to detect access to external AI tools.

:::image type="content" source="../media/risky-browser-usage-template.png" alt-text="Screenshot shows the Choose a policy template screen in the Insider Risk Management policy template wizard." lightbox="../media/risky-browser-usage-template.png":::

This policy helps Contoso identify users who interact with external AI sites while working with sensitive data. They name the policy **AI Browsing Detection**, making it easier to track and reference when configuring Adaptive Protection.

## Step 2: Assign adaptive risk levels

Next, Contoso configures risk levels for Adaptive Protection. They associate both their existing Data leaks policy and the new AI Browsing Detection policy with Adaptive Protection to support dynamic risk scoring based on a broader range of activities.

- **Elevated**: Assigned when high-severity events like confirmed data sharing occur
- **Moderate**: Used for irregular but less severe activities
- **Minor**: Assigned for low-level but notable behaviors

Contoso chooses to assign risk levels based on user activity, allowing them to focus on specific signals related to AI usage.

:::image type="content" source="../media/custom-risk-levels-adaptive-protection.png" alt-text="Screenshot shows the Custom risk levels menu in Adaptive Protection." lightbox="../media/custom-risk-levels-adaptive-protection.png":::

## Step 3: Create a DLP policy with risk-based actions

Contoso uses the **Fortify your data security** recommendation in **DSPM for AI** to simplify deployment. This recommendation creates a prebuilt DLP policy named **DSPM for AI - Block sensitive info from AI sites** designed to work with Adaptive Protection.

**The policy**:

- Targets **elevated risk users** identified through insider risk management
- **Blocks pasting and uploading** of sensitive content to AI tools in Microsoft Edge, Chrome, and Firefox
- Uses a **block with override** action to give users a chance to justify the action
- Starts in **simulation mode** to evaluate potential matches before enforcement

Contoso reviews the policy configuration and simulation results to confirm accuracy. They enable the option to automatically turn the policy on after 15 days if no changes are made, ensuring it doesn't remain inactive indefinitely.

This approach gives Contoso a fast way to put protections in place while still allowing time for validation and adjustment.

## Step 4: Enable Adaptive Protection

To complete setup, Contoso enables Adaptive Protection in the Microsoft Purview portal. This activates the dynamic protections they configured.

:::image type="content" source="../media/enable-adaptive-protection.png" alt-text="Screenshot shows Adaptive Protection enabled." lightbox="../media/enable-adaptive-protection.png":::

Once enabled:

- Insider Risk Management policies assign risk levels based on activity
- Adaptive Protection updates risk levels and tracks users in scope
- DLP policies apply different enforcement rules based on each user's risk level

This connection ensures that users with higher risk scores face stricter safeguards when interacting with sensitive data, while lower-risk users can work with fewer restrictions.

This configuration helps Contoso manage AI-related data risks while allowing their teams to continue using tools that support productivity and innovation.
