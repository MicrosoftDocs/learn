Train compute-intensive models at scale by using GPU compute in Azure Machine Learning. 

Recall the insurance company you work for. You've been asked to train a model that recognizes handwritten text to automatically extract and process it. After some initial experimentation, you realize you'll have to train a deep learning model, which means it will be compute-intensive. To minimize training time, you decide to use a GPU compute cluster in Azure Machine Learning.

You'll learn how to train a compute-intensive model with GPU compute.

## Submit a compute-intensive training run

The process to train a model in Azure Machine Learning looks similar, whether you use CPU or GPU compute. 

1. Create your training script. 
2. Connect to your Azure Machine Learning workspace.
3. Create a compute target. 
4. Define your environment.
5. Submit your training run.
6. Register or download the model.

There are a couple of considerations if you expect your training run to be compute-intensive. 

### Test your script

First of all, to test your training script, you can work with a small subset of the data to test different configurations quickly. 

Be mindful with testing: when you want to use GPU compute, you're likely to use frameworks that are designed to work with GPU, but can't run on CPU compute. To save costs during testing, you can use **low-priority** compute clusters. 

### Quota restrictions

Per workspace, there are limits to how much compute can be created. Next to that, your organization may have configured quotas on your workspace. You can request limits and quotas to be increased. Still, it's a good practice to check the available compute types and number of cores before you decide on how to train your model. 

> [!TIP]
> Learn more about [how to manage quotas for Azure Machine Learning](/azure/machine-learning/how-to-manage-quotas)

### Choose the appropriate framework

Your choice of model will affect how you should configure your training job. 

Let's take the example of the insurance company again. You want to train a deep learning model that can recognize handwritten text. Two commonly used open-source libraries for such a task are:

- **PyTorch**: Explore the [PyTorch documentation](https://pytorch.org/).
- **TensorFlow**: Explore the [TensorFlow documentation](https://www.tensorflow.org/).

Which of these libraries you use depends on your preference. Assuming you'll train a deep learning model for the first time, you may find PyTorch easier to work with when you use Azure Machine Learning. Both of these frameworks work well with GPUs and support distributed training.

> [!IMPORTANT]
> To use a framework like PyTorch or TensorFlow, the necessary software dependencies need to be installed on the compute. To easily create and manage the dependencies across different compute targets, [use Azure Machine Learning **environments**](/azure/machine-learning/how-to-use-environments). Curated environments exist for both frameworks, or you can create your own custom environment to include the necessary packages. 

### Track metrics and models

When you train a deep learning model with Azure Machine Learning, you may want to experiment with different input parameters. An easy way to track parameter values, metrics, and models, is to use MLflow. 

To track your experiment runs with MLflow:

1. Include the `azureml-mlflow` in your environment.
2. Import `mlflow` in your training script. 
3. Log any parameters, metrics, and models that you want to retrieve after a run has successfully executed.

> [!TIP]
> Learn more about [how to track experiments with MLflow](/azure/machine-learning/how-to-use-mlflow)