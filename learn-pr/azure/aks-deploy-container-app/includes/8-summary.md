The company needed to deploy its infrastructure from the ground up. So we created an AKS cluster and deployed a ping application to check it's working properly.

We used Kubernetes' declarative paradigm to help us describe what we wanted to create, this way we can keep a version history and make it easily reproducible. AZ CLI allowed us to connect to our managed Kubernetes service with AKS without having to worry about infrastructure and to get up and running fast.

Imagine how would it be to deploy this application on a VM or another environment without Kubernetes. Having AKS to manage the heavy lifting for us, it made possible not only to save much time but to make our deployment much simpler.

## Learn more

To learn more about Azure Kubernetes Service, visit the following articles:

- [AKS Documentation on Microsoft Docs](https://docs.microsoft.com/azure/aks/?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Introduction to AKS](https://docs.microsoft.com/learn/modules/intro-to-azure-kubernetes-service/?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Prepare an application for AKS](https://docs.microsoft.com/azure/aks/tutorial-kubernetes-prepare-app?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Integrating ACR with AKS](https://docs.microsoft.com/azure/aks/cluster-container-registry-integration?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Deploy an AKS cluster](https://docs.microsoft.com/azure/aks/tutorial-kubernetes-deploy-cluster?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [HTTP Application Routing](https://docs.microsoft.com/azure/aks/http-application-routing?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [Azure CLI documentation on Microsoft Docs](https://docs.microsoft.com/azure/aks/kubernetes-walkthrough?WT.mc_id=deploycontainerapps_summary-learn-ludossan)
- [AZ CLI command docs](https://docs.microsoft.com/cli/azure/aks?view=azure-cli-latest&WT.mc_id=deploycontainerapps_summary-learn-ludossan#az-aks-create)
- [Kubernetes' Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
- [Kubernetes documentation](https://kubernetes.io/docs/home/)
- [Kubernetes Service Types](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)
