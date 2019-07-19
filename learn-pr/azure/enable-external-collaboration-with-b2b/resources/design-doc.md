# Module Design

## Title

Enable secure external collaboration for your applications with Azure AD B2B

## Role(s)

- Solution architect
- Developer

## Level

- Intermediate

## Product(s)

- Azure AD and multi-factor authentication
- Azure AD B2B collaboration

## Prerequisites

- Basic understanding of Azure AD

## Summary

Azure Active Directory (Azure AD) business-to-business (B2B) collaboration lets you securely share your company's applications and services with guest users from any other organization, while maintaining control over your own corporate data.

## Learning objectives

- Identify the methods to enable secure external collaboration for your applications with Azure AD B2B collaboration
- Enable B2B collaboration for an application
- Enforce MFA for B2B collaboration

## Chunk your content into subtasks

Identify the subtasks of *Enable secure external collaboration for your applications with Azure AD B2B*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| How to secure external applications | Identify the methods to secure external applications with MFA | Knowledge check | 1 | Yes |
| What are Azure AD  features for B2B? | Identify the MFA features for AAD B2B | Knowledge check | 2 | Yes |
| How to enable MFA in Azure AD B2B | Identify the steps to enable MFA in AAD B2B | Knowledge check | 3 | Yes |

## Outline the units

1. **Introduction**

    You are the solution architect for a health care organization. Your organization is publishing an application that allows clinicians from partnering health providers access health records for patients at your facilities. You need to enable the ability for these organizations to collaborate in a secure way.

1. **How to secure external applications using MFA**

    Administrators and developers can control access to data and applications using centralized rules and policies configured in Azure AD. 

    In the scenario, the health care organization has an application. You need to allow the application to share information with partner organizations.

    Your health care organization requires that all logins occurring outside the company's perimeter network are authenticated with an additional factor of authentication. This requirement combines two aspects of the Azure AD service:
    - Conditional access policies -  You can implement automated access control decisions for accessing your cloud apps that are based on conditions. Conditional access policies are enforced after the first-factor authentication has been completed. You can set up conditional access policy for Azure AD B2B. Conditional access policy has 2 key parts:
        - Conditions – Specified conditions that need to be met
        - Action – defined action steps once the conditions are met 

    - Multi-factor authentication (MFA) - Azure MFA helps safeguard access to data and external applications while maintaining simplicity for users. It provides additional security by requiring a second form of authentication and delivers strong authentication via a range of easy to use authentication methods. The security of two-step verification lies in its layered approach. Compromising multiple authentication factors presents a significant challenge for attackers. Even if an attacker manages to learn the user's password, it is useless without also having possession of the additional authentication method. MFA provides additional security for your identities by requiring two or more elements for full authentication. These elements fall into three categories:
        - Something you know
        - Something you possess
        - Something you are

        Something you know would be a password or the answer to a security question. Something you possess could be a mobile app that receives a notification or a token generating device. Something you are is typically some sort of biometric property such as a fingerprint or face scan used on many mobile devices. You can set up MFA for Azure AD B2B. 

    **How to get Multi-Factor Authentication?**

     Multi-Factor Authentication comes as part of the following offerings:

    - Azure Active Directory Premium or Microsoft 365 Business - Full featured use of Azure Multi-Factor Authentication using Conditional Access policies to require multi-factor authentication.
    - Azure Active Directory Global Administrators - A subset of Azure Multi-Factor Authentication capabilities is available as a means to protect global administrator accounts.

    **Multi-factor authentication (MFA) policies** 
    You can force external users to need more than just a user name and password to access your resources. In Azure AD, you can accomplish this goal with a conditional access policy that requires MFA for access. 

    MFA policies can be enforced at the tenant, app, or individual guest user level, the same way that they are enabled for members of your own organization.
    Describe supported 2nd factors:
    - Mobile app, e.g. Authenticator
    - Mobile app verification code
    - Phone call
    - One-way SMS

    **Knowledge check**
    - Which of the following are valid categories for multi-factor authentication?
    - Multi-Factor Authentication comes as part of which SKUs in Azure ?
    
1. **What are the MFA features for Azure AD B2B?**

    - Azure AD B2B allows secure collaboration and to share your company's applications and services with guest users and external partners from any organization, while maintaining control over your own corporate data. 
    - Azure AD B2B, you invite the guest user to share resources. You don't need to manage the guest's credentials. Guests only have to manage one credential. 
    - You can manage guest accounts created like employee’s accounts with Azure AD features available such as conditional access and MFA. Guests are just users in Azure AD. You invite the user, using their email ID, into the Azure AD tenant. When the user accepts the invitation, the user will go thru the 2-factor authentication before being granted access to the resources. 
    - Apps and resources that use Azure AD to manage their authentication and authorization do not require any additional configuration in order to use guest accounts.  
    
1. **How to enable MFA in Azure AD B2B**

    With Azure AD B2B collaboration, organizations can enforce MFA policies for B2B users. These policies can be enforced at the tenant, app, or individual user level. MFA policies are enforced at the resource organization.
   
    Describe the key steps to enable MFA for Azure AD B2B:
    - Create an Azure AD B2B tenant 
    - Link your tenant to your subscription
    - Register an application in Azure Active Directory B2B
    - Invite guest users using the email identity of their choice
    - Use authorization policies protect your corporate content.
    - Conditional Access policies, such as multi-factor authentication, can be enforced 
        - At the tenant level
        - At the application level
        - For specific guest users to protect corporate apps and data
    - Test your Conditional Access policy
    
    **Knowledge check**
    - At what level can you enforce MFA?
    - How are guest accounts different from regular user accounts?

1. **Summary**

    In this unit, we have seen how Azure Active Directory MFA and Conditional access policy can be combined to provide a solid solution for securing access to external applications, regardless of their location. 

## Notes

MFA in B2B - https://docs.microsoft.com/azure/active-directory/b2b/conditional-access
