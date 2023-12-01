Developers often face many challenging tasks and decisions when building apps for the cloud. Creating a properly architected and configured environment can be a time consuming and difficult process. Developers must account for many different concerns in these environments, such as creating resources, applying configurations, setting up monitoring and logging, building CI/CD pipelines, and other tasks. The Azure Developer CLI (`azd`) reduces and streamlines these responsibilities to help the developer on their journey from a local development environment to an application successfully deployed on Azure.

## Prerequisites

* Before completing this module, you should have a basic conceptual understanding of what the Azure Developer CLI is and how it works. For a high-level introduction to the tool, complete the [Introduction to Azure Developer CLI](/training/modules/introduction-to-azure-developer-cli) module first.

* You will also need an Azure subscription to provision and deploy resources. You can [sign up for an Azure account](https://azure.microsoft.com/free) that includes some free credits for the first 30 days to get started.

> [!NOTE]
> The Azure Developer CLI provisions resources in Azure that may incur costs. If you choose to use your own subscription, make sure to dispose of the resources when you are finished to avoid unwanted charges. The end of this module explains the best ways to perform resource clean up when you are done working with `azd`.

## Example scenario

Suppose you work at a company that operates a ticket management and customer communication platform. Your customers use a mobile app or website to submit questions, report issues or message customer service representatives. The platform requires a variety of Azure services to provide a reliable and scalable architecture:

- Two App Services and an App Service Plan to host the front-end web app and back-end API
- A Key Vault instance to store secure app secrets
- A Cosmos DB database to permanently store app data
- Azure Monitor resources such as Application Insights dashboards
- A Service Bus to manage scalable messaging
- CI/CD pipelines to ensure changes can be reliably deployed through an automated, repeatable process.

Rather than starting from the ground up, you'd like to leverage an existing and extensible architecture template that can provision and deploy most of the resources for you. The development team can then focus on building the app and making smaller adjustments the architecture. You would also like the solution to be reusable and distributable, meaning the same architecture could be consistently recreated at a later date in additional environments for additional teams.

The Azure Developer CLI can help you with these goals using intuitive workflow commands and a powerful template system. The sample app template you'll work with in this module includes many of the previously listed services through the following architecture:

:::image type="content" source="../media/architecture-diagram-small.png" lightbox="../media/architecture-diagram.png" alt-text="An architectural diagram for a messaging app.":::

## What is the main goal?

By the end of this session, you'll understand how to provision and deploy an Azure Developer CLI template, run commands to access additional `azd` features such as monitoring, and see how to redeploy updates to the infrastructure and application code.
