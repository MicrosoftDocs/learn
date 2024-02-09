Once the container image is built, the next step is to deploy the application as a container on Azure App Service.

Azure App Service is an HTTP-based service on Azure that you can use to host web applications and REST APIs. This service provides benefits such as:

- Autoscaling to help your app scale to meet demand, based on the parameters you specify, and then automatically reduce the scale when demand decreases.
- High availability to help ensure that your application remains available if there are server or datacenter failures or downtime. Azure achieves high availability by making use of zones, regions, and availability sets.
- Support on the Windows and Linux platforms.
- Integration with automated deployment models using Azure DevOps or GitHub repos.

## Create new App Service plan

The tool provides an option to select an existing App Service plan but for this exercise, let's create a new App Service plan.

1. Select **Create new App Service plan**.  
1. Select the Azure subscription you want to work with. 
1. Select the **LearnAppContainerization** resource group.
1. Specify the Azure Kubernetes Service (AKS) cluster name as **LearnAppContainerizationAppServiceplan**.
1. Select any available location and version for the App Service plan to be created.  
1. Once you select **Create**, the tool triggers the App Service plan creation.

## Specify secret store

Since you opted to parameterize application configurations (database connection string), you can choose Azure Key Vault or Kubernetes secrets for managing your application secrets.

1. Select the option to **create new Azure Key Vault** and specify the name as **learnappcontainerizationkeyvault**. The tool automatically assigns the necessary permissions for managing secrets through the Key Vault.

## Create Application Insights resource

To monitor the containerized Java web application, we need to create a new Application Insights resource.

1. Select the option to **create new Azure Application Insights** and specify the name as **learnappcontainerizationappinsight**. The tool creates the resource and the configuration is performed automatically during deployment.

## Specify Azure file share

If you added more folders and selected the Persistent Volume option, then specify the Azure file share that the Azure Migrate: App Containerization tool should use during the deployment process. The tool creates new directories in this Azure file share to copy over the application folders that are configured for Persistent Volume storage. During deployment, these directories are mounted to the application container.

1. Select the option to **Create new Storage Account and Azure file share**.
1. Specify a name for storage account and select the location and SKU for the storage account.
1. Specify the Azure file share name as **learnappcontainerizationfileshare**.
1. Select **Create**.

## Application deployment configuration

Once you complete the previous steps, you need to specify the deployment configuration for the application. Select **Configure** to customize the deployment for the application and provide the following customizations:

1. **Name**: Specify a unique app name for the application. This name is used to generate the application URL, and is used as a prefix for other resources being created as part of this deployment.

1. **Application Configuration**: For application configurations that were parameterized, use the following value for the current deployment.
    - Navigate to the *LearnAppContainerization* resource group [Azure portal](https://portal.azure.com).
    - Copy the name of the MySQL server. The MySQL server name is in the following format: `airsonic-mysql-server-0000000000`.
        - **Username**: Generate the username as **mysqladmin@${MYSQL_SERVER_NAME}**.
        - **Password**: Specify the value as **SuperS3kretPasSw0rd**.
        - **URL**: Create the URL by replacing `{MYSQL_SERVER_NAME}` in the following connection string, and pasting it in the App Containerization tool. <br/>
        `jdbc:mysql://${MYSQL_SERVER_NAME}.mysql.database.azure.com:3306/airsonic?useSSL=false&amp;sessionVariables=sql_mode=ANSI_QUOTES`

1. Select **Apply** to save the deployment configuration.

1. Select **Continue** to deploy the application.

    ![Screenshot for deployment app configuration.](../media/deploy-java-app-config.png)

## Deploy the application

Once the deployment configuration for the application is saved, the tool generates a deployment file for the application. The file is created based on the inputs specified in the deployment specification steps.

1. Select **Review** to review the deployment specifications for the application. 
1. Select the application to deploy.
1. Select **Deploy** to start deployments for the selected applications.
1. Once the application is deployed, you can select the **Deployment status** column to track the resources that were deployed for the application. 

## Browse the deployed application

Now that your application container is deployed, use the following steps to browse to the migrated application.

1. Copy the URL displayed in the **Deployment status** column.
1. Paste the URL in a new browser tab.
1. Append the URL with the following string: `/airsonic`.

You should now be able to access your application.
