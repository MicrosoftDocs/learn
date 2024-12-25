Rapid deployment is key to business agility. Modern organizations must be able to release apps quickly to attract and retain business. Containerization saves time and reduces costs. You don't have to configure hardware and spend time installing operating systems and software to host a deployment. Multiple apps can run in their isolated containers on the same hardware. You can scale out quickly by starting more instances of containers. The images that run in containers are extensible; you can start with a working base image and layer more functionality on top to create a new image.

Suppose you work for an online clothing retailer that's planning to deploy a handful of internal apps, but it hasn't yet decided how to host them. You're looking for maximum compatibility, and the apps could be hosted on-premises, in Azure, or in another cloud provider. Some of the apps might share IaaS infrastructure. In these cases, the company requires the apps to be isolated from each other. Apps can share the hardware resources, but an app shouldn't be able to interfere with the files, memory space, or other resources the other apps use. The company values the efficiency of its resources and wants something with a compelling app-development story. Docker seems an ideal solution to these requirements. With Docker, you can quickly build and deploy an app and run it in its tailored environment, either locally or in the cloud.

In this module, you'll take an existing application and package it as a Docker image. You'll automate the image-build process by defining the build steps in a Dockerfile. You'll test the app locally by using Docker for Windows. Finally, you'll upload the image to Azure Container Registry and run the application using the Azure Container Instance service.

By the end of this module, you'll be able to build Docker images and run them from Azure.

## Learning objectives

In this module, you will:

- Create a Dockerfile for a new container image based on a starter image from Docker Hub.
- Add files to an image using Dockerfile commands.
- Configure an image's startup command with Dockerfile commands.
- Build and run a web application packaged in a Docker image.
- Deploy a Docker image using the Azure Container Instance service.

## Prerequisites

- An active Azure subscription
- Familiarity with basic web application development concepts

> [!NOTE]
> The exercises in this module require local installations of [Docker](https://hub.docker.com/editions/community/docker-ce-desktop-windows/) and [Git](https://git-scm.com/downloads).
