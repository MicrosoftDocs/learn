In this unit, you'll learn how to create a Spring application, connect it to a PostgreSQL database, and run everything locally.

Several targets are available to deploy a Quarkus application on Azure.

Azure Container Apps is a fully managed platform that allows you to deploy your containerized applications to Azure with a single command. It is a serverless platform that abstracts away the complexity of managing infrastructure and lets you focus on your application.

The application needs to be packaged into a Docker container. Azure Container Apps supports Docker containers built with Dockerfiles or containers built with Jib.

The container has to be available on a container registry. Azure Container Apps supports Azure Container Registry, Docker Hub, and GitHub Container Registry.

The application needs to be deployed to Azure Container Apps. Azure Container Apps supports deploying from the Azure Portal, Azure CLI, GitHub Action and Azure DevOps.

ACA environment

Logs are aggregated by environment and available in the Azure Portal or using CLI.

