[Deep learning](https://wikipedia.org/wiki/Deep_learning?azure-portal=true) is a branch of machine learning that relies on [neural networks](https://wikipedia.org/wiki/Neural_network?azure-portal=true) to perform predictive analytics. Neural networks are built by using libraries like [TensorFlow](https://www.tensorflow.org/?azure-portal=true) and [keras](https://keras.io/?azure-portal=true), an open-source Python library that dramatically simplifies the building of neural networks. Under the hood, keras uses TensorFlow and other frameworks to do the heavy lifting. With keras, you can build sophisticated neural networks with just a few lines of code, and then train the networks to classify images, analyze text for sentiment, do natural-language processing, and perform other tasks at which deep learning excels.

In this exercise, you will use keras to build a series of neural networks that recognize faces. You will train the networks by using images from the famous [Labeled Faces in the Wild](http://vis-www.cs.umass.edu/lfw/?azure-portal=true) (LFW) dataset. Along the way, you will learn the basics of building, training, and evaluating neural networks. You also will learn about [convolutional neural networks](https://wikipedia.org/wiki/Convolutional_neural_network?azure-portal=true) (CNNs), which excel at tasks that involve computer vision.

:::image type="content" source="../media/lfw.png" alt-text="Panel of eight photos of political figures." loc-scope="Azure":::

## Learning objectives

> **Sarah** TBD. Please check the learning objectives and prereqs that I derived from the module content.

In this module, you will:

- Use NumPy to analyze and visualize the contents of a dataset.
- Use keras to train a neural network.
- Use keras to check for training and validity accuracy in a neural network model.
- Add dropout during model training to help neural networks generalize better and increase validation accuracy.
- Use a convolution neural network (CNN) for classification of a dataset.

## Prerequisites

- Text classifications with Naive Bayes
- Principal component analysis (PCA)
- Support vector machines (SVMs) with facial recognition

