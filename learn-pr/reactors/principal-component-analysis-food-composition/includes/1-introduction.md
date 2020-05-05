One of the iron laws of data science is know as the "curse of dimensionality": as the number of considered features (dimensions) of a feature space increases, the number of data configurations can grow exponentially. The number observations (data points) needed to account for these configurations must also increase. Because this fact of life has huge ramifications for the time, computational effort, and memory required, it is often desirable to reduce the number of dimensions we have to work with.

One way to accomplish this is by reducing the number of features considered in an analysis. After all, not all features are created equal, and some yield more insight for a given analysis than others. Although this type of feature engineering is necessary in any data science project, we can takt it only so far; up to a point, considering more features can often increase the accuracy of a classifier. (For example, consider how many features could increase the accuracy of classifying images as cats or dogs.)

## Learning objectives

> [!NOTE]
> SARAH: Would you check the learning objectives I derived from the module content? Thanks.

In this module, you will:

- Learn the meaning of *principal component analysis (PCA)* and *eigenvector*, and their function in machine learning.
- Learn about PCA theory, and then apply PCA to a food composition dataset.
- Check for correlation, and then normalize and center the data.

## Prerequisites

- [Text classifications with Naive Bayes](../../text-classification-naive-bayes/index.yml)
