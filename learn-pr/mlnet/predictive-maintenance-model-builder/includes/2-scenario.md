In this unit, you'll learn about scenarios in Model Builder.

## What is a scenario?

A scenario describes problem you're trying to solve using your data. Some common scenarios include:

- Categorizing data (organize articles by topic)
- Predicting a numerical value (price of a home)
- Detecting uncommon behavior (credit card fraud)
- Grouping items with similar characteristics (customer segmentation)
- Recommending items (recommend movies)

These scenarios map to machine learning tasks. A machine learning task is the type of prediction or inference being made, based on the problem or question that is being asked, and the available data.

Machine learning tasks tend to fall into two categories:

- Supervised
- Unsupervised

The main difference between them is whether the label, or value you're trying to predict, is known or not.

For supervised tasks, the **label is known**. Examples of supervised machine learning tasks include:

- Classification
  - Binary (2 categories)
  - Multiclass (2 or more categories)
  - Image
- Linear regression

For unsupervised tasks, the **label is unknown**. Examples of unsupervised machine learning tasks include:

- Clustering
- Anomaly detection

## Scenarios in Model Builder

Model Builder supports the following scenarios which map to the respective machine learning tasks

| Scenario | Machine Learning Task | Use Case |
| --- | --- | --- |
| Data classification | Binary and multiclass classification | Organize articles by topic |
| Value prediction | Linear regression | Predict the price of a home |
| Image classification | Image Classification (Deep Learning) | Organize images by animal species based on the content of an image |
| Recommendation | Recommendation | Recommend movies based on the preferences of similar users |
| Object detection | Object Detection (Deep Learning) | Identify physical damage in an image |

## Predictive maintenance scenario

Depending on what your data looks like, the predictive maintenance problem can be modeled using different tasks. For your use case, since the label is a binary value 0 or 1 describing whether a machine is broken or not, the data classification scenario is appropriate.