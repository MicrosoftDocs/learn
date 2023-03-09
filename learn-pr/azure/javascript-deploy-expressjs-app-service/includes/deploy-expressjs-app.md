When you deploy to Azure App Service, you move all files to the hosting environment that are necessary to run the web app. You can also instruct the deployment to install the npm dependency packages.

## Deploy files

Because this app is a Node.js app, it needs to have the npm modules the app requires. As the deployment engineer, you can choose to move the modules as part of the deployment. You can also have the deployment process on Azure install the resources.

Typically, it's better to have Azure install the npm packages. This module uses that process.

If you intend to deploy another app to App Service, which requires moving npm modules instead of having Azure install them, consider the following strategy to make the process easier:

- Store custom npm modules in Azure Storage and install modules from there. This process speeds up the deployment and allows you to make a secure connection between Storage and App Service.

## Azure installs npm packages

To tell the Azure deployment process to install the npm modules, the `SCM_DO_BUILD_DURING_DEPLOYMENT` app setting is already set to `true`.

If you use a deployment process that doesn't use Visual Studio Code, configure the app setting yourself:

```bash
SCM_DO_BUILD_DURING_DEPLOYMENT=true
```

## Build process

For the sample app used in this module, the build process runs `npm install`. This command installs the list of dependencies from `package.json`.

When you deploy other apps, consider using the npm script `postinstall` to run more build tasks for your app.

## Deployment tasks

After you deploy your app, you might want to:

- Automate deployments.
- Manually deploy part of the app.
- Manually verify files on the host service.
- Manually swap slots.

### Automate deployments

Deployments to Azure hosting services, including App Service, can include many types of deployments:

- **GitHub actions, Azure pipelines, and other continuous integration and continuous delivery (CI/CD) processes**: These CI/CD processes can be orchestrated to have checks before and after deployment.
- **CLI tools**: Azure CLI, Git, and GitHub CLI provide the ability to push files to a remote location. You can configure Azure as one of your remote locations. This configuration allows you to push to Azure from your local development computer.
- **Development environments**: Visual Studio and Visual Studio Code, along with other development environments, provide mechanisms to authenticate to your Azure hosting environment, such as App Service, and push files to your hosting environment.

### Verify files on the host service

If you've used another hosting service, you might be accustomed to checking the files deployed successfully by reviewing files on the host service.

Azure provides different ways to look at files on the host service:

- **Azure portal**: When you look at your host resource with the Azure portal, you can use the provided tools in the portal, such as the in-browser SSH and bash terminals that are available from your app's SCM URL: `https://YOUR-APP-NAME.scm.azurewebsites.net`.
- **Visual Studio Code**: The Visual Studio Code extension for App Service provides access to the hosting environment's *files*. You can change them locally and save them back to App Service.

### Partial deployment

Sometimes the most efficient way to fix or improve a deployment is to manually move a file or a few files onto App Service.

You can use the same tools as you would verify the files, the Azure portal's SSH and bash in-browser portals or Visual Studio Code's *files*.

### Manually swap deployment slots

Deployment slots are available on middle and higher pricing tiers.

*These tiers aren't available in the Learn sandbox.*

With these slots, you can keep more than one deployment on App Service. You can swap between slots quickly with the Azure portal, the Azure CLI, and Visual Studio Code.

Use deployment slots when you need to:

- Change which deployment slot's code is live.
- Reverse a deployment.
- Show a temporary message, like "Sorry, we're having issues," with branding and contact information.

A deployment slot name, such as `test`, is postpended to your resource name. That slot name also becomes part of the URL to reach that slot's deployed code, `https://YOUR-APP-NAME-test.azurewebsites.net`.

## Visual Studio Code deployment sources

You can use Visual Studio Code to deploy a local folder to App Service. You can also configure a deployment source, such as GitHub.

This module deploys all the *local* files. To deploy those files, clone your own fork to your local computer and then deploy a folder within it.

The Visual Studio Code deployment process creates a *ZIP deploy* of the folder you select to deploy. App Service uses the zipped package and `package.json` to install the npm packages and start the project correctly.

The ZIP deploy actions usually have the following order:

- Create ZIP package
- Onyx build
- Node.js platform detection
- Create manifest file
- Npm install
- Copy files to destination directory `/home/site/wwwroot`
- Clean up
