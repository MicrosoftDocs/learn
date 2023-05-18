
Traditionally, shipping a new application feature requires a complete redeployment of the application itself. Testing or deployment of a feature often requires multiple versions of the application. Each deployment might require different configurations, credentials, changing settings or parameters for testing.

Configuration management is a modern software-development practice that decouples configuration from code deployment and enables quick changes to feature availability on demand. Decoupling configuration as a service enables systems to dynamically administer the deployment lifecycle.

Let's examine an Azure solution that can help you focus on deployment issues.

### Things to know about Azure App Configuration

[Azure App Configuration](/azure/azure-app-configuration/overview) provides a service to centrally manage application settings and feature flags. You can use App Configuration to store all the settings for your application and secure their accesses in one place.

App Configuration offers many benefits for an application architecture. As you review the features, consider how Azure App Configuration can support deployment for the Tailwind Traders applications.

- Azure App Configuration is a fully managed service that can be set up in minutes, and supports native integration with popular frameworks.

- App Configuration offers flexible key representations and mappings, and point-in-time replay of settings.

- App Configuration has a dedicated UI for feature flag management, and supports resource tagging with labels.

- You can compare two sets of configurations on custom-defined dimensions.

- App Configuration provides enhanced security through Azure Active Directory-managed identities for Azure resources.

- Sensitive information can be encrypted at rest and in transit.

- Azure App Configuration works in both development and production environments. 

#### Development

An Azure App Configuration development environment consists of Visual Studio, Visual Studio Code, and the Azure CLI. These components are linked to Azure Active Directory (Azure AD), App Configuration, and Azure Key Vault.

:::image type="content" source="../media/app-config-development.png" alt-text="Diagram of a development environment with Visual Studio, Visual Studio Code, and the Azure CLI. The components are linked to Azure AD, App Configuration, and Key Vault." border="false":::

#### Production

An Azure App Configuration production environment consists of Azure and Azure AD-managed identities for Azure resources with related Azure services. These components are linked to Azure AD, App Configuration, and Key Vault.

:::image type="content" source="../media/app-config-production.png" alt-text="Diagram of a production environment with Azure and Azure AD-managed identities for Azure resources with related Azure services. The components are linked to Azure AD, App Configuration, and Key Vault." border="false":::