Once the container image is built, the next step is to deploy the application as a container on AKS.

AKS simplifies deploying a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. As a hosted Kubernetes service, Azure handles critical tasks like health monitoring and maintenance. Since Kubernetes masters are managed by Azure, you only manage and maintain the agent nodes. 

## **Create the Azure Kubernetes Service Cluster** 

The tool provides an option to select an existing AKS cluster but for this exercise, we create a new AKS cluster. 

1. Select **Create new AKS cluster**.  
2. Select the Azure subscription you want to work with. 
3. Select the **LearnAppContainerization** resource group.
4. Specify the AKS cluster name as **LearnAppContainerizationAKSCluster**.
5. Select any available location and SKU for the AKS cluster to be created.  

Once you select **Create**, the tool triggers the AKS cluster creation process. The tool creates an AKS cluster with a Linux node pool and configure the cluster to have permissions to pull images from the Azure Container Registry that was selected to store the images. 

## **Specify secret store**

Since you had opted to parameterize application configurations (database connection string), you can choose Azure Key Vault or Kubernetes secrets for managing your application secrets.

1. Select the option to **create new Azure Key Vault** and specify the name as **learnappcontainerizationkeyvault**. The tool automatically assigns the necessary permissions for managing secrets through the Key Vault.
2. Create a new managed identity called **learnappcontainerizationmanagedidentity**. This managed identity is used by AKS to access Key Vault to mount secrets for your application. 

## **Create Application Insights resource**

To monitor the containerized Java web application, we'll need to create a new Application Insights resource.

1. Select the option to Create new Azure Application Insights and specify the name as **learnappcontainerizationappinsight**. The tool creates the resource and configures it automatically during deployment. 

## **Specify Azure file share** 

If you had added more folders and selected the Persistent Volume option, then specify the Azure file share that should be used by Azure Migrate: App Containerization tool during the deployment process. The tool creates new directories in this Azure file share to copy over the application folders that are configured for Persistent Volume storage. Once the application deployment is complete, the tool cleans up the Azure file share by deleting the directories it had created. 

1. Select the option to **Create new Storage Account and Azure file share**. 
2. Specify a name for storage account and select the location and SKU for the storage account. 
3. Specify the Azure file share name as **learnappcontainerizationfileshare**. 
4. Select **Create**.

## **Application deployment configuration** 

Once you've completed the steps above, you'll need to specify the deployment configuration for the application. Select **Configure** to customize the deployment for the application. In the configure step, you can provide the following customizations:

1. **Prefix string**: Specify a prefix string to use in the name for all resources that are created for the containerized application in the AKS cluster. Use **airsonictest** as the prefix string for this exercise.
2. **Number of replicas**: Specify the number of application instances (pods) that should run inside the containers. Use the value **1**.
3. **Load balancer type**: Select **External** so that the containerized application is reachable from public networks.
4. **Application Configuration**: For application configurations that were parameterized, use the following value for the current deployment. 
    - Navigate to the *LearnAppContainerization* resource group [Azure portal](https://portal.azure.com). 
    - Copy the name of the MySQL server. The MySQL server name will be in the following format - "airsonic-mysql-server-0000000000". 
    - The MySQL server name will be in the following format - "airsonic-mysql-server-0000000000". 
        - **Username**: Generate the username as **mysqladmin@${MYSQL_SERVER_NAME}**.
        - **Password**: Specify the value as **SuperS3kretPasSw0rd**.
        - **URL**: To create the URL to be specified, replace the MySQL Server name in the following connection string and paste it in the App Containerization tool. <br/>
        **jdbc:mysql://${MYSQL_SERVER_NAME}.mysql.database.azure.com:3306/airsonic?useSSL=false&amp;sessionVariables=sql_mode=ANSI_QUOTES**
5. Select **Apply** to save the deployment configuration.
6. Select **Continue** to deploy the application.

   :::image type="content" source="../media/deploy-java-app-config.png" alt-text="Screenshot for deployment app configuration.":::

## **Deploy the application** 

Once the deployment configuration for the application is saved, the tool generates the Kubernetes deployment YAML file for the application. The file is created based on the inputs specified in the deployment specification steps. 

1. Select **Edit** to review and customize the Kubernetes deployment YAML for the applications. The tool provides the option to customize the YAML file but for this exercise, we stick with the default file generated by the tool.
2. Select the application to deploy.
3. Select **Deploy** to start deployments for the selected applications.
4. Once the application is deployed, you can select the **Deployment status** column to track the resources that were deployed for the application. 

## **Browse the deployed application**

Now that your application container is deployed, you can browse the migrated application as follows - 

1. Copy the IP address displayed in the **Deployment status** column.
2. Paste the IP address in a new browser tab. 
3. Append the IP address with the following string - *:8080/airsonic*

You should be able to access your application. 