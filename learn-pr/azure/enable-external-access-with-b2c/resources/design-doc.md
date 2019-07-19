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

Use Azure AD as the full-featured identity system for your application, while letting customers sign in with an identity they already have established (like Facebook or Gmail).

## Learning objectives

- Secure access to an application with Azure AD B2C
- Enable multi-factor authentication for Azure AD B2C

## Chunk your content into subtasks

Identify the subtasks of *Enable secure external user access for your applications with Azure AD B2C*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| How to secure customer-facing applications | Identify the methods to secure customer-facing applications with MFA | Knowledge check | 1 | Yes |
| What are Azure AD features for B2C? | Identify the MFA features for AAD B2C | Knowledge check | 2 | Yes |
| How to enable MFA in Azure AD B2C | Identify the steps to enable MFA in AAD B2C | Exercise | 2 | Yes |

## Outline the units

1. **Introduction**

    You are the solution architect for a health care organization. Your organization is publishing an application that allows patients to view their health records. You need to implement a secure identity solution for the application to protect the sensitive health data of your patients.

1. **How to secure customer-facing applications using MFA**

    Administrators and developers can control access to data and applications using centralized rules and policies configured in Azure AD. 

    In the scenario, the health care organization has an application. You need to allow patients to access their health records from this application.

    Your health care organization requires that all logins occurring outside the company's perimeter network are authenticated with an additional factor of authentication. This requirement combines two aspects of the Azure AD service:
    - Conditional access policies -  You can implement automated access control decisions for accessing your cloud apps that are based on conditions. Conditional access policies are enforced after the first-factor authentication has been completed. You can set up conditional access policy for Azure AD B2C. Conditional access policy has 2 key parts:
        - Conditions – Specified conditions that need to be met
        - Action – defined action steps once the conditions are met 

    - Multi-factor authentication (MFA) - Azure MFA helps safeguard access to data and customer-facing applications while maintaining simplicity for users. It provides additional security by requiring a second form of authentication and delivers strong authentication via a range of easy to use authentication methods. The security of two-step verification lies in its layered approach. Compromising multiple authentication factors presents a significant challenge for attackers. Even if an attacker manages to learn the user's password, it is useless without also having possession of the additional authentication method. MFA provides additional security for your identities by requiring two or more elements for full authentication. These elements fall into three categories:
        - Something you know
        - Something you possess
        - Something you are

        Something you know would be a password or the answer to a security question. Something you possess could be a mobile app that receives a notification or a token generating device. Something you are is typically some sort of biometric property such as a fingerprint or face scan used on many mobile devices. You can set up MFA for Azure AD B2C.

    **How to get Multi-Factor Authentication?**

     Multi-Factor Authentication comes as part of the following offerings:

    - Azure Active Directory Premium or Microsoft 365 Business - Full featured use of Azure Multi-Factor Authentication using Conditional Access policies to require multi-factor authentication.
    - Azure AD-Free, Azure AD Basic, or standalone Office 365 licenses - Use pre-created Conditional Access baseline protection policies to require multi-factor authentication for your users and administrators.
    - Azure Active Directory Global Administrators - A subset of Azure Multi-Factor Authentication capabilities is available as a means to protect global administrator accounts.

    **Multi-factor authentication (MFA) policies**
    You can ensure that customers need more than just a user name and password to access resources. In Azure AD, you can accomplish this goal with a conditional access policy that requires MFA for access.

    MFA policies can be enforced at the tenant, app, or individual user level.

    Describe supported 2nd factors:
    - Mobile app, e.g. Authenticator
    - Mobile app verification code
    - Phone call
    - One-way SMS

    **Knowledge check**
    - Which of the following are valid categories for multi-factor authentication?
    - Multi-Factor Authentication comes as part of which SKUs in Azure ?

1. **What are the MFA features for Azure AD B2C?**

    - Azure AD B2C is a cloud identity management service that enables your applications to authenticate your customers. 
    - Azure AD B2C is built on Azure Active Directory. 
    - Azure AD B2C directories are separate from standard Azure AD directories and can be created in the Azure portal. 
    - Azure AD B2C enables you to customize and control how customers sign up, sign in, and manage their profiles when using your applications. This includes applications developed for iOS, Android, and .NET, among others. 
    - Azure AD B2C provides a social identity login experience, while at the same time protecting your customer identity profile information.  
    - For your health care organization, the application is a customer-facing app. Azure AD will handle the user account creation. The consumer can create an account using Gmail, Yahoo or Hotmail ID. The consumer verifies the account using code and authenticate. Azure AD allows multi-factor authentication. If MFA is enabled, the user will have to go thru the 2-factor authentication before being granted access to the resources.  This is all done via the Azure AD without the developer having to write any code.

1. **Exercise - Enable MFA in Azure AD B2C**

    Exercise must be done in the user's own Azure subscription, as the sandbox does not support Azure premium.

    In this exercise, you will learn how to:

    - Create an Azure AD B2C tenant
    - Link your tenant to your subscription
    - Register an application in Azure Active Directory B2C
    - Create a sign-up and sign-in user flow
    - Create the identity provider applications
    - Add the identity providers to your tenant
    - Add the identity providers to your user flow
    - Use authorization policy multi-factor authentication to protect your content
    - Test your Conditional Access policy

1. **Summary**

    In this unit, we have seen how Azure Active Directory MFA and a conditional access policy can be combined to provide a solid solution for securing access to customer-facing applications, regardless of their location.

## Notes

MFA in B2C - https://docs.microsoft.com/azure/active-directory-b2c/active-directory-b2c-reference-mfa
