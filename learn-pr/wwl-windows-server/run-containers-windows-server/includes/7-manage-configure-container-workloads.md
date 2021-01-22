The Contoso Windows Server administrator needs to understand how to manage containers in Windows Server environments by using management tools such as WAC and the command line.

## Manage containers by using WAC

WAC is a browser-based GUI you can use to manage Windows servers, clusters, hyperconverged infrastructure (HCI), and Windows 10 PCs. It's used to provide a single administrative tool that can perform many of the tasks that were commonly performed using a variety of consoles, tools, or processes. Another powerful aspect of the WAC is that it's extensible and supports third-party hardware manufacturers for configuration or monitoring capabilities related to their specific hardware.

After you install the WAC, you might need to add additional extensions to allow you to manage the services you intend to use with the tool. You can add extensions by selecting the **Settings** button and then selecting **Extensions**. WAC pulls the latest extension list from its default feed to display the available extensions that can be installed.

## Overview of the Containers extension

The WAC Containers extension is used to perform management and monitoring of the containers running on the targeted host machine. The Containers extension has the information and management tabs listed in the following table.

|Tab name|Tab details|
|||
|Summary|Provides a summary of the status of the containers, including how many are running, which images are available, the networks that have been configured, and the volumes used.|
|Containers|Provides an extensive amount of status information in both text and graphical format. You can also obtain details, logs, and events from specific containers and perform tasks such as End or Delete containers.|
|Images|Displays and provides details on the images that are available in your local repository. You can also use this tab to delete images from the repository.|
|Networks|Displays the networks that have been configured for the containers. Includes networking information such as subnet and gateway addresses used for the network connection.|
|Volumes|Displays volume information used by containers on the host machine.|

## Maintain container images

After you've successfully containerized your application, you'll need ensure that you update your image regularly. This entails creating a new image for every change you make in your own code, and ensuring that all layers receive regular patching.

A large part of a container image is the base OS layer, which contains OS elements that aren't shared with the container host. The base OS layer consists of two separate images: a larger base layer, and a smaller update layer. The base layer changes less frequently than the update layer. Updating your image's base OS layer is usually a matter of getting the latest update layer.

:::image type="content" source="../media/m25-os-image-layers.png" alt-text="A diagram representing a base image. The base OS layer is broken into a base layer and an update layer." border="false":::

> [!NOTE]
> It's possible to run Linux containers on Windows 10 using Docker CE for Windows for Windows, and then use Docker to switch between the Windows and Linux modes.

> [!CAUTION] In Windows Server 2019, you can use an experimental feature to run Linux containers on Windows Server. This is not recommended for production environments or critical workloads.

## Demonstration

The following video demonstrates how to:

- Enable Linux container support on Windows Server.
- Run a Linux container on Windows Server 2019.

The main steps in the process are:

1. Install **Docker** on **Windows Server**.
1. Pull down a **Linux Ubuntu** container image.
1. Run the container in interactive mode.
1. Exit the running container.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MzHK]