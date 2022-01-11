You can save time by using distributed training in Azure Machine Learning.

To train a deep learning model that recognizes handwritten text, you can use a GPU compute cluster. As you work for an insurance company, the demand for a highly accurate model is strong. You want to train with a large dataset to improve the model's performance. The available GPU clusters don't give you the performance you need, so you're interested to explore whether distributed training will help you.

You'll learn how to use distributed training with Azure Machine Learning.

## Distributed training

Many data science libraries are designed to use a single node when processing data. Although single-node compute is sufficient in many use cases, processing data in parallel can save compute time. Instead of using one node to run the workload, you can split up parts of the work and process them in parallel on multiple nodes. 

There are two main approaches to what can be split up:

- **Data parallelism**: Splits up your dataset. Each node trains a model on a subset of the dataset. Most commonly used.
- **Model parallelism**: Splits up the model. Each node trains part of the model. Only possible for certain algorithms and is more complex to configure as you'll have to pin layers to a specific node.

> [!CAUTION]
> Distributed training can speed up training time, but often creates more overhead and complexity. Distributed training can be beneficial for large scale models but should be carefully executed. 

Azure Machine Learning supports many frameworks that help you to set up distributed training. Next to features within the PyTorch and TensorFlow library to enable distributed training. There are two other frameworks that are commonly used:

- **Horovod**: Focuses on infrastructure management to run distributed training of deep learning models with data parallelism. Also used for model parallelism, which needs to be configured with PyTorch, TensorFlow, or Keras.
- **DeepSpeed**: Enables data and model parallelism, as well as 3D parallelism (data parallelism, model parallelism, and pipeline parallelism) with the **Zero Redundancy Optimizer** (**ZeRO**). Includes a wide array of distributed training features to fit your requirements best.

> [!Tip]
> Examples for distributed training in Azure Machine Learning can be found on Github. For example, explore the example of [TensorFlow distributed training using Horovod](https://github.com/Azure/azureml-examples/tree/main/python-sdk/workflows/train/tensorflow/mnist-distributed-horovod), or of [distributed training with DeepSpeed on CIFAR-10](https://github.com/Azure/azureml-examples/tree/main/python-sdk/workflows/train/deepspeed/cifar).
