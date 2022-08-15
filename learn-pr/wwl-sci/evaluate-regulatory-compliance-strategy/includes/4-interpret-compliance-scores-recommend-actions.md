The regulatory compliance dashboard in Microsoft Defender for Cloud shows the status of all the assessments within your environment for your chosen standards and regulations. As you act on the recommendations and reduce risk factors in your environment, your compliance posture improves.

## Resolve compliance recommendations

Using the information in the regulatory compliance dashboard, you can improve your compliance posture by resolving recommendations directly within the dashboard. You can select any of the failing assessments that appear in the dashboard to view the details for that recommendation. Each recommendation includes a set of remediation steps to resolve the issue. From there you can select any of the failing assessments that appear in the dashboard to view the details for that recommendation. Each recommendation includes a set of remediation steps to resolve the issue.

When reviewing the assessments, you will see a dashboard view similar to the one in the picture below. You can then take action to resolve recommendations:

:::image type="content" source="../media/azure-security-benchmark.png" alt-text="Screenshot of the Defender for Cloud dashboard.":::

1. Select a tab for a compliance standard that is relevant to you.
1. View which subscriptions the standard is applied on.
1. See the list of all controls for that standard.
1. For the applicable controls, you can view the details of passing and failing assessments associated with that control.
1. You also see the number of resources affected by that assessment.

Some controls are greyed out. These controls don't have any Defender for Cloud assessments associated with them. Check their requirements and assess them in your environment. Some of these might be process-related and not technical.

Use the regulatory compliance dashboard to help focus your attention on the gaps in compliance with your chosen standards and regulations.

Let's consider a scenario where a Contoso security admin needs to ensure their SQL Database workloads are compliant with PCI DSS 3.2.1. When reviewing the dashboard, he sees a recommendation not to store sensitive authentication information after authorization:

:::image type="content" source="../media/azure-security-benchmark-1.png" alt-text="Screenshot showing non compliant items on the dashboard.":::

To address this issue, the security administrator needs to click on the *SQL servers should have an Azure Active Directory administrator provisioned* recommendation and remediate it.

To track your progress over time you can use the *Compliance Over Time Workbook*. This workbook tracks your compliance status over time with the various standards you've added to your dashboard.

:::image type="content" source="../media/microsoft-defender-cloud-workbooks-compliance-over-time.png" alt-text="Screenshot showing the Compliance over time workbook to track your compliance status with the various standards you've added to your dashboard.":::