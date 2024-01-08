[Data science](/fabric/data-science/data-science-overview/?azure-portal=true) is a multidisciplinary field that uses scientific methods, processes, algorithms, and tools to extract knowledge and insights from structured and unstructured data. 

In a typical data science project, it's a common practice to start with the Exploratory Data Analysis (EDA) where it involves understanding the patterns, spotting anomalies, testing hypotheses, and checking assumptions related to the underlying data.

The insights gained from EDA can guide data scientists in choosing the appropriate statistical or machine learning models that best fit the data. 

Microsoft Fabric notebooks allow you to seamlessly integrate your exploration results into a data science workflow. This can then be used to feed an upstream reporting solution, such as a Power BI report.

## Understand the data science process

Data exploration is a preliminary investigation of the data that sets the stage for all subsequent steps in the data science process.

:::image type="content" source="../media/1-data-science-process.png" alt-text="Diagram of sequential steps in the data science process.":::

1. **Define the problem**: Together with business users and analysts, decide on what the model should predict and when it's successful.
1. **Get the data**: Find data sources and get access by storing your data in a Lakehouse.
1. **Prepare the data**: Explore the data by reading it from a Lakehouse into a notebook. Clean and transform the data based on the model's requirements.
1. **Train the model**: Choose an algorithm and hyperparameter values based on trial and error by tracking your experiments with MLflow.
1. **Generate insights**: Use model batch scoring to generate the requested predictions.

In this module, you focus on how to load data and perform data exploration. Working in a notebook within Microsoft Fabric, you work with Python to understand different types of data distribution. You learn the concept of missing data, and strategies to handle missing data effectively. Finally, you visualize data using various data visualization techniques and libraries.
