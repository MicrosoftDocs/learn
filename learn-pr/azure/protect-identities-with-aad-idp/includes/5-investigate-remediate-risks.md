You've been asked to investigate and remediate all the risks detected, and share a report with the project manager. The team will then better understand the company's identity-based risks.

In this unit, you'll learn how to investigate risks using reports. You'll see how to remediate different types of risks, and deal with any user accounts that might be blocked.

### Investigate risks

Azure Active Directory Identity Protection (AADIP) provides reports you can use to investigate identity-based risks detected for your organization's users. These reports come in different types. Each kind of report gives the administrator information about certain risks. The administrator can then take specific actions to address those risks.

|Report |Information included |Actions the admin can take |Period covered|
|---------|---------|---------|---------|
|Risky sign-ins| Location details, device details, sign-ins confirmed as safe, or with dismissed or remediated risks.| Confirm sign-ins are safe, or confirm that they're compromised. | Last 30 days.|
|Risky users|Lists of users at risk, and users with dismissed or remediated risks. User's history of risky sign-ins.| Reset a user's password, dismiss a user risk, block user sign-ins, confirm user account as compromised.| Not applicable.

You use these reports to investigate risks detected by AADIP. The reports help you understand how to better prevent risks and improve your security stance for identities.

You can also access *risk detection type reports*, which combine information about risky user detections and sign-in detections. Use these reports to see how different risk types are related, and take appropriate action.

You can view and download all reports from the Azure portal.

![View and download a report](../media/5-identity-protection-risky-sign-ins-report.png)
<!-- Please feel free to style according to Learn standards. Original image: https://docs.microsoft.com/en-us/azure/active-directory/identity-protection/media/howto-identity-protection-investigate-risk/identity-protection-risky-sign-ins-report.png  -->

### Remediate risks

When your investigation is complete, you'll want to remediate the risks if you're not already using risk policies to automatically deal with them. Always address detected risks quickly.

There are different ways to remediate risks. The methods you use depend on your organization's needs.

| Remediation method  |  Description |
|---------------------|--------------|
|**Self-remediation**  |If you configure risk policies, you can let users self-remediate. When AADIP has detected a risk, users either reset their password, or go through multi-factor authentication to unblock themselves. After self-remediation, these detected risks are considered closed. In your risk policies, the lower the acceptable risk level that triggers the policy, the more users will be affected. In general, you're recommended to set the threshold for user risk policies at *high*, and set sign-in risk policies to *medium and above*.|
|**Reset passwords manually**|For some organizations, automated password reset might not be an option. In this case, your administrators can manually enforce password resets. For example, the administrator could generate a temporary password and advise the user. The user can then change their password.|
|**Dismiss user risk detections**|Sometimes, password reset isn't possible. For example, the affected user account could have been deleted. In this case, you could dismiss the risk detections for this user. If you choose to dismiss user risk detections, all associated risk detections for the user are closed.|
|**Close individual detections** |All detected risks contribute to an overall risk score for a user. This risk score represents the probability that a user account is compromised. The administrator can also choose to close individual risk detections, and lower the overall risk of a user's account. For example, an administrator can find out from a user that a particular risk detection is no longer needed and dismiss it. The overall risk that a user account has been compromised is lowered.|

### Unblock users

User accounts can be blocked by risk policies, or manually by an administrator after an investigation. How these user accounts are unblocked depends on the type of risk that caused the blockage.

- **Accounts blocked because of sign-in risk**

    An account blocked because of sign-in risk can be unblocked by excluding the user from the policy. The account might be unblocked if an administrator asks the user to sign in from a familiar location or device. Sometimes, sign-ins are blocked from unfamiliar locations or devices. There may be an alert for suspicious behavior based on what's known about the user account's sign-in patterns. The policy can also be disabled if the administrator has found issues with it.

- **Accounts blocked because of user risk**

    An account might be blocked if the user has been flagged because of possible risky behavior. The administrator can reset the password for the user to unblock the account. To remove the block, the administrator might dismiss the activity identified as risky, or exclude the user from the policy. If the policy is causing problems for many users, the administrator could completely disable the policy.
