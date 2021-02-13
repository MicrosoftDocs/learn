Packaging an app in a Docker image gives you a convenient way to deploy and run the app. You can automate the process of building a Docker image by defining the steps in a Dockerfile. Once you've created an image, you can upload it to a registry such as the Azure Container Registry. From there, you can create a container instance that runs the application.

## Clean up resources

In this module, you created resources by using your Azure subscription. You want to clean up these resources so that you will not continue to be charged for them.

1. In Azure, on the left, select **Resource groups**.

1. Find the **learn-deploy-container-aci-rg** resource group, or whatever resource group name you used, and select it.

1. In the **Overview** tab of the resource group, select **Delete resource group**.

1. This opens a new dialog. Enter the name of the resource group again, and then select **Delete**. This action deletes all of the resources we created in this module.

## Learn More

- [Docker overview](https://docs.docker.com/engine/docker-overview/)
- [Install Docker Desktop for Windows](https://docs.docker.com/docker-for-windows/install/)
- [Docker reference documentation](https://docs.docker.com/reference/)
- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
- [Container Registry](https://azure.microsoft.com/services/container-registry/)
- [Container Instances](https://azure.microsoft.com/services/container-instances/)
