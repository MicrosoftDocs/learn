Manually managing many YAML files introduces unnecessary risk when teams want to target efficient deployment, operation, and maintenance of Kubernetes application releases.

DevOps teams can use Helm to standardize, simplify, and implement reusable deployment packages.

You learned how to install third-party packages into your Azure Kubernetes (AKS) Cluster and how to create Helm charts for the applications your teams develop.

Overall, you learned how introducing Helm as part of your software development and release strategy introduces many benefits to simply application deployments and improve productivity.

## Clean up resources

To avoid charges to your Azure subscription, you'll want to clean up the resources you created for this module by following these steps"."

1. Open the Azure portal.

1. Select Resource groups on the left.

1. Find the **learn-helm-deploy-aks-rg** resource group and select it.

1. On the Overview tab of the resource group, select **Delete** resource group.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

1. Finally, run the `kubectl config delete-context` command to remove the deleted clusters context. Here's an example of the complete command. Remember to replace the name of the cluster with your cluster's name:

    ```bash
    kubectl config delete-context learn-helm-deploy-aks
    ```

    If successful, the command returns the following example output:

    ```output
    deleted context learn-helm-deploy-aks from /home/user/.kube/config
    ```

## Revert .NET SDK changes

Review the following steps to revert any changes that you made to your Cloud Shell environment:

1. Run the following command to restore your prior *:::no-loc text=".bashrc":::* profile startup file from a backup saved by the setup script.

    ```bash
    cp ~/.bashrc.bak.learn-helm-deploy-aks ~/.bashrc
    ```

## Learn More

- [GitHub module source code repository](https://github.com/MicrosoftDocs/mslearn-aks)

- [Helm documentation](https://helm.sh/docs/helm/helm/)

- [Go template language](https://godoc.org/text/template)

- [Sprig template library](https://masterminds.github.io/sprig/)

- [Get Started With Bitnami Charts Using The Microsoft Azure Marketplace](https://docs.bitnami.com/azure/get-started-charts-marketplace/)

- [ASP.NET](https://dotnet.microsoft.com/apps/aspnet)
