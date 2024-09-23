A containerized image is an essential part of any distributed application that uses Azure Kubernetes Service (AKS). You can use tags to:

- Create different container images that you need.
- Store your images in a container registry.
- Deploy a particular tagged image.

In this unit, you explore how your CI/CD pipeline uses tagged application images.

## Container images

A container image is an executable software bundle that encapsulates an application and all its software dependencies. This module uses a Docker container image to build the Contoso website application.

The Docker image contains the application code and any dependencies needed to create a fully executable image of the application. The container image is configured by a Dockerfile that has a set of instructions for the container runtime.

If you look at the Dockerfile in the root of your fork, you see that the image starts by using another *nginx* image as its base. Instead of starting from scratch, it's common to start with other images that have the files you need.

You build an image from a Dockerfile by using the `docker build` command.

> [!IMPORTANT]
> The `docker build` command doesn't work within the Cloud Shell environment, because [the use of Docker inside a running container is disallowed](/answers/questions/1353781/azure-cloudshell-docker-doesnt-work). If you want to test the `docker build .` command, clone the repository locally and run the command by using your own Docker installation.

## Image tags

Tags are an important aspect of working with container images. Tags can tell you the type of image and differentiate between multiple images that have the same name.

For example, if you want the Node.js image in a repository to start from Node 12, you can include the tag `FROM node:12` in the Dockerfile. If you want to start from the latest stable version, you can use the tag `FROM node:current`. Tags indicate the type of image and what it's expected to do.

Building a container image uses the same technique as creating a GitHub repository, and the Docker container path is usually something like *repository/image-name*. But you can build multiple versions of the same image that use tags to distinguish them.

In this module, you use tags to label release versions. You create a tag for each production version by using `v*.*.*` semantic versioning rules, such as `v1.0.0` for version 1.0.0. Every tagged push to the main branch generates a new image tag with the same name as the tag on that push. Nontagged pushes generate only the `latest` tag.

All pushes, tagged and nontagged, update the `latest` image with the most recent code and deploy it to staging. The images that are tagged with `v*` are also deployed to production. Only official tagged images deploy to production, while both the staging and production environments always have the `latest` staged image.

## Container registries

An important aspect of working with an image is where it's stored. A *container registry* is a place to store containerized image files. For example, GitHub is a container registry that also stores code changes and versions. You can push new application images into container registries by using the `docker push` command.

In this module, you store application image files in the Azure Container Registry instance you created in the previous unit. After you create a Personal Access Token (PAT) and issue a federated certificate to authenticate with GitHub and Azure, the pipeline essentially automates both the `docker build` and `docker push` commands.

Now that you understand CI/CD pipelines and tagged container images, proceed to the next unit to start building your GitHub Actions CI/CD pipeline.
