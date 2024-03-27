You can build and deploy Azure-based web apps by using Docker containers. This approach allows you to roll out a web app quickly. Support for continuous delivery ensures that users see the latest build of the app while minimizing administrative overhead.

Suppose that you work for an already-successful company that's testing a new software as a service (SaaS) product. The small team working on it is moving quickly. When they began, they weren’t sure where they were going to host the app. So, they chose to package the app into a Docker container to improve the efficiency of their development process and maximize their options for deployment. They’re ready to deploy the first version, and they expect to be iterating quickly.

The team decided to deploy the new app as a web app that uses Azure App Service, a platform for hosting web apps. The code for a web app running in App Service can be supplied as a Docker image.

This module shows you how to create and store Docker images in Azure Container Registry. You'll see how to use these images to deploy a web app. Then, you'll learn how to configure continuous deployment so that the web app is redeployed whenever a new version of the image is released.

By the end of this module, you'll be able to create and maintain web apps that use Docker images that are stored in Container Registry.

## Learning objectives

In this module, you will:

- Create Docker images and store them in a repository in Azure Container Registry.
- Use App Service to run web apps that are based on Docker images held in Azure Container Registry.
- Use webhooks to configure continuous deployment of a web app that's based on a Docker image.

## Prerequisites

- Basic experience with Docker, including the use of Docker commands to store and retrieve Docker images
- Experience with creating web apps by using App Service
