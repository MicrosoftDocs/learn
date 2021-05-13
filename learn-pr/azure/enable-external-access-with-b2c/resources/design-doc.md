# Module Design

## Title

Enable secure external user access for your applications with Azure AD B2C

## Role(s)

- Solution Architect
- Developer

## Level

- Intermediate

## Product(s)

- Azure AD and multi-factor authentication
- Azure AD B2C

## Prerequisites

- Basic understanding of Azure AD

## Summary

Use Azure AD B2C as the full-featured identity system for your application, and ensure users are required to sign in securely through multi-factor authentication.  

## Learning objectives

- Secure access to an application with Azure AD B2C
- Enable multi-factor authentication for Azure AD B2C

## Chunk your content into subtasks

Identify the subtasks of *Enable secure external user access for your applications with Azure AD B2C*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| What is Azure AD B2C? | Implement a secure identity solution for the application | Knowledge check | 1 | Yes |
| Use multi-factor authentication to protect your application | Implement a secure identity solution for the application | Knowledge check | 2 | Yes |
| Configure Azure AD B2C with MFA | Implement a secure identity solution for the application | Exercise | 1, 2 | Yes |

## Outline the units

1. **Introduction**

    You're the solution architect for a health care organization. Your organization is publishing an application that allows patients to view their health records. You need to implement a secure identity solution for the application to protect the sensitive health data of your patients.

2. **What is Azure AD B2C?**

    Explain the purpose of Azure AD B2C. Describe the following points and concepts:

    - What is a *user journey* in Azure B2C?
    - Using secure protocols and tokens for user journeys.
    - How to register tenants with applications for users. 
    - How to configure user journeys through policies.
    - Allowing users to sign in with different identity providers.
    - Customizing the user journey through page customization.

    **Knowledge check**
    - What should you do to enable your applications to be ready for Azure AD B2C?
    - Your organization wants you to make it possible for patients to use their own personal social media accounts to access their health records. How would you meet this requirement?

3. **Use multi-factor authentication to protect your application**

    In the scenario, the health care organization has an application. You need to allow patients to access their health records from this application. You can implement automated access control decisions for accessing your cloud apps that are based on conditions. Conditional access policies are enforced after the first-factor authentication has been completed. Cover the following points:

    - The additional layers of protection available to your applications with MFA.
    - Options for implementing multi-factor authentication in Azure (brief - details are in the next unit)
    - Occasions when you may need to disable MFA.

    **Unit Notes:**

    Conditional access policy has two key parts:

    - Conditions – Specified conditions that need to be met
    - Action – defined action steps once the conditions are met.

    Azure AD MFA helps safeguard access to data and customer-facing applications while maintaining simplicity for users. It provides additional security by requiring a second form of authentication and delivers strong authentication via a range of easy to use authentication methods. The security of two-step verification lies in its layered approach. Compromising multiple authentication factors presents a significant challenge for attackers. Even if an attacker manages to learn the user's password, it's useless without also having possession of the additional authentication method. MFA provides additional security for your identities by requiring two or more elements for full authentication. These elements fall into three categories:

    - Something you know
    - Something you possess
    - Something you are

    Something you know would be a password or the answer to a security question. Something you possess could be a mobile app that receives a notification or a token generating device. Something you are is typically some sort of biometric property such as a fingerprint or face scan used on many mobile devices.

    MFA policies can be enforced at the tenant, app, or individual user level. Example second factors include:

    - Mobile app, for example, Authenticator
    - Mobile app verification code

    Azure AD B2C directories are separate from standard Azure AD directories and can be created in the Azure portal. Azure AD B2C enables you to customize and control how customers sign up, sign in, and manage their profiles when using your applications. This includes applications developed for iOS, Android, and .NET, among others. Azure AD B2C provides a social identity sign in experience, while at the same time protecting your customer identity profile information.  

    **Knowledge check**

    - You want to set up multi-factor authentication for the application. You notice you are unable to set up new conditional access policies. What might have happened?
    - Your organization wants to enable users in the local office to sign in to the application without being prompted for multi-factor authentication.  How could you meet this expectation?

4. **Configure Azure AD B2C with MFA**

    Walk through the process of implementing MFA in Azure B2C, using the portal. Describe the options available at each stage of the process. Summarize the experience of the end-user of an application once B2C and MFA are set up (how do they run an app, what will they see during authentication, what information will they be expected to provide?).

5. **Exercise - Set up Azure AD B2C with MFA through the Azure portal**

    The exercise uses the sample scenario as a specific example of B2C with MFA. Perform the following tasks:

    - Create an Azure AD B2C tenant.
    - Register your application in Azure AD B2C.
    - Create user flows in Azure AD B2C.
    - Set multi-factor authentication on the user flow.

6. **Summary**

    In this module, you've learned how Azure AD B2C can be used as an identity solution to protect the sensitive health data of patients. You've also learned how multi-factor authentication can be used with Azure AD B2C to add an additional layer of protection for your application.

## Notes

- MFA in B2C - https://docs.microsoft.com/azure/active-directory-b2c/active-directory-b2c-reference-mfa
