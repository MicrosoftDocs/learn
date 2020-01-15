In addition to trying a selection of algorithms, automated machine learning can apply preprocessing transformations to your data, which may improve the performance of a model trained on the featurized data.

## Scaling and Normalization

Automated machine learning applies scaling and normalization to numeric data automatically. This helps prevent any large scale features from dominating training. During an automated machine learning experiment, a variety of scaling or normalization techniques will be applied.

## Optional Featurization

You can choose to have automated machine learning apply preprocessing transformations such as:

* Missing value imputation to eliminate nulls in the training dataset.
* Categorical encoding to convert categorical features to numeric indicators.
* Dropping high-cardinality features, such as record IDs.
* Feature engineering (for example, deriving individual date parts from DateTime features)
* Others...

> **More Information**: For more information about the preprocessing support in automated machine learning , see [What is automated machine learning](https://aka.ms/AA70rrt) in the documentation.
