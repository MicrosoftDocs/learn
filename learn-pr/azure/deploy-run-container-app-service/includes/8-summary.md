You can use Azure Container Registry to hold Docker images, and you can construct web apps based on these images. By using a webhook, you can configure continuous deployment for a web app. This process monitors the image for the web app in Container Registry and causes the web app to be redeployed automatically if the image changes.

## Clean up resources

In this module you created resources using your Azure subscription. You want to clean up these resources so that you will not continue to be charged for them.

   1. In Azure, select **Resource groups** on the left.

   1. Find the **learn-deploy-container-acr-rg** resource group, or whatever resource group name you used,  and select it.

   1. In the **Overview** tab of the resource group, select **Delete resource group**.

   1. This opens a new dialog box. Type the name of the resource group  again and select **Delete**. This will delete all of the resources we created in this module.

## Learn more

- [Container Registry](https://azure.microsoft.com/services/container-registry/)
- [Use a custom Docker image for Web App for Containers](https://docs.microsoft.com/azure/app-service/containers/tutorial-custom-docker-image)
- [Tutorial: Build and deploy container images in the cloud with Azure Container Registry Tasks](https://docs.microsoft.com/azure/container-registry/container-registry-tutorial-quick-task)
- [Tutorial: Automate container image builds in the cloud when you commit source code](https://docs.microsoft.com/azure/container-registry/container-registry-tutorial-build-task)
- [List of Azure CLI commands to manage private Azure Container Registries](https://docs.microsoft.com/cli/azure/acr?view=azure-cli-latest)
