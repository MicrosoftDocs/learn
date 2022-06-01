You've now identified the resources you'll need to proceed with the first stage of the migration where you'll determine an optimized organization. After which, you'll need to consider how to connect to your Azure environment.

It's a good time to consider the following questions:

 -  **What tools do I need for connecting to the Azure?**
     -  You can connect to the Azure using the [Azure portal](https://portal.azure.com) or command line tools such as [Azure CLI](/cli/azure/what-is-azure-cli). Using Azure CLI might be more challenging, but it allows for scripting setup tasks and common tasks repeatable.
    
        > [!IMPORTANT]
        > Make sure you can log into the Azure portal by using the credentials that were provided to you.
     -  You should record most commands and scripts you execute for later reference. Making note of the commands will help you in the subsequent exercises for reuse of similar commands.
 -  **What other tools would you need to perform the migration?**
     -  If you're using Azure Spring Apps as the target platform, there are no more tools required for the migration steps.
     -  If you're using Azure Kubernetes Service as the target platform, you'll need Docker tools to containerize the microservices for the application. You'll also need to consider the optimal base image for containerizing the microservices.
