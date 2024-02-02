When a DLP policy alert informs you about a DLP policy violation, it can mean many things. Not all alerts mean that data loss is imminent or was prevented. DLP policies don't make decisions about the reason for attempting to share protected data, but they alert you if a violation is observed. Reacting to policy violations can include escalating issues to your security team and working closely with other business stakeholders. You should know the process for contacting other teams and security before it's necessary.

For example, you protect financial information in your organization to prevent sharing of customer data with third parties. However, at the end of the first month, you start receiving alerts about rule violations on your financial information policy. Reviewing the reports shows a high number of e-mails from the accounting department including billing information for your customers. The policy reacted to the sensitive customer information without taking context into account. A compliance administrators' role is to assess and evaluate policy violations and act accordingly. In this instance, you should accept that the end of the month information triggers alerts because it correctly identifies protected data and informs you about this fact. You might want to adjust the instance count of the policy to reduce the number of alerts, but this adjustment could have negative effects on the policy at other times of the month.

Now consider that you later created a personal data policy. This policy displays an alert spike around the same time at the end of each month, just like the financial information policy. Looking at the new spike in your personal data policy shows you the violation happens on the same items as the financial information policy. You decide to take a closer look at the billing documents and notice that they include personal identifiable information beyond what is immediately necessary for billing documents. In this case, you shouldn't adjust the policies to avoid triggering at the end of the month. Instead, you should reach out to the responsible party and identify whether this information is needed in the current business process. If it isn't, inquire why it was created in the first place.

A technical solution to this problem would involve allowing the accounting department to override the block action of the personal data policy. However, implementing this solution would result in increased processing time for sending out billing information. The reason is that they would need to manually override each policy match, which adds extra steps to the workflow. If you can't work with the accounting department on reducing the amount of shared personal data, you still have options to address the issue. One approach is to adjust the sensitivity, instance count, or exclusions of your policy. By doing so, you can reduce the number of alerts generated at the end of each month.

DLP reports can also help you identify users who create a high number of matches. There may be multiple reasons and your role as a compliance administrator is to evaluate if the matches are benign or malevolent. For example, a user in the accounting department might generate a high number of matches at the end of each month because of the financial information policy and the monthly business process of sending out billing information. This situation is most likely harmless, but you should take a closer look at all occurrences of a high alert count. Users who are aware of these policies have gained knowledge about them through policy tips or by collaborating with you in their creation. As a result, they might exploit this knowledge to intentionally share information that they shouldn't share. If a malevolent user decides to send out financial information, they could use the end of the month to hide the malevolent mails in between the legitimate mails from your business process.

You can also use the reports to allow your users to help you with refining the DLP policies. For this purpose, you can use the DLP false positives and overrides report. If you allow users the ability to override using a business justification, they not only hold themselves accountable by choosing the override but also enable you to review the reason behind it. This approach allows you to identify business processes that may warrant an adjustment to your policy or the business process itself.

For example, you open the false positives and overrides report and notice a high number of false positives on your Tax Identification Number policy. Opening the details of these false positives, you notice that your internal product numbers resemble European tax identification numbers. As a consequence, users report these matches as false positives.

## Configure DLP rule exclusions

You decide to adjust the Tax identification number DLP policy to exclude instances where it matches your custom sensitive information type for Product Number. To make this adjustment, follow these steps:

1. In the Microsoft Purview compliance portal, expand **Data Loss Prevention** and select **Policies**.

1. Check the Tax identification number policy and select **Edit Policy**.

1. Select **Next** until you reach the **Customize advanced DLP rules** page and edit the rule that creates numerous false positives.

1. Under the created condition that needs an exclusion, select **Add group**.

1. To create an exception, select the slider for **Not** to ensure the condition doesn't consider those conditions in the group.

1. From the dropdown menu, select  **Content contains**.

1. Select **Add** and select **Sensitive info types**.

1. From the fly-out menu on the right, select the custom product number info type and select **Add**.

1. Select **Save**.

1. Select **Next** twice, review the policy and select **Submit**.

By following these steps, you can reduce the number of false positives generated by your policy. It no longer applies when it identifies product numbers in your users' shared content.

If a malicious user is aware of the matching indicators, they can use them to create a match on the product numbers exclusion and circumvent the protective actions of this rule by purposefully including a matching exclusion.
