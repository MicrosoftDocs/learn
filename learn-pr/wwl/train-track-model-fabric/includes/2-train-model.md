How you train a machine learning model depends on the type of model you want to train. Let's explore some commonly used frameworks that you can use to train a machine learning model in Microsoft Fabric.

## Explore machine learning frameworks

Many data scientists work in Python, and many machine learning libraries are designed to work well with Python.

Some libraries and their popular uses that you can work with in Microsoft Fabric are:

- [Scikit-learn](https://scikit-learn.org/stable/?azure-portal=true): Train traditional machine learning models for tasks like classification, regression, and clustering.
- [PyTorch](https://pytorch.org/?azure-portal=true) and [TensorFlow](https://www.tensorflow.org/?azure-portal=true): Train deep learning models for natural language processing or computer vision tasks.
- [SynapseML](https://microsoft.github.io/SynapseML/?azure-portal=true): Allows you to create scalable machine learning pipelines for more optimal model training.

## Work with notebooks in Microsoft Fabric

When you want to train a model in Microsoft Fabric, you can use **notebooks**.

As a data scientist, you may already be familiar with Jupyter notebooks. The notebooks available in your Microsoft Fabric workspace are similar to Jupyter notebooks, making it easy for you to run your code as expected.

The notebooks in Microsoft Fabric are powered by Spark compute, which means that you can use PySpark and Python. Most machine learning frameworks like scikit-learn, PyTorch, and TensorFlow work with Python and Pandas DataFrames.

PySpark is a Python library that is built for distributed data processing. Whenever you notice the need for a more scalable machine training pipeline, you can explore the use of PySpark and SynapseML in your projects.

## Train a model

How you approach the training of a machine learning depends on the type of model you train. A common approach with traditional models is to iterate through the following steps:

- **Load** the data by making it available in the notebook as a DataFrame.
- **Explore** the data by visualizing the data and understanding the relationship between the *features* (model input) and how it affects the *label* (model output).
- **Prepare** the data, also known as feature engineering.
- **Split** the data into a training dataset and test dataset.
- **Train** the model.
- **Evaluate** the model by inspecting the performance metrics.

Let's explore an example and assume you already have a dataset that you explored and prepared for model training. Imagine you want to train a regression model and you choose to use scikit-learn.

You can split the prepared dataset with the following code:

```python
from sklearn.model_selection import train_test_split

X, y = df[['feature1','feature2','feature3']].values, df['label'].values

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.30, random_state=0)
```

As a result of splitting your dataset, you'll have four DataFrames:

- `X_train`: Training dataset including only the features.
- `X_test`: Test dataset including only the features.
- `y_train`: Training dataset including only the label.
- `y_test`: Test dataset including only the label.

When you want to train a model, you can select one of the algorithms (for example linear regression) for your task (for example regression) that are available in the framework of your choice (for example scikit-learn). The following code shows an example of training a regression model:

```python
from sklearn.linear_model import LinearRegression

model = LinearRegression() 
model.fit(X_train, y_train)
```

After fitting the model, you can use the model to generate predictions on the test dataset to create model performance metrics. When you use MLflow to track your model, you can track the performance metrics you calculate. Alternatively, you can let MLflow create and track standard performance metrics for you.

When tracking with MLflow, you can also ensure your model is saved in a format to enable model scoring at a later stage.
