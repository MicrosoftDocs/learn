


In Azure Machine Learning, *compute targets* are physical or virtual computers on which jobs are run.

## Understand the available types of compute

Azure Machine Learning supports multiple types of compute for experimentation, training, and deployment. By having multiple types of compute, you can select the most appropriate type of compute target for your particular needs.

- **Compute instance**: Behaves similarly to a virtual machine and is primarily used to run notebooks. It's ideal for experimentation.
- **Compute clusters**: Multi-node clusters of virtual machines that automatically scale up or down to meet demand. A cost-effective way to run scripts that need to process large volumes of data. Clusters also allow you to use parallel processing to distribute the workload and reduce the time it takes to run a script.
- **Kubernetes clusters**: Cluster based on Kubernetes technology, giving you more control over how the compute is configured and managed. You can attach your self-managed Azure Kubernetes (AKS) cluster for cloud compute, or an Arc Kubernetes cluster for on-premises workloads.
- **Attached compute**: If you already use an Azure-based compute environment for data science, such as an Azure virtual machine or an Azure Databricks cluster, you can attach it to your Azure Machine Learning workspace and use it as a compute target for certain types of workload.

> [!NOTE]
> In Azure Machine Learning, another type of compute exists for **inference**. Inference compute is more lightweight than compute targets designed for training, and can only be used to deploy trained models as endpoints. 

## When to use which type of compute?

In general, there are some best practices that you can follow when working with compute targets. To understand how to choose the appropriate type of compute, several examples are provided. Remember that which type of compute you use always depends on your specific situation.

### Choose a compute target for experimentation

Imagine you're a data scientist and you've been asked to develop a new machine learning model. You'll likely have a small subset of the training data with which you can experiment. 

During experimentation and development, you may prefer working in a Jupyter notebook. A notebook experience benefits most from a compute that is continuously running. 

When working with notebooks, you'll therefore want to use a *compute instance*.

### Choose a compute target for production

After experimentation, you may train your models by running Python scripts to prepare for production. Scripts will be easier to automate and schedule for when you want to retrain your model continuously over time.

When moving to production, you want the compute target to be ready to handle large volumes of data. The more data you use, the better the machine learning model is likely to be. 

When training models with scripts, you'll prefer a *compute cluster*. A compute cluster will automatically scale up when the script(s) need to be executed, and scale down when the script has finished executing. 

### Choose a compute target for scalability

Training machine learning models can take a long time. To train multiple models that you want to evaluate afterwards, you may spend a long time waiting for all models to complete before you can compare their evaluation metrics. 

Azure Machine Learning offers features like Automated Machine Learning and hyperparameter tuning with sweep jobs to iterate over various configurations of a model. When working with such features, you'll want the models to be trained in parallel to more quickly decide which model performs best and is suited for further development or even production.

When you want to train multiple models simultaneously to speed up processing time, you'll want to use a *compute cluster*. A cluster offers multiple nodes, which each can perform a separate task in parallel.

