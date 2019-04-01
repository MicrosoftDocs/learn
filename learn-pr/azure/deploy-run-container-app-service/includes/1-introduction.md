You can build and deploy Azure web apps using Docker containers. This approach enables you to roll out the web app quickly. Continuous delivery support ensures that users see the latest build of the application while minimizing the administrative overhead involved.

Suppose that you work for an already-successful company that is testing a new SaaS product. The small team working on it is moving quickly. When they began, they weren’t sure where they were going to host the app, so they chose to package the app into a Docker container to improve the efficiency of their development process and to maximize their options for deployment. They’re ready to deploy the first version, with the expectation that they'll be iterating quickly.

The team decided to deploy the new application as a web app in Azure. Azure provides App Service as a platform for hosting web apps. The code for a web app running in App Service can be supplied as a Docker image.

This module shows you how to create and store Docker images in Azure Container Registry. You'll see how to use these images to deploy a web app. Then, you'll learn how to configure continuous deployment so that the web app is redeployed whenever a new version of the image is released.

By the end of this module, you'll be able to create and maintain web apps that use Docker images stored in Azure Container Registry.

## Learning objectives

In this module, you will:

- Create Docker images and store them in a repository in Azure Container Registry
- Use Azure App Service to run web applications based on Docker images held in Azure Container Registry
- Configure continuous deployment of a web app based on a Docker image using webhooks

## Prerequisites

- Basic experience with Docker, including using Docker commands to store and retrieve Docker images
- Experience creating web apps with App Service