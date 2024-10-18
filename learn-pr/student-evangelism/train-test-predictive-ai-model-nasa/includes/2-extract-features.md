We've cleaned and separated the data in our program. Now we're ready to train the computer to recognize the different features of the types of space rocks.

To train the computer, you have to extract features from images. This step might seem counterintuitive. Our brains automatically extract features from images, so we don't usually notice it's happening.

We learned that each image is a collection of pixels, and pixels are represented by numbers. To train our model, we'll review each image as a matrix of numbers.

To extract the features from an image, we multiply the image by filters. Each filter is used to extract a particular feature.

In the following photo, we see filters move over an image to extract features like edges, curves, and the texture of a rock.

We'll use 32 filters to classify the rocks in our model, but more filters are available.

:::image type="content" source="../media/filters.gif" alt-text="Dynamic diagram that demonstrates the application of a filter." loc-scope="Azure":::

> *Visualization credit: Grant Sanderson, https://www.3blue1brown.com/.*
