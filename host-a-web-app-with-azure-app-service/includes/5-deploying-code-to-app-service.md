Now, let's see how we can deploy our application to App Service.

## What is automated deployment?

Automated deployment, or continuous integration, is a process used to push out new features and bug fixes in a fast and repetitive pattern with minimal impact on end users.

Azure supports automated deployment directly from several sources. The following options are available:

- **Visual Studio Team Services (VSTS)**: You can push your code to VSTS, build your code in the cloud, run the tests, generate a release from the code, and finally, push your code to an Azure Web App.

- **GitHub**: Azure supports automated deployment directly from GitHub. When you connect your GitHub repository to Azure for automated deployment, any changes you push to your production branch on GitHub will be automatically deployed for you.

- **Bitbucket**: With its similarities to GitHub, you can configure an automated deployment with Bitbucket.

- **OneDrive**: You can connect your OneDrive account with App Service so that when you change any file on your OneDrive account, Azure will automatically detect it and pull in any changes on the web app files. This is a great option for static websites. It will give you the feeling that you are dealing with a local file system that reflects any changes on Azure, smoothly and instantly.

- **Dropbox**: Similar to OneDrive, you can host your web app files in a Dropbox account and have them automatically push and be deployed over a web app.

- **External repository**: You can configure automated deployment with any external Git repository.

### Non-automated deployment to Azure

There are a few options that you can use to manually push your code to Azure:

- **FTP/S**: FTP or FTPS is a traditional way of pushing your code to any hosting environment. Despite the fact that it is not recommended anymore, you can still make use of it.

- **Web Deploy/IDE**: You can use the Visual Studio IDE to publish your web app to Azure. The Visual Studio publishing mechanism can make use of Web Deploy technology to push your code to Azure.

- **Git**: Azure maintains a **local Git repository** for your application. You can **commit** your code directly to it.

## Summary

Azure provides multiple ways to upload your code to help it better fit in with your current workflow.