Packaging an app in a Docker image gives you a convenient way to deploy and run the app. You can automate the process of building a Docker image by defining the steps in a Dockerfile. After you've created an image, you can upload it to a registry such as the Azure Container Registry. From there, you can create a container instance that runs the application.

## Clean up resources

In this module, you created resources by using your Azure subscription. You want to clean up these resources so that you won't continue to be charged for them.

1. In the Azure portal, select **Home**, and then select **Resource groups**.

1. Find the **learn-deploy-container-aci-rg** resource group, or whatever resource group name you used, and select it.

1. In the command bar, select **Delete resource group**. A dialog pane appears asking you to type the resource group name.

1. Enter the name of the resource group (**learn-deploy-container-aci-rg** or whatever name you used), then select **Delete**. Select **Delete** again to confirm deletion. All of the resources that you created in this module are deleted along with the resource group.

## Learn More

- [Docker overview](https://docs.docker.com/guides/docker-overview/)
- [Install Docker Desktop on Windows](https://docs.docker.com/desktop/install/windows-install/)
- [Docker reference documentation](https://docs.docker.com/reference/)
- [Best practices for writing Dockerfiles](https://docs.docker.com/build/building/best-practices/)
- [Dockerfile reference](https://docs.docker.com/reference/dockerfile/)
- [Azure Container Registry](https://azure.microsoft.com/products/container-registry/)
- [Container Instances](https://azure.microsoft.com/products/container-instances/)
