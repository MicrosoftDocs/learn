Congratulations! You've containerized and deployed a Java app to Azure Kubernetes Service.

You wanted to learn how to containerize and deploy a Java app to Azure. You followed these steps:

1. Containerize a Java app.
1. Build a container image for the Java app.
1. Run the container image locally.
1. Push the container image to Azure Container Registry.
1. Deploy the container image to Azure Kubernetes Service.

You're now confident that you can containerize and deploy a Java app to Azure.

## Monitor and troubleshoot AKS

For immediate troubleshooting, inspect application logs with `kubectl logs deployment/flightbookingsystemsample --tail=100` and Kubernetes events with `kubectl get events --sort-by=.metadata.creationTimestamp`. For platform metrics, control-plane logs, and container log collection, see [Monitor Azure Kubernetes Service (AKS)](/azure/aks/monitor-aks).

This exercise doesn't enable Container insights log collection or configure control-plane diagnostic settings. Those features require separate configuration and can incur additional Azure Monitor charges.

## Clean up resources

In this module, you created Azure resources in a resource group. If you won't need these resources later, delete the resource group from the [Azure portal](https://portal.azure.com) or run the following command in the same local Bash session you used for the exercises:

> [!NOTE]
> If you open another terminal or choose Bash in Azure Cloud Shell, first set `AZ_RESOURCE_GROUP` to the actual resource group name from setup and select the same Azure subscription. A new local Bash session can inherit exported variables when started as a child of your original shell. An independent Azure Cloud Shell session doesn't inherit environment variables from your local shell. Confirm the group name and active subscription before deleting resources.

```bash
az group delete --name "$AZ_RESOURCE_GROUP" --yes
```

This command might take a minute to run.

> [!IMPORTANT]
> Deprovision the Azure resources you used in this module to avoid unwanted charges.

## Additional resources

Learn more about [Docker](https://docs.docker.com/reference/).

Learn more about [Azure Container Registry](https://azure.microsoft.com/services/container-registry/).

Learn more about [Azure Kubernetes Service](https://azure.microsoft.com/services/kubernetes-service/).
