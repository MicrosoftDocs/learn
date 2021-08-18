Access management for cloud resources is a critical function for any organization that is using the cloud. Role-based access control (RBAC) helps you manage who has access to Azure resources, what they can do with those resources, and what areas they have access to.

Azure RBAC is an authorization system built on Azure Resource Manager that provides fine-grained access management of resources in Azure.

## What can I do with Azure roles?

Here are some examples of what you can do with Azure RBAC:

 -  Allow an application to access all resources in a resource group
 -  Allow one user to manage virtual machines in a subscription and another user to manage virtual networks
 -  Allow a DBA group to manage SQL databases in a subscription
 -  Allow a user to manage all resources in a resource group, such as virtual machines, websites, and subnets

## Concepts

 -  **Security principal**. Object that represents something that is requesting access to resources. Examples: user, group, service principal, managed identity
 -  **Role definition**. Collection of permissions that lists the operations that can be performed. Examples: Reader, Contributor, Owner, User Access Administrator
 -  **Scope**. Boundary for the level of access that is requested. Examples: management group, subscription, resource group, resource
 -  **Assignment**. Attaching a role definition to a security principal at a particular scope. Users can grant access described in a role definition by creating an assignment. Deny assignments are currently read-only and can only be set by Azure.

## Considerations

Using Azure RBAC, you can segregate duties within your team and grant only the amount of access to users that they need to perform their jobs. Instead of giving everybody unrestricted permissions in your Azure subscription or resources, you can allow only certain actions at a particular scope.

When planning your access control strategy, it's a best practice to grant users the least privilege to get their work done.
