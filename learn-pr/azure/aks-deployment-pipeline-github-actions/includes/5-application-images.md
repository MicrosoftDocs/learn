Our environment is now set up. It's just waiting for us to deploy our workloads and create a pipeline.

An essential part of a distributed application that uses AKS is the container image. Let's talk a bit more about container images and how you can harness tags to create what you need.

## Container images

A container image is a file that has multiple layers that are used to execute a container. For our project, you'll use Docker containers.

> [!NOTE]
> We won't discuss in detail what are containers and how they work, but if you'd like to know more, check the links at the summary of this module.

The container image is built from the Dockerfile. The file has a set of instructions that you can use to tell the container runtime what steps it needs to take to create a fully executable image of your application.

If you take a look at the Dockerfile in the root of the fork you created, you see thatthis image starts by using another *nginx* image as base. So, instead of starting from scratch, you start with oher images that have the files you need.

You can build an image from a Dockerfile by using the `docker build` command. Try running it on the repository root and see how this works:

```bash
docker build .
```

## Image tags

Tags are another important aspect of container images. Tags tell you what type of image you're dealing with, even if the images have the same name.

Generally, container images are built by using the same technique as GitHub repositories. So, Docker container paths are usually something like *repository/image_name*. But images go a step further. You can have multiple versions of the same image by using tags to distinguish them.

For example, consider the Node.js image. If you wanted to start from Node 12, you'd include the tag `FROM node:12` in the Dockerfile. However, if you wanted to start from the latest stable version, you could use the tag `FROM node:current`. Tags tell you what type of image you're using and what to expect it to do.

In your project, use tags the same way. You'll create a tag for each production version by using the `v*.*.*` template, like `v1.0.0`. Every tagged push to the main branch generates a new image tag that has the same name as the tag on that push, in addition to a `latest` tag. The images that are tagged with `v*` are deployed to production.

Non-tagged pushes to the main branch update only the `latest` image with the most recent code, and then deploy it to staging.

You'll always have the `latest` image both in staging and production. Official tagged images go only to production.

## Container registries

The final important aspect of an image is where it will be stored. You have GitHub to store your code changes and versions. In the container world, GitHub is a *container registry*.

In this project, we use the Container Registry service in Azure. The concept of a container registry is straight-forward: It's a place to store image files. You can push new images to registries using the `docker push` command.

For your pipeline, you're going to push the built images to the Container Registry instance you created earlier, using a username and a password. In essence, you'll automate both `docker build` and `docker push` commands by using your pipeline.
