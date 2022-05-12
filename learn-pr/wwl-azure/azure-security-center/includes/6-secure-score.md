Secure Score is going to help your company track and raise your security posture.

## Introduction to secure score

Microsoft Defender for Cloud has two main goals: to help you understand your current security situation, and to help you efficiently and effectively improve your security. The central aspect of Security Center that enables you to achieve those goals is secure score.

Security Center continually assesses your resources, subscriptions, and organization for security issues. It then aggregates all the findings into a single score so that you can tell, at a glance, your current security situation: the higher the score, the lower the identified risk level. Use the score to track security efforts and projects in your organization.

The secure score page of Security Center includes:

 -  **The score** \- The secure score is shown as a percentage value, but the underlying values are also clear:

:::image type="content" source="../media/az500-secure-score-1-f06d5cd2.png" alt-text="Microsoft Defender for Cloud secure score as shown on the security score page.":::


 -  **Security controls** \- Each control is a logical group of related security recommendations, and reflects your vulnerable attack surfaces. A control is a set of security recommendations, with instructions that help you implement those recommendations. Your score only improves when you remediate all of the recommendations for a single resource within a control. The higher the score, the lower the identified risk level.

To immediately determine how well your organization is securing each individual attack surface, review the scores for each security control.

### How the secure score is calculated

The contribution of each security control towards the overall secure score is shown clearly on the recommendations page.

:::image type="content" source="../media/az500-secure-score-2-73470cd2.png" alt-text="Microsoft Defender for Cloud - Recommendations page is displayed.":::


To get all the possible points for a security control, all your resources must comply with all of the security recommendations within the security control. For example, Security Center has multiple recommendations regarding how to secure your management ports. In the past, you could remediate some of those related and interdependent recommendations while leaving others unsolved, and your secure score would improve. When looked at objectively, it's easy to argue that your security hadn't improved until you had resolved them all. Now, you must remediate them all to make a difference to your secure score.

### Improving your secure score

To improve your secure score, remediate security recommendations from your recommendations list. You can remediate each recommendation manually for each resource, or by using the Quick Fix! option (when available) to apply a remediation for a recommendation to a group of resources quickly.
