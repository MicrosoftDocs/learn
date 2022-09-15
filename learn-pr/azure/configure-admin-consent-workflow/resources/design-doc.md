# Title

Configure admin consent workflow using Azure Active Directory

## Role(s)

- administrator
- Developer

## Level

intermediate

## Product(s)

- Azure active directory

## Prerequisites

- An Azure account with an [active subscription](https://azure.microsoft.com/free/).
- The Global Administrator, Cloud Application Administrator, or Application Administrator role.
- Ability to develop with JavaScript or TypeScript at the beginner level.

## Summary

To enable admin consent workflow, you'll create or add a new Azure AD application. When the user attempts to sign in to the application, they request admin consent by submitting a request to the designated reviewer via the consent screen. The reviewer receives an email notification, acts on the request via the Azure portal, then the user is notified of the reviewer's action.

## Learning objectives

Upon completion of this module, the learner will be able to:

- Identify possible user and administrator consent configurations
- Configure the admin consent workflow to enable users to submit requests to access applications.
- Test the admin consent workflow feature by using test user accounts.
- Manage, evaluate, and act on admin consent requests

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Create a test app | Suppose you work as an IT admin for retail company that focuses on integrating applications for the employees in their organization. | Exercise | Create a Node.js web application and Azure AD application to implement the admin consent workflow feature.  | Yes |
| Enable admin consent workflow | You hear about the admin consent workflow, which can field and track requests in the Azure portal and give trusted and up to date information for each application | Test the workflow using test user accounts | Exercise | Yes |
| Review admin consent requests | You hear about the admin consent workflow, which can field and track requests in the Azure portal and give trusted and up to date information for each application | Exercise + Knowledge check | Test the admin consent workflow feature by using test user accounts | Yes |

## Outline the units

1. Introduction

Suppose you work as an IT admin for a retail company that focuses on integrating applications for the employees in your organization. To be as secure as possible, you haven't allowed users to grant access to any applications in their tenant, which means only administrators can grant access to adding an application. Sometimes, your coworkers send you emails asking you to add applications they would like to use with their work accounts. Your email has been overwhelmed, and you’re having to research the permissions and information about each application. You hear about the admin consent workflow, which can field and track requests in the Azure portal and give trusted and up to date information for each application.

1. Choose a secure user consent setting

   1. Choose consent setting
   1. Why enable admin consent workflow?
   1. Consent experience without admin consent workflow
   1. Consent experience with admin consent workflow

1. Exercise - Create a test app

   1. Create a web app
   1. Create a web for user sign-in
   1. Create an Azure AD application
   1. Add permissions to the Azure AD app
   1. Update web page with Azure AD application details
   1. Test consent experience without admin consent workflow

1. Configure the admin consent workflow

   1. Consent setting options
   1. Consent experience without admin consent workflow
   1. Consent experience with admin consent workflow

1. Exercise - Enable admin consent workflow

   1. Disable user consent and enable the admin consent workflow
   1. Select designated reviewers
   1. Test the user experience when admin consent workflow is enabled

1. Manage and evaluate admin consent requests

   1. Email notifications
   1. Evaluate admin consent requests
   1. How reviewers respond to the requests

1. Exercise - Review admin consent requests

   1. Locate the admin consent requests
   1. View and act on admin consent requests

1. Knowledge check
    1. How does enabling the admin consent workflow improve the user consent experience?
    1. What are the factors to consider when evaluating an admin consent request?
    1. What options does an administrator or designated review have when responding to admin consent requests?
   1

1. Summary

As the IT administrator for your company, you restricted user access to applications by requiring each user to reach out to you in person when they need to be granted access. This user consent setting enabled you to keep the organization's resources secure from malicious applications, but it was difficult for you to keep up with the growing number of requests.

In this module, you implemented the admin consent workflow that enables the users to request for admin consent right from the consent screen. You were able to view all the incoming requests and their details from the Azure portal and respond to them in a timely and more organized manner.

## Notes

- [Manage and evaluate consent requests](/azure/active-directory/manage-apps/manage-consent-requests)
- [User and admin consent overview](/azure/active-directory/manage-apps/consent-and-permissions-overview)
