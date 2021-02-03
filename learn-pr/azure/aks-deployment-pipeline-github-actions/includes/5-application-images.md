Your environment is set up. The next steps are to deploy workloads and create a pipeline.

An essential part of a distributed application that uses AKS is the container image. Let's talk about container images and how you can use tags to create the images you need.

## Container images

A container image is a file that has multiple layers that are used to execute a container. For this project, you'll use a Docker container.

> [!NOTE]
> We won't discuss in detail what containers are and how they work. If you'd like to know more, check the links in the summary unit of this module.

The container image is built from a Dockerfile. The file has a set of instructions that you can use to tell the container runtime what steps it needs to take to create a fully executable image of your application.

If you look at the Dockerfile in the root of the fork you created, you see that the image starts by using another *nginx* image as its base. Instead of starting from scratch, you start with other images that have the files you need.

You can build an image from a Dockerfile by using the `docker build` command.

> [!IMPORTANT]
> The `build` command for Docker will not work within CloudShell environment since the use of Docker inside a running container is disallowed as explained in [this doc](https://docs.microsoft.com/azure/cloud-shell/troubleshooting#bash-troubleshooting). If you want to test the `docker build .` command you'll need to clone the repository locally and run using your own Docker installation.

## Image tags

Tags are an important aspect of working with container images. Tags tell you what type of image you're dealing with. A tag can differentiate images, even if multiple images have the same name.

To build a container image, you use the same technique that you use to create a GitHub repository. Like a GitHub repository, Docker container paths usually are something like *repository/image-name*. But images go a step further. You can have multiple versions of the same image and use tags to distinguish them.

For example, consider the Node.js image in the repository's directory. If you want to start from Node 12, you'd include the tag `FROM node:12` in the Dockerfile. If you want to start from the latest stable version, you can use the tag `FROM node:current`. Tags tell you what type of image you're using and what to expect it to do.

In your project, use tags the same way. You'll create a tag for each production version by using the `v*.*.*` template, like `v1.0.0`. Every tagged push to the main branch generates a new image tag that has the same name as the tag on that push, in addition to a `latest` tag. The images that are tagged with `v*` are deployed to production.

Non-tagged pushes to the main branch update only the `latest` image with the most recent code. Then, they deploy the code changes to staging.

You'll always have the `latest` image both in staging and production. Official tagged images go only to production.

## Container registries

The final important aspect of working with an image is where it will be stored. GitHub stores your code changes and versions. In the container world, GitHub is a *container registry*.

In this project, we use the Container Registry service in Azure. A container registry is a place to store image files. You can push new images to registries by using the `docker push` command.

For your pipeline, you'll push the built images to the Container Registry instance you created earlier by using a username and a password. In essence, you'll automate both `docker build` and `docker push` commands by using your pipeline.
