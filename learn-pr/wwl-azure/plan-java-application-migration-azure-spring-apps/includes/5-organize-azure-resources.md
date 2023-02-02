Now that you have an understanding of which Azure services, you can start working through the first initial stages of migrating the Spring Petclinic application. You'll need to plan how the resource will be organized in Azure prior to creating the resources. To address this need, try to answer the following questions:

 -  **How many resource groups will you be creating for hosting your Azure resources?**
     -  It's a good practice for all Azure resources that are created together for a purpose to be associated with the same resource group. For this exercise that includes one application, you could deploy all resources for this application into a single resource group.
 -  **How will you configure networking for the application components?**
     -  You could deploy Azure Spring Apps either into a virtual network or without a virtual network dependency. The latter approach will simplify the task of making the initial migration of the application accessible from the Internet. In a subsequent exercise, you'll modify your approach to accommodate extra requirements. For now, you won't create a virtual network for Azure Spring Apps.
        
        > [!NOTE]
        > For Azure Kubernetes Service, you would need at least one subnet in a virtual network to run Azure Kubernetes Service cluster nodes. The subnet can be small (for example, /26), thus allowing for a total of 64 IP addresses.
     -  The Azure Database for MySQL deployment won't require virtual network connectivity for the first phase of the migration of the application. Modified in a subsequent exercise for implementing security measures for protection of the full application stack.
 -  **Are there any supporting services you would need for running the application?**
     -  For running Azure Spring Apps, no extra supporting services are needed during the first phase of the migration. All you need is the compute platform and a database.
     -  For running Azure Kubernetes Service, you'll need a container registry for storing container images to be deployed to the cluster. You can use Azure Container Registry.
