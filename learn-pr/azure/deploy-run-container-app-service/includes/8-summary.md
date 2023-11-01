You can use Azure Container Registry to hold Docker images, and you can construct web apps based on these images. By using a webhook, you can configure continuous deployment for a web app. This process monitors the image for the web app in Container Registry and causes the web app to be redeployed automatically if the image changes.

## Clean up resources

In this module, you created resources using your Azure subscription. You want to clean up these resources so that you won't continue to be charged for them.

   1. In Azure, select **Resource groups**.

   1. Find the **learn-deploy-container-acr-rg** resource group, or whatever resource group name you used, and select it.

   1. In the **Overview** tab of the resource group, select **Delete resource group**.

   1. A dialog box appears prompting you to confirm the deletion. Enter the name of the resource group again, and select **Delete**. Select **Delete** again to confirm deletion. This will delete all of the resources we created in this module.

## Learn more

- [Azure Container Registry](https://azure.microsoft.com/services/container-registry/)
- [Migrate custom software to Azure App Service using a custom container](/azure/app-service/tutorial-custom-container)
- [Tutorial: Build and deploy container images in the cloud with Azure Container Registry Tasks](/azure/container-registry/container-registry-tutorial-quick-task)
- [Tutorial: Automate container image builds in the cloud when you commit source code](/azure/container-registry/container-registry-tutorial-build-task)
- [List of Azure CLI commands to manage private Azure Container Registries](/cli/azure/acr)