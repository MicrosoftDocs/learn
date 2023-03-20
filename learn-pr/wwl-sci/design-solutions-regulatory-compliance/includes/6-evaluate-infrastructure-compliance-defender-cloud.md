Microsoft Defender for Cloud helps streamline the process for meeting regulatory compliance requirements, using the **regulatory compliance dashboard**. Defender for Cloud continuously assesses your hybrid cloud environment to analyze the risk factors according to the controls and best practices in the standards that you've applied to your subscriptions. The dashboard reflects the status of your compliance with these standards.

When you enable Defender for Cloud on an Azure subscription, the [Microsoft cloud security benchmark](https://learn.microsoft.com/security/benchmark/azure/introduction) is automatically assigned to that subscription. This widely respected benchmark builds on the controls from the [Center for Internet Security (CIS)](https://www.cisecurity.org/benchmark/azure/), [PCI-DSS](https://www.pcisecuritystandards.org/) and the [National Institute of Standards and Technology (NIST)](https://www.nist.gov/) with a focus on cloud-centric security.

The regulatory compliance dashboard shows the status of all the assessments within your environment for your chosen standards and regulations. As you act on the recommendations and reduce risk factors in your environment, your compliance posture improves.

## Security policies and recommendations
A security policy defines the desired configuration of your workloads and helps ensure compliance with company or regulatory security requirements. In Defender for Cloud, you can define policies for your Azure subscriptions, which can be tailored to the type of workload or the sensitivity of data.

Defenders for Cloud policies contain the following components:

- Data collection: agent provisioning and data collection settings.
- Security policy: an Azure Policy that determines which controls are monitored and recommended by Defender for Cloud. You can also use Azure Policy to create new definitions, define more policies, and assign policies across management groups.
- Email notifications: security contacts and notification settings.
- Pricing tier: with or without Microsoft Defender for Cloud's Defender plans, which determine which Defender for Cloud features are available for resources in scope (can be specified for subscriptions and workspaces using the API).

### Security policies definitions and recommendations

Defender for Cloud automatically creates a default security policy for each of your Azure subscriptions. You can edit the policy in Defender for Cloud or use Azure Policy to create new definitions, define more policies, and assign policies across management groups. Management groups can represent the entire organization or a business unit within the organization. You can monitor policy compliance across these management groups.

Before configuring security policies, review each of the security recommendations:

- See if these policies are appropriate for your various subscriptions and resource groups.
- Understand what actions address the security recommendations.
- Determine who in your organization is responsible for monitoring and remediating new recommendations.

## Assess your regulatory compliance

The regulatory compliance dashboard shows your selected compliance standards with all their requirements, where supported requirements are mapped to applicable security assessments. The status of these assessments reflects your compliance with the standard.

Use the regulatory compliance dashboard to help focus your attention on the gaps in compliance with your chosen standards and regulations. This focused view also enables you to continuously monitor your compliance over time within dynamic cloud and hybrid environments.

## Investigate your regulatory compliance issues

You can use the information in the regulatory compliance dashboard to investigate any issues that may be affecting your compliance posture.

## Remediate an automated assessment

The regulatory compliance has both automated and manual assessments that may need to be remediated. Using the information in the regulatory compliance dashboard, improve your compliance posture by resolving recommendations directly within the dashboard.

## Remediate a manual assessment

The regulatory compliance has automated and manual assessments that may need to be remediated. Manual assessments are assessments that require input from the customer to remediate them.

## Generate compliance status reports and certificates

-   To generate a PDF report with a summary of your current compliance status for a particular standard, select **Download report**. The report provides a high-level summary of your compliance status for the selected standard based on Defender for Cloud assessments data. The report's organized according to the controls of that particular standard. The report can be shared with relevant stakeholders, and might provide evidence to internal and external auditors.

## Configure frequent exports of your compliance status data

If you want to track your compliance status with other monitoring tools in your environment, Defender for Cloud includes an export mechanism to make this straightforward. Configure **continuous export** to send select data to an Azure Event Hubs or a Log Analytics workspace.

## Run workflow automations when there are changes to your compliance

Defender for Cloud's workflow automation feature can trigger Logic Apps whenever one of your regulatory compliance assessments changes state.