Service principals provide a way to authenticate pipelines, applications, and software. In this unit, you'll learn why service principals are important for deployment pipelines, how they fit into Azure's security model, and how they work.

## Why does a pipeline need to authenticate?

When you deploy a Bicep template, you effectively ask Azure Resource Manager to create or modify your Azure resources. In this example scenario, you've created a Bicep template to deploy your toy company's website. The Bicep template declares resources that include an Azure App Service plan, an app, and an Application Insights instance. 

When you deploy the template, Resource Manager checks whether the resources exist. If they don't, Resource Manager creates them. If any already exist, Resource Manager ensures that their configuration matches the configuration that you specify in the template.

All of these operations require permissions, because they access and modify your Azure resources. The specific permissions needed for deployment will depend on what the template contains. To deploy the example Bicep template for your toy company's website, you need to have the following permissions inside the resource group that you're deploying to:

- The ability to create deployments. Deployments are considered to be resources with a type of `Microsoft.Resources/deployments`.
- The ability to create and modify App Service plans and apps.
- The ability to create and modify Application Insights instances.

Until now, you've probably deployed your Bicep templates yourself by using the Azure CLI or Azure PowerShell. When you use these tools, you normally use your own user account and authenticate by using your browser. This is called using your own _identity_. When you submit a deployment, Azure verifies that your identity has the necessary permissions to do what your Bicep template specifies.

After you move to a pipeline, you need to use a different type of identity because the pipeline itself runs deployments, without your direct involvement.

## Types of security principals

Microsoft Entra ID is the service that manages identities for Azure. Microsoft Entra ID has multiple types of identities, which are also called _security principals_:

:::image type="content" source="../media/2-security-principals.png" alt-text="Diagram that shows the four types of security principals: user, group, service principal, and managed identity." border="false":::

- A *user* represents a human who usually signs in interactively by using a browser. Users often have additional security checks to perform when they sign in, such as multifactor authentication (MFA) and Conditional Access based on their location or network.
- A *group* represents a collection of users. Groups don't authenticate directly, but they provide a convenient way to assign permissions to a set of users together.
- A *service principal* represents an automated process or system that usually doesn't have a human directly running it.
- A *managed identity* is a special type of service principal that's designed for situations where a human isn't involved in the authentication process.

### Service principals

A service principal is a type of account. It can sign in to Microsoft Entra ID, but there's no human to sign in and interact with the authentication process. Service principals don't have MFA or similar protections, because those require a person to do something to prove their identity.

In Microsoft Entra ID, a service principal is identified by an _application ID_ and a credential. The application ID is a globally unique ID (GUID). For pipelines, the credential is usually a strong password called a _key_. Alternatively, you can use a _certificate_ as a credential.

### Managed identities

In contrast to the other types of service principals, a managed identity doesn't require that you know or maintain its credentials. A managed identity is associated with an Azure resource. Azure manages the credentials automatically. When the resource needs to access something, Azure automatically signs in by using the credentials.

Managed identities are available for Azure-hosted resources like virtual machines and App Service apps. They're a great way for Azure resources to authenticate themselves for situations like automating your Azure management, connecting to databases, and reading secret data from Azure Key Vault. You can also use managed identities with Azure Arc for other scenarios as well.

When you work with pipelines, you usually can't use managed identities. This is because managed identities require that you own and manage the Azure resources that run your deployments. When you work with Azure Pipelines, you usually rely on shared infrastructure provided by Microsoft.

> [!NOTE]
> There are some situations where pipelines can use managed identities. In Azure Pipelines, you can create a _self-hosted agent_ to run your pipeline's scripts and code by using on your own Azure-based virtual machine. Because you own the virtual machine, you can assign it a managed identity and use it from your pipeline. 
>
> However, most of the time your pipelines run by using a _hosted agent_, which is a server that Microsoft manages. Hosted agents aren't currently compatible with managed identities.

> [!TIP]
> In other parts of your solution, if you have a choice between using a managed identity or using a normal service principal, it's best to go with a managed identity. They're easier to work with and are usually more secure.

## Why can't you just use your user account?

You might wonder why you need to create this whole new type of object just to authenticate a pipeline, when you have user accounts that work perfectly well.

User accounts aren't designed for unattended use. The authentication process for a user account often checks that a human is the entity that's trying to sign in. Increasingly, organizations use additional security checks during authentication. These checks include MFA, CAPTCHA checks, and inspecting the device and network that the user is using so that they can verify the legitimacy of a request to sign in.

Pipelines are designed to run your deployments even when no-one is actively running them. In fact, most of the benefits of pipelines come from the fact that they are completely automated and don't require human interaction. If you store your username and password in a pipeline and try to use them to sign in, they probably won't work. Even if they do seem to work, they can easily break in the future if Microsoft Entra ID or your organizational administrator adds more security checks to your user authentication process.

> [!WARNING]
> It's also a bad idea to save your username and password anywhere, because someone else might get access to them and then use them to impersonate you.

For these reasons, the built-in pipeline tasks that interact with Azure don't let you provide a user account's credentials. They require that you use a service principal.

## How do service principals work?

You might see a few different terms in use when you work with service principals, or with tools like the Azure portal or the Microsoft Graph API. Although it's not essential to understand these terms just to use service principals in a pipeline, it is helpful to know a little about the concepts.

Service principals are a feature of Microsoft Entra ID. Microsoft Entra ID is a global identity service. Many companies use Microsoft Entra ID, and each company is called a _tenant_.

Microsoft Entra ID has a concept of an _application_, which represents a system, piece of software, process, or some other non-human agent. You can think of a deployment pipeline as an application. 

In Microsoft Entra ID, applications can do many things that are beyond the scope of authentication and pipeline deployments. When you create an application and tell Microsoft Entra ID about it, you create an object called an _application registration_. An application registration represents the application in Microsoft Entra ID.

Service principals and applications are tightly linked. Whenever an application registration is added to a Microsoft Entra tenant, a _service principal_ object is created in that Microsoft Entra tenant. When you look at a service principal in the Azure portal, you see a lot of other functionality and configuration that might not seem relevant. Much of this is because service principals are linked to applications.

When you create a service principal, most of the tools that you use also create an application registration at the same time. So you might not notice that there are two different objects.

One type of service principal isn't associated with an application registration: a managed identity. As mentioned earlier, Azure manages the configuration and credentials for a managed identity.

> [!NOTE]
> A service principal is sometimes called an _enterprise application_. Some tools use one name and other tools use the other. You might also see service principals called _managed applications_ in your local directory, but these aren't the same thing as managed identities.

To summarize, when you create a service principal, you first create an application registration, and then you create a service principal for that application registration to use. Most of the tools that you work with will do this for you, so you're not even aware of it. You might not use all of the features of Microsoft Entra applications when you work with deployment pipelines. Even so, because service principals are related to applications, the same Microsoft Entra object structure applies.
