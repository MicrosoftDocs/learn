You have successfully tested the concept of IaC by using GitHub Actions to deploy an Azure Resource Manager template, resulting in provisioning of an AKS cluster suitable for hosting your cloud-native applications. Now, you want to explore a more comprehensive approach that uses GitHub Actions to implement a fully-functional CI/CD pipeline. This pipeline will set up the necessary infrastructure components and build and deploy your containerized applications. Just as with the previous implementation, you intend to use GitHub actions for this purpose.

## How do cloud-native applications benefit from DevOps?

DevOps practices facilitate implementing cloud-native applications. They closely align with Twelve-Factor App guidelines that serve as the foundation for building cloud-native apps. In particular, they help address the following guidelines:

- Code Base. A single code base for each microservice that's stored in its own repository and tracked with version control. It can also be deployed to multiple environments, such as QA, staging, and production.
- Build, Release, Run. Each release must enforce a strict separation across the build, release, and run stages. Each stage should be tagged with a unique ID and support the ability to roll back to a previous version.

CI/CD solutions such as Azure DevOps or GitHub Actions allow you to separate deployments across multiple environments. while also helping to ensure consistency across all of them. Developers author new features in their own environment. Then, after the development is complete, the code is committed into a designated branch of a code repository via a CI pipeline. The commit triggers a build stage that transforms the code into a binary artifact. It then automatically builds, tests, and packages the application.

The release stage picks up the binary artifact, applies external application and environment configuration information, and then produces an immutable release. The release is then deployed to a specified environment and implemented with a CD pipeline. Finally, the released feature is run in the target execution environment.

## How to implement CI/CD by using GitHub actions

Cloud-native applications are particularly suitable for containerization and container orchestration, which further enhances their agility. Typically, their Azure-based implementations tie closely to the use of such services as AKS and Azure Container Registry (ACR).

GitHub Actions accommodate such implementations through a number of built-in and Marketplace-based actions that are specific to Azure. With GitHub Actions for Azure, you can create workflows that build, test, package, release, and deploy your applications to Azure. GitHub Actions also include support for capabilities such as:

- Provisioning resources by using Azure Resource Manager templates.
- Running Azure CLI commands.
- Applying Azure Policy.

Some of the more commonly-used actions applicable to Azure-based cloud-native application scenarios are:

- azure/login. This action performs a non-interactive sign-in by using Azure AD service principal credentials.
- azure/arm-deploy. This action deploys an Azure Resource Manager template to a target Azure resource group.
- azure/k8s-create-secret. This action creates a generic secret or docker-registry secret in a Kubernetes cluster.
- azure/k8s-bake. This action prepares a Kubernetes manifest file for deployment into a target Kubernetes cluster.
- azure/k8s-deploy. This action deploys a Kubernetes manifest file for deployment into a target Kubernetes cluster.

> [!NOTE]
> When implementing GitHub Actions, the names of individual actions are followed by the suffix designating the action version. For example, version 1 of the **azure/login** action has the format of **azure/login@v1**.

A typical GitHub action-based workflow consists of the build and deploy jobs, with the following sequence of actions:

1. Build and push image to container registry (the build job).
    1. Check out access to the repository (actions/checkout@v2).
    1. Sign in to Azure (azure/login@v1).
    1. Create an AKS cluster (azure/arm-deploy@v1).
    1. Create ACR (Azure CLI).
    1. Build and push image to ACR (docker).
1. Deploy application to AKS (the deployment job).
    1. Check out access to the repository (actions/checkout@v2).
    1. Sign in to Azure (azure/login@v1).
    1. Retrieve credentials to access the AKS cluster (Azure CLI).
    1. Create the target AKS namespace (kubectl).
    1. Retrieve the ACR credentials (Azure CLI).
    1. Create a Kubernetes secret (azure/k8s-create-secret@v1).
    1. Prepare a Kubernetes manifest (azure/k8s-bake@v1).
    1. Deploy the Kubernetes manifest (azure/k8s-deploy@v1).

To validate an application's availability, you can use Azure Monitor or Azure Application Insights. Provisioning the corresponding Application Insights instance is commonly part of the CD stage.

To implement Continuous Integration, you can associate the workflow event with a push to the master branch by adding the following section to the beginning of the YAML file:

```yml
name: Build and Deploy to AKS
on:
  push:
    branches:
      - master
```
