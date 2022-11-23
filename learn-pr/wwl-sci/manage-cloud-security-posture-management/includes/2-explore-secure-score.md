Defender for Cloud continually assesses your cross-cloud resources for security issues. It then aggregates all the findings into a single score so that you can tell, at a glance, your current security situation: the higher the score, the lower the identified risk level.

In the Microsoft Defender for Cloud Overview page, the secure score is shown as a percentage value and the underlying values are also clearly presented:



:::image type="content" source="../media/single-secure-score.png" alt-text="Screenshot of Defender for Cloud Security Posture Secure Score.":::


To increase your security, review Defender for Cloud's recommendations page and remediate the recommendation by implementing the remediation instructions for each issue. Recommendations are grouped into security controls. Each control is a logical group of related security recommendations, and reflects your vulnerable attack surfaces. Your score only improves when you remediate all of the recommendations for a single resource within a control. To see how well your organization is securing each individual attack surface, review the scores for each security control.





## Manage your security posture
On the Security posture page, you're able to see the secure score for your entire subscription, and each environment in your subscription. By default all environments are shown.

:::image type="content" source="../media/security-posture-page.png" alt-text="Screenshot of Defender for Cloud Security Posture Overview." lightbox="../media/security-posture-page.png":::


The bottom half of the page allows you to view, and manage all of your individual subscriptions, accounts, and projects, by viewing their individual secure scores, number of unhealthy resources and even view their recommendations.

### How your secure score is calculated
To get all the possible points for a security control, all of your resources must comply with all of the security recommendations within the security control. For example, Defender for Cloud has multiple recommendations regarding how to secure your management ports. You'll need to remediate them all to make a difference to your secure score.