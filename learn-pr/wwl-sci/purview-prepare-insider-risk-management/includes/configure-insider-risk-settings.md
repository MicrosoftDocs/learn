Microsoft Purview Insider Risk Management enables organizations to identify and mitigate internal risks by detecting potentially harmful activities. Settings are a foundational part of this solution, defining how risks are detected, scored, and managed across your organization. Understanding these settings and how they work ensures your policies align with organizational needs while reducing unnecessary alerts and noise.

## How Insider Risk Management settings work

Insider Risk Management settings operate globally, affecting all policies regardless of the template you choose. These settings allow you to:

- Customize how user activities are analyzed and scored.
- Prioritize evaluating activities for specific users or groups.
- Ensure compliance with privacy and data handling requirements.
- Reduce false positives by refining detection criteria.

By tailoring these settings, you can focus on the risks most relevant to your organization while maintaining operational efficiency.

## Understand Insider Risk Management settings

Insider Risk Management settings provide configurable tools to align policies with your organization's unique compliance and security needs. These settings apply globally across all policies and help fine-tune detection, scoring, and alerting mechanisms.

To access and configure these settings:

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true).
1. Select **Settings** > **Insider Risk Management**.
1. Select the setting category you want to configure.

### Privacy

Choose whether usernames in alerts and cases are anonymized or displayed. Anonymizing usernames can help organizations maintain employee privacy during investigations.

### Policy indicators

Enable and adjust indicators that track activities such as downloading sensitive files or forwarding emails. Configuring thresholds for these indicators ensures that alerts reflect the organization's risk tolerance.

### Detection groups

Create detection groups to apply specific thresholds or criteria to different sets of users. For example, you can assign more tailored thresholds for users in high-risk roles, like IT admins or executives.

### Global exclusions (preview)

Exclude specific users, groups, or activities from being included in policy detections. For instance, service accounts or routine administrative tasks can be excluded to reduce unnecessary alerts.

### Policy timeframes

Define the time period for which activities are reviewed when a policy is triggered. This setting allows organizations to focus on relevant activity periods, such as the 30 days following a policy violation.

### Intelligent detections

Use intelligent detections to identify unusual activities, adjust alert volumes, and incorporate alerts from external tools like Microsoft Defender for Endpoint. This setting also allows organizations to prioritize risks related to specific domains or activities.

### Priority user groups

Assign higher risk-scoring thresholds to users in critical roles or those with elevated access. For example, users with access to sensitive data might need more detailed activity evaluations.

### Priority physical assets

Identify and track activity related to sensitive locations, such as data centers or secure facilities. Correlating this activity with other user events can provide additional risk insights.

### Notifications

Set up email notifications for admins and other Insider Risk Management role groups. Notifications can be triggered for new alerts, unresolved warnings, or high-severity cases.

### Data sharing

Enable the export of alerts to external tools like SIEM or SOAR platforms. Using the Office 365 Management Activity API, this integration allows for centralized alert aggregation and investigation.

### Analytics

Run analytics scans to evaluate risk trends and identify potential areas of concern before creating policies. This feature provides insights without requiring policy deployment.

### Inline alert customization

Adjust thresholds for policies directly from the **Alert dashboard**. This feature allows real-time tuning of detection criteria based on the specifics of an alert.

### Power Automate flows (preview)

Automate tasks such as sharing case updates or posting case notes using Power Automate flows. This can streamline workflows and improve efficiency during investigations.

### Microsoft Teams

Enable private Teams channels to facilitate collaboration among investigators. Teams can be used to securely share evidence, coordinate actions, and track responses.

## Configure insider risk settings

Follow these steps to configure settings effectively:

1. **Define organizational goals**: Identify the types of insider risks your organization aims to address, such as data exfiltration or misuse of sensitive information.
1. **Adjust privacy settings**: Decide whether to anonymize usernames in cases and alerts based on your organization's privacy and compliance needs.
1. **Run analytics scans**: Use analytics to gain insights into potential risks across your organization and fine-tune your configurations before deploying policies.
1. **Enable relevant indicators**: Select indicators that align with your organization's identified risks and set appropriate thresholds to minimize unnecessary alerts.
1. **Create detection groups**: Tailor thresholds for high-risk users or departments to ensure accurate and focused risk scoring.
1. **Establish admin notifications**: Set up notifications to keep key stakeholders informed of high-priority alerts and cases.
1. **Integrate external tools**: If needed, configure export settings to send alert data to SIEM or SOAR platforms.
1. **Test and refine settings**: Regularly review alerts, adjust thresholds, and update settings as organizational needs evolve.

Once settings are configured, you can expand Insider Risk Management's capabilities by integrating it with other tools and data sources. These integrations help enhance detection, refine policies, and streamline investigations.
