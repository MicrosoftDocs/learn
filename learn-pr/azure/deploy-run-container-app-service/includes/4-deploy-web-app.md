You can deploy a web app to App Service directly from Azure Container Registry.

In the example scenario, the team wants to host the web app in App Service. They need to configure App Service to retrieve the image for the web app from the repository in Azure Container Registry.

In this unit, you'll learn how you can configure App Service to deploy a web app from a repository in Azure Container Registry.

## Deploy a web app from a repository in Azure Container Registry

When you create a web app from a Docker image, you configure the following properties:

- The registry containing the image. The registry can be DockerHub, Azure Container Registry, or some other private registry.
- The image. This item is the name of the repository.
- The tag. This item indicates which version of the image to use from the repository. By convention, the most recent version is given the tag **latest** when it's built.
- Startup File. This is the name of an executable file or a command, which should be run when the image is loaded. This is equivalent to the command you can supply to Docker when running an image from the command line using `docker run`. If you are deploying a ready-to-run containerized app that already has the `ENTRYPOINT` and/or `COMMAND` values configured, you don't need to fill this in.

After you have configured the web app, the Docker image will be pulled and run as a "cold start" operation the first time a user attempts to visit the site. It may take a few seconds for the app to start up initially, but thereafter it will be available immediately.