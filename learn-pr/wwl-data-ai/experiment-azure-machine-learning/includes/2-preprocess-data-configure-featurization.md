
Before you can run an automated machine learning (AutoML) experiment, you need to prepare your data. When you want to train a machine learning model, you only need to provide the training data. 

After you collected the data, you need to create a **data asset** in Azure Machine Learning. In order for AutoML to understand how to read the data, you need to create a **MLTable** data asset that includes the schema of the data.

You can create a MLTable data asset when your data is stored in a folder together with a MLTable file. After you created the data asset, you can specify it as input with the following code:

```python
from azure.ai.ml.constants import AssetTypes
from azure.ai.ml import Input

my_training_data_input = Input(type=AssetTypes.MLTABLE, path="azureml:input-data-automl:1")
```

> [!Tip]
> Learn more about [how to create a MLTable data asset in Azure Machine Learning](/azure/machine-learning/how-to-mltable?azure-portal=true).

Once you created the data asset, you can configure the AutoML experiment. Before AutoML trains a classification model, preprocessing transformations can be applied to your data.

## Understand scaling and normalization

AutoML applies scaling and normalization to numeric data automatically, helping prevent any large-scale features from dominating training. During an AutoML experiment, multiple scaling or normalization techniques are applied.

## Configure optional featurization

You can choose to have AutoML apply preprocessing transformations, such as:

- Missing value imputation to eliminate nulls in the training dataset.
- Categorical encoding to convert categorical features to numeric indicators.
- Dropping high-cardinality features, such as record IDs.
- Feature engineering (for example, deriving individual date parts from DateTime features)

By default, AutoML performs featurization on your data. You can disable it if you don't want the data to be transformed.

If you do want to make use of the integrated featurization function, you can customize it. For example, you can specify which imputation method should be used for a specific feature.

After an AutoML experiment is completed, you can review which scaling and normalization methods were applied. You get notified if AutoML detected any issues with the data, like whether there are missing values or class imbalance.
