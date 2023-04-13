

Microsoft Defender for Cloud provides security posture management and threat protection capabilities for Azure Virtual Desktop VMs in the following ways:

 -  Secure configuration assessment and Secure Score.
 -  Industry-tested vulnerability assessment.
 -  Host level detections.
 -  Agentless cloud network micro-segmentation & detection.
 -  File integrity monitoring.
 -  Just-in-time VM access.
 -  Adaptive Application Controls.

Microsoft Defender for Cloud has two main goals:

 -  Understand your current security situation
 -  Efficiently and effectively improve your security

The central feature in Defender for Cloud that enables those goals is the secure score.

Defender for Cloud continually assesses your cross-cloud resources for security issues. It then aggregates all the findings into a single score so that you can tell, at a glance, your current security situation: the higher the score, the lower the identified risk level.

In the Azure portal pages, the secure score is shown as a percentage value and the underlying values are also clearly presented:

:::image type="content" source="../media/single-secure-score-1-7e0c01a6.png" alt-text="Screenshot showing the secure score in the Azure portal.":::


In the Azure mobile app, the secure score is shown as a percentage value and you can tap the secure score to see the details that explain the score:

:::image type="content" source="../media/single-secure-score-2-366e7615.png" alt-text="Screenshot showing the percentage value and the secure score.":::


To increase your security, review Defender for Cloud's recommendations page and remediate the recommendation by implementing the remediation instructions for each issue. Recommendations are grouped into security controls. Each control is a logical group of related security recommendations, and reflects your vulnerable attack surfaces. Your score only improves when you remediate *all* of the recommendations for a single resource within a control. To see how well your organization is securing each individual attack surface, review the scores for each security control.

## Manage security posture

On the Security posture page, you're able to see the secure score for your entire subscription, and each environment in your subscription. By default all environments are shown.

:::image type="content" source="../media/security-posture-page-3-148f6db0.png" alt-text="Screenshot of the security posture page.":::


:::image type="content" source="../media/secure-score-5-53f8d88c.png" alt-text="Screenshot showing the security posture page with statistics.":::


The bottom half of the page allows you to view and manage viewing the individual secure scores, number of unhealthy resources and even view the recommendations for all of your individual subscriptions, accounts, and projects.

You can group this section by environment by selecting the Group by Environment checkbox.

:::image type="content" source="../media/secure-score-6-dcecd15d.png" alt-text="Screenshot showing the grouping sections by environment.":::


## How secure score is calculated

The contribution of each security control towards the overall secure score is shown on the recommendations page.

:::image type="content" source="../media/security-controls-6-50a868e0.png" alt-text="Screenshot showing the overall secure score on the recommendations page.":::
