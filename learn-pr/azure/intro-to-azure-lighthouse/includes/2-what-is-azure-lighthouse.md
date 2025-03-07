In the past, Contoso would sign in to each customer's Azure tenant with an account provided by the customer. With this method, Contoso only had visibility into one customer's Azure environment at a time. Customers were responsible for creating and managing accounts for the service provider in their tenants.

Your manager recently heard that Azure Lighthouse might provide a better way to access and manage Azure tenants for multiple customers. Your manager tells you that Azure Lighthouse may be a way to enable access while supporting the different requirements of each customer's service contract. This would remove the administration overhead from each customer, while still maintaining customers' visibility into Contoso's access and activities inside their environments. Your manager wants you to learn more how Azure Lighthouse would work for Contoso and its customers.

In this unit, you'll get an introduction to Azure Lighthouse and the benefits it provides for managed service providers like Contoso and their customers.

> [!TIP]
> This module focuses on enabling the delivery of services under a commercial arrangement between a managed service provider and a customer. However, the same features and benefits are available to any organization that manages multiple Azure tenant environments, such as multi-national/regional organizations.

## Azure Lighthouse overview

Azure Lighthouse lets service providers like Contoso manage your Azure customer's resources from within your own Azure environment. As a result, it gives Contoso control from one single, consolidated view. Contoso staff can view and manage all customer's Azure resources to which they’ve been granted access. The customer can also see which service providers have access to their resources and with which permissions.

## Core Azure Lighthouse features

At the heart of Azure Lighthouse is Azure delegated resource management. This feature manages access to subscriptions and resources inside another Azure tenant. It uses Azure's role-based access control (RBAC) to allow a set of permissions for Contoso’s users for the customer’s delegated scope. We'll go over this in more detail in the next unit.

One of the biggest challenges you face at Contoso is how to onboard your customers and manage them at scale. You want to avoid asking each customer to create and manage an account in their Azure tenant for you to use. With Azure Lighthouse, there are two ways to onboard customers. You can ask your customer to deploy an Azure Resource Manager template that you pre-configured. Or, if you're a Microsoft Partner, you can use Partner Center to publish your managed service offers to the Azure Marketplace. You can publish targeted private offers to specific customers, or you can publish public offers visible to everyone, to attract new business.

Finally, to improve the managed service experience for both your company and your customers, Azure Lighthouse provides two views in the Azure portal. Contoso users can find details about all the customers they manage in **My customers**. Customers can view information about the service providers who have access to their resources in **Service providers**.

## Benefits of using Azure Lighthouse

Azure Lighthouse is a powerful tool that can help Contoso perform valuable services for their customers, streamline access to resources across all of their customers, and allow Contoso to publish public service offers to attract new customers.

Here are some of the key benefits Contoso will see when using Azure Lighthouse:

- **Management at scale**: Contoso can perform tasks for multiple customers without having to sign in to multiple individual Azure tenants.
- **Preservation of management IP**: Contoso can keep control and access of proprietary automation scripts, because they can be run directly from Contoso's tenant and don't need to be copied into customer tenants.
- **Flexibility**: Azure Lighthouse supports multiple license models, existing APIs and Azure services, and other partner programs such as Cloud Solution Provider (CSP).
- **No additional costs**: Azure Lighthouse is provided free, as part of the native Azure platform.

For Contoso's customers, benefits from Contoso's use of Azure Lighthouse include:

- **Ease of access**: Customers don't have to manage Contoso's user accounts, even if Contoso changes the individuals who work with those customers.
- **Transparency**: Customers have full visibility into all actions that Contoso performs in their tenants.
- **Improved customer control**: Customers can control the scope and range of Contoso's access, and can revoke it at any time.

