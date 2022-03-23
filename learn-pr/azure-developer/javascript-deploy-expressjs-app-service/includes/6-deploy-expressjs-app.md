## Deploy files

When you deploy to App Service, you move all files to the hosting environment that are necessary to run the web app. 

Because this is a Node.js app, it needs to have the npm modules required by the app. As the deployment engineer, you can choose to move the modules as part of deployment or you can have the deployment process on Azure install the resources. 

Typically, having Azure install the npm packages is a better solution and is the process this module uses. 

If you intend to deploy another app to App Service, which requires moving npm modules instead of having Azure install them, you should consider strategies to make the process easier such as: 

* Storing custom npm modules in Azure Storage and installing modules from there. This will speed up the deployment and allows you to make a secure connection between Storage and App Service.

## Azure installs npm packages

In order to tell the Azure deployment process to install the npm modules, the `SCM_DO_BUILD_DURING_DEPLOYMENT` app setting is already set to `true`. 

If you use a different deployment process, instead of Visual Studio Code, you should configure the app setting yourself:

```bash
SCM_DO_BUILD_DURING_DEPLOYMENT=true
```

## Build process

For the sample app used in this module, the build process runs `npm install` which installs the list of dependencies from `package.json`. 

When you deploy other apps, consider using the npm script, `postinstall` to run additional build tasks for your app. 

## Deployment tasks

After you deploy your app, you may want to:

* Automate deployments
* Manually deploy part of the app
* Manually verify files on the host service
* Manually swap slots

### Automate deployments

Deployments to Azure hosting services, including App Service, can include many types of deployments:

* **GitHub actions, Azure Pipelines, and other CI/CD processes** - these are processes that can be orchestrated to have checks before and after deployment.
* **CLI tools** - Azure CLI, Git, and GH (GitHub CLI) provide the ability to push files to a remote location. Azure can be configured as one of your remote locations. This allows you to push to Azure from your local development computer.
* **Development environments** - Visual Studio and Visual Studio Code, along with other development environments, provide mechanisms to authenticate to your Azure hosting environment, such as App Service, and push files to your hosting environment. 

### Verify files on the host service

When coming from another hosting service, you may be accustomed to checking the files deployed successfully by reviewing files on the host service. 

Azure provides several ways to look at files on the host service:
* **Azure portal**: When you look at your host resource with the Azure portal, you can use the provided tools in the portal such as:
    * The in-browser SSH and bash terminals, available from your app's SCM URL: `https://YOUR-APP-NAME.scm.azurewebsites.net`.
* **Visual Studio Code**'s App Service extension provides access to the hosting environment's **files**, which you can locally change and save back to your App Service. 

### Partial deployment

There may be times when the most efficient way to fix or improve a deployment is to move a file or a few files onto the App Service manually.

You can use the same tools as you would verify the files, the Azure portal's SSH and bash in-browser portals or Visual Studio Code's **files**. 

### Manually swap deployment slots

Deployment slots are available on middle and higher pricing tiers. 

THESE TIERS AREN'T AVAILABLE IN THE LEARN SANDBOX.

These slots allow you to keep more than one deployment on App Service. You can swap between slots quickly with the Azure portal, Azure CLI, and Visual Studio Code. 

Use deployment slots when you need to:
* Change which deployment slot's code is live.
* Reverse a deployment.
* Show a temporary "Sorry, we're having issues" message with full branding and contact information.

A deployment slot name, such as `test` is postpended to your resource name. That slot name also becomes part of the URL to reach that slot's deployed code, `https://YOUR-APP-NAME-test.azurewebsites.net`.

## Visual Studio Code deployment sources

Visual Studio Code allows you to deploy a local folder to Azure App Service or you can configure a Deployment source such as GitHub. 

This module deploys all the _local_ files. To deploy those files, you need to clone your own fork to your local computer, then deploy a folder within it.

The Visual Studio Code deployment process creates a **Zip deploy** of the folder you select to deploy. The App Service uses the zipped package, along with the `package.json` to install the npm packages and start the project correctly. 

The **Zip deploy** actions usually have the following order:

    * Create zip package
    * Oryx build
    * Node.js platform detection
    * Create manifest file
    * Npm install
    * Copy files to destination directory `/home/site/wwwroot`
    * Clean up 