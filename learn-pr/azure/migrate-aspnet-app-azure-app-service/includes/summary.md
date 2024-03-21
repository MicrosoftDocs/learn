Great work! In this module, you learned about accelerating your application modernization journey using Azure Migrate: App Containerization by containerizing and migrating an ASP.NET application to Azure App Service. You containerized and migrated the ASP.NET application *Parts Unlimited* that was running on Windows machines to App Service using the Azure Migrate: App Containerization tool.

Azure Migrate: App Containerization tool is a standalone tool that runs on any Windows machine. The tool can remotely connect to a Windows server machine that's running your ASP.NET web application, that you're looking to containerize and migrate to AKS or Azure App Service. The tool identifies the components that need to be packaged together into the container image and generates a Dockerfile that can help you build out that container image. Further, you can also use the Azure Container Registry based build feature to build that container image and push it to your Container Registry. Then, the tool generates the Kubernetes manifest files that are needed to get that application deployed on App Service. The customizations built into every step along the way can help you parameterize app configurations, store and manage application secrets using Azure Key Vault, and even helps you move app contents to persistent volumes. The tool generated artifacts such as Dockerfiles and Kubernetes manifest files can be downloaded, saved and further used for day two operations.

## Clean up resources

In this module, you created resources by using your Azure subscription. The following steps show you how to clean up these resources so that there's no continued charge against your account.

1. Go to the Azure portal.
2. In the left menu, select **Resource groups**.
3. Select the resource group name that starts with *LearnAppContainerization* or the resource group name you used.
4. On the **Overview** tab, select **Delete resource group**.
5. To confirm the deletion, enter the name of the resource group. To delete all the resources you created in this module, select **Delete**.

## Learn more

For more information on containerizing and migrating your applications to App Service or AKS using Azure Migrate, see these articles:

- [Containerize and migrate ASP.NET applications to AKS](https://go.microsoft.com/fwlink/?linkid=2173710).
- [Containerize and migrate Java web apps to AKS](https://go.microsoft.com/fwlink/?linkid=2173511).
- [Containerize and migrate ASP.NET applications to Azure App Service](https://go.microsoft.com/fwlink/?linkid=2173711).
- [Containerize and migrate Java web apps to Azure App Service](https://go.microsoft.com/fwlink/?linkid=2173512).

