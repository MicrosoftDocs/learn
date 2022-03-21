You have many choices when deploying to Azure App Service. Many of the typical choices you may be familiar with such as:

* GitHub repo
* SSH or other CLI tools
* Zip deploy 
* local git
* CI/CD such as GitHub actions or Azure Pipelines

## Deploy files

Deploy to Azure App means to move all files to the hosting environment that are necessary to run the web app. 

Because this is a Node.js app, it needs to have the npm modules required by the app. As the deployment engineer, you can choose to move the modules as part of deployment or you can have the deployment process on Azure install the resources. 

Typically, having Azure install the npm packages is a better solution and is the process this module uses. 

If you intend to deploy another app to App Service which requires moving npm modules instead of having Azure install them, you should consider strategies to make the process easier such as: 

* Storing custom npm modules in Azure Storage and installing modules from there. This will speed up the deployment and allows you to make a secure connection between Storage and App Service.

## Azure installs npm packages

In order to tell the Azure deployment process to install the npm modules, an app setting, `SCM_DO_BUILD_DURING_DEPLOYMENT`, needs to be configured. This setting is configured for you if you deploy by Visual Studio Code. If you use a different deployment process, you should configure the app setting yourself:

```bash
SCM_DO_BUILD_DURING_DEPLOYMENT=true
```

## Build process

For the sample app used in this module, the build process runs `npm install` which accesses the list of dependencies from `package.json`. You will set `SCM_DO_BUILD_DURING_DEPLOYMENT` to true in the following exercise 

## Deployment tasks

After you deploy your app, you may want to overwrite just a file or set of files. Don't do this with Visual Studio Code because it overwrites *all* files.  This is best accomplished with the Azure CLI, the Kudu UI in the Azure portal, or SSH. 

## Deploy local code or GitHub repository

Visual Studio Code allows you to deploy a local folder to Azure App Service or you can configure a Deployment Source such as GitHub. 

This module deploys local files. You clone your own fork of the sample repo and deploy a folder within it.

## Next steps to deploy

In the next exercise:

* Start the sandbox, get the subscription name
* View resource group from Visual Studio Code