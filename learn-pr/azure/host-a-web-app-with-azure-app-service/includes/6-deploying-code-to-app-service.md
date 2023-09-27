Now, let's see how we can deploy our application to App Service.

## Automated deployment

Automated deployment, or continuous integration, is a process used to push out new features and bug fixes in a fast and repetitive pattern with minimal impact on end users.

Azure supports automated deployment directly from several sources. The following options are available:

- **Azure DevOps**: You can push your code to Azure DevOps, build your code in the cloud, run the tests, generate a release from the code, and finally push your code to an Azure Web App.
- **GitHub**: Azure supports automated deployment directly from GitHub. When you connect your GitHub repository to Azure for automated deployment, any changes you push to your production branch on GitHub will be automatically deployed for you.
- **Bitbucket**: Due to its similarities to GitHub, you can configure an automated deployment with Bitbucket.
- **OneDrive**: OneDrive is Microsoft's cloud-based storage. You must have a Microsoft account linked to a OneDrive account to deploy to Azure.
- **Dropbox**: Azure supports deployment from Dropbox, which is a popular cloud-based storage system similar to OneDrive.

## Manual deployment

There are a few options that you can use to manually push your code to Azure:

- **Git**: App Service web apps feature a Git URL that you can add as a remote repository. Pushing to the remote repository will deploy your app.
- ***az webapp up***: `webapp up` is a feature of the `az` command-line interface that packages your app and deploys it. Unlike other deployment methods, `az webapp up` can create a new App Service web app for you if you haven't already created one.
- **ZIP deploy**: You can use `az webapp deployment source config-zip` to send a ZIP of your application files to App Service. You can also access ZIP deploy via basic HTTP utilities such as `curl`.
- **WAR deploy**: WAR deploy is an App Service deployment mechanism designed for deploying Java web applications using WAR packages. You can access WAR deploy using the Kudu HTTP API located at `http://<your-app-name>.scm.azurewebsites.net/api/wardeploy`. If that fails, try: `https://<your-app-name>.scm.azurewebsites.net/api/wardeploy`.
- **Visual Studio**: Visual Studio features an App Service deployment wizard that walks you through the deployment process.
- **FTP/S**: FTP or FTPS is a traditional way of pushing your code to many hosting environments, including App Service.
