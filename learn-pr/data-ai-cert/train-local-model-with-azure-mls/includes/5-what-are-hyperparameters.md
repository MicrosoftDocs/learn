The term _hyperparameters_ was mentioned in the prior unit but we didn't stop and explore what they are.

Hyperparameters are **parameters** that cannot be directly learned from the regular training process.

For example, to train a decision tree, there are many hyperparameters to tune such as _splitter_, which is the strategy behind splitting at each node, and _max_depth_ which defines the maximum depth of the tree. Another example would be [random forest](https://en.wikipedia.org/wiki/Random_forest) algorithm, a collection of decision trees. In random forest, the number of trees and the depth of each tree would also be hyperparameters. Hyperparameters are usually fixed before the actual training process begins, while the actual parameters are learned during the training process.

In machine learning and deep learning use cases, sometimes the performance of the model depends heavily on the selected hyperparameter values, including training scheme parameters such as learning rate, batch size, and model architecture hyperparameters, such as the number of nodes in a deep neural network.

## How are hyperparameters decided?

Though there's much active research in this space, in practice, data scientists often tune those hyperparameters using a technique called grid-searching, then observe the difference between the evaluation metrics for different model training executions and select the hyperparameter values that provide the best result.

As you can imagine, hand tuning and exploring those hyperparameters can be time-consuming if there are many hyperparameters to tune. This is because the search space is vast, and the evaluation of each configuration can be expensive. In Azure Machine Learning, you can automate hyperparameter exploration by using the **HyperDrive service** to save significant time and resources.

## What is HyperDrive?

HyperDrive is a built-in service that automatically launches multiple experiments in parallel each with different parameter configurations. Azure Machine Learning then automatically finds the configuration that results in the best performance measured by the metric you choose. The service will terminate poorly performing training runs to minimize compute resources usage.

Using HyperDrive is beyond the scope of this module but if you would like to explore this topic, you can use the sample notebook referenced in the summary that provides a detailed walk through of using the service.