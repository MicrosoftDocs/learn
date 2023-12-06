[Data science](/fabric/data-science/data-science-overview/?azure-portal=true) is a multidisciplinary field that uses scientific methods, processes, algorithms, and tools to extract knowledge and insights from structured and unstructured data. 

In a typical data science project, it's a common practice to start with the Exploratory Data Analysis (EDA) where it involves understanding the patterns, spotting anomalies, and checking assumptions related to the underlying data.

Once you have this understanding, you can move on to the preprocessing phase. This is where you address the data quality issues identified during EDA and prepare your data for modeling. Preprocessing transforms raw data into an understandable format for machine learning algorithms, which improves their ability to make accurate predictions.

[Data Wrangler](/en-us/fabric/data-science/data-wrangler?azure-portal=true) in Microsoft Fabric provides a graphical experience where you can easily generate code for exploration and preprocessing purposes, and ensures that your data is in the best possible shape before it’s used to train a machine learning model.

## Understand the data science process

Data preprocessing is a preliminary preparation of the data that sets the stage for all subsequent steps in the data science process.

:::image type="content" source="../media/1-data-science-process.png" alt-text="Diagram of sequential steps in the data science process.":::

1. **Define the problem**: Together with business users and analysts, decide on what the model should predict and when it's successful.
1. **Get the data**: Find data sources and get access by storing your data in a Lakehouse.
1. **Prepare the data**: Explore the data by reading it from a Lakehouse into a notebook. Clean and transform the data based on the model's requirements.
1. **Train the model**: Choose an algorithm and hyperparameter values based on trial and error by tracking your experiments with MLflow.
1. **Generate insights**: Use model batch scoring to generate the requested predictions.

In this module, the focus is on preprocessing data using Data Wrangler. You work within a Microsoft Fabric notebook, using both Data Wrangler and Python for data exploration. You learn how to manage missing data and use various operators to transform data for a model-building pipeline. Lastly, you get hands-on experience in preprocessing data using Data Wrangler within Microsoft Fabric notebooks through a practical exercise.
