Many of the Azure Cognitive Services support containerization.  LUIS is one such service. Using LUIS in a container offers benefits such as;

- Ability to run the service closer to your application
- Reduce network constraints on consumption
- Reduce the cost associated with testing
- A portable architecture constrained only by hardware resources you allocate to it
- Ability to scale up or scale out the service

## Learning objectives

In this module, you will learn how to:

- Export your LUIS app for use in a container
- Add your LUIS app to a container running locally
- Plan for LUIS containers

## Preparation

There are specific requirements to use LUIS in a container environment.  The first requirement is to have Docker installed on the host computer.  Docker must be configured to connect with and send billing information to Azure.  If you are running Docker on a Windows host, Docker must be configured to support Linux containers.

This module does not cover how to install Docker or manage it.  You will use the commands and processes necessary to pull down the Docker container and deploy your LUIS application to that container. For information on installing and using Docker, refer to the [Docker Get Started](https://www.docker.com/get-started) page.

To containerize LUIS, you require an existing LUIS application.  You will not create a LUIS app insider a Docker container.  LUIS offers the ability to export to a container. Before you can export the app as a container, it must be trained so ensure that you have selected the **Train** button and its status is showing a green dot.

To export your LUIS app for containerization;

1. Sign in to your LUIS portal.
1. Locate the app you want to export.
1. Ensure the app has been trained.
1. You should also publish the app to either production or staging.
1. Select the **Manage** tab in the top toolbar.
1. Select **Versions** in the left toolbar.
1. Select the version you wish to export.
1. Select the **Export** drop down menu and select **Export for Containers**.
1. A **gzip** file is created for you in your default download location.
1. You will move this file to the proper location in the next unit.

:::image type="content" source="../media/export-containers.png" alt-text="Export for containers option selected in portal":::

If you do not already have a LUIS app created, you can [download this exported LUIS app file](https://github.com/MicrosoftLearning/AI-102-LUIS/raw/master/314a24df-7cfd-40e1-a417-cec549a39db7_v0%20(1).1.gz) that is intended for use in containers.
Once you have the file downloaded, or your own LUIS exported app file, you are ready to start working with the container and Docker.
