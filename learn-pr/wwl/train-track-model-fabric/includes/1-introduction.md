To get valuable insights from your data, you can train a machine learning model using data science. As a data scientist, you may be familiar with using open-source frameworks like scikit-learn and TensorFlow to train models. Microsoft Fabric offers a familiar notebook experience for you to train your models, integrating with the open-source framework MLflow to easily track and manage your models.

## Understand the data science process

A data science project commonly includes the following phases:

:::image type="content" source="../media/data-science-process.png" alt-text="Diagram of sequential steps in the data science process.":::

1. **Define the problem**: Together with business users and analysts, decide on what the model should predict and when it's successful.
1. **Get the data**: Find data sources and get access by storing your data in a lakehouse.
1. **Prepare the data**: Explore the data by reading it from a lakehouse into a notebook. Clean and transform the data based on the model's requirements.
1. **Train the model**: Choose an algorithm and hyperparameter values based on trial and error by tracking your experiments with MLflow.
1. **Generate predictions**: Use model batch scoring to generate the requested predictions.

In this module, you focus on how to train and track the model. Working in a notebook within Microsoft Fabric, you work with Python to train a model. You learn how to use MLflow to track your machine learning models and their metadata. Finally, you explore your models by using the MLflow library and the Microsoft Fabric user interface.
