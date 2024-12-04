Thumbnails are often used to provide smaller versions of images in applications and websites. For example, a tourism site might display a list of tourist attractions in a city with a small, representative thumbnail image for each attraction; and only display the full image when the user selects the "details" page for an individual attraction.

The Azure AI Vision service enables you to create a thumbnail with different dimensions (and aspect ratio) from the source image, and optionally to use image analysis to determine the *region of interest* in the image (its main subject) and make that the focus of the thumbnail. This ability to determine the region of interest is especially useful when cropping the image to change its aspect ratio.

![A large building cropped to show the region of interest.](../media/smart-cropping.png)

You can specify the aspect ratio of the cropped image (width / height), ranging from `0.75` to `1.80`.

## Remove image background

The background removal feature can split the image into the subject in the foreground, and everything else that is considered background. Azure AI Vision achieves this feature by creating an *alpha matte* of the foreground subject, which is then used to return either the foreground or the background.

For example, take this image original of a skateboarder.

![A skateboarder performing a trick in front of a concrete wall.](../media/sample-skateboard.jpg)

With the background removed, we get just the skateboarder on a transparent background.

![A skateboarder performing a trick with a black background.](../media/sample-skateboard-no-background.png)

When creating an alpha matte of an image, the result is the foreground in all white, with a black background.

![A silhouette of a skateboarder performing a trick with a black background.](../media/sample-skateboard-alpha-matte.png)

Alpha matte images are helpful when client applications intend to do further processing of an image that requires separation of foreground and background objects.
