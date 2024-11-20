The secure score in Microsoft Defender for Cloud can help you to improve your cloud security posture. The secure score aggregates security findings into a single score so that you can assess, at a glance, your current security situation. The higher the score, the lower the identified risk level is.

When you turn on Defender for Cloud in a subscription, the [Microsoft cloud security benchmark (MCSB)](/security/benchmark/azure/introduction) standard is applied by default in the subscription. Assessment of resources in scope against the MCSB standard begins.

> [!NOTE]
> Recommendations flagged as Preview aren't included in secure score calculations. You should still remediate these recommendations wherever possible, so that when the preview period ends, they'll contribute toward your score.

## Viewing the secure score

When you view the Defender for Cloud Overview dashboard, you can view the secure score for all of your environments. The dashboard shows the secure score as a percentage value and includes the underlying values. :::image type="content" source="../media/single-secure-score-d9d15a01.png" alt-text="Screenshot of the portal dashboard that shows an overall secure score and underlying values.":::


The Azure mobile app shows the secure score as a percentage value. Tap it to see details that explain the score.

:::image type="content" source="../media/single-secure-score-mobile-abce495b.png" alt-text="Screenshot of the Azure mobile app that shows an overall secure score and details.":::
<br>

## Exploring your security posture

The Security posture page in Defender for Cloud shows the secure score for your environments overall and for each environment separately.

[:::image type="content" source="/azure/defender-for-cloud/media/secure-score-security-controls/security-posture-page.png" alt-text="Screenshot of the Defender for Cloud page for security posture.":::
](/azure/defender-for-cloud/media/secure-score-security-controls/security-posture-page.png#lightbox)

On this page, you can see the subscriptions, accounts, and projects that affect your overall score, information about unhealthy resources, and relevant recommendations. You can filter by environment, such as Azure, Amazon Web Services (AWS), Google Cloud Platform (GCP), and Azure DevOps. You can then drill down into each Azure subscription, AWS account, and GCP project.

[:::image type="content" source="/azure/defender-for-cloud/media/secure-score-security-controls/bottom-half.png" alt-text="Screenshot of the bottom half of the security posture page. The bottom half of the security posture page.":::
](/azure/defender-for-cloud/media/secure-score-security-controls/bottom-half.png#lightbox)

## Calculation of the secure score

On the Recommendations page in Defender for Cloud, the Secure score recommendations tab shows how compliance controls within the MCSB contribute toward the overall security score.

:::image type="content" source="../media/security-controls-score-ca14a4c9.png" alt-text="Screenshot that shows security controls that affect a secure score.":::


Defender for Cloud calculates each control every eight hours for each Azure subscription or for each AWS or GCP cloud connector.

Recommendations within a control are updated more often than the control itself. You might find discrepancies between the resource count on the recommendations and the resource count on the control.

:::image type="content" source="../media/security-controls-6-50a868e0-14b56fbe.png" alt-text="Screenshot showing the overall secure score on the recommendations page.":::
<br>
