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
| What is Azure B2B? | Understand the purpose of B2B and how it applies to the sample scenario | Knowledge Check | 1 | Yes |
| Collaborate with external users through Azure AD B2B | Enable organizations to collaborate securely | Exercise | 2 | Yes |
| Enable multi-factor authentication in Azure AD B2B | Enable organizations to collaborate securely | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    You're the solution architect for a health care organization. Your organization is publishing an application that allows clinicians from partnering health providers to access health records for patients at your facilities. You need to enable the ability for these organizations to collaborate in a secure way.

2. **What is Azure AD B2B**

   Explain the purpose of Azure AD B2B, and how it works at the conceptual level (implementation details are described in the next unit).

    **Knowledge check**
    - Your organization has a few managers who must be in charge of deciding which specific guest users are allowed to access the application. How can these managers invite guest users?
    - How can you protect the application to ensure that it can only be accessed based on certain criteria having been met?

3. **Collaborate with external users through Azure AD B2B**

    Describe how to Use Azure AD B2B to share access to your apps and services. Cover the following points, and walk through the various stages using the Azure portal:

      - How to collaborate with external users using their identities
      - Using simple invitation and redemption to collaborate with external users.
      - Enabling application owners to manage guest users for their applications.
      - How to protect your shared applications and services through policies.

4. **Exercise - Invite guest users with Azure AD B2B through the Azure portal**

    There are several different ways you can invite external users to collaborate with them. In this exercise, you'll  use the Azure portal to invite users to a directory, a group, and a specific application.

    - Add guest users to the directory
    - Add guest users to a group
    - Add guest users to an application

5. **Enable multi-factor authentication in Azure AD B2B**

    With Azure AD B2B collaboration, organizations can enforce MFA policies for B2B users. These policies can be enforced at the tenant, app, or individual user level. Recap how MFA Azure AD applications can use MFA (already described in detail in the B2C module), and summarize the key steps involved.

    Call out the following points:

    - At what levels can MFA be enforced?
    - How are guest accounts different from regular user accounts? (moved this to unit 2)

        **Knowledge check**
        - At what levels can multi-factor authentication be enforced?
        - Which of the following are valid categories for multi-factor authentication?

6. **Summary**

    In this module, you've learned how you can enable organizations to securely collaborate with one another through Azure AD B2B. You've also learned how multi-factor authentication can help you provide an additional layer of security for your shared applications and services.

## Notes

- MFA in B2B - https://docs.microsoft.com/azure/active-directory/b2b/conditional-access
