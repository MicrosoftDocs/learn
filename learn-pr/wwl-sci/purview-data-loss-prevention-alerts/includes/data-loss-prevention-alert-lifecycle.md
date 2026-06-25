Data loss prevention (DLP) alerts follow a structured path from detection through resolution. Each stage has a specific purpose and a different set of decisions.

## Trigger

A DLP alert starts when a user's action matches a condition in a DLP policy. Policies are typically configured to watch for activity that could lead to data loss, like:

- Sharing sensitive data with people outside the organization
- Downloading confidential files to removable media
- Uploading protected content to unsanctioned cloud apps

When this kind of activity happens, the policy can take actions such as blocking the activity, warning the user, and if configured to do so, generating an alert.

## Notify

If a policy is configured to generate an alert, that alert appears in two places:

- **Microsoft Defender portal**: Where alerts are grouped into incidents along with other security signals
- **Microsoft Purview alerts dashboard**: Where you can track alert history, review alert details, and perform basic actions

Email notifications can also be sent to users, admins, or security teams depending on the policy setup. These notifications let you know something happened that might require a closer look.

In this phase, you can also use Activity explorer to view the details of what happened. If your team uses Microsoft's APIs, you can export activity data for long-term storage or custom reporting.

## Triage

Triage is about reviewing new alerts and deciding what to do next. You decide if the alert is a false positive or something that needs a deeper investigation. If it's valid, you assign it a priority level and designate someone to own the response.

The Microsoft Defender portal groups related alerts into incidents. This gives you a broader view of the user's actions. For example, if a user downloads a file from SharePoint, uploads it to a personal OneDrive, and then shares it externally, those events are grouped into one incident. This makes it easier to focus on what matters.

You can use tags, comments, and filters to manage the incident queue. To focus only on DLP-related alerts, select **Add filter**, choose **Service/detection sources**, and select **Microsoft Data Loss Prevention**.

If your organization shares Insider Risk Management signals with Defender, you can also see the user's insider risk severity level next to their DLP alerts. This helps prioritize which alerts might require immediate action.

Microsoft Security Copilot is also available in some tenants and can help analyze alert context and suggest next steps. This feature is embedded in the [DLP Alerts dashboard](/purview/dlp-alerts-dashboard-get-started?azure-portal=true#investigate-a-dlp-alert) and in [Data Security Posture Management (preview)](/purview/data-security-posture-management-copilot?azure-portal=true#use-microsoft-security-copilot-with-data-security-posture-management-preview).

## Investigate

Once a triage owner is assigned, the next step is to investigate the alert further. This means gathering evidence, reviewing activity logs, and deciding on a remediation plan.

Where you start depends on what you're trying to answer:

- **Start in Microsoft Defender** when you need to see whether the DLP alert is part of a broader pattern. Defender correlates DLP alerts with signals from endpoints, email, identity, and cloud apps, so it's the right place when the user's behavior looks like more than a one-off policy match.
- **Start in the Microsoft Purview alerts dashboard** when you already know which policy fired and want to review the specific match, check the file content, or decide whether the policy needs tuning.
- **Use Activity explorer** when you need to filter and compare user actions over time without opening individual alerts.
- **Use Content explorer** when you need to inspect the actual file or message content that triggered the match.

If your organization has enabled data sharing in Insider Risk Management settings and the user is in scope of an Insider Risk policy, you can also access a **User activity summary** that shows up to 120 days of user behavior, including risky actions like exfiltrating files or bypassing policy warnings.

## Remediate

After investigation, the alert owner decides what actions to take. Remediation options vary based on how your organization handles risk. Some common actions include:

- Marking the alert as informational and taking no action
- Following up with the user to explain why the action was risky
- Blocking file sharing or revoking access
- Removing the file from cloud storage or applying a sensitivity label
- Resetting passwords, disabling accounts, or isolating devices

In Defender, you can take many of these actions directly from the portal, including:

- Remove or quarantine a file
- Revoke sharing permissions
- Disable user accounts
- Reset passwords
- Download or delete emails
- Use Advanced Hunting to look for related events

## Tune

The final step in the alert lifecycle is tuning your DLP policy. Once you respond to the alert, ask whether the policy worked as intended. You might need to adjust:

- The sensitivity level of conditions that trigger an alert
- The scope of the policy (users, locations, or groups)
- Notification settings
- Whether certain low-risk actions should trigger alerts at all

Tuning reduces false positives and improves detection accuracy over time. You can revisit your policy intent and compare it to actual outcomes to decide what changes are needed.
