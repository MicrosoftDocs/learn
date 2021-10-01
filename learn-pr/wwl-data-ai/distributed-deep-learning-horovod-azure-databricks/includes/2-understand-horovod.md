Horovod is an answer to a problem that data scientists face when training *deep learning* models. Before we can explore Horovod, let's review what deep learning is and what the problem with training deep learning models is.

## A quick review of deep learning

Deep learning is a subfield of machine learning and refers to models that consist of multiple layers also known as deep neural networks. The training process starts with data being submitted to the input layer in **batches**. The data is analyzed by the input layer and passed on to the next layer until it reaches the output layer and produces a prediction. Predictions are compared to the actual known value and based on these results, weights, and bias values are revised to improve the model. Batches are processed by the network over multiple iterations or **epochs**. Each epoch, the model tries to further improve predictions by updating the weight and bias values.

## Deep learning with Azure Databricks

Within Azure Databricks, we can train deep learning models using the popular open-source frameworks for Python: TensorFlow, PyTorch, and Keras. When we use any of these single-node frameworks to train a deep learning model, we should use a *single-node* cluster in Azure Databricks.

Deep learning model benefit from having more data: the more data, the more likely it is we will get a better or more accurate model. Although it is advised to train deep learning models on single-node clusters, your model or your data may be too large to fit in the memory of a single machine. A single-node cluster being insufficient is the problem that data scientists may face when training deep learning models. The answer to that problem is Horovod.

## Understand Horovod

Horovod is an open-source distributed training framework and is the alternative to training a model on a single-node cluster and allows data scientists to distribute the training process and make use of parallel processing. Since deep learning models contain layers that need to be processed sequentially, and use intermediary results to improve the model at the end of an epoch, the parallel processing of deep learning models can quickly become complicated. Although Horovod helps with the infrastructure management of distributing your code, this process is more complex than training a model on a single-node cluster and should therefore be done carefully.

Horovod is named after a traditional dance in which partners hold hands while dancing in a circle. Horovod owes this name to the way it allows worker nodes to communicate with other worker nodes to avoid a bottle-neck at the driver node. When Horovod is used on top of one of the deep learning frameworks (TensorFlow, PyTorch or Keras), it trains multiple models on different batches of the input dataset on separate workers. In other words, multiple models are trained in parallel on different partitions of the data. And each model is trained on a worker node. At the end of an epoch, the weights are communicated between workers and the average weight of all workers is calculated. Next, a new epoch can start using the new average weight and during which again, multiple models are trained in parallel.

The goal of Horovod is to make distributed deep learning fast and easy. Horovod wants to make it easy by mainly separating the infrastructure management from the model training. As a data scientist, you can focus on training your model with one of your preferred frameworks, while Horovod takes care of distributing it efficiently across workers to speed up the training process, which also allows you to use a larger training dataset.

> [!TIP] 
> Find more information on Horovod [here](https://github.com/horovod/horovod). And more information on Horovod on Azure Databricks [here](/azure/databricks/applications/machine-learning/train-model/distributed-training/).