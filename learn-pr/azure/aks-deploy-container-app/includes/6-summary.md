Your company is experiencing increased demand for its video rendering service because of its international expansion. You're looking for ways to scale the product to provide a better experience for all customers. You want to understand how to deploy applications to an Azure Kubernetes Service (AKS) cluster and allow customers access to the application's services.

You created an AKS cluster and deployed your web application to the Kubernetes cluster. When you deployed the web app, you used the Kubernetes declarative paradigm to describe what you wanted to create. This way, you can keep the app's version history and make future deployments easily reproducible.

Imagine how it would be to deploy this application onto multiple virtual machines or another environment without Kubernetes. You would have to recreate your environment with each new deployment and configure more services to manage user requests between these instances. AKS simplifies the implementation of Kubernetes clusters and provides all the orchestration features you need to manage cloud-native applications.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.


1. Delete the _rg-contoso-video_ resource group and resources that you created for this module.

    ```azurecli-interactive
    az group delete --name rg-contoso-video --yes --no-wait
    ```

   When the resource group is deleted, the **MC_rg-contoso-video_aks-contoso-video_eastus** resource group that contains the cluster's resources is also deleted.

1. Remove the deleted cluster's context using the `kubectl config delete-context <clusterName>` command.

    ```azurecli-interactive
    kubectl config delete-context aks-contoso-video
    ```

    If the command is successful, it returns the following example output:

    ```output
    deleted context aks-contoso-video from /home/user/.kube/config
    ```

## Learn more

To learn more about Azure Kubernetes Service, see the following articles:

- [AKS documentation](/azure/aks/)
- [Introduction to AKS](/training/modules/intro-to-azure-kubernetes-service/)
- [Prepare an application for AKS](/azure/aks/tutorial-kubernetes-prepare-app)
- [Deploy an AKS cluster](/azure/aks/tutorial-kubernetes-deploy-cluster)
- [HTTP application routing](/azure/aks/http-application-routing)
- [Azure CLI documentation](/azure/aks/kubernetes-walkthrough)
- [Azure CLI command docs](/cli/azure/aks/#az-aks-create)
- [AKS HTTPS ingress controller docs](/azure/aks/ingress-tls)
- [Kubernetes ingress controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
- [Kubernetes documentation](https://kubernetes.io/docs/home/)
- [Kubernetes deployments documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- [Kubernetes service types](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)
- [Azure Kubernetes Service (AKS) Production Baseline](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks)
