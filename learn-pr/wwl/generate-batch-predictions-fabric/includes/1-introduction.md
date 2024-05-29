As a data scientist, you spend most of your time on training machine learning models to identify complex patterns in your data. After training, you want to use the models to retrieve valuable insights.

For example, after training a model on historical sales data, you can generate the forecast of the upcoming week. Or using customer data, you train a model to identify customers that are likely to churn. Whatever use case you have, after training the model, you want to apply the model to a new dataset to generate predictions.

Microsoft Fabric helps you to apply your model after tracking it with MLflow.

## Understand the data science process

A data science project commonly includes the following phases:

:::image type="content" source="../media/data-science-process.png" alt-text="Diagram of sequential steps in the data science process.":::

1. **Define the problem**: Together with business users and analysts, decide on what the model should predict and when it's successful.
1. **Get the data**: Find data sources and get access by storing your data in a lakehouse.
1. **Prepare the data**: Explore the data by reading it from a lakehouse into a notebook. Clean and transform the data based on the model's requirements.
1. **Train the model**: Choose an algorithm and hyperparameter values based on trial and error by tracking your experiments with MLflow.
1. **Generate predictions**: Use model batch scoring to generate the requested predictions.

In this module, you focus on how to generate batch predictions. To retrieve predictions from a trained model, you first need to save the model to the Microsoft Fabric workspace. You can then prepare your new data and apply the model to the data to generate batch predictions. Finally, you can save the predictions in Microsoft Fabric for further processing, like visualizing the data in a Power BI report.
