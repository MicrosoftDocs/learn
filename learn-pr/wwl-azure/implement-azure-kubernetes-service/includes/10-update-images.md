After you've successfully containerized your application, you'll need to ensure that you update your image regularly.

It means creating a new image for every change in your code and ensuring that all layers receive regular patching.

A large part of a container image is the base OS layer, which contains the operating system elements that aren't shared with the container host.

:::image type="content" source="../media/2-6-4-image-layers-149ee7b7.png" alt-text="Image layers are stacked atop each other in the following order from bottom to top Base OS layer, IIS Layer, ASP.NET Layer, and Your website layer.":::


The base OS layer gets updated frequently. Other layers, such as the IIS layer and ASP.NET layer in the image, are also updated.

Your images are built on top of these layers. It's up to you to ensure that they incorporate those updates.

Fortunately, the base OS layer consists of two images: a more significant base layer and a minor update layer. The base layer changes less frequently than the update layer. Updating your image's base OS layer is usually a matter of getting the latest update layer.

:::image type="content" source="../media/2-6-4-os-image-layers-e69ee918.png" alt-text="A Base OS layer is broken into an Update layer and a base layer.":::


If you're using a Docker file to create your image, patching layers should be done by explicitly changing the image version number using the following commands:

```
FROM microsoft/windowsservercore:10.0.14393.321
RUN cmd /c echo hello world
```

Into:

```YML
FROM microsoft/windowsservercore:10.0.14393.693
RUN cmd /c echo hello world
```

When you build this Docker file, it now uses version 10.0.14393.693 of the image microsoft/windowsservercore.

## Latest tag

Don't be tempted to rely on the latest tag. To define repeatable custom images and deployments, you should always be explicit about the base image versions that you're using. Also, just because an image is tagged as the latest doesn't mean it's the latest. The owner of the image needs to ensure it.

> [!NOTE]
> The last two segments of the version number of Windows Server Core and Nano images will match the build number of the operating system inside.
