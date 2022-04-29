Pipelines will need to deploy containers from images. For it, you should create an AKS cluster and an AKS container registry.

The AKS cluster will need to retrieve the image from the container registry. You'll need to grant the AKS service principal permission to access the new container registry.

In the pipeline, practical tasks will be:

 -  Create Deployments &amp; Services in AKS.
 -  Update image in AKS.

See [Deploy to Azure Kubernetes Service - Azure Pipelines \| Microsoft Docs](/azure/devops/pipelines/ecosystems/kubernetes/aks-template) for details.
