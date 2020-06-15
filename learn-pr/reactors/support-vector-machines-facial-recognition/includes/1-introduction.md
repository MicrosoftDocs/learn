[Support vector machines (SVMs)](https://wikipedia.org/wiki/Support-vector_machine?azure-portal=true) often can do better than other models at fitting data, especially data that is highly nonlinear. SVM models use kernels to draw complex boundaries around sets of like data points. In the following figure, the diagram on the left shows a 2-D set of data points that a linear model won't fit. In other words, there is no line you can draw to separate the blue points from the green points. However, an SVM can use a "kernel trick" to add a third dimension to each data point based on its distance from the center. In 3-D space (right), you can then draw a plane that cleanly separates the two classes of data points.

:::image type="content" alt-text="Two diagrams that show 2-D and 3-D data planes" source="../media/svm.png" loc-scope="Azure":::

That's a simple way to visualize how SVMs work. Let's learn about SVMs by using the [Labeled Faces in the Wild](http://vis-www.cs.umass.edu/lfw/?azure-portal=true) (LFW) dataset that is provided with scikit-learn to build a facial recognition model.

## Learning objectives

> **Sarah** TBD. Please check the learning objectives and prereqs that I derived from the module content.

In this module, you will:

- Train a support vector machine (SVM) model for image classification by using items in a dataset. 
- Use principal component analysis (PCA) to reduce the number of dimensions in a dataset to help increase the accuracy of a model.
- Use `GridSearchCV` with scikit-learn to tune hyperparameters and increase the accuracy of your model.
- Learn how to cross-validate a model and quantify the accuracy of the hyperparameters.

## Prerequisites

- Text classifications with Naive Bayes
- Principal component analysis (PCA)