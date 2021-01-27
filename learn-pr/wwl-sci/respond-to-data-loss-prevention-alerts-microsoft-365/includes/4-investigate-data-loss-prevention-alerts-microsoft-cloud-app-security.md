After a Cloud App Security File policy is created with a DLP-related configuration, file policy violation alerts are investigated in the Alerts area of Cloud App Security.

To manage alerts:

From the Alerts page, select **Open** for the Resolution Status.

This section of the dashboard provides full visibility into any suspicious activity or violation of your established policies. It can help you safeguard the security posture you defined for your cloud environment.

![Cloud App Security Alerts Dashboard](../media/cloud-app-security-alerts.png)

For each alert, you need to investigate and determine the nature of the violation and the required response.

- You can filter the alerts by Alert type or by Severity to process the most important ones first.

- Select a specific alert. Depending on what type of alert it is, you'll see various actions that can be taken before resolving the alert.

- You can filter based on App - The apps listed are ones for which activities were detected by Cloud App Security.

- There are three types of violations you'll need to deal with when investigating alerts:

  - **Serious violations** - Serious violations require an immediate response.

    - Examples:

      - For a suspicious activity alert, you might want to suspend the account until the user changes their password.

      - For a data leak, you might want to restrict permissions or quarantine the file.

      - If a new app is discovered, you might want to block access to the service on your proxy or firewall.

  - **Questionable violations** - Questionable violations require further investigation.

    - You can contact the user or the user's manager about the nature of the activity.

    - Leave the activity open until you have more information.

  - **Authorized violations or anomalous behavior** - Authorized violations or anomalous behavior can result from legitimate use.

    - You can dismiss the alert.

Anytime you dismiss an alert, it's important to submit feedback about why you're dismissing the alert. The Cloud App Security team uses this feedback as an indication of the accuracy of the alert. This information is then used to fine-tune our machine learning models for future alerts. You can follow these guidelines in deciding how to categorize the alert:

- If legitimate use triggered the alert and it isn't a security issue, it could be one of these types:

  - Benign positive: The alert is accurate, but the activity is legitimate. You can dismiss the alert and set the reason to Actual severity is lower or Not interesting.

  - False positive: The alert is inaccurate. Dismiss the alert and set the reason to Alert is not accurate.

- If there's too much noise to determine the legitimacy and accuracy of an alert, dismiss it and set the reason to Too many similar alerts.

- True positive: If the alert is related to an actual risky event that was either committed maliciously or unintentionally by an insider or outsider, you should set the event to Resolve after all appropriate action has been taken to remediate the event.

Even though you are interested in File policy alerts for DLP, the alerts list will show many different alert types.  It is important to understand the different alert types because these non-DLP alerts could also provide insight into a security incident.

The following table provides a list of the types of alerts that can be triggered and recommends ways you can resolve them.

| Alert type| Description| Recommended resolution|
| :--- | :--- | :--- |
| Activity policy violation| This type of alert is the result of a policy you created.| To work with this type of alert in bulk, we recommend that you work in the Policy center to mitigate them. Fine-tune the policy to exclude noisy entities by adding more filters and more granular controls. If the policy is accurate, the alert is warranted, and it's a violation you want to stop immediately, consider adding automatic remediation in the policy.|
| File policy violation| This type of alert is the result of a policy you created.| To work with this type of alert in bulk, we recommend that you work in the Policy center to mitigate them. Fine-tune the policy to exclude noisy entities by adding more filters and more granular controls. Fine-tune the policy to exclude noisy entities by adding more filters and more granular controls.|
| Compromised account| This type of alert is triggered when Cloud App Security identifies an account that was compromised. This means there's a high probability that the account was used in an unauthorized way.| We recommend that you suspend the account until you can reach the user and make sure they change their password.|
| Inactive account| This alert is triggered when an account hasn't been used in 60 days in one of your connected cloud apps.| Contact the user and the user's manager to determine whether the account is still active. If not, suspend the user and terminate the license for the app.|
| New admin user| Alerts you to changes in your privileged accounts for connected apps.| Confirm that the new admin permissions are required for the user. If they aren't, recommend revoking admin privileges to reduce exposure.|
| New admin location| Alerts you to changes in your privileged accounts for connected apps.| Confirm that the sign-in from this anomalous location was legitimate. If it's not, recommend revoking admin permissions or suspending the account to reduce exposure.|
| New location| An informative alert about access to a connected app from a new location, and it's triggered only once per country/region.| Investigate the specific user's activity.|
| New discovered service| This alert is an alert about Shadow IT. A new app was detected by Cloud Discovery.|  Assess the risk of the service based on the app catalog.|
| Suspicious activity| This alert lets you know that anomalous activity has been detected that isn't aligned with expected activities or users in your organization.| Investigate the behavior and confirm it with the user. This type of alert is a great place to start learning more about your environment and creating new policies with these alerts. For example, if someone suddenly uploads a large amount of data to one of your connected apps, you can set a rule to govern that type of anomalous behavior.|
| Use of personal account| This alert lets you know that a new personal account has access to resources in your connected apps.| Remove the user's collaborations in the external account.|

