Now that you have clean, separated data in your program, you have to train the computer to recognize the different features of the two types of rocks.

To do this you have to extract features of images, this might be the most non intuitive step since our brains automatically extract features of images without us knowing.

We know each image is a collection of pixels and pixels can be represented with numbers. Therefore each image is a matrix of numbers.

To extract features out of images we multiply images by filters, each filter is responsible for extracting a feature.

Below you can see how we slide a filter over an image to extract features, such as edges, curves and texture of a rock.

We have so many of such filters, we will use 32 filters for our rock classification example.

<img src="../Media/convv.gif" width="450" align="center">
