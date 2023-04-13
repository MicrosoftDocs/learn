Deployment workflows, applications, and software require a special way to authenticate. In this unit, you'll learn why workload identities are important for deployment workflows, how they fit into Azure's security model, and how they work.

## Why does a workflow need to authenticate?

When you deploy a Bicep file, you effectively ask Azure Resource Manager to create or modify your Azure resources. In the example scenario, you've created a Bicep file to deploy your toy company's website. The Bicep file declares resources that include an Azure App Service plan, an app, and an Application Insights instance.

When you deploy the file, Resource Manager checks whether the resources exist. If they don't, Resource Manager creates them. If any resources already exist, Resource Manager ensures that their configuration matches the configuration that you specify in the Bicep file.

All of these operations require permission, because they access and modify your Azure resources. The specific permissions needed for deployment depend on what the Bicep file contains. To deploy the example file for your toy company's website, you need to have the following permissions inside the resource group that you're deploying to:

- The ability to create deployments. Deployments are resources with a type of `Microsoft.Resources/deployments`.
- The ability to create and modify App Service plans and apps.
- The ability to create and modify Application Insights instances.

Until now, you've probably deployed your Bicep files yourself by using the Azure CLI or Azure PowerShell. When you use these tools, you normally use your own user account and authenticate by using your browser. This is called using your own _identity_. When you submit a deployment, Azure verifies that your identity has the necessary permissions to do what your Bicep template specifies.

After you move to a GitHub Actions deployment workflow, you need to use a different type of identity because the workflow runs deployments without your direct involvement.

## Types of identities

Azure Active Directory (Azure AD) is the service that manages identities for Azure. Some of the main types of identities are:

- **User identities**: A user represents a human who usually signs in interactively by using a browser. Users often have extra security checks to perform when they sign in, such as multifactor authentication (MFA), and Conditional Access based on their location or network.
- **Groups**: A group represents a collection of users. Groups don't authenticate directly, but they provide a convenient way to assign permissions to a set of users together.
- **Workload identities**: A workload is an automated process or system that usually doesn't have a human directly running it. A workload can sign in to Azure AD, but there's no human to sign in and interact with the authentication process. Workload identities don't have MFA or similar protections, because those features require a person to do something to prove their identity.

This module focuses on workload identities.

### Managed identities

A managed identity is associated with an Azure resource. Azure manages the credentials automatically. When the resource needs to access something, Azure automatically signs in by using the credentials.

Managed identities are available for Azure-hosted resources like virtual machines and App Service apps. They're a great way for Azure resources to authenticate themselves for situations like automating your Azure management, connecting to databases, and reading secret data from Azure Key Vault. You can use managed identities with Azure Arc for other scenarios, too.

When you work with deployment workflows, you usually don't use managed identities. Managed identities require that you own and manage the Azure resources that run your deployments. When you work with GitHub Actions, you usually rely on shared infrastructure that Microsoft or GitHub provides. However, when you use a workload identity with GitHub Actions, you can get the main benefit of managed identities: you don't need to manage any credentials.

> [!TIP]
> In other parts of your solution, if you have a choice between using a managed identity or using a normal service principal, it's best to go with a managed identity. Managed identities are easier to work with and are usually more secure.

## Why can't you just use your user account?

You might wonder why you need to create this whole new type of object just to authenticate a deployment workflow, when you have user accounts that work perfectly well.

User accounts aren't designed for unattended use. The authentication process for a user account often checks that a human is the entity that's trying to sign in. Increasingly, organizations use extra security checks during authentication. These checks include MFA, CAPTCHA checks, and inspecting the device and network that the user is using so that they can verify the legitimacy of a request to sign in.

Workflows are designed to run your deployments even when nobody is actively running them. In fact, most of the benefits of deployment workflows come from the fact that they're automated and don't require human interaction.

If you store your username and password in a workflow and try to use them to sign in, they probably won't work. Even if they do seem to work, they can easily break in the future if Azure AD or your organizational administrator adds more security checks to your user authentication process.

> [!WARNING]
> It's also a bad idea to save your username and password anywhere, because someone else might get access to them and then use them to impersonate you.

For these reasons, the built-in GitHub Actions tasks that interact with Azure don't let you provide a user account's credentials. They require you to use a workload identity.

## How do workload identities work?

Workload identities are a feature of Azure AD, which is a global identity service. Many companies use Azure AD, and each company is called a _tenant_.

Azure AD has a concept of an _application_, which represents a system, piece of software, process, or some other non-human agent. You can think of a deployment workflow as an application too.

When you create an application and tell Azure AD about it, you create an object called an _application registration_. An application registration represents the application in Azure AD.

An application registration can have _federated credentials_ associated with it. Federated credentials don't require you to store any secrets. Instead, they enable an Azure AD application to be used with a supported service like GitHub.

When your GitHub Actions workflow needs to authenticate, it contacts Azure AD through GitHub. GitHub tells Azure AD the name of the GitHub organization and repository, and optionally some other information. If you've configured a federated credential that matches the repository's details, Azure AD authenticates your deployment workflow. The workflow can use the permissions that you've assigned to the application.

> [!TIP]
> When you look at an application registration in the Azure portal, you see a lot of other functionality and configuration that might not seem relevant. That's because, in Azure AD, applications can do many things that are beyond the scope of authentication and workflow deployments.

You can also create a _service principal_ object in your Azure AD tenant. A service principal is like a copy of the application for your own Azure AD tenant to use. Service principals and applications are tightly linked. You'll use a service principal later in this module, when you grant your workflow permission to access Azure.

> [!NOTE]
> Some tools call a service principal an _enterprise application_. You might also see service principals called _managed applications in your local directory_, but these aren't the same thing as managed identities.
