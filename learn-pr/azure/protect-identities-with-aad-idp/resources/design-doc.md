# Title

Protect your identities with Azure AD Identity Protection

## Role(s)

- Solution Architect
- Administrator

## Level

- Intermediate

## Product(s)

- Azure AD

## Prerequisites

- Basic familiarity with Azure AD

## Summary

Use the advanced detection and remediation of identity-based threats to protect your Azure AD identities and applications from compromise.

## Learning objectives

1. Describe the features of Azure AD Identity Protection
1. Configure and simulate a risk detection

## Chunk your content into subtasks

Identify the subtasks of *Protect your identities with Azure AD Identity Protection*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Understand Azure Active Directory Identity Protection | Take advantage of Azure native services to protect from identity related incidents. | KC | Describe the features of Azure AD Identity Protection | Yes |
| Detect risks with Identity Protection policies | Take advantage of Azure native services to protect from these incidents in the future | Exercise | Configure and simulate a risk detection | Yes |
| Investigate detected risks | Take advantage of Azure native services to protect from identity related incidents. | KC | Describe the features of Azure AD Identity Protection | Yes |
| Remediate detected risks| Take advantage of Azure native services to protect from identity related incidents. | KC | Describe the features of Azure AD Identity Protection | Yes |


## Outline the units

1. **Introduction**

    You work for an organization that has their identities stored in Azure AD. You've recently had several incidents where identities were compromised and sensitive customer information was exposed. You would like to take advantage of Azure native services to protect from these incidents in the future, and believe that Azure AD Identity Protection can provide this for your identity infrastructure.

1. **Azure Active Directory Identity Protection Overview**

    List the content that will enable the learner to understand Azure Active Directory Identity Protection:
	- What is Azure Active Directory Identity Protection?
	- What are risks in Azure Active Directory Identity Protection?
	- Azure Active Directory Identity Protection workflow
	    - Illustrate a typical Azure AD Identity Prorection workflow

    **Knowledge check**
    - How do you protect against identity-based risks using Azure AD Idenity Protection?
            - Configure a report, investigate using a policy, and then remediate.
            - Configure a report, remediate, and then configure a policy.
            - Configure a policy, investigate using a report, and remediate.
    - You want to analyze risks that describe authentication requests have probably not been authorized by users. Which type of risks will you analyze?
            - User risk
            - Sign-in risk
            - Authentication risk

1. **Detect risks with Identity Protection policies**

    List the content that will enable the learner to detect risks with Identity Protection policies:
	- Sign-in risk policy
		- What is a Sign-in risk policy?
		- Configure a Sign-in risk policy
		- End-user experience of Sign-in risk policy
	- User risk policy
		- What is a user risk policy?
		- Configure a User risk policy
		- End-user experience of user risk policy
	- Multi-factor authentication (MFA) registration policy
		- What is an MFA registration policy?
		- Configure an MFA registration policy
		- End-user experience of MFA registration policy

1. **Exercise - Detect risks with Identity Protection policies**

    List the steps which apply the learning content from previous unit:

    - Configure a Sign-in risk policy
    - Configure a User risk policy
    - Simulate risk events
    - View detected risks from the Identity Protection dashboard

1. **Investigate detected risks**

    List the content that will enable the learner to investigate detected risks:
	- Risky users reports
		- Information in risky users reports
		- Actions to take for risky user reports
	- Risky sign-in reports
		- Information in risky sign-in reports
		- Actions to take for risky sign-in reports
	- Briefly mention risk detection reports combine both types of detections

	 **Knowledge check**

    - Which report would you review to find devices that have been identified as part of a detected risk?
            - Risky sign-in report
            - Risky user report
            - Risky registration report
    - You want to investigate a history of risky sign-ins for a particular user, what do you need to do?
            - Review the risky user reports
            - Review the risky sign-in reports
            - Review the risky registration reports
1. **Remediate detected risks**

    List the content that will enable the learner to remediate detected risks:
	- User self-remediation with risk policy
	- Reset passwords manually
	- Dismiss user risk detections
	- Close detections manually
	- Unblock user accounts
		- Unblock account blocked due to user risk
		- Unblock accounts blocked due to sign-in risk

    **Knowledge check**

    - Which actions can administrators take if they want to manually close all individual detections?
            - Dismiss user risk, confirm sign-in compromised, set up self-remediation with risk policy
            - Confirm sign-in compromised, confirm user compromised, require usrs to reset password
            - Confirm sign-in compromised, dismiss user risk, confirm user compromised
    - Password reset is not an option for you, because the user has been deleted. What action can you take?
            - Confirm user compromised
            - Dismiss user risk
            - Confirm sign-in compromised

1. **Summary**

    In this module you've explored how Azure Active Directory Identity Protection can protect your identities. You've configured policies to detect risks to your identities. You've simulated risks to test your policies. You then went on to investigate the risks that you have detected in more detail.
## Notes

The following doc can be used to simulate risk events. We should be able to do this in sandbox, so try to create this module with an exercise.

https://docs.microsoft.com/en-us/azure/active-directory/identity-protection/howto-identity-protection-simulate-risk
