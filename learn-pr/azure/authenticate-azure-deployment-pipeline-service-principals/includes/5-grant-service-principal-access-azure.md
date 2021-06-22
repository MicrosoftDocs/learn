By itself, a service principal can't do anything in your Azure environment - just like how a user can't work with your Azure resources unless it's authorized to do so. In this unit, you'll learn about how to authorize service principals to deploy and configure Azure resources, while avoiding being unnecessarily permissive.

## Service principal authorization

Up till now, we've focused on what service principals are, and how they can be used to prove the identity of a pipeline to Azure Active Directory (Azure AD). This is all about _authentication_.

Once Azure AD has authenticated a service principal, the next question becomes: what can this service principal do? This is the responsibility of Azure's role-based access control (RBAC) system, sometimes called identity and access management (IAM). By using Azure RBAC, you can grant a service principal access to a specific resource group, subscription, or management group.

## Select the right role assignment for your pipeline

A role assignment has three key parts: **who** the role is assigned to, **which** role is assigned, and **the resource or resources** that the role assignment applies to.

### Who the role is assigned to

When you work with a service principal, you assign roles for that service principal. Sometimes this is called the _assignee_. You use the service principal's application ID to identify the right service principal.

<!-- TODO confirm that -->

### Which role is assigned

It can be a little more work to figure out which role to assign. In Azure, there are a few common roles:

- **Reader**, which allows the assignee to read information about resources but not modify or delete them.
- **Contributor**, which allows the assignee to create resources, and read and modify existing resources. However, contributors can't grant other principals access to resources.
- **Owner**, which allows full control over resources, including granting other principals access.

There are also lots of very specific roles that provide access just to a subset of functionality. You can even create your own _role definition_ to specify the exact list of permissions that you want to assign.

### The scope of the assignment

TODO

### How do you select the right role assignment?

TODO:
- Go with the least permissive role you can
- Go with the narrowest scope you can
- But make sure you factor in everything a pipeline might do - e.g. for our website's pipeline, maybe next month we'll add a Cosmos DB account. We don't want to be too stingy with permissions to avoid having to constantly tweak them
- Creating custom role definitions for pipelines is certainly possible, but more advanced and not something we recommend for most situations
- Contributor on a RG is a good default option for many pipelines
- Test it

### Mix and match role assignments

You can create multiple role assignments that provide different permissions at different scopes. For example, you might assign a service principal the role of **Reader** with a scope of the entire subscription, and then separately assign the same service principal the role of **Contributor** for a specific resource group. When the service principal tries to work with the resource group, the more permissive assignment is applied.

## Create a role assignment for a service principal

TODO

TODO mention --assignee-object-id versus --assignee

TODO mention Azure AD also has roles, sometimes called directory roles - these are separate to Azure roles