We now have all the environment set up. It's just waiting for us to deploy our workloads and create our pipeline.

One of the most important parts in a distributed application using AKS is the container image. Let's understand a bit more of what is a container image and how we can harness the power of tags to create what we need.

## Container images

A container image is a file with multiple layers used to execute a container. In our case, we're using Docker, so the containers are Docker containers.

> We'll not go through what are containers and how do they work but, if you'd like to know more, check the links at the summary of this module.

The image is built from the `Dockerfile`. This file has a set of instructions that allows us to tell the container runtime which steps we need to take to create a fully executable image of our application.

If you take a look at the `Dockerfile` in the root of the fork you just made, you'll see this image starts by leveraging another `nginx` image. This way, we are never starting from scratch, but from other images that have the files we need.

We can build an image from a Dockerfile through the `docker build` command. Try running `docker build .` on the repository root and see how this works.

## Image tags

Another important aspect of container images are tags. Tags tells us what type of image we're dealing with, even if they have the same name.

Generally, container images are build using the same technique as GitHub repositories, which means that we'll have something like `repository/image_name` for Docker containers. But images go a step further and allow you to have multiple versions of the same image by tagging them.

For example, let's take the Node.js image. If we wanted to start from Node 12, we'll just use `FROM node:12` in the Dockerfile, however, if we wanted to start from the latest stable version, we could just use `FROM node:current`. Tags tell us what type of image we're using and what to expect of it.

In our project, we're going to use tags the same way, we'll have a tag for each production version using the `v*.*.*` template. And all commits to `main` generate a new push to the `latest` tag, which is equivalent to the `current` tag in the Node.js repository.

This way we'll always have the latest image both in staging and production, while just official tagged images will go to production.

## Container Registries

The final important aspect of an image is where it's going to be stored. We have GitHub to store our code changes and versions. In the container world, this is called a _Container Registry_.

For this project, we're using the _Azure Container Registry_ (ACR). The concept of a container registry is pretty straight-forward: It's a place to store image files. We can push new images to registries using the `docker push` command.

For our pipeline, we're going to push the built images to the ACR we created before, using a key and a username. In essence, we'll automate both `docker build` and `docker push` using our pipeline.
