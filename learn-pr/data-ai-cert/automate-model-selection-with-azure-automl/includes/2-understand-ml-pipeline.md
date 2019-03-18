The steps of going from preparing data, building and training models, and deployment are known collectively as the machine learning pipeline. Pipelines can be simple or complex and the level of automation can vary. However, as the number and complexity of machine learning pipelines increase, the need for automation grows and this is where the [Azure Machine Learning Pipeline](https://docs.microsoft.com/azure/machine-learning/service/concept-ml-pipelines) comes in.

Azure Machine Learning Pipeline is created to solve the problem of creation and management of machine learning pipelines. It enables data scientists to manage multiple workflows at the same time, whether they are simple or complex, and thus enables data scientists to focus on machine learning rather than the infrastructure.

The Azure Machine Learning Pipeline consists of individual steps each of which is a distinct computational unit. Steps make it possible to rerun only the needed part of the pipeline. A typical pipeline consists of multiple steps such as data preparation, model training, model deployment, and potentially using the model to score new batches of data. An individual step such as data preparation can involve in many tasks. The diagram below shows four major phases of a pipeline.

![Screenshot of Azure ML Pipeline](../media/2-azure-ml-pipeline.png)

- Data Ingestion is the process of loading the source data.
- Data normalization translates some input data to be in a certain range. For example, normalize the input RGB value of the image pixel (usually from 0~255) to 0~1.
- Data transformation involves converting a piece of data to something that can be consumed by the model. For example, for a monthly sales forecast, you might need to transform the sales data from date and time (01/01/2000 15:32:43) to month (01/2001).
- Data validation verifies the data values are valid. For example, the age column should only have a number, and alphabetical values should be rejected.
- Data Featurization is the process of creating model features from the data. For example, to encode string values into a categorical format understood by a model.

If you have a lot of data, each of the above steps could be computationally expensive. Azure Machine Learning pipelines can be used so data sources and intermediate data are automatically re-used inside the pipeline, un-changed steps are automatically skipped, and the re-training process becomes much faster and less expensive.

You can use the [Azure Machine Learning SDK for Python](https://docs.microsoft.com/azure/machine-learning/service/concept-ml-pipelines#the-python-sdk-for-pipelines) to create ML pipelines, as well as to submit and track individual pipeline runs.

With Azure Machine Learning Pipelines, and the Automated Machine Learning (AutoML) capability, you can easily train your algorithms with just a few lines of code. In the next two units, we will talk about AutoML.