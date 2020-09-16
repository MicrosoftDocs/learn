# Title

Secure your identities with Azure Active Directory

## Role(s)

- Solution Architect
- Administrator
- Developer

## Level

- Beginner

## Product(s)

- Azure AD

## Prerequisites

- None

## Summary

Secure internal resources, external resources, SaaS applications, and more with Azure Active Directory. Learn about the features and capabilities available in Azure AD.

## Learning objectives

1. Describe the core terminology of Azure AD.
1. Describe the core features of Azure AD.
1. Describe the licensing models for Azure AD.

## Chunk your content into subtasks

Identify the subtasks of *Secure your identities with Azure Active Directory*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| What is Azure AD? | learn more about the features available to help you secure your organization's identities | Knowledge Check | 2 | Yes |
| Understand Azure AD Terminology | learn more about the features available to help you secure your organization's identities | Knowledge Check | 1 | Yes |
| Licensing Azure AD | learn more about the features available to help you secure your organization's identities | Knowledge Check | 3 | Yes |
| Essential features of Azure AD | learn more about the features available to help you secure your organization's identities | Knowledge Check | 2                                                | Yes |
| Getting Started with Azure AD | learn more about the features available to help you secure your organization's identities | Exercise | 2 | Yes |

## Outline the units

1. **Introduction**

    You work for an organization that has an Active Directory environment on-premises. Your organization is moving to Microsoft 365 and Azure, and you're aware that Azure AD has a number of features that could be beneficial in several use cases. You'd like to learn more about the features available to help you secure your organization's identities.

1. **What is Azure AD?**

   Azure Active Directory (Azure AD) is Microsoft’s cloud-based identity and access management service, which helps your employee's sign-in and access resources

    - Target Audience
    - Azure AD vs on-premises AD
    - The identity secure score
    - Default user permissions in Azure AD
    - Using Azure AD in Europe
    - Using hybrid identity to link your on-premises AD with Azure AD

   **Knowledge Check**

   1. What is a tenant in Azure AD?
       A: A tenant represents an entire organization.
   1. What is an identity security score?
       A: It's a number between 1 and 223 that indicates how aligned your security is with Microsoft best practices.
   1. What is the name associated with a user identity used to authenticate and authorized access to your organization's resources regardless of where they are stored or accessed from?
       A: hybrid identity.

1. **Understand Azure AD terminology**

   Get to grips with the terminology that underlies using Azure AD, including Identity, Azure tenant, custom domain, etc.

   **Knowledge Check**
   1. What is meant by the term Identity?
       A: A thing that can get authenticated.  This can be a user, an application, other servers, or anything that needs to be identified.
   1. What is meant by the term Azure tenant?
       A: A dedicated and trusted instance of Azure AD that represents your organization.
   1. What is meant by the term Azure subscription?
       A: A subscription is the mechanism used to pay for Azure cloud services.

1. **Licensing Azure AD**

    - What is Azure AD licensing
    - License plans
              - Free
              - Premium 1
              - Premium 2
    - Find your service plan. You can view your available service plans, including the individual licenses, check pending expiration dates, and view the number of available assignments
    - Assign licenses
          - Make sure that anyone needing to use a licensed Azure AD service has the appropriate license.
    - Remove a license. You can remove a license from a user's Azure AD user page, from the group overview page for a group assignment, or starting from the Azure AD **Licenses** page to see the users and groups for a license.

   **Knowledge Check**
   1. Which of these if a valid Azure AD licensing plan?
       A: Microsoft 365
   1. Which licensing plan supports Identity protection?
       A: Premium 2

1. **Essential features of Azure AD**

   Once you have chosen your Azure AD license, you can make use of these features. Including Application management, B2B, B2C, Domain Services, etc.

   **Knowledge Check**
   1. What does the identity protection feature provide?
       A: The capability to detect potential vulnerabilities affecting your organization.
   1. What do the Domain services feature provide?
       A: Allows the joining of virtual machines to a domain, without a domain controller.

1. **Getting started with Azure AD**

   A basic introduction to getting started with Azure AD
    - A phased deployment guide for Azure AD
      identifies common tasks that customers find helpful to complete in phases, over the course of 30, 60, 90 days.
              - Build a foundation of security
              - Import users, enable synchronization, and manage devices
              - Manage applications
              - Audit privileged identities, complete an access review, and manage user lifecycle
    - Creating a new tenant in Azure Active Directory
    - Associate or add an Azure subscription to your Azure AD tenant

1. **Exercise - Setting up Azure AD**

   In this exercise, you'll create a new Azure AD tenant...

   1. Sign in to your Azure portal
   1. Create a resource
   1. Select Identity and then Active Directory
   1. Create a directory

   Now apply a subscription to the AD tenant.

   1. Select Subscriptions
   1. Select Change directory
   1. Select the directory created in step 4.
   1. Select the Change Button

   The AD tenant directory is now associated with your subscription.

1. **Summary**

    As the administrator for your on-premises AD, you wanted to explore the features and capabilities of a move to Azure AD.  

    In this module, you've been introduced to the capabilities and features of Azure AD.  You now have a greater awareness of what Azure AD is, and how it differs from your on-premises AD.  You have a broad awareness of the terminology used in an Azure Active Directory. You understand the licensing costs and implications of using Azure AD and what features are associated with each type of license.  Finally you got to see the best practice for a phased deployment of Azure AD into your enterprise.

## Notes

This should be an overview module of what Azure AD is, differentiating it from traditional AD, and what the different features (B2C, B2B, etc.) are. If we can add in a hands-on exercise that adds value, then great, but this may be more topical in nature. Need to have a section on licensing, and would like to ensure we clarify terminology, and the architecture of AAD tenants/subscriptions/etc.

https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-whatis
