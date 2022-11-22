
One of the successful branches of artificial intelligence is **computer vision**, which allows computer to gain some insights from digital images and/or video. **Neural networks** can be successfully used for computer vision tasks.

Imagine you’re developing a system to recognize printed text. You’ve used some algorithmic approach to align the page and cut out individual characters in the text, and now you need to recognize individual letters. This problem is called **image classification**, because we need to separate input images into different classes. Other examples of such a problem would be automatically sorting post-cards according to the image, or determining product type in a delivery system from a photograph.

In this module, we’ll learn how to train image classification neural network models using **PyTorch**, one of the most popular Python libraries for building neural networks. We’ll start from simplest model - a fully connected dense neural network - and from a simple MNIST dataset of handwritten digits. We'll then learn about **convolutional neural networks**, which are designed to capture 2D image patterns, and switch to more complex dataset, CIFAR-10. Finally, we’ll use **pre-trained networks** and **transfer learning** to allow us to train models on relatively small datasets.

By the end of this module, you’ll be able to train image classification models on real-world photographs, such as cats and dogs dataset, and develop image classifiers for your own scenarios.
## Learning objectives

In this module you will:

  - Learn about computer vision tasks most commonly solved with neural networks
  - Understand how Convolutional Neural Networks (CNNs) work
  - Train a neural network to recognize handwritten digits and classify cats and dogs
  - Learn how to use Transfer Learning to solve real-world classification problems with PyTorch

## Prerequisites

- Basic knowledge of Python and Jupyter Notebooks
- Familiarity with PyTorch framework, including tensors, basics of back propagation and building models
- Understanding machine learning concepts, such as classification, train/test dataset, accuracy, etc.
