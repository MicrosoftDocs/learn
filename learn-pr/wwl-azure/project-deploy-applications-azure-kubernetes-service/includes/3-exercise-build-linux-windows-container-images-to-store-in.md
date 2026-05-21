This guided project consists of the following exercises:

 -  Exercise 1: Provision Azure Container Registry (ACR) and Azure Kubernetes Service (AKS).
 -  **Exercise 2: Build Linux and Windows container images and store them in Azure Container Registry.**
 -  Exercise 3: Deploy container images to Azure Kubernetes Service.
 -  Exercise 4: Review the deployment and deprovision all resources.

In Exercise 2, you build Linux and Windows Docker images and push them to the Azure Container registry created in the previous exercise.

 -  **Task 1**: Build a Linux container image and store it in ACR.
 -  **Task 2**: Build a Windows container image and store it in ACR.

> [!NOTE]
> To complete this exercise, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

> [!IMPORTANT]
> Before you launch the hosted exercise, apply these current container-build corrections to the hosted steps:
>
> - For the Linux Dockerfile, replace `FROM node:20.2-alpine` with a current Node.js LTS Alpine image, such as `FROM node:24-alpine`. Node.js 20 is end-of-life, and Azure JavaScript guidance recommends Long-Term Support (LTS) versions for production. The sample displays `process.env.NODE_VERSION`, so expect the browser output to show the version from the supported image you choose. For details, see [Node.js support in Azure](/azure/developer/javascript/what-is-azure-for-javascript-development#nodejs-support-in-azure).
> - The hosted exercise builds both images with ACR Tasks by using `az acr build`. ACR task runs are temporarily paused from Azure free credits. Use an eligible paid subscription, or open an Azure support case if task runs are blocked. For details, see [Azure Container Registry tasks overview](/azure/container-registry/container-registry-tasks-overview).
> - The Bash variable created by the commands is `ACR_NAME`. If hosted prose refers to `$ACRNAME`, use `$ACR_NAME` instead so `az acr build --registry $ACR_NAME` receives the registry name. For command details, see [az acr build](/cli/azure/acr#az-acr-build).
> - For the Windows image, don't rely on hosted text that describes the sample as .NET 7 or expects a **Hello World from .NET 7** response. .NET 7 is out of support, and the current cloned sample targets .NET 10. Build and validate the current sample with a supported .NET release, preferably .NET 10 LTS. If the sample Dockerfile still needs manual base-image updates, use supported Windows container tags such as `mcr.microsoft.com/dotnet/sdk:10.0-nanoserver-ltsc2022` and `mcr.microsoft.com/dotnet/aspnet:10.0-nanoserver-ltsc2022`, and align any expected browser output with the sample's current page content and target framework. For details, see [.NET releases and support](/dotnet/core/releases-and-support) and [.NET container images](/dotnet/core/docker/container-images).

[![Button to launch exercise.](../media/launch-exercise-162c1d6a.png)](https://go.microsoft.com/fwlink/?linkid=2246993)
