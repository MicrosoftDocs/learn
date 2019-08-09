Continuous deployment is a key feature for many fast-moving organizations. They need to deploy the latest version of their software quickly, but with the minimum of fuss.

In the example scenario, the development team adds new features and enhancements to the web app regularly. For this reason, the team has decided to adopt a continuous-deployment approach.

In this unit, you'll configure continuous deployment of a web app that uses an image in Azure Container Registry.

## Continuous deployment by using tasks and webhooks

Azure App Service supports continuous deployment by means of *webhooks*. A webhook is a service offered by Azure Container Registry. Services and applications can subscribe to the webhook to receive notifications about updates to images in the registry. A web app that uses App Service can subscribe to an Azure Container Registry webhook to receive notifications about updates to the image that contains the web app. When the image is updated and App Service receives a notification, your app automatically restarts the site and pulls the latest version of the image.

Additionally, you can use the *tasks* feature of Container Registry to automatically rebuild your image whenever its source code changes. You can configure a Container Registry task to monitor the GitHub repository that contains your code and to trigger a build each time it changes. If the build finishes successfully, Container Registry can store the image in the repository. If your web app is set up for continuous integration in App Service, it receives a notification via the webhook and updates the app.

## Enable continuous integration from App Service

The **Container settings** page of an App Service resource in the Azure portal automates the setup of continuous integration. If you turn on **Continuous Deployment**, App Service configures a webhook in your container registry to notify an App Service endpoint. Notifications from the registry that reach this endpoint cause your app to restart and pull the latest version of the container image.

### Extend continuous integration to source control by using a Container Registry task

Container Registry tasks must be created from the command line. Unlike the `az acr build` command that we used earlier to build our image, the `az acr task create` command creates and registers a long-lived task.

The following command shows how to create a task called *buildwebapp*. The task monitors the GitHub repository for the sample web app used by this module. Each time a change is committed, the task builds the `webimage` Docker image from the source code in GitHub and stores it to your registry in Container Registry.

```bash
az acr task create --registry <container_registry_name> --name buildwebapp --image webimage --context https://github.com/MicrosoftDocs/mslearn-deploy-run-container-app-service.git --branch master
```