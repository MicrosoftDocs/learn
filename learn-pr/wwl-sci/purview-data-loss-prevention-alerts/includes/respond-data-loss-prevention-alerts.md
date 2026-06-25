After you've investigated a data loss prevention (DLP) alert, the next step is to respond appropriately. This includes documenting your findings, assigning ownership if needed, taking mitigation actions, and closing out the alert or incident. Microsoft Purview and Microsoft Defender XDR each handle different parts of this process.

## Response actions in Microsoft Purview

In Microsoft Purview, you respond to DLP alerts directly from the **Alerts dashboard**. These alerts are typically scoped to user actions that match a DLP policy.

Key actions include:

- **Set alert status** to track progress, such as Investigating or Resolved
- **Assign the alert** to a reviewer for accountability
- **Add comments** to capture internal notes or observations
- **Share alert details** using a generated read-only link
- **View user activity summary** (if Insider Risk Management is integrated)

Recording this context keeps your audit trail clean and gives the next analyst something to work from.

## Response actions in Microsoft Defender XDR

In Microsoft Defender XDR, alerts are grouped into incidents, giving analysts a broader view of correlated activity across endpoints, email, cloud apps, and identities.

From the incident and alert views, you can:

- **Update the incident status**, assign it to a team member, and add notes
- **Apply classifications** like **True Positive** or **False Positive** and specify a reason
- **Take remediation actions** directly, such as:
  - Disabling a user account
  - Removing file access
  - Applying a sensitivity or retention label

You can also **correlate the DLP alert** with other security signals to determine whether it's part of a larger threat or an isolated incident.

## Handle false positives

Sometimes an alert fires on legitimate activity. A finance team shares masked account numbers with an authorized vendor, or a test environment triggers a production policy. When that happens, close the alert with the right classification so your queue stays useful and your reporting reflects actual risk.

In **Microsoft Defender XDR**, classify the incident as **False Positive** and select a reason, such as _Inaccurate alert_ or _Security testing_. That classification shows up in Defender reporting, so you can track how much noise a policy generates over time.

In **Microsoft Purview**, set the alert status to **Resolved** and add a comment explaining why it was a false positive. Purview doesn't have a separate classification field, so the comment is where you document the rationale for the next person who looks at this alert.

If the same legitimate activity keeps triggering alerts, adjust the policy conditions, add an exception, or narrow the scope. The goal is to prevent the next analyst from spending time on the same determination you already made.

## What happens when you resolve an alert

Setting an alert or incident to **Resolved** closes it, but doesn't suppress future alerts from the same activity. If the same user does the same thing again and it still matches the policy, a new alert appears. Resolve means "I've handled this one," not "stop alerting on this pattern."

Resolved incidents stay visible in Defender for up to six months. You can filter for them when reviewing historical patterns or auditing past decisions. In Purview, resolved alerts remain visible based on your organization's audit log retention settings.
