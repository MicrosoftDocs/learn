Microsoft Defender for Cloud helps streamline the process for meeting regulatory compliance requirements, using the regulatory compliance dashboard. Defender for Cloud continuously assesses your hybrid cloud environment to analyze the risk factors according to the controls and best practices in the standards that you've applied to your subscriptions. The dashboard reflects the status of your compliance with these standards.

When you enable Defender for Cloud on an Azure subscription, the Microsoft cloud security benchmark is automatically assigned to that subscription. This widely respected benchmark builds on the controls from the Center for Internet Security (CIS), PCI-DSS and the National Institute of Standards and Technology (NIST) with a focus on cloud-centric security.<br>

The regulatory compliance dashboard shows the status of all the assessments within your environment for your chosen standards and regulations. As you act on the recommendations and reduce risk factors in your environment, your compliance posture improves.<br>

## Assess your regulatory compliance<br>

The regulatory compliance dashboard shows your selected compliance standards with all their requirements, where supported requirements are mapped to applicable security assessments. The status of these assessments reflects your compliance with the standard.

Use the regulatory compliance dashboard to help focus your attention on the gaps in compliance with your chosen standards and regulations. This focused view also enables you to continuously monitor your compliance over time within dynamic cloud and hybrid environments.

The dashboard provides you with an overview of your compliance status and the set of supported compliance regulations. You'll see your overall compliance score, and the number of passing vs. failing assessments associated with each standard.

**Example: Microsoft Defender for Cloud - Regulatory compliance dashboard** 

:::image type="content" source="../media/regulatory-compliance-dashboard-drilldown-18dadd8b.png" alt-text="Screenshot showing an example of the regulatory compliance controls in the Azure dashboard with descriptions of feature functionality.":::


The following list has a numbered item that matches each location in the image above, and describes what is in the image:

1.  Select a compliance standard to see a list of all controls for that standard.<br>
2.  View the subscription(s) that the compliance standard is applied on.
3.  Select a Control to see more details. Expand the control to view the assessments associated with the selected control. Select an assessment to view the list of resources associated and the actions to remediate compliance concerns.
4.  Select Control details to view Overview, Your Actions and Microsoft Actions tabs.
5.  In the Your Actions tab, you can see the automated and manual assessments associated to the control.
6.  Automated assessments show the number of failed resources and resource types, and link you directly to the remediation experience to address those recommendations.
7.  The manual assessments can be manually attested, and evidence can be linked to demonstrate compliance.

Recommendations give you suggestions on how to better secure your resources. You implement a recommendation by following the remediation steps provided in the recommendation.

> [!NOTE]
> Assessments **run approximately every 12 hours,** so you will see the impact on your compliance data only after the next run of the relevant assessment.

## Remediation steps

After reviewing all the recommendations, decide which one to remediate first. We recommend that you prioritize the security controls with the highest potential to increase your secure score.

1. From the list, select a recommendation.

2. Follow the instructions in the Remediation steps section. Each recommendation has its own set of instructions. The following screenshot shows remediation steps for configuring applications to only allow traffic over HTTPS.

    :::image type="content" source="../media/regulatory-compliance-remediation-recommendation-techdoc-example-415f39e1.png" alt-text="Screenshot showing an example of manual remediation steps for storage accounts.":::


## Remediate an automated assessment

The regulatory compliance has both automated and manual assessments that may need to be remediated. Using the information in the regulatory compliance dashboard, improve your compliance posture by resolving recommendations directly within the dashboard.

**To remediate an automated assessment:**<br>

1. Sign in to the **Azure portal.**<br>

2. Navigate to **Defender for Cloud** then click, **Regulatory compliance.**<br>

3. Select a regulatory compliance standard.<br>

4. Select a compliance control to expand it.<br>

5. Select any of the failing assessments that appear in the dashboard to view the details for that recommendation. Each recommendation includes a set of remediation steps to resolve the issue.<br>

6. Select a particular resource to view more details and resolve the recommendation for that resource. For example, in the **Azure CIS 1.1.0** standard, select the recommendation **Disk encryption should be applied on virtual machines.**

    :::image type="content" source="../media/disk-encryption-example-recommendation-d7d9c47a.png" alt-text="Screenshot showing an example of affected resources that require remediation.":::


7. In this example, when you select **Take action** from the recommendation details page, you arrive in the Azure Virtual Machine pages of the Azure portal, where you can enable encryption from the **Security** tab:

    :::image type="content" source="../media/disk-encryption-settings-example-recommendation-b78e253b.png" alt-text="Screenshot showing an example of a virtual machines disk setting.":::


8. After you take action to resolve recommendations, you'll see the result in the compliance dashboard report because your compliance score improves.

## Remediate a manual assessment

The regulatory compliance has automated and manual assessments that may need to be remediated. Manual assessments are assessments that require input from the customer to remediate them.

### To remediate a manual assessment:<br>

1. Sign in to the **Azure portal.**<br>

2. Navigate to **Defender for Cloud** then click, **Regulatory compliance.**<br>

3. Select a regulatory compliance standard.<br>

4. Select a compliance control to expand it.<br>

5. Under the Manual attestation and evidence section, select an assessment.<br>

6. Select the relevant subscriptions.<br>

7. Select **Attest.**<br>

8. Enter the relevant information and attach evidence for compliance.<br>

9. Select **Save.**<br>
