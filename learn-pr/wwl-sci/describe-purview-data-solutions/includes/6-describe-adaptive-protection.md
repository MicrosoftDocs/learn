

Adaptive protection in Microsoft Purview uses machine learning (ML) to identify the most critical risks and proactively and dynamically apply protection controls from:

- Microsoft Purview Data Loss Prevention (DLP)
- Microsoft Purview Data Lifecycle Management
- Microsoft Entra Conditional Access

Integration with these three control surfaces helps organizations automate their response to insider risks and reduce the time required to identify and remediate potential threats. Adaptive protection applies the right level of protection to each user based on their current risk level—blocking high-risk activities for users who demonstrate risky behavior, while allowing low-risk users to remain productive.

Adaptive protection helps mitigate potential risks by using:

- **Context-aware detection**: Identifies the most critical risks with ML-driven analysis of both content and user activities.
- **Dynamic controls**: Enforces effective controls on high-risk users while others maintain productivity.
- **Automated mitigation**: Minimizes the impact of potential data security incidents and reduces admin overhead.

:::image type="content" source="../media/purview-adaptive-protection-white-background.png" lightbox="../media/purview-adaptive-protection-white-background.png" alt-text="An diagram illustrating how adaptive protection in Microsoft Purview integrates with Microsoft Purview DLP, Microsoft Purview Data Lifecycle Management, and Microsoft Entra Conditional Access.":::

## Insider risk levels

At the center of adaptive protection are insider risk levels, which are calculated by Insider Risk Management based on each user's behavior and the risk indicators defined in the organization's policies. Adaptive protection uses three risk levels:

- **Elevated risk level**: Assigned to users with high severity alerts or users with multiple high-severity activity sequences. The strongest protective controls apply to users at this level.
- **Moderate risk level**: Assigned to users with medium severity alerts or users with multiple high-severity data exfiltration activities. Moderate controls help balance security with productivity.
- **Minor risk level**: Assigned to users with low severity alerts or users with at least one high-severity exfiltration activity. Light controls such as policy tips and educational reminders apply to influence positive behavior without disrupting work.

Insider risk levels update continuously and automatically based on users' ongoing activity. When a user's risk level decreases, the protective controls applied to them also relax. When risk increases, controls tighten automatically—without any manual action from an admin.

## Adaptive protection in Data Loss Prevention

When Insider Risk Management identifies a user as high-risk, adaptive protection dynamically assigns DLP policies to that user based on their current risk level. Organizations don't need to maintain separate, static DLP policies for every possible risk scenario—instead, the right policy applies automatically as risk levels change.

For example, an organization might configure adaptive protection so that:

- Users with a **Minor risk level** receive a policy tip that educates them about best practices for handling sensitive data.
- Users with a **Moderate risk level** receive a warning and are required to justify any action that would share or export sensitive information.
- Users with an **Elevated risk level** are blocked from saving or sharing sensitive data outside the organization.

As a user's insider risk level changes in Insider Risk Management, the DLP policy applied to them adjusts automatically.

## Adaptive protection in Data Lifecycle Management

For users identified as high-risk, adaptive protection can also apply controls through Microsoft Purview Data Lifecycle Management. When a user is assigned an Elevated risk level, a retention label policy automatically preserves any content that user deletes from SharePoint, OneDrive, or Exchange Online for 120 days. This preservation is automatic—if a high-risk user attempts to delete evidence of their activity, that content is retained and remains available for investigation.

## Adaptive protection in Conditional Access

Adaptive protection integrates with Microsoft Entra Conditional Access to restrict application access based on insider risk levels. Organizations configure Conditional Access policies that respond automatically to a user's current risk level. For example:

- Users with a **Minor risk level** might be required to acknowledge a Terms of Use agreement before accessing certain applications.
- Users with a **Moderate risk level** might be blocked from accessing specific high-sensitivity applications.
- Users with an **Elevated risk level** might be completely blocked from accessing organizational applications until their risk level is resolved.

Because Conditional Access policies and DLP policies both respond dynamically to the insider risk levels managed by Insider Risk Management, the organization achieves a layered, coordinated response to insider risk—without needing to manually update multiple policies whenever a user's behavior changes.

