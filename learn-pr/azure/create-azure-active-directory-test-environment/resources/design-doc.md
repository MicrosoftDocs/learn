# Title

Setup an Azure AD test environment for application testing in Azure

## Role(s)

Developer (developer), Administrator (administrator), Identity and Access Administrator (identity-access-admin)

## Level

intermediate

## Product(s)

Azure
Azure Active Directory

## Prerequisites
- Experience navigating the Azure portal
- Ability to write Azure CLI and PowerShell scripts at the beginner ability
- Knowledge of Azure AD tenants, app registrations, service principals, and users at the beginner level.
- Knowledge of app permissions and consent in Microsoft identity platform at the beginner level.
- To complete the exercise in this module you will need an Azure account with an active subscription. Create an [account for free](https://azure.microsoft.com/free/).

## Summary

Evaluate whether you need a dedicated test tenant for your application test environment. Create a test tenant in Azure AD for testing Azure applications or use in a continuous integration/continuous deployment (CI/CD) pipeline.

## Learning objectives

After completing this module, you'll be able to:

1. Evaluate whether you need a dedicated test Azure AD tenant or production tenant for your application test environment.
1. Set up a test environment in a separate Azure AD tenant.

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Evaluate whether you need a dedicated test tenant or production Azure AD tenant for your application test environment | TODO | Knowledge check | 1 | Yes |
| Create a dedicated Azure AD tenant for your application test environment | TODO | Exercise | 2 | Yes |
| Create an Azure AD app registration as an identity for your web app. | TODO | Exercise | 2 | Yes|
| Create a test user | TODO | Exercise | 2 | No |

## Outline the units

Add more units as needed for your content

1. Introduction

    Suppose you work on a development team that creates internal apps for a retail company. Your team recently released a sales team dashboard for sales managers to manage their direct reports and help them meet their targets. The initial release of the dashboard app went well, but now management and internal customers are requesting new features and bug fixes in advance of the coming holiday season. You and your team have been manually building, testing, and deploying the web app to Azure App Service.  This process has been labor intensive and is affecting your ability to deliver quality updates on time. The configuration of web app authentication, creation of Azure AD test environments and users, and execution of integration tests have been especially time consuming. You need a CI/CD pipeline that automates the deployment of a web app, the configuration of an Azure AD test environment, the configuration of Azure App Service authentication, and the execution of integration tests as users.

    In this module, your team will set up an Azure Active Directory (Azure AD) test environment to help move your web app through the development, test, and production lifecycle.  You'll create a separate test tenant which contains app registrations to represent your application and test clients, test users, and optionally policies to protect resources.

1. Plan your Azure Active Directory test environment

    List the content that will enable the learner to complete the subtask:

    - Evaluate whether you need a dedicated test tenant or production Azure AD tenant for your application test environment.
        - Your application uses settings that require tenant-wide uniqueness. For example, your app might need to access tenant resources as itself, not on behalf of a user, by using app-only permissions. App-only access requires admin consent which applies to the entire tenant. Such permissions are hard to scope down safely within a tenant boundary.
        - You have low tolerance of risk for potential unauthorized access of test resources by tenant members.
        - Configuration changes could negatively impact the critical operation of your production environment.
        - You're unable to create users or other test data in your production tenant.
        - Policies are enabled in your production tenant that require user interaction during authentication. For example, if multi-factor authentication is required for all users, you can't use automated sign-ins for integration testing.
        - Adding non-production resources and/or workload to your production tenant would exceed service or throttling limits for the tenant.

1. Exercise - Setup a dedicated test Azure AD tenant

    List the steps that apply the learning content from previous unit:

    1. Get a test tenant
        1. Join the Microsoft 365 Developer Program (recommended), or
        1. Manually create a tenant
    1. Get an Azure AD subscription (optional)

1. Knowledge check

    What types of questions will test the learning objective? [(Knowledge check guidance)](/help/learn/id-guidance-knowledge-check)

    - (Evaluate) Suppose you have a web application hosted on Azure that signs in users and provides users access to personal medical information.  You need to create or configure a test environment in Azure AD.  Which of the following are good reasons for creating a separate test tenant instead of using your production tenant? 1- You have low tolerance of risk for potential unauthorized access of test resources by tenant members. 2- You can create a tenant for free through the Microsoft 365 Developer Program and can have test user accounts and sample data packs automatically added to the tenant. 3- Policies are enabled in your production tenant that require user interaction during authentication. For example, multi-factor authentication.
    - (Analyze) When creating a separate test tenant in Azure AD, what are some benefits to joining the Microsoft 365 Developer Program instead of manually creating a tenant? 1- It is free and you can have test user accounts and sample data packs automatically added to the tenant. 2- You can only get a free trial of Azure AD Premium1 or Premium 2 licenses through the Microsoft 365 Developer Program. 3-  It includes a Microsoft 365 E5 developer subscription that you can use to create your own sandbox and develop solutions independent of your production environment.

1. Summary

    Great work!  You've successfully setup a dedicated test tenant in Azure AD.  You've also created a test user and app registrations for test clients. Next, your team will move on to implementing the configuration of Azure App Service authentication for the web app in Azure Pipelines.

    Clean up your Azure resources

    1. Clean up Azure AD resources

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.

## Learn more

 You can also learn about App Service in the [Deploy a website to Azure with Azure App Service](https://learn.microsoft.com/learn/paths/deploy-a-website-with-azure-app-service/) learning path.