One of the laws of data science is the "curse of dimensionality": as the number of considered features (dimensions) of a feature space increases, the number of data configurations can grow exponentially. The number of observations (data points) needed to account for these configurations must also increase. Because this fact of life has huge ramifications for the time, computational effort, and memory required, it's often desirable to reduce the number of dimensions we have to work with.

One way to reduce the number of dimensions is to reduce the number of features considered in an analysis. After all, some features yield more insight than others for a specific analysis. Although this type of feature engineering is necessary in any data science project, we can take it only so far. Up to a point, considering more features often increases the accuracy of a classifier. (For example, consider how many features might increase the accuracy of classifying images as cats or dogs.)

## Learning objectives

In this module, you will:

- Learn the terms *principal component analysis (PCA)* and *eigenvector* and understand their functions in machine learning.
- Learn about PCA theory, and then apply PCA to a food composition dataset.
- Check for correlation, and then normalize and center the data.

## Prerequisites

- Text classifications with Naive Bayes

[!INCLUDE [Set up your environment](../../includes/set-up-environment.md)]
