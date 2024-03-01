Manually managing many YAML files introduces unnecessary risk when teams want to target efficient deployment, operation, and maintenance of Kubernetes application releases. DevOps teams can use Helm to standardize, simplify, and implement reusable deployment packages.

In this module, you learned how to:

- Describe the benefits of using Helm as a Kubernetes package manager
- Create a Helm chart for a cloud-native application
- Manage a cloud-native application release using Helm

## Clean up resources

To avoid charges to your Azure subscription, you want to clean up the resources you created for this module using the following steps:

1. Navigate to the [Azure portal](https://portal.azure.com).
2. Select **Resource groups** and select the resource group you created for this module.
3. On the Overview tab, select **Delete resource group**.
4. Enter the name of the resource group to confirm and select **Delete** > **Delete**.
5. Navigate back to the **Resource groups** page and select the cluster resource group (the name is prefixed with `MC_`).
6. On the Overview tab, select **Delete resource group**.
7. Enter the name of the resource group to confirm and select **Delete** > **Delete**.

## Learn more

- [Helm documentation](https://helm.sh/docs/helm/helm/)
- [Go template language](https://godoc.org/text/template)
- [Azure Kubernetes Service (AKS) documentation](/azure/aks/)
