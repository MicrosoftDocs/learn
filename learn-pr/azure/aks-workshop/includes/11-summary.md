In this workshop, you deployed a multicontainer application to Azure Kubernetes Service (AKS). You used Azure Container Registry to store your container images. You deployed MongoDB with Helm and learned about key Kubernetes concepts to make deployments easier, and support communication between applications and services. Wou set up TSL/SSL to ensure communication is encrypted, and also set up autoscaling to handle fluctuations in traffic. 

You can now use what you learned to deploy container-based applications in your environment to AKS.

## Clean up resources

In this module, you created resources by using your Azure subscription. You want to clean up these resources so that there's no continued charge against your account for these resources.

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **Resource groups** on the left.

1. Find the **aksworkshop** resource group, or the resource group name you used, and select it.

1. On the **Overview** tab of the resource group, select **Delete resource group**.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

## Learn more

We've covered a number of concepts in this module. Check out the URLs below to learn more about each of the concepts:

* [Network concepts for applications in AKS](https://docs.microsoft.com/azure/aks/concepts-network#azure-virtual-networks)
* [Helm](https://helm.sh?azure-portal=true)
* [How to use Helm](https://helm.sh/docs/intro/using_helm/?azure-portal=true)
* [Helm charts](https://helm.sh/docs/topics/charts/?azure-portal=true)
* [GitHub Helm charts repository](https://github.com/helm/charts?azure-portal=true)
* [Helm Hub](https://hub.helm.sh?azure-portal=true)
* [MongoDB Helm chart repository](https://github.com/helm/charts/tree/master/stable/mongodb?azure-portal=true)
* [Kubernetes Deployments](https://docs.microsoft.com/azure/aks/concepts-clusters-workloads?azure-portal=true#deployments-and-yaml-manifests)
* [Kubernetes Services](https://docs.microsoft.com/azure/aks/concepts-network?azure-portal=true#services)
* [Kubernetes security concepts](https://docs.microsoft.com//azure/aks/concepts-security?azure-portal=true#kubernetes-secrets)
* [Kubernetes secrets](https://kubernetes.io/docs/concepts/configuration/secret/?azure-portal=true)
* [Let's Encrypt](https://letsencrypt.org/)
* [cert-manager](https://cert-manager.io)
* Wildcard DNS services - [nip.io](https://nip.io), [xip.io](http://xip.io), [sslip.io](https://sslip.io)
* [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/overview?azure-portal=true)
* [Azure Monitor for containers](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview?azure-portal=true)
* [Log Analytics workspace](https://docs.microsoft.com/azure/azure-monitor/learn/quick-create-workspace?azure-portal=true)
