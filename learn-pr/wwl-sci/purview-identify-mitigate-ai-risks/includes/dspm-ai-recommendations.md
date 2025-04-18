Microsoft Purview Data Security Posture Management (DSPM) for AI includes a set of AI security recommendations to help reduce the risk of sensitive data exposure and ensure responsible AI use. These recommendations help you apply protections through solutions like data loss prevention (DLP), sensitivity labels, Insider Risk Management, and Communication Compliance.

Some recommendations can be applied automatically using one-click policies, while others require manual configuration across Purview solutions.

## About AI security recommendations

When you enable DSPM for AI, the **Recommendations** page in the Microsoft Purview portal surfaces AI security risks related to interactions with Microsoft 365 Copilot, enterprise AI tools (like ChatGPT Enterprise), and other AI applications. These risks are grouped into categories like:

- **Data security**: Prevent oversharing, apply labels, and enforce protective actions

- **Data discovery**: Detect where sensitive information is used in AI tools

- **AI regulations**: Help align AI usage with regulatory requirements

- **Insight into communications**: Detect inappropriate or risky prompts and responses

Each recommendation includes either:

- A **preconfigured one-click policy** that can be activated immediately

- A **set of guided steps** for manually creating a policy in another Microsoft Purview solution

When a one-click policy is activated, the resulting policy appears in the **Policies** tab of the Microsoft Purview portal.

> [!NOTE]
> One-click policies currently don't support administrative units. Even if you're scoped to a specific administrative unit, a created policy applies to all users.

## One-click policy recommendations

These recommendations create and configure policies automatically when selected in the Recommendations page:

| Recommendation | Description | Solution area |
|-----|-----|-----|
| **Fortify your data security** | Creates a DLP policy using Adaptive Protection. High-risk users are warned before pasting or uploading sensitive data to AI sites. | Data Loss Prevention |
| **Protect your data with sensitivity labels** | Sets up default sensitivity labels and policies to protect data in prompts and responses. Includes autolabeling and publishing policies. | Information Protection |
| **Detect risky interactions in AI apps (preview)** | Creates an Insider Risk Management policy to detect prompts or responses that might indicate risky user behavior. | Insider Risk Management |
| **Control unethical behavior in AI** | Creates a Communication Compliance policy to flag unethical or inappropriate AI-generated content. | Communication Compliance |

Policies created from these recommendations appear in the Policies tab of the Microsoft Purview portal.

## Recommendations that require manual action

These recommendations guide you through configuration steps but don't create policies automatically:

| Recommendation | Description | Solution area |
|-----|-----|-----|
| **Protect sensitive data referenced in Microsoft 365 Copilot (preview)** | Provides instructions for creating a custom DLP policy to prevent Copilot from using labeled content. | Data Loss Prevention |
| **Protect your data from potential oversharing risks** | Opens the default weekly data assessment to help identify unlabeled or overshared content. | DSPM for AI|
| **Guided assistance to AI regulations** | Offers a checklist of recommended policy configurations across Audit, Communication Compliance, DLP, and retention settings. | Multi-solution (Audit, DLP, Communication Compliance, Data Lifecycle Management) |
| **Discover and govern interactions with ChatGPT Enterprise AI (preview)** | Requires registering a ChatGPT Enterprise workspace and configuring a data connector in Purview. | Data Map and Scanning |
| **Use Copilot to improve your data security posture (preview)** | Requires Security Copilot permissions and manual use of prompts to analyze security alerts and behavior. | Security Copilot |
| **Protect sensitive data referenced in Copilot responses** | Guides you to run a manual data assessment to identify unlabeled or overshared content. | DSPM for AI |

## What to expect after activating a policy

Activated policies begin analyzing activity or applying controls based on the configuration for each solution. For example:

- DLP policies created from DSPM for AI recommendations start in **simulation mode**, where enforcement actions aren't applied, but results are logged for review.
- Insider Risk Management policies generate alerts based on user behavior signals.
- Communication Compliance policies flag content for review based on detected policy violations.
- Data assessments identify oversharing risks and surface them in reports.

You can review policy results in **Activity Explorer**, the **Policies** tab, or directly in the related Microsoft Purview solution area.
