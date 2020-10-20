The manual management of many YAML files introduces unnecessary risk when teams want to target efficient deployment, operation, and maintenance of Kubernetes application releases.

By using Helm, DevOps teams can use Helm to standardize, simplify, and implement reusable deployment packages.

You saw how to install third-party packages into your Azure Kubernetes (AKS) Cluster and how to create Helm charts for the applications your teams develop.

Overall you saw how introducing Helm, as part of your software development and release strategy, introduces a number of benefits to simply application deployments and improve productivity.

## Clean up resources

In this module, you created resources by using your Azure subscription. You want to clean up these resources so that there's no continued charge against your account for these resources.

1. Open the Azure portal.

1. Select Resource groups on the left.

1. Find the **learn-helm-deploy-aks-rg** resource group and select it.

1. On the Overview tab of the resource group, select **Delete** resource group.

1. Enter the name of the resource group to confirm. Select **Delete** to delete all of the resources you created in this module.

1. Finally, run the `kubectl config delete-context` command to remove the deleted clusters context. Here is an example of the complete command. Remember to replace the name of the cluster with your cluster's name.

    ```bash
    kubectl config delete-context learn-helm-deploy-aks
    ```

    If successful, the command returns the following example output.

    ```output
    deleted context learn-helm-deploy-aks from /home/user/.kube/config
    ```

## Revert .NET Core SDK changes

The setup script installs a newer version of the .NET Core SDK, alongside the default SDK version of Cloud Shell. You can choose to keep this configuration. To revert to your prior configuration, run the following commands:

```bash
cp ~/.bashrc.bak.learn-helm-aks ~/.bashrc
```

The preceding command restores your prior *:::no-loc text=".bashrc":::* profile startup file from a backup saved by the setup script.

## Reset Azure Cloud Shell

The scripts used in this module make temporary changes to your Cloud Shell preferences. You don't need to reset your configuration if the scripts ran as intended. If you want to reset your Cloud Shell to its default configuration, see the [documentation](/azure/cloud-shell/troubleshooting#delete) on deleting personal data.

## Learn More

- [GitHub module source code repository](https://github.com/MicrosoftDocs/mslearn-aks)

- [Helm documentation](https://helm.sh/docs/helm/helm/)

- [Go template language](https://godoc.org/text/template)

- [Sprig template library](https://masterminds.github.io/sprig/)

- [Get Started With Bitnami Charts Using The Microsoft Azure Marketplace](https://docs.bitnami.com/azure/get-started-charts-marketplace/)

- [ASP.NET Core](https://dotnet.microsoft.com/apps/aspnet)