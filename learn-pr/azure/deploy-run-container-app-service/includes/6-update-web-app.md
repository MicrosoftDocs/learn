Continuous deployment is a key feature for many fast-moving organizations. They need to deploy the latest version of their software quickly, but with the minimum of fuss.

In the example scenario, the development team adds new features and enhancements to the web app regularly. For this reason, the team has decided to adopt a continuous-deployment approach.

In this unit, you'll configure the continuous deployment of a web app that uses an image in Azure Container Registry.

## What is a webhook?

Azure App Service supports continuous deployment using *webhooks*. A webhook is a service offered by Container Registry. Services and applications can subscribe to the webhook to receive notifications about updates to images in the registry. A web app that uses App Service can subscribe to a Container Registry webhook to receive notifications about updates to the image that contains the web app. When the image is updated and App Service receives a notification, your app automatically restarts the site and pulls the latest version of the image.

## What is the Azure Container Registry tasks feature?

You use the *tasks* feature of Container Registry to rebuild your image whenever its source code changes automatically. You configure a Container Registry task to monitor the GitHub repository that contains your code and trigger a build each time it changes. If the build finishes successfully, Container Registry can store the image in the repository. If your web app is set up for continuous integration in App Service, it receives a notification via the webhook and updates the app.

Let's use these two features to enable continuous integration from the App Service.

## Enable continuous integration from App Service

The **Container settings** page of an App Service resource in the Azure portal automates the setup of continuous integration. If you turn on **Continuous Deployment**, App Service configures a webhook in your container registry to notify an App Service endpoint. Notifications from the registry that reach this endpoint cause your app to restart and pull the latest version of the container image.

### Extend continuous integration to source control by using an Azure Container Registry task

You must create Container Registry tasks from the command line. Unlike the `az acr build` command that we ran earlier to build our image, the `az acr task create` command creates and registers a long-lived task.

The following command shows how to create a task called *buildwebapp*. The task monitors the GitHub repository for the sample web app this module uses. Each time a change is committed, the task builds the `webimage` Docker image from the source code in GitHub and stores it to your registry in Container Registry. Before running this command, you need to create a GitHub personal access token with permissions to create a webhook in your repository. For private repositories, the token will also need full repository read permissions.

```bash
az acr task create --registry <container_registry_name> --name buildwebapp --image webimage --context https://github.com/MicrosoftDocs/mslearn-deploy-run-container-app-service.git --file Dockerfile --git-access-token <access_token>
```
