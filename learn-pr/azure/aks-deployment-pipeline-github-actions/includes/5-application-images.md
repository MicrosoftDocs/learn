We now have all the environment setup. It's just waiting for us to deploy our workloads and create our pipeline.

One of the essential parts of a distributed application using AKS is the container image. Let's understand a bit more about a container image and how you can harness tags to create what you need.

## Container images

A container image is a file with multiple layers used to execute a container. Here you'll use Docker containers.

> We'll not go through what are containers and how they work, but if you'd like to know more, check the links at the summary of this module.

The container image is built from the `Dockerfile`. This file has a set of instructions that allows you to tell the container runtime that steps it needs to take to create a fully executable image of your application.

If you take a look at the `Dockerfile` in the root of the fork you just made, you'll see this image starts by leveraging another `nginx` image. This way, you're never starting from scratch, but from other images that have the files, you need.

You can build an image from a Dockerfile through the `docker build` command. Try running `docker build .` on the repository root and see how this works.

## Image tags

Another important aspect of container images is tags. Tags tell you what type of image you're dealing with, even if they have the same name.

Generally, container images are build using the same technique as GitHub repositories, which means that you'll have something like `repository/image_name` for Docker containers. But images go a step further and allow you to have multiple versions of the same image by tagging them.

For example, let's take the Node.js image. If you wanted to start from Node 12, you'd just use `FROM node:12` in the Dockerfile. However, if you wanted to start from the latest stable version, you could just use `FROM node:current`. Tags tell us what type of image you're using and what to expect of it.

In your project, you're going to use tags the same way. You'll have a tag for each production version using the `v*.*.*` template, and all commits to `main` generate a new push to the `latest` tag. This value is equivalent to the `current` tag in the Node.js repository.

This way, you'll always have the latest image both in staging and production, while official tagged images will go to production.

## Container Registries

The final important aspect of an image is where it's going to be stored. You have GitHub to store your code changes and versions. In the container world, this is called a _Container Registry_.

For this project, you're using the Azure Container Registry (ACR). The concept of a container registry is straight-forward: It's a place to store image files. You can push new images to registries using the `docker push` command.

For your pipeline, you're going to push the built images to the ACR you created before, using a key and a username. In essence, you'll automate both `docker build` and `docker push` using our pipeline.
