Now that you have clean, separated data in your program, you have to train the computer to recognize the different features of the types of space rocks.

To train the computer, you have to extract features of images. This step might be counterintuitive because our brains automatically extract the features of images. We're usually not aware that it's happening.

We know that each image is a collection of pixels, and we know that pixels can be represented by numbers. Therefore, each image is a matrix of numbers.

To extract features from images, we multiply images by filters. Each filter is responsible for extracting a feature.

In the following photo, you can see how we slide a filter over an image to extract features like edges, curves, and the texture of a rock.

We'll use 32 filters for our rock classification example, but many more filters are available.

:::image type="content" source="../media/filters.gif" alt-text="Dynamic diagram that demonstrates the application of a filter."  loc-scope="Azure":::
