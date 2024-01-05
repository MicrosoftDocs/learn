Azure AI Services include a wide range of AI capabilities that you can use in your applications. To use any of the AI Services, you need to create appropriate resources in an Azure subscription to define an endpoint where the service can be consumed, provide access keys for authenticated access, and to manage billing for your application's usage of the service.

## Options for Azure resources

For many of the available AI Services, you can choose between the following provisioning options:

### Multi-service resource

You can provision an **AI Services** resource that supports multiple different AI Services. For example, you could create a single resource that enables you to use the **AI Language**, **AI Vision**, **AI Speech**, and other services.

This approach enables you to manage a single set of access credentials to consume multiple services at a single endpoint, and with a single point of billing for usage of all services.

### Single-service resource

Each AI service can be provisioned individually, for example by creating discrete **AI Language** and **AI Vision** resources in your Azure subscription.

This approach enables you to use separate endpoints for each service (for example to provision them in different geographical regions) and to manage access credentials for each service independently. It also enables you to manage billing separately for each service.

Single-service resources generally offer a free tier (with usage restrictions), making them a good choice to try out a service before using it in a production application.

## Training and prediction resources

While most Azure AI Services can be used through a single Azure resource, some offer (or require) separate resources for model *training* and *prediction*. This enables you to manage billing for training custom models separately from model consumption by applications, and in most cases enables you to use a dedicated service-specific resource to train a model, but a generic **Azure AI Services** resource to make the model available to applications for inferencing.
