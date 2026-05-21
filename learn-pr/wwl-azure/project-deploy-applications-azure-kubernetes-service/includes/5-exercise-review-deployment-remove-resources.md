This guided project consists of the following exercises:

 -  Exercise 1: Provision Azure Container Registry (ACR) and Azure Kubernetes Service (AKS).
 -  Exercise 2: Build Linux and Windows container images and store them in ACR.
 -  Exercise 3: Deploy container images to AKS.
 -  **Exercise 4: Review the deployment and deprovision all resources.**

In Exercise 4, you review the deployment of the services in the previous exercises and deprovision the resources.

 -  **Task 1: Review the AKS deployments and services**. You review results of both deployments, including the deployments and services objects.
 -  **Task 2: Delete all resources.** You delete all resources provisioned in this guided project.

> [!NOTE]
> To complete this exercise, you need an [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

> [!IMPORTANT]
> Before you launch the hosted exercise, apply these validation corrections to the hosted steps:
>
> - After you list the LoadBalancer services, wait for each `EXTERNAL-IP` to change from `<pending>` to a public IP address before browsing to the service. Public LoadBalancer provisioning can take several minutes and occasionally up to 10 minutes. You can monitor each service with:
>
>   ```bash
>   kubectl get service hellofromnode-service -n=dev-node --watch
>   kubectl get service hellofromdotnet-service -n=dev-dotnet --watch
>   ```
>
>   Use `CTRL-C` to stop each watch after the external IP appears. For details, see [Deploy a Windows Server container on AKS using the Azure portal: Test the application](/azure/aks/learn/quick-windows-container-deploy-portal#test-the-application).
> - If the hosted page expects **Hello World from .Net 7**, verify the page content from the current supported .NET sample you built in Exercise 2 instead. The current cloned sample targets .NET 10, and .NET 7 is out of support; keep the expected output aligned with the sample's current page content and target framework. For details, see [.NET releases and support](/dotnet/core/releases-and-support).

[![Button to launch exercise.](../media/launch-exercise-162c1d6a.png)](https://go.microsoft.com/fwlink/?linkid=2247093)
