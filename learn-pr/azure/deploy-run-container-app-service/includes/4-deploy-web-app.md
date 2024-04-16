You can deploy a web app to Azure App Service directly from Azure Container Registry.

In the example scenario, the team wants to host the web app in App Service. They need to configure App Service to retrieve the image for the web app from the repository in Container Registry.

In this unit, you'll learn how you can configure App Service to deploy a web app from a repository in Container Registry.

## Deploy a web app from a repository in Azure Container Registry

When you create a web app from a Docker image, you configure the following properties:

- **Registry that contains the image**: The registry can be Docker Hub, Container Registry, or some other private registry.
- **Image**: This item is the name of the repository.
- **Tag**: This item indicates which version of the image to use from the repository. By convention, the most recent version is given the tag *latest* when it's built.
- **Startup file**: This item is the name of an executable file or a command to be run when the image is loaded. It's equivalent to the command that you can supply to Docker when loading an image from the command line by running `docker run`. If you're deploying a ready-to-run, containerized app that already has the `ENTRYPOINT` and/or `COMMAND` values configured, you don't need to fill this in.

After you've configured the web app, the Docker image is pulled, and runs as a *cold start* operation the first time a user attempts to visit the site. The app might take a few seconds to start initially, but thereafter, it will be available immediately.
