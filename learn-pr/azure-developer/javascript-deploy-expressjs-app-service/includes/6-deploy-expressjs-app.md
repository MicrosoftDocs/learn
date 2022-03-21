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

After you deploy your app, you may want to:

* Automate deployments
* Manual partial deployment
* Manually verify files on the host service
* Manually swap slots

### Automate deployments

Deployments to Azure hosting services, including App Service, can include many types of deployments:

* **GitHub actions, Azure Pipelines, and other CI/CD processes** - these are processes that can be orchestrated to have some checks before and after deployment.
* **CLI tools** - Azure CLI, Git, and GH (GitHub CLI) provide the ability to push files to a remote location. 
* **Development environments** - Visual Studio and Visual Studio Code, along with other development environments, provide mechanisms to authenticate to your Azure hosting environment, such as App Service, and push files to your hosting environment. 

### Verify files on the host service

When coming from another hosting service, you may be accustomed to checking the files deployed successfully by reviewing files on the host service. 

Azure provides several ways to look at files on the host service:
* **Azure portal**: When you look at your host resource for with the Azure portal, you can use the provided development tools in the portal such as:
    * The in-browser SSH terminal.
    * The in-browser bash terminal.
* **Visual Studio Code**'s App Service extension provides access to the hosting environment's **files**, which you can locally change and save back to your App Service. 

### Partial deployment

There may be times when the most efficient way to fix or improve a deployment is to move a file or a few files onto the App Service manually.

You can use the same tools as you would to verify the files, the Azure portal's SSH and BASH in-browser portals or Visual Studio Code's **files**. 

### Manually swap deployment slots

Deployment slots are available on middle and higher pricing tiers. These slots allow you to keep more than one deployment on App Service. You can swap between slots quickly with the Azure portal, Azure CLI, and Visual Studio Code. 

Use deployment slots when you need to:
* Move through a structured deployment process
* Reverse a deployment between from new to old
* Show a temporary "Sorry, we're having issues" message with full branding and contact information




## Deploy local code or GitHub repository

Visual Studio Code allows you to deploy a local folder to Azure App Service or you can configure a Deployment Source such as GitHub. 

This module deploys local files. You clone your own fork of the sample repo and deploy a folder within it.

## Next steps to deploy

In the next exercise:

* Start the sandbox, get the subscription name
* View resource group from Visual Studio Code