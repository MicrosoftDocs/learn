You have successfully tested the concept of IaC by using GitHub Actions to deploy an Azure Resource Manager template, resulting in provisioning of an AKS cluster suitable for hosting your cloud-native applications. Now, you want to explore a more comprehensive approach that leverages GitHub Actions to implement a fully-functional CI/CD pipeline that will not only set up the necessary infrastructure components, but also build and deploy your containerized applications. Just as with the previous implementation, you intend to use GitHub actions for this purpose.

## How do cloud-native applications benefit from DevOps?

DevOps practices facilitate implementing cloud-native applications. They closely align with Twelve-Factor Application guidelines that serve as the foundation for building cloud-native apps. In particular, they help address the following ones:

- Code Base. A single code base for each microservice, stored in its own repository, tracked with version control, which can be deployed to multiple environments, such as QA, staging, and production.
- Build, Release, Run. Each release must enforce a strict separation across the build, release, and run stages. Each should be tagged with a unique ID and support the ability to roll back.

CI/CD solutions such as Azure DevOps or GitHub Actions allow you to separate deployments across multiple environments while, at the same time, ensure consistency across all of them. Developers author new features in their own environment. Once the development is complete, the code is committed into a designated branch of a code repository. The commit triggers a build stage that transforms the code into a binary artifact. The work is implemented with a Continuous Integration (CI) pipeline. It automatically builds, tests, and packages the application.

The release stage picks up the binary artifact, applies external application and environment configuration information, and produces an immutable release. The release is deployed to a specified environment. The work is implemented with a Continuous Delivery (CD) pipeline. Finally, the released feature is run in the target execution environment. 

## How to implement CI/CD by using GitHub actions?

Cloud-native applications are particularly suitable for containerization and container orchestration, which further enhance their agility. Effectively, their Azure-based implementations typically tie closely to the use of such services as Azure Kubernetes Service (AKS) and Azure Container Registry (ACR).

GitHub Actions accommodate such implementations through a number of built-in and Marketplace-based Azure-specific actions. With GitHub Actions for Azure, you can create workflows that build, test, package, release, and deploy your applications to Azure. GitHub Actions also include support for such capabilities as provisioning resources by using Azure Resource Manager templates, running Azure CLI commands, and applying Azure Policy.

Some of the more commonly used actions applicable to Azure-based cloud-native application scenarios include:

- azure/login - performs a non-interactive sign in by using credentials of an Azure Active Directory service principal.
- azure/arm-deploy - deploys an Azure Resource Manager template to a target Azure resource group.
- azure/k8s-create-secret - creates a generic secret or docker-registry secret in a Kubernetes cluster.
- azure/k8s-bake - prepares a Kubernetes manifest file for deployment into a target Kubernetes cluster.
- azure/k8s-deploy - deploys a Kubernetes manifest file for deployment into a target Kubernetes cluster.

> [!NOTE]
> When implementing GitHub Actions, the names of individual actions are followed by the suffix designating the action version. For example, the version 1 of the **azure/login** action has the format of **azure/login@v1**.

A typical GitHub action-based workflow consists of the build and deploy jobs, with the following sequence of actions:

1. Build and push image to container registry (the build job)
    1. Check out access to the repository (actions/checkout@v2)
    1. Log in to Azure (azure/login@v1)
    1. Create an AKS cluster (azure/arm-deploy@v1)
    1. Create ACR (Azure CLI)
    1. Build and push image to ACR (docker)
1. Deploy application to AKS (the deployment job)
    1. Check out access to the repository (actions/checkout@v2)
    1. Log in to Azure (azure/login@v1)
    1. Retrieve credentials to access the AKS cluster (Azure CLI)
    1. Create the target AKS namespace (kubectl)
    1. Retrieve the ACR credentials (Azure CLI)
    1. Create a Kubernetes secret (azure/k8s-create-secret@v1)
    1. Prepare a Kubernetes manifest (azure/k8s-bake@v1)
    1. Deploy the Kubernetes manifest (azure/k8s-deploy@v1)

To validate the availability of the application, you can use Azure Monitor or Azure Application Insights. Commonly, provisioning of the corresponding Application Insights instance is part of the CD stage.

To implement Continuous Integration, you can associate the workflow event with a push to the master branch, by adding the following section to the beginning of the YAML file:

    ```yaml
    name: Build and Deploy to AKS
    on:
      push:
        branches:
          - master
    ```

