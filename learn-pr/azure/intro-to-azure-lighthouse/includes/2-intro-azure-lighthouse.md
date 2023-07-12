In the past, Contoso would log in to a customer's Azure tenant with an account provided by the customer. It meant that Contoso only had visibility of one customer's Azure environment at a time. It also placed the responsibility on the customer to create and provide that account, reset the password if necessary, and remove the account once the service contract ended.

Your manager has heard that Azure Lighthouse may provide a better way of accessing and managing Azure tenants for multiple customers while supporting the different requirements of each customer's service contract, removing the administration overhead from the customer and maintaining the customer's visibility of Contoso's access and activities inside their environment.

In this unit, you'll get an introduction to Azure Lighthouse, and the core features and benefits it delivers for managed service providers like Contoso and their customers.

>[!TIP]
> Though this module focuses on enabling the delivery of services under a commercial arrangement between a managed service provider and their customer, the same features and benefits are available to any organization managing multiple Azure tenant environments. This includes large Enterprises such as multi-national/regional organizations or franchisors and their franchisees.

## What is Azure Lighthouse?

One of the first things you find is that Azure Lighthouse is free, providing you have an existing Azure subscription. There's no cost to onboard a customer and no ongoing cost for any of the Azure Lighthouse capabilities.

Azure Lighthouse has been designed to cater to the needs of service providers like Contoso. Lighthouse lets you manage your Azure customer's subscriptions and resources using your own Azure environment. As a result, it gives Contoso control from one single, consolidated view, displaying all of the customer's Azure resources that they have access to. The customer can also see which service providers have access to their resources and with which permissions.

Contoso has experienced a recent increase in the number of customers wanting to use Azure and needing a quality-managed service. You think that a consolidated view across all of your customers will improve the delivery of your services and make it easier to see which resources need attention.

## Core Azure Lighthouse features

At the heart of Azure Lighthouse is **Azure delegated resource management**. This feature controls the method of your access to subscriptions and resources inside another Azure tenant, and whether those resources are visible inside your own Azure environment or not. It leverages Azure's role-based access control (RBAC) to allow a set of permissions for your credentials against the target resources (or scope). It means you can have different permissions to different resources inside the same customer's Azure tenant. We'll go over that in more detail in a later unit.

One of the biggest challenges you face at Contoso is how to onboard your customers and manage them at scale. You're keen to avoid asking each customer to create and manage an account in their Azure tenant for you to use. Enabling Azure delegated resource management is how you onboard a customer and there are two ways to accomplish the task. You can ask your customer to deploy **Azure Resource Manager** templates that you have pre-configured. Or, if you're a Microsoft Partner, you can use **Partner Center** to publish your managed service offers to the Azure Marketplace. You can publish targeted private offers to specific customers, or you can publish public offers visible to everyone, to attract new business.

Finally, to improve the managed service experience for both your company and your customers, Azure Lighthouse in the Azure portal provides two views. Contoso users can find the details of the Azure delegated resource management for all the customers they managing from the **My Customers** view. Your customers can view (and can revoke access from) all of the service providers who have access to their resources, through a dedicated page called **Service Providers**.

## Benefits of using Azure Lighthouse

Azure Lighthouse is a powerful tool that will help Contoso meet the needs of the three new customers, consolidate access to resources across all of their customers and allow Contoso to publish public service offers to attract new customers.

Here's an at-a-glance look at the key benefits of using Azure Lighthouse in your company:

- **Management at scale**: manage and scale all your customers' engagements and life-cycle operations
- **Greater visibility**: customers you manage can now see and audit your actions
- **Improved customer control**: the customer can control the scope and range of your access and can revoke it at any time
- **Preservation of management IP**: Contoso can keep control and access of proprietary automation scripts because they can be run from Contoso's tenant and don't need to be copied into their customer's tenants
- **Improved tools**: Azure Lighthouse supports multiple license models, existing APIs, and other partner programs such as CSP
- **No additional costs**: Azure Lighthouse is provided free, as part of the native Azure platform
