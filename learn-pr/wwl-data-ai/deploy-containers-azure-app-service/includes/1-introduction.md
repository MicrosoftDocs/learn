Containerized applications provide consistent deployment across environments, but running containers in production requires infrastructure management, scaling configuration, and operational tooling. Azure App Service offers a fully managed platform for running custom containers without managing the underlying infrastructure. Developers bring their own container images and benefit from built-in scaling, deployment slots, and integrated diagnostics.

## Scenario: Deploy a document processing service

Imagine you're a developer on a team building a document processing service. The service accepts uploaded documents, extracts text and metadata, and returns structured results to calling applications. Your team packages the service as a Docker container to ensure consistent behavior across development, testing, and production environments.

The service needs different configuration values for each environment. Development uses local storage endpoints and verbose logging. Production connects to Azure Storage accounts and requires API keys for downstream services. Your team wants to avoid rebuilding the container image for each environment.

Operations requires visibility into the service's behavior. When documents fail to process, the team needs to identify whether the issue is a container startup failure, a misconfigured environment variable, or an application error. The current local Docker setup provides limited diagnostic information compared to what production monitoring requires.

Your client expects the service to handle variable load throughout the day. Document uploads spike during business hours and drop overnight. The team needs the platform to scale without manual intervention. Cold start times matter because users notice delays when the app becomes idle and needs to start again, or when new instances start during scale-out.

Azure App Service addresses these requirements by providing a managed container hosting platform with environment-specific configuration, integrated logging, and automatic scaling. This module guides you through deploying and configuring containerized applications on App Service.

## Learning objectives

After completing this module, you'll be able to:

- Deploy custom containers to Azure App Service from container registries.
- Configure container runtime behavior including startup commands, port settings, and persistent storage.
- Configure application settings and connection strings in App Service.
- Observe and troubleshoot containerized applications using App Service diagnostic tools.
