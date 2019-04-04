Continuous deployment is a key feature of many fast-moving organizations that need to deploy the latest version of their software quickly, but with the minimum of fuss.

In the example scenario, the development team adds new features and enhancements to the web app regularly. For this reason, the team have decided to adopt a continuous deployment approach to the web app.

In this unit, you'll configure continuous deployment of a web app that uses an image in Azure Container Registry.

## Continuous deployment using tasks and webhooks

App Service supports continuous deployment through the use of webhooks. A webhook is a service offered by Azure Container Registry. Services and applications can subscribe to the webhook to receive notifications about updates to images in the registry. An App Service web app can subscribe to an Azure Container Registry webhook to receive notifications about updates to the image containing the web app. When the image is updated and App Service receives a notification, your app will automatically restart the site and pull the latest version of the image.

Additionally, Azure Container Registry's *tasks* feature can be used to automatically rebuild your image whenever its source code changes. You can configure an ACR task to monitor the GitHub repository containing your code and trigger a build each time it changes. If the build completes successfully, ACR can store the image in the repository. If your App Service web app is set up for continuous integration, it will receive a notification via the webhook and update the app.

## Enabling continuous integration from App Service

The **Container settings** page of an App Service resource in the Azure portal automates the setup of continuous integration. By toggling **Continuous Deployment** to On, App Service will configure a webhook in your Azure Container Registry to notify an App Service endpoint. Notifications from the registry that reach this endpoint will cause your app to restart and pull the latest version of the container image.

### Extend continuous integration to source control with an Azure Container Registry task

Azure Container Registry tasks must be created from the command line. Unlike the `az acr build` command we previously used to build our image, the `az acr task create` command creates and registers a long-lived task.

The following command shows how to create a task called *buildwebapp*. The task would monitor the GitHub repository for the sample web app used by this module. Each time a change is committed, the task would build the *webimage* Docker image from the source code in GitHub and store it to your registry in Azure Container Registry.

```bash
az acr task create --registry <container_registry_name> --name buildwebapp --image webimage --context https://github.com/MicrosoftDocs/mslearn-deploy-run-container-app-service.git --branch master
```