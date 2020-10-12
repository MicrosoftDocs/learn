We now have all the environment set up. It's just waiting for us to deploy our workloads and create our pipeline.

One of the essential parts of a distributed application using AKS is the container image. Let's understand a bit more about a container image and how you can harness tags to create what you need.

## Container images

A container image is a file with multiple layers used to execute a container. Here you'll use Docker containers.

> [!NOTE]
> We'll not go through what are containers and how they work, but if you'd like to know more, check the links at the summary of this module.

The container image is built from the `Dockerfile`. This file has a set of instructions that allows you to tell the container runtime what steps it needs to take to create a fully executable image of your application.

If you take a look at the `Dockerfile` in the root of the fork you just made, you'll see this image starts by using another `nginx` image as base. This way, you're never starting from scratch, but from other images that have the files you need.

You can build an image from a Dockerfile through the `docker build` command. Try running it on the repository root and see how this works.

```bash
docker build .
```

## Image tags

Another important aspect of container images is tags. Tags tell you what type of image you're dealing with, even if they have the same name.

Generally, container images are built using the same technique as GitHub repositories, which means that you'll have something like `repository/image_name` for Docker containers. But images go a step further and allow you to have multiple versions of the same image by tagging them.

For example, let's take the Node.js image. If you wanted to start from Node 12, you'd just use `FROM node:12` in the Dockerfile. However, if you wanted to start from the latest stable version, you could just use `FROM node:current`. Tags tells you what type of image you're using and what to expect of it.

In your project, you're going to use tags the same way. You'll have a tag for each production version using the `v*.*.*` template, like `v1.0.0`. Every tagged push to `main` will generate a new image tag with the same name as the tag on that push as well as a `latest` tag. These images tagged with `v*` will be deployed to production.

Non-tagged pushes to `main` will only update the `latest` image with the most recent code and deploy it to staging.

This way, you'll always have the `latest` image both in staging and production, while official tagged images will only go to production.

## Container Registries

The final important aspect of an image is where it's going to be stored. You have GitHub to store your code changes and versions. In the container world, this is called a _Container Registry_.

For this project, you're using the __Azure Container Registry (ACR)__. The concept of a container registry is straight-forward: It's a place to store image files. You can push new images to registries using the `docker push` command.

For your pipeline, you're going to push the built images to the ACR you created before, using a username and a password. In essence, you'll automate both `docker build` and `docker push` commands using your pipeline.
