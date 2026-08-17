Privacy Risk Management alerts flag when a policy matches something in your environment. Whether that match is a real risk, what to do about it, and who acts on it are decisions that happen after the alert fires. For the healthcare team from the scenario, the job is to separate an actual overexposure of medical histories from a legitimate clinical workflow that just looks like one. The work in this unit is what happens between a policy match and a change in the content's state.

## From alert to issue

The **Alerts** page in the [Microsoft Priva portal](https://purview.microsoft.com/priva?azure-portal=true) is where every policy-generated alert lands. Each alert names the triggering conditions, the matched items, and a severity so an admin can size the risk before opening it. For Data transfer policies with Teams tips turned on, an alert can arrive with a business justification the user typed in when they overrode the tip. Reading that justification first often saves triage time because it names the reason the user gave for the transfer.

From an alert's detail page, an admin either dismisses it or escalates it into an issue:

- **Dismiss the alert** when nothing needs follow-up. A dismissed alert leaves the active list without becoming an issue. Use this option when the content is already remediated, or when the source policy is too broad and needs tuning.
- **Create an issue** when the alert is worth a structured investigation. Naming the issue and adding a comment at creation time gives whoever picks it up the context to start working.

To move an alert forward:

1. On the **Alerts** page, select an alert name to open its details.
1. Review the **Content** tab to see what triggered the alert: the data types, the file locations, and the user actions involved.
1. Based on that review, select **Create issue** or dismiss the alert.

## When alerts stack up

Alert volume can outpace a team when a policy is too broad or fires an alert on every match. It can also spike after an organizational change like a new department, a project between regions, or updated collaboration settings. Before working alerts individually, check the **Active alerts over time** card on the Reports page. A spike traceable to a single policy is usually a tuning problem, and Microsoft's docs recommend the condition-based frequency option to keep volume manageable in that case. A spike spread across multiple policies usually points to a real event worth investigating. Alerts carry the severity from their triggering policy, so on the Alerts page you can work the highest-severity items first.

## Work an issue

Once an alert becomes an issue, the work moves to the **Issues** page. An issue holds the related alerts, the content in question, the notes your team leaves as they work, and the record of what got done. The Issues page groups issues by severity, so you can triage the highest risk first.

Each issue's details page uses tabs that match the parts of an investigation:

- **Overview**: current status, recommended actions, the policy that generated the issue, and a content timeline.
- **Alerts**: every alert rolled into this issue.
- **Content**: the files and messages involved, with filters and per-item remediation actions.
- **Notes**: shared context for the team working the issue.
- **Collaborators**: the people assigned to work it.

## Act on the content

The point of investigation is to decide what happens to the content. The **Content** tab is where those decisions get made. From it, admins take one of these actions on the items involved:

- **Notify owner**: tell the content owner about the risk so they can respond.
- **Make private**: restrict access to overexposed content.
- **[Apply sensitivity label](/purview/sensitivity-labels?azure-portal=true)**: mark the content's sensitivity and apply the protection tied to that label, like encryption or visual markings.
- **[Apply retention label](/purview/retention?azure-portal=true)**: attach a label that governs how long to keep the content and when to delete it.
- **Mark as not a match**: exclude the item from future evaluation when the alert was a false positive.

When the actions are complete, close the issue by selecting **Resolve** and adding a final comment so the resolution is on the record.

Before closing, check that the content's state changed. If the alert was a false positive, tune the policy so the same signal doesn't come back next week.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
