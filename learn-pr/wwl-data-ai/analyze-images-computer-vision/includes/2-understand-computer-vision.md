Computer vision capabilities are built on deep learning models, which use layers of equations to make predictions about what is in images. The main type of deep learning model that supports computer vision is a **Convolutional neural network** (CNN), which uses pixel numbers from images as *features* to make calculations and predict *labels*.  

For example, an image of an apple could be described as an array of pixel numbers (features), associated with the name of what they represent (label): 

![A photo of an apple against a white background with a grid on top of it where each grid block has a pixel number in it.](../media/fruit-pixel1.jpg)

Thus an array of numbers: 
```
255 255 255 255 255 255 
255 255 100 255 255 255
255 100 100 100 255 255
100 100 100 100 100 255
255 255 255 255 255 255
255 255 255 255 255 255
```
can represent the label "apple". 

CNNs extract features from images and use feature extraction layers to reduce the number of features from the potentially huge array of individual pixel values to a smaller feature set. A smaller feature set can make it easier for a computer to predict labels with speed and accuracy. 

CNNs consist of multiple layers, each performing a specific task in extracting features or predicting labels. One of the principal layer types is a convolutional layer that extracts important features in images. A convolutional layer works by applying a filter to images. The filter is defined by a matrix of weight values known as a filter kernel.

For example, a 3x3 matrix of weight values can look like this: 
 1  -1   1
-1   0  -1
 1  -1   1

Let's take a look at how the filter kernel can be applied to an array of pixels to create a feature map.  

![An animation showing what is outlined in the five steps below on how a feature map is created.](../media/steps-to-create-feature-map.gif)

1. An image is passed to the convolutional layer. In this case, the image is a simple geometric shape.
2. The image is composed of an array of pixels with values between 0 and 255 (for color images, this is usually a 3-dimensional array with values for red, green, and blue channels).
3. A filter kernel is generally initialized with random weights. This filter will be used to extract a feature map from the image data.
4. The filter is convolved across the image, calculating feature values by applying a sum of the weights multiplied by their corresponding pixel values in each position. A Rectified Linear Unit (ReLU) activation function is applied to ensure negative values are set to 0.
5. After convolution, the feature map contains the extracted feature values, which often emphasize key visual attributes of the image. In this case, the feature map highlights the edges and corners of the triangle in the image.

Different calculations can be done with the arrays of numbers in a feature map. Usually, a CNN ends with a fully connected network in which the feature values are passed into an input layer, through one or more hidden layers, and generate predicted values in an output layer.

![An image of the steps of a basic CNN architecture.](../media/convolutional-neural-network.png)

## Predictions and evaluations 

To be useful in real-life scenarios, computer vision applications need to make predictions that mimic or improve upon the performance of human eyes. 

Evaluation metrics help us understand how well a model is performing. That information can be used to improve the model. One metric is a *confidence score*, which is a value between 0 and 1, and indicates how likely the image contains the items in its description. When a computer vision model makes a prediction, that prediction has a probability of reflecting the truth.

Importantly, each time the computer vision model is run, the resulting trained model can differ. One of the causes for variations in the trained model is the setting of the initial values of the model's parameters (its weights and biases) before training. 

The complexity of training computer vision models is why pretrained vision models are so valuable. Next we will explore how Azure AI Vision's vision capabilities, powered by CNNs and other deep learning models, can make it possible for engineers to build intelligent vision applications without a background in deep learning.   
