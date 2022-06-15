Traditionally, shipping a new application feature requires a complete redeployment of the application itself. Testing or deployment of a feature often requires multiple versions of the application. Each deployment may require different configurations, credentials, changing settings or parameters for testing.

Configuration management is a modern software-development practice that decouples configuration from code deployment and enables quick changes to feature availability on demand. Decoupling configuration as a service enables systems to dynamically administer the deployment lifecycle.

In this unit, you’ll learn about Azure Configuration Management solutions that can help you address deployment issues.

## What is Azure App Configuration?

[Azure App Configuration](/azure/azure-app-configuration/overview) provides a service to centrally manage application settings and feature flags. Use App Configuration to store all the settings for your application and secure their accesses in one place.

The following two diagrams show how Azure App Configuration works in Development and Productions environments:

#### Development

:::image type="content" source="../media/app-config-development.png" alt-text="A graphic depicts the development environment consisting of Visual Studio, VSC, and Azure CLI linked to Azure AD, App configuration and Key Vault.":::


#### Production

:::image type="content" source="../media/app-config-production.png" alt-text="A graphic depicts the production environment. This includes Azure and MSI, together with related Azure services, linked to Azure AD, App configuration and Key Vault.":::


## What are the benefits of App Configuration?

App Configuration offers the following benefits:

- A fully managed service that can be set up in minutes.

- Flexible key representations and mappings.

- Tagging with labels.

- Point-in-time replay of settings.

- Dedicated UI for feature flag management.

- Comparison of two sets of configurations on custom-defined dimensions.

- Enhanced security through Azure-managed identities.

- Encryption of sensitive information at rest and in transit.

- Native integration with popular frameworks.