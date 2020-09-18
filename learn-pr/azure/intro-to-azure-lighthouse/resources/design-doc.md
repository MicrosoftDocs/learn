# Title

Deploying and using Azure Lighthouse

## Role(s)

- Solution Architect
- Administrator
- Technology manager

## Level

- Beginner

## Product(s)

- Azure Lighthouse
- Azure Security Center
- Azure Resource Manager

## Prerequisites

- None

## Summary

Learn about and adopt Azure Lighthouse for your managed service business to manage your customers at scale.

## Learning objectives

1. What is Azure Lighthouse
1. Features of Azure Lighthouse
1. Using Azure Lighthouse for cross tenant management
1. Using Azure Resource Manager templates
1. Set up Security Center with Alerting
1. Creating a managed service offer on the Azure Marketplace

## Outline the units

1. **Introduction**

   The introduction unit summarizes the purpose of the module and describes the objectives.  Each module should have a scenario that defines the objectives of the content and any exercises. Here is a suggested scenario.

   You work for an organization that delivers managed services to your customers. You've been approached by a prospective customer who recently migrated to Azure.  They explain they're a mid-sized company with minimal in-house expertise in Azure management. While they know they want a managed service; they are keen only to extend the necessary access and privileges needed to carry out management, maintenance and governance activities.   Microsoft has recently launched additional management capabilities on Azure, but you know little about it.  This is an important customer, and you're keen to win their business. In the future, you'd also like to scale this service to manage multiple customers with as much automation as possible. To respond, you need to get a better understanding of the capabilities of Azure Lighthouse, its features, any ancillary costs, and how it's set up and configured.

1. **Introduction to Azure Lighthouse**

   In this unit, we'll provide a basic overview of Azure Lighthouse for those readers that are new to the service offering.  This unit covers the following topics.

   - **What is Azure Lighthouse**
     Azure Lighthouse is a free tool that offers service providers a single control plane to view and manage Azure across all their customers with higher automation, scale, and enhanced governance.
   - **Core Azure Lighthouse features**
     What are the core features of Azure Lighthouse.
   - **Benefits of using Azure Lighthouse**
     Azure Lighthouse helps you to profitably and efficiently build and deliver managed services for your customers.

   **Knowledge check**

   A knowledge check is a short multiple-choice quiz of two or three questions to assess if the reader has understood the content of the unit.  The questions presented here test the reader's awareness of Azure Lighthouse.

   - How much does Azure Lighthouse cost to run and deploy?
     - Correct: Azure Lighthouse is free to use; however, costs may be incurred by using underlying Azure services, like Security Center and Log Analytics.
     - Wrong: Azure Lighthouse uses the customers Azure Subscription for billing for it and any underlying Azure services.
     - Wrong: Azure Lighthouse uses the partners Azure Subscription for billing for it and any underlying Azure services.
   - What Azure feature lets you onboard and manage customer resources securely from your tenant without switching context?
     - Correct: Azure delegated resource management
     - Wrong: Azure Resource Manager
     - Wrong: Azure Security Center

1. **Preparing for Azure Lighthouse**

   In this unit, we want to cover preparing your organization to use Azure Lighthouse, highlighting the roles of users, groups, and tenants. Also, the security considerations when implementing Azure Lighthouse.  This unit will cover these subjects in more detail.

   Note: The unit scenario should indicate you want to admin their security center so this how you'd onboard for a specific scenario.  

   - **Getting started**

     Before onboarding customers for Azure delegated resource management, it's important to understand how Azure Active Directory (Azure AD) tenants, users, and roles work in Azure Lighthouse.  We'll show the essential groups that are required to get up and running.

     We'll set up this user with a contributor role/group.  Explain why, rather than speak about group in the abstract.

     - **Understanding tenants**
     - **Authorizations**
       - Understanding roles
         - Why are roles important, and any limitations of roles
       - Best practices
         - Provide tips for using roles
   - **Security Considerations**

     What does the service provider need to consider from a security perspective when preparing for Azure delegated resource management.
     - Azure mulit-factor authentication
     - Permissions structure
     - Permission groups and public offers

1. **Using Azure Resource Manager templates**

   In this unit, you'll learn about the Azure Resource Manager templates permissions required by a Microsoft partner to deliver managed services and onboard a customer, and the tasks to onboarding a customers tenant.
   This unit covers the following topics.

   Note: Using ARM templates are really where you are onboarding the customers.  

   - **Delegated resource management**
     Describe as a service provider how to onboard your customers.  

   - **Azure Resource Management Templates / Scenario's**
     What are the Azure Resource Manager templates?
     - Why use templates.
     - Different templates and the typical scenario's where they would be used
       - Touch on the key onboarding templates

   - **Configure an Azure Resource Manager template**
     The steps to configure an Azure Resource Manager template to onboard your customer.
     - Select the correct onboarding template
       - Talk about specific ways in which that template can be used.
     - Define the configuration parameters file for onboarding

   - **Deploying Azure Resource Manager templates**
     A walkthrough of how you'd go about using or deploying your Azure Resource Manager template.
     - Deploying the templates
     - Confirm successful onboarding

   **Knowledge check**

   Test the reader's awareness of ARM with a few questions

    Make sure the knowledge check is more specific to lighthouse and not just about ARM.  A blend of the two.

   - When deploying at a subscription-level, which method must be used?
      - Correct: PowerShell or Azure CLI
      - Wrong: Azure Resource Manager
      - Wrong: Azure Lighthouse
      - Wrong: Azure Portal
   - Who is responsible for deploying the Azure Resource Manager Template for a customer?
      - Correct: A user in the customers subscription with the owner role. 
      - Wrong: A user in the service providers tenant with the admin role.
      - Wrong: A user in the customers subscription with admin role.
      - Wrong: A user in the service providers tenant with the owner role. 

