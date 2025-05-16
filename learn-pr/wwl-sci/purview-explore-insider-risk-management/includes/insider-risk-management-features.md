Microsoft Purview Insider Risk Management provides a suite of tools and features designed to help organizations address insider risks thoughtfully and effectively. Each feature contributes to a structured approach, helping to identify, analyze, and resolve risks while maintaining transparency and respecting privacy.

## Policies

Policies are the backbone of Microsoft Purview Insider Risk Management. They define the types of activities to evaluate, ensuring a targeted and efficient approach to identifying risks.

**How policies work**:

1. **Start with a template**: Use predefined templates to address common risk scenarios, such as data theft or security violations.
1. **Customize conditions**: Adjust criteria like detection timeframes, user groups, and activity types to fit your organization's needs.
1. **Create policies**: Begin receiving alerts based on the defined conditions.
1. **Review and refine**: Use insights from alerts and analytics to update policy criteria and improve accuracy.

Policies ensure that Insider Risk Management focuses on the most relevant risks for your organization. By tailoring conditions and thresholds, administrators can address specific threats while avoiding unnecessary alerts.

## Signals

Insider Risk Management uses signals, which are data points from user activities from Microsoft 365, Microsoft Defender, and other integrated tools to identify activities that might indicate risks. These signals provide the data needed to analyze user actions and determine whether they align with policy criteria.

**Examples of signals include**:

- Unusual file downloads or transfers.
- Patterns of communication that might indicate sensitive information sharing.
- Device-related activities flagged by Microsoft Defender.

Signals, like file downloads or email activity, are combined from tools across Microsoft 365. These help organizations identify risky patterns, such as repeated data transfers, while respecting employee privacy.

## Analytics

Analytics help organizations identify areas of higher user risk before implementing policies. For example, you might discover that departing employees frequently download sensitive files, allowing you to prioritize policies for this group. By identifying potential risks early, analytics can guide the creation or refinement of policies, ensuring that efforts focus on the most impactful areas.

## Dashboards

Microsoft Purview Insider Risk Management offers dashboards that provide a high-level view of risk activities, policies, alerts, and cases.

**Key dashboards**:

- **Alerts dashboard**: Helps reviewers prioritize risks by displaying the severity, status, and type of activities flagged by policies. It highlights critical alerts, enabling quick action on high-priority risks.

   :::image type="content" source="../media/insider-risk-alerts-dashboard.png" alt-text="Screenshot showing the alerts dashboard in Insider Risk Management." lightbox="../media/insider-risk-alerts-dashboard.png":::

- **Cases dashboard**: Tracks investigations with details on progress, timelines, and outcomes. It streamlines case management to support efficient and timely resolution.

Together, these dashboards provide a centralized view of alerts and investigations, helping organizations respond to insider risks quickly and effectively. Investigators can use tools like **Content explorer** and **User activity reports** to dig deeper into flagged activities.

## Investigative tools

When an alert requires further review, Microsoft Purview provides tools to help administrators and investigators understand risky activities in detail. These tools are designed to provide the necessary context for identifying whether an activity truly poses a risk and to support decision-making during investigations.

**Key features for investigations**:

- **User activity reports (preview)**: Allow investigators to view detailed records of a user's actions over a specific time period. For example, these reports can highlight unusual activity such as multiple file downloads in a short timeframe, helping investigators assess whether the behavior aligns with a policy violation.

- **Content explorer**: Displays files, emails, and other data associated with flagged activities. Investigators can review these items to understand the context of an alert, such as whether sensitive information was shared externally.

- **Case notes**: Help investigators document their findings during an investigation. For example, a reviewer might note that a flagged email contained confidential data or that a user accessed sensitive files without proper authorization. These notes ensure consistent tracking and can be shared with team members for collaboration.

Together, these tools ensure investigators have a complete picture of risky activities, from initial alerts to the final resolution of cases.

## Notices and actions

Not every risk requires punitive action. Microsoft Purview includes tools for guiding users toward better practices.

**Tools for addressing risks**:

- **Notice templates**: Send customized messages to users as reminders of compliance policies or as corrective guidance.
- **Integrated escalation**: Serious risks can be escalated to tools like eDiscovery (Premium) for further review.

Notices are often used for minor risks, like accidental data sharing, to remind users of compliance policies. Escalations are reserved for more serious risks requiring legal or compliance team involvement.

## Integrated risk management across Microsoft Purview

Microsoft Purview Insider Risk Management integrates with other tools to create a holistic approach to managing risks.

- **[eDiscovery (Premium)](/purview/ediscovery-overview?azure-portal=true)** enables legal teams to manage investigations involving insider risks.
- **[Microsoft Defender for Endpoint](/defender-endpoint/microsoft-defender-endpoint?azure-portal=true)** contributes alerts about device-related risks.
- **[Communication Compliance](/purview/communication-compliance-solution-overview?azure-portal=true)** helps address risks related to inappropriate messaging behavior.

These integrations allow Insider Risk Management to combine signals from multiple sources, providing a more comprehensive view of risks across your organization.

Microsoft Purview Insider Risk Management provides organizations with the tools they need to detect, investigate, and address insider risks. By using these features, organizations can protect sensitive data, ensure compliance, and build a culture of trust and accountability.
