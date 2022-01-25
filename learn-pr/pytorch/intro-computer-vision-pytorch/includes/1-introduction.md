
In this module, we’ll learn how to perform different computer vision tasks using [PyTorch](http://pytorch.org), one of the most popular Python libraries for building neural networks. First, let's talk about main problems that computer vision focuses on.

## Computer Vision Problems

Computer Vision (CV) is a field that studies how computers can gain some degree of understanding from digital images and/or video. *Understanding* in this definition has a rather broad meaning - it can range from being able to distinguish between a cat and a dog on the picture, to more complex tasks such as describing the image in natural language.

The most common problems of computer vision include:

* **Image Classification** is the simplest task, when we need to classify an image into one of many pre-defined categories, for example, distinguish a cat from a dog on a photograph, or recognize a handwritten digit.

* **Object Detection** is a bit more difficult task, in which we need to find known objects on the picture and localize them, that is, return the **bounding box** for each of recognized objects.

* **Segmentation** is similar to object detection, but instead of giving bounding box we need to return an exact pixel map outlining each of the recognized objects.  

![An image showing how computer vision object detection can be performed with cats, dogs, and ducks.](../images/mFBCV.png)

Image taken from [CS224d Stanford Course](https://cs224d.stanford.edu/index.html)

In this module, we’ll focus on **image classification** task, and how neural networks can be used to solve it. As with any other machine learning tasks, to train a model for classifying images we’ll need a labeled dataset, that is, a large number of images for each of the classes. 

## Overview of the module

We’ll consider three main examples of image classification:

* Classifying handwritten digits using **MNIST** Dataset. This can be considered a toy problem, because in this dataset all digits are already properly aligned, which isn’t often the case when we start dealing with real-world problems.
* Classifying common objects such as trucks, airplanes, etc. using **CIFAR-10** dataset. It’s very similar to MNIST, but images are colorful, and quite more complex.
* Distinguishing between **cats and dogs** using real-world images. This problem is very realistic, because all images in the dataset are real images, with different resolutions, sizes, and positions of pets within the picture.

The course is structured as follows:

* We'll start by using simple Dense Neural Networks (DNNs), also called *perceptrons*, to classify handwritten digits, and also recap how neural networks can be expressed in PyTorch, and how to write a training algorithm. If you’re familiar with PyTorch, you can skip this unit.
* We'll discuss the main idea behind specialized networks for computer vision - **Convolutional Neural Networks** (CNNs), and see how using CNN we can improve digit classification and switch to more complex datasets that can’t be handled with DNNs. CNNs work similarly to human eye, by extracting patterns from the image, and building a hierarchy of those patterns to recognize required objects. 
* MNIST and CIFAR datasets contain quite a lot of images, and for accurate classification require a lot of training resources. In real life, we usually have limited datasets, and we want to train models using limited computational capacity. This can be achieved using **pre-trained models**, when we can take a model already trained on datasets like CIFAR or ImageNet, and use it as feature extractor to train our own classifier. This is called **transfer learning**, at it’s used in almost all real-life computer vision tasks.
* Finally, we’ll see that we can use smaller and optimized models that can work on devices with limited computational capacity, such as mobile phones, with little sacrifice in classification accuracy.

We’ll begin with discussing how images can be represented using tensors, and loading our first dataset - MNIST.

## Learning objectives

In this module you will:

  - Learn about computer vision tasks most commonly solved with neural networks
  - Understand how Convolutional Neural Networks (CNNs) work
  - Train a neural network to recognize handwritten digits and classify cats and dogs
  - Learn how to use Transfer Learning to solve real-world classification problems with PyTorch

## Prerequisites

  - **Knowledge of Python**. We’ll be using Python to define and train our neural networks, so understanding this code would be helpful. We also allow you to execute this code in a sandbox using **Jupyter Notebook**, so we expect some familiarity with Jupyter.
  - Familiarity with **PyTorch framework** is required, because we won’t go into details on tensor operations and implementing back propagation. It’s recommended to go through [Introduction to PyTorch](/learn/modules/intro-machine-learning-pytorch/) module.
  - Basic understanding of machine learning is also helpful 
