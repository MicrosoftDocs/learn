Every development team has unique requirements that can make implementing an efficient deployment pipeline difficult on any cloud service. App Service supports both automated and manual deployment.

## Automated deployment

Automated deployment, or continuous deployment, is a process used to push out new features and bug fixes in a fast and repetitive pattern with minimal effect on end users.

Azure supports automated deployment directly from several sources. The following options are available:

* **Azure DevOps Services**: You can push your code to Azure DevOps Services, build your code in the cloud, run the tests, generate a release from the code, and finally, push your code to an Azure Web App.
* **GitHub**: Azure supports automated deployment directly from GitHub. When you connect your GitHub repository to Azure for automated deployment, any changes you push to your production branch on GitHub are automatically deployed for you.
* **Bitbucket**: With its similarities to GitHub, you can configure an automated deployment with Bitbucket.

## Manual deployment

There are a few options that you can use to manually push your code to Azure:

* **Git**: App Service web apps feature a Git URL that you can add as a remote repository. Pushing to the remote repository deploys your app.
* **CLI**: `webapp up` is a feature of the `az` command-line interface that packages your app and deploys it. Unlike other deployment methods, `az webapp up` can create a new App Service web app for you if you haven't already created one.
* **Zip deploy**: Use `curl` or a similar HTTP utility to send a ZIP of your application files to App Service.
* **FTP/S**: FTP or FTPS is a traditional way of pushing your code to many hosting environments, including App Service.

## Use deployment slots

Whenever possible, use deployment slots when deploying a new production build. When using a Standard App Service Plan tier or better, you can deploy your app to a staging environment and then swap your staging and production slots. The swap operation warms up the necessary worker instances to match your production scale, thus eliminating downtime.

### Continuously deploy code

If your project has designated branches for testing, QA, and staging, then each of those branches should be continuously deployed to a staging slot. This allows your stakeholders to easily assess and test the deployed branch.

### Continuously deploy containers

For custom containers from Azure Container Registry or other container registries, deploy the image into a staging slot and swap into production to prevent downtime. The automation is more complex than code deployment because you must push the image to a container registry and update the image tag on the webapp.

* **Build and tag the image**: As part of the build pipeline, tag the image with the git commit ID, timestamp, or other identifiable information. It’s best not to use the default “latest” tag. Otherwise, it’s difficult to trace back what code is currently deployed, which makes debugging far more difficult.
* **Push the tagged image**: Once the image is built and tagged, the pipeline pushes the image to our container registry. In the next step, the deployment slot will pull the tagged image from the container registry.
* **Update the deployment slot with the new image tag**: When this property is updated, the site will automatically restart and pull the new container image.
