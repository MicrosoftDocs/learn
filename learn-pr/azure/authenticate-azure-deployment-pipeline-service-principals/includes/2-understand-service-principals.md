TODO

## Why does a pipeline need to authenticate?

TODO

## Types of security principals

- [What is a security principal?](https://docs.microsoft.com/azure/role-based-access-control/overview#security-principal)
- What is a service principal? What is a managed identity?
- When you can use a service principal vs. a managed identity?

## How do service principals work behind the scenes?

You might see a few different terms in use when you work with service principals. Although it's not essential to understand these terms just to use service principals in a pipeline, it's helpful to know a little about how this works so you can understand how to resolve any issues that might happen. It also helps to understand these terms when you work with different tools like the Azure portal, or the Graph API.

Service principals are a feature of Azure Active Directory. Azure AD has a concept of an _application_, which represents a system, piece of software, process, or some other non-human agent. You can consider a deployment pipeline to be an applicatoin too. In Azure AD, applications can do many different things that are outside the scope of what we're interested in here. The key point is that service principals and applications are tightly linked. When you look at a service principal in the Azure portal, you see a lot of other functionality and configuration that might not seem relevant. Much of this is because service principals are linked to applications.

Azure AD is a global identity service. Many different companies use Azure AD, and each company is called a _tenant_. One of the features of Azure AD is that one tenant can optionally provide other tenants with access to their applications, and access applications provided by others. This enables a lot of interesting features for cross-company collaboration. When you create a brand new application and tell Azure AD about it, you create an object called an _application registration_. An application registration represents the application in Azure AD.

By default, an application is only used within your own Azure AD tenant. But you can optionally make your application available to other Azure AD tenants too, by configuring it as a _multitenant app_. That's beyond the scope of our discussion here, since multitenant apps aren't commonly used with pipelines. However, it's important to know that whenever an application registration is added to an Azure AD tenant, an _enterprise application_ object is created in that Azure AD tenant. When you create an application registration, most of the tools you use also create an enterprise in your own tenant at the same time, so you may not notice that there's are two different objects.

> [!IMPORTANT]
> A service principal is the same thing as an enterprise application. Some tools uses one name and other tools uses the other.

So, to summarize, when you create a service principal, you actually first create an application registration, and then link it to your tenant by creating a service principal/enterprise application. Most of the tools you work with will do this for you so you're not even aware of it. You might not use all of the features of Azure AD applications when you work with deployment pipelines, but since service principals are related to applications, the same Azure AD object structure applies.

> [!NOTE]
> You might see multiple identifiers, too. An application registration has an object ID and a client ID, and a service principal/enterprise application has an object ID. When you work with pipelines, you'll usually use the application registration's client ID instead of the other IDs.
