Once the container image is built, the next step is to deploy the application as a container on Azure App Service.

Azure App Service is an HTTP-based service on Azure that you can use to host web applications and REST APIs. This service provides benefits such as:
- Autoscaling to help your app scale to meet demand, based on the parameters you specify, and then automatically reduce the scale when demand decreases.
- High availability to help ensure that your application remains available in case of server or datacenter failures or downtime. Azure makes use of zones, regions, and availability sets to help achieve this.
- Support on the Windows and Linux platforms.
- Integration with automated deployment models using Azure DevOps or GitHub repos.

## **Create new App Service plan** 

The tool provides an option to select an existing App Service plan but for this exercise we will create a new App Service plan. 

1. Click **Create new App Service plan**.  
2. Select the Azure subscription you want to work with. 
3. Select the **LearnAppContainerization** resource group.
4. Specify the AKS cluster name as **LearnAppContainerizationAppServiceplan**.
5. Select any available location and SKU for the App Service plan to be created.  
6. Once you click **Create**, the tool triggers the App Service plan creation. 

## **Specify secret store**
Since you had opted to parameterize application configurations (database connection string), you can choose Azure Key Vault or Kubernetes secrets for managing your application secrets.

1. Select the option to **create new Azure Key Vault** and specify the name as **learnappcontainerizationkeyvault**. The tool will automatically assign the necessary permissions for managing secrets through the Key Vault.


## **Specify Azure file share** 

If you had added more folders and selected the Persistent Volume option, then specify the Azure file share that should be used by Azure Migrate: App Containerization tool during the deployment process. The tool will create new directories in this Azure file share to copy over the application folders that are configured for Persistent Volume storage. During deployment, these directories will be mounted to the application container. 

Since this application didn't have any file system dependencies that we chose to externalize, click **continue** to proceed. 

## **Application deployment configuration** 

Once you've completed the steps above, you'll need to specify the deployment configuration for the application. Click **Configure** to customize the deployment for the application. In the configure step, you can provide the following customizations:

1. **Name**: Specify a unique app name for the application. This name will be used to generate the application URL and used as a prefix for other resources being created as part of this deployment. 
2. **Application Configuration**: For any application configurations that were parameterized, use the following value for the current deployment.
    - **URL**: To create the URL to be specified, navigate to *LearnAppContainerization* resource group and copy the name of the SQL server. 
      - The SQL server will name will be in the format: "appcontainerization-lab0000". 
      - Replace the SQL Server name in the following connection string and paste it in the App Containerization tool. <br/>
        Server=tcp:{SQLSERVERNAME}.database.windows.net,1433;Initial Catalog=partsunlimiteddb;Persist Security Info=False;User ID=adminuser;Password=Password@123;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;

3. Click **Apply** to save the deployment configuration.
4. Click **Continue** to deploy the application.

    ![Screenshot for deployment app configuration.](../media/deploy-aspnet-app-config.png)

## **Deploy the application** 

Once the deployment configuration for the application is saved, the tool will generate the Kubernetes deployment YAML file for the application. The file will be created based on the inputs specified in the deployment specification steps. 

1. Click **Review** to review the deployment specifications for the application. 
2. Select the application to deploy.
3. Click **Deploy** to start deployments for the selected applications.
4. Once the application is deployed, you can click the **Deployment status** column to track the resources that were deployed for the application. 

## **Browse the deployed application**

Now that your application container is deployed, you can browse the migrated application as follows: 

1. Copy the URL displayed in the **Deployment status** column.
2. Paste the URL in a new browser tab. 

You should be able to access your application. 