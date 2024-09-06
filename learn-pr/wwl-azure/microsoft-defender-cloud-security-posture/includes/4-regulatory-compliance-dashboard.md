Microsoft Defender for Cloud helps streamline the process for meeting regulatory compliance requirements, using the regulatory compliance dashboard. Defender for Cloud continuously assesses your hybrid cloud environment to analyze the risk factors according to the controls and best practices in the standards that you've applied to your subscriptions. The dashboard reflects the status of your compliance with these standards.

When you enable Defender for Cloud on an Azure subscription, the Microsoft cloud security benchmark is automatically assigned to that subscription. This widely respected benchmark builds on the controls from the Center for Internet Security (CIS), Payment Card Industry (PCI) Data Security Standards (DSS) and the National Institute of Standards and Technology (NIST) with a focus on cloud-centric security.

The regulatory compliance dashboard shows the status of all the assessments within your environment for your chosen standards and regulations. As you act on the recommendations and reduce risk factors in your environment, your compliance posture improves.

> [!TIP]
> *Compliance data from Defender for Cloud now seamlessly integrates with Microsoft Purview Compliance Manager, allowing you to centrally assess and manage compliance across your organization's entire digital estate. When you add any standard to your compliance dashboard (including compliance standards monitoring other clouds like AWS and GCP), the resource-level compliance data is automatically surfaced in Compliance Manager for the same standard. Compliance Manager thus provides improvement actions and status across your cloud infrastructure and all other digital assets in this central tool.*

## Assess your regulatory compliance

The regulatory compliance dashboard shows your selected compliance standards with all their requirements, where supported requirements are mapped to applicable security assessments. The status of these assessments reflects your compliance with the standard.

Use the regulatory compliance dashboard to help focus your attention on the gaps in compliance with your chosen standards and regulations. This focused view also enables you to continuously monitor your compliance over time within dynamic cloud and hybrid environments.

1. Sign in to the Azure portal.

2. Navigate to **Defender for Cloud**, **Regulatory compliance**.

The dashboard provides you with an overview of your compliance status and the set of supported compliance regulations. You'll see your overall compliance score, and the number of passing vs. failing assessments associated with each standard.

## Investigate regulatory compliance issues

You can use the information in the regulatory compliance dashboard to investigate any issues that might be affecting your compliance posture.

### To investigate your compliance issues:

1. Sign in to the [Azure portal](https://portal.azure.com/).<br>

2. Navigate to **Defender for Cloud**, **Regulatory compliance**.<br>

3. Select a regulatory compliance standard.<br>

4. Select a compliance control to expand it.<br>

5. Select **Control details**.<br>

:::image type="content" source="../media/new-control-details-6b59bc2b.png" alt-text="Screenshot showing the Defender for Cloud Regulatory compliance Control details.":::


 -  Select Overview to see the specific information about the Control you selected.
 -  Select Your Actions to see a detailed view of automated and manual actions you need to take to improve your compliance posture.
 -  Select Microsoft Actions to see all the actions Microsoft took to ensure compliance with the selected standard.

6. Under **Your Actions**, you can select a down arrow to view more details and resolve the recommendation for that resource.

:::image type="content" source="../media/new-your-actions-45615309.png" alt-text="Screenshot showing how to to view more details and resolve the recommendation for a resource.":::


> [!NOTE]
> *Assessments run approximately every 12 hours, so you will see the impact on your compliance data only after the next run of the relevant assessment.*

## Remediate an automated assessment

The regulatory compliance has both automated and manual assessments that might need to be remediated. Using the information in the regulatory compliance dashboard, improve your compliance posture by resolving recommendations directly within the dashboard.

### To remediate an automated assessment:

1. Sign in to the [Azure portal](https://portal.azure.com/).<br>

2. Navigate to **Defender for Cloud**, **Regulatory compliance**.<br>

3. Select a regulatory compliance standard.<br>

4. Select a compliance control to expand it.<br>

5. Select any of the failing assessments that appear in the dashboard to view the details for that recommendation. Each recommendation includes a set of remediation steps to resolve the issue.<br>

6. Select a particular resource to view more details and resolve the recommendation for that resource.<br>

:::image type="content" source="../media/new-sample-recommendation-example-273b7ee0.png" alt-text="Screenshot showing that disk encryption should be applied on virtual machines.":::


7. In this example, when you select **Take action** from the recommendation details page, you arrive in the Azure Virtual Machine pages of the Azure portal, where you can enable encryption from the **Security** tab:

:::image type="content" source="../media/new-encrypting-virtual-machine-disks-4949d026.png" alt-text="Screenshot showing how to enable encryption from the Security tab.":::


8. After you take action to resolve recommendations, you'll see the result in the compliance dashboard report because your compliance score improves.

## Remediate a manual assessment

The regulatory compliance has automated and manual assessments that might need to be remediated. Manual assessments are assessments that require input from the customer to remediate them.

### To remediate a manual assessment:

1. Sign in to the [Azure portal](https://portal.azure.com/).<br>

2. Navigate to **Defender for Cloud**, **Regulatory compliance**.<br>

3. Select a regulatory compliance standard.<br>

4. Select a compliance control to expand it.<br>

5. Under the Manual attestation and evidence section, select an assessment.<br>

6. Select the relevant subscriptions.<br>

7. Select **Attest**.<br>

8. Enter the relevant information and attach evidence for compliance.<br>

9. Select **Save**.
