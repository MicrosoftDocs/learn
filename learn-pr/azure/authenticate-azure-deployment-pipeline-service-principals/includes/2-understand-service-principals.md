Service principals provide a way to authenticate pipelines, applications, and software. In this unit, you'll learn why service principals are important for deployment pipelines, how they fit into Azure's security model, and how they work.

## Why does a pipeline need to authenticate?

When you deploy a Bicep template, you're asking Azure Resource Manager to create or modify your Azure resources. For example, you've created a Bicep template to deploy your toy company's website. The Bicep template declares resources including an App Service plan, an app, and an Application Insights instance. When you deploy the template, Resource Manager checks whether the resources exist. If they don't, it creates them. If they do, it ensures their configuration matches the configuration you specify in the template.

All of these operations require permission, since they access your Azure resources. The specific permissions needed to deploy will depend on what the template contains. To deploy the example Bicep template for our website, we need to have the following permissions inside the resource group we're deploying to:

- The ability to create deployments. Deployments are considered to be resources with a type of `Microsoft.Resources/deployments`.
- The ability to create and modify App Service plans and apps.
- The ability to create and modify Application Insights instances.

Until now, you've probably deployed your Bicep templates yourself using the Azure CLI or Azure PowerShell. When you use these tools, you normally use your own user account. You authenticate this using your browser. This is referred to as using your own _identity_. When you submit a deployment, Azure verifies that your identity has the necessary permissions to do what your Bicep template specifies.

Once you move to a pipeline, you need to use a different type of identity.

## Types of security principals

Azure Active Directory (Azure AD) is the service that manages identities for Azure. Azure AD has multiple different types of _security principals_:

:::image type="content" source="../media/2-security-principals.png" alt-text="Diagram showing the four types of security principal: user, group, service principal, and managed identity." border="false":::

- **A user** represents a human, who usually signs in interactively using a browser. Users often have security checks associated with their sign-ins, such as multi-factor authentication (MFA) and conditional access based on their location or network.
- **A group** represents a collection of users. Groups don't authenticate directly, but they provide a convenient way to assign permissions to a set of users together.
- **A service principal** represents an automated process or system, which usually doesn't have a human directly running it. Service principals are the topic of this module.
- **A managed identity** is a special type of service principal, which we discuss further below.

### Service principals

A service principal is a special type of account. It can log into Azure AD, but it doesn't have a human interacting with the login process. So, service principals don't have multifactor authentication or other similar protections, since those require a person to do something to prove their identity.

In Azure AD, a service principal is identified by an _application ID_, which is a globally unique ID (GUID), and a credential. For pipelines, the credential is usually a strong password called a _key_.

### Managed identities

You might have heard of the term _managed identity_ before. A managed identity is a special type of service principal. Like a normal service principal, it's designed for situations where a human isn't involved in the authentication process. But unlike a normal service principal, a managed identity doesn't require that you know or maintain its credentials. Instead, Azure manages the credentials automatically, and it provides the credentials to the software that needs them. Managed identities are a great way for Azure resources to authenticate themselves for situations like automating your Azure management, connecting to databases, and reading secret data from Key Vault.

When we work with pipelines, we usually can't use managed identities. This is because managed identities require that you own and manage the Azure resources. When you work with Azure Pipelines and GitHub Actions, you usually rely on infrastructure provided by Microsoft or GitHub.

> [!TIP]
> There are some situations where pipelines can use managed identities. In Azure Pipelines, you can create a _self-hosted agent_ to run your pipelines, and deploy your own virtual machine to do so. Since you own the virtual machine, you can use a managed identity. However, most of the time, you use a _hosted agent_ that is managed by Microsoft or GitHub, which aren't compatible with managed identities.

> [!TIP]
> In other parts of your solution, if you have a choice between using a managed identity or using a normal service principal, it's usually best to go with a managed identity since they are easier to work with and can be more secure.

### Why can't I just use my user account?

You might wonder why you need to create this whole new type of object just to authenticate a pipeline, when you've got user accounts that have worked perfectly well up to now.

User accounts aren't designed or intended for _unattended_ use - in other words, user account authentication may often check that a human is the one actually authenticating. Increasingly often, organizations employ additional security checks during authentication, including MFA, CAPTCHA checks, and inspecting the device and network the user is using.

Pipelines are designed to run your deployments even when nobody is sitting there actively running them - in fact, most of the benefits of pipelines come from the fact that they are completely automated and don't require human interaction. If you store your username and password in a pipeline and try to use it to log in, it probably won't work. Even if it does seem to work, it could easily break in the future if Azure AD or your organizational administrator adds more security checks to your user authentication process.

> [!WARNING]
> It's also a bad idea to save your username and password anywhere, since someone else might get access to it and then use it to impersonate you.

For this reason, the built-in pipeline tasks that interact with Azure don't even let you provide a username and password - they require that you use a service principal.

## How do service principals work under the covers?

You might see a few different terms in use when you work with service principals. Although it's not essential to understand these terms just to use service principals in a pipeline, it's helpful to know a little about how this works so you can understand how to resolve any issues that might happen. It also helps to understand these terms when you work with different tools like the Azure portal, or the Graph API.

Service principals are a feature of Azure Active Directory. Azure AD has a concept of an _application_, which represents a system, piece of software, process, or some other non-human agent. You can consider a deployment pipeline to be an application too. In Azure AD, applications can do many different things that are outside the scope of what we're interested in here. The key point is that service principals and applications are tightly linked. When you look at a service principal in the Azure portal, you see a lot of other functionality and configuration that might not seem relevant. Much of this is because service principals are linked to applications.

Azure AD is a global identity service. Many different companies use Azure AD, and each company is called a _tenant_. One of the features of Azure AD is that one tenant can optionally provide other tenants with access to their applications, and access applications provided by others. This enables a lot of interesting features for cross-company collaboration. When you create a brand new application and tell Azure AD about it, you create an object called an _application registration_. An application registration represents the application in Azure AD.

By default, an application is only used within your own Azure AD tenant. But you can optionally make your application available to other Azure AD tenants too, by configuring it as a _multitenant app_. That's beyond the scope of our discussion here, since multitenant apps aren't commonly used with pipelines. However, it's important to know that whenever an application registration is added to an Azure AD tenant, an _enterprise application_ object is created in that Azure AD tenant. When you create an application registration, most of the tools you use also create an enterprise in your own tenant at the same time, so you may not notice that there's are two different objects.

> [!IMPORTANT]
> A service principal is the same thing as an enterprise application. Some tools uses one name and other tools uses the other. You might also see service principals called _managed applications in your local directory_.

You might see multiple identifiers, too. An application registration has two identifiers: an application ID, which is sometimes called a client ID, and it has an object ID. A service principal/enterprise application has an object ID. When you work with pipelines, you'll usually use the application registration's application ID rather than the other IDs. You'll see how to do this soon.

A managed identity is a special kind of service principal that isn't associated with an application registration.

To summarize, when you create a service principal, you actually first create an application registration, and then link it to your tenant by creating a service principal/enterprise application. Most of the tools you work with will do this for you so you're not even aware of it. You might not use all of the features of Azure AD applications when you work with deployment pipelines, but since service principals are related to applications, the same Azure AD object structure applies.