1. **Managing Azure customers after onboarding**

   In this unit, we'll do the first video walk through, which covers the operations and management of your customers post the onboarding process.  This will be an Azure Portal focused video, showing how you'd manage customers.

   You'll cover these topics:

   - **Finding your Azure Customers**
     - The my customer page
   - **Managing Azure Resources**
     - Taking over management tasks
   - **Enhanced services and scenarios**
     - Using security center to set up alerts/notifications

   **Knowledge Check**

   Test the readers understanding of cross-tenant management with a few questions.

   - When are the service providers users granted access to the customers Azure subscription?
     - Correct: During the onboarding process, the users/groups that will manage the subscription are assigned.
     - Wrong: Once the subscription has been onboarded, the customer will nominate the users from a selected list supplied by the service provider.
     - Wrong: Before the onboarding process can begin, the customer nominates the service providers users.

1. **Publish a managed service offer on the Azure Marketplace**

   In this unit, we'll do the final video walk through, and focus on the creation and deployment of a managed service offer to the Azure Marketplace.

   You'll cover these topics:

   - Create offer in the Cloud Partner Portal
     - Public Plans - for offers you want to make to new customers
       - Maybe phrase this around, having set up a new customer, extending the offer to new customers.
     - Private Plans - for offers you want to make to specific customers
   - Publish a managed service offer to the Azure Marketplace

1. **Summary**

   The Summary unit aims to restate the scenario problem, show how you solved the scenario problem, if applicable, describe the experience without the product, and describe the business impact.

   You know that Microsoft recently launched Azure Lighthouse and knew little about it.  To provide a winning response, you needed to get a better understanding of the Azure Lighthouse service offering.

   Using Azure Lighthouse, you can offer your customers a managed Azure service, where the customer controls the level of authority and control you have over their subscription(s).  Azure Lighthouse capabilities allow you to automate the management of multiple customer subscriptions and tenants. By using ARM templates, you can quickly create service offerings to meet your customer's needs and publish those offerings to the Microsoft Marketplace.  

   Without Azure Lighthouse, your customer would need to grant you direct access to their Azure subscriptions, and you'd require the use of third-party tools to achieve the same goal.

   Customer would have to grant direct access to their Azure instance, and you would have to work on each customer individually.  LIghthouse lets you work on all your customers from one view at the same time.

## Notes on the exercises

Having tested onboarding subscriptions to Lighthouse using the Learn sandbox environment, we have found a number of challenges and have two proposed solutions.

### Challenges

1. A minimum of two subscriptions is required to demonstrate Lighthouse, and the sandbox environment only supports one subscription at a time per user.
1. The user of a sandbox doesn't have sufficient permissions to onboard the subscription to Lighthouse.
1. If a student has sufficient permissions, they can onboard their own subscription to a managing subscription running in a sandbox. This will work, but they would be giving permissions from their own (genuine) subscription to the sandbox subscription. It's unlikely that customers would want to do this.

### Solutions

With these challenges in mind, we propose two possible solutions:

1. Recorded demo featuring a screen capture of the onboarding process. Once onboarding is complete, a quick overview of Lighthouse tools is shown.
1. Step-by-step instructions to onboard a subscription.

Option 1 is preferred. We've checked with Learn, and we can use video. This would provide a more engaging experience than a list of steps.

### Useful links

- https://docs.microsoft.com/en-us/azure/lighthouse/overview
- https://docs.microsoft.com/en-us/azure/lighthouse/concepts/azure-delegated-resource-management
- https://docs.microsoft.com/en-us/azure/lighthouse/how-to/view-manage-service-providers
- https://docs.microsoft.com/en-us/azure/lighthouse/how-to/view-manage-customers
- https://docs.microsoft.com/en-us/azure/lighthouse/concepts/cross-tenant-management-experience
- https://docs.microsoft.com/en-us/azure/lighthouse/how-to/onboard-customer
- https://docs.microsoft.com/en-us/azure/lighthouse/concepts/managed-services-offers
- https://docs.microsoft.com/en-us/azure/lighthouse/concepts/cross-tenant-management-experience#enhanced-services-and-scenarios
- https://azure.microsoft.com/en-us/resources/videos/azure-lighthouse-demo-recording/?cdn=disable
