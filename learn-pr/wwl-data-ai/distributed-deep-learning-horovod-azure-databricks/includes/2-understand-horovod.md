Horovod can help data scientists when training *deep learning* models. Before we can explore Horovod, let's review what deep learning is and what the problem with training deep learning models can be.

## A quick review of deep learning

Deep learning is a subfield of machine learning and refers to models that consist of multiple layers, also known as deep neural networks. The training process starts with data being submitted to the input layer in **batches**. 

The data is analyzed by the input layer and passed on to the next layer until it reaches the output layer and produces a prediction. Predictions are compared to the actual known value and based on these results, weights, and bias values are revised to improve the model.

Batches are processed by the network over multiple iterations or **epochs**. Each epoch, the model tries to further improve predictions by updating the weight and bias values.

## Deep learning with Azure Databricks

Within Azure Databricks, we can train deep learning models using the popular open-source frameworks for Python: TensorFlow, PyTorch, and Keras. When we use any of these single-node frameworks to train a deep learning model, we should use a *single-node* cluster in Azure Databricks.

Deep learning models benefit from having more data: the more data, the more likely it is we will get a better or more accurate model. Although it is advised to train deep learning models on single-node clusters, your model or your data may be too large to fit in the memory of a single machine. A single-node cluster being insufficient is the problem that data scientists may face when training deep learning models. Thankfully, Horovod can help in these scenarios.

## Understand Horovod

Horovod is an open-source distributed training framework and is the alternative to training a model on a single-node cluster. Horovod allows data scientists to distribute the training process and make use of Spark's parallel processing.

Since deep learning models contain layers that need to be processed sequentially, and use intermediary results to improve the model at the end of an epoch, the parallel processing of deep learning models can quickly become complicated. Horovod is designed to take care of the infrastructure management so that data scientists can focus on training models.

Horovod is named after a traditional dance in which partners hold hands while dancing in a circle. Horovod owes this name to the way it allows worker nodes to communicate with other worker nodes, to avoid a bottle-neck at the driver node. 

When Horovod is used on top of one of the deep learning frameworks (TensorFlow, PyTorch or Keras), it trains multiple models on different batches of the input dataset on separate workers. In other words, multiple models are trained in parallel on separate workers using different subsets of the data.

At the end of an epoch, the weights are communicated between workers and the average weight of all workers is calculated. Next, a new epoch can start using the new average weight and during which again, multiple models are trained in parallel.

> [!TIP]
> Find more information on Horovod [here](https://github.com/horovod/horovod). Read about Horovod on Azure Databricks in the documentation [here](/azure/databricks/applications/machine-learning/train-model/distributed-training/).