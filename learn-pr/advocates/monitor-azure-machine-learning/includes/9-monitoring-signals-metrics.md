Azure Machine Learning supports the following signals and metrics for model monitoring:

| Monitoring signal | Description | Metrics | Model tasks or supported data format | Production data | Reference data |
|---|---|---|---|---|---|
| **Data drift** | Tracks changes in the distribution of a model's input data by comparing the distribution to the model's training data or recent production data. | Jensen-Shannon Distance, Population Stability Index, Normalized Wasserstein Distance, Two-Sample Kolmogorov-Smirnov Test, Pearson's Chi-Squared Test | Classification (tabular data), regression (tabular data) | Model inputs | Recent production data or training data |
| **Prediction drift** | Tracks changes in the distribution of a model's predicted outputs by comparing the distribution to validation data, labeled test data, or recent production data. | Jensen-Shannon Distance, Population Stability Index, Normalized Wasserstein Distance, Chebyshev Distance, Two-Sample Kolmogorov-Smirnov Test, Pearson's Chi-Squared Test | Classification (tabular data), regression (tabular data) | Model outputs | Recent production data or validation data |
| **Data quality** | Tracks the data integrity of a model's input by comparing it to the model's training data or recent production data. The data quality checks include checking for null values, type mismatch, or out-of-bounds values. | Null value rate, data type error rate, out-of-bounds rate | Classification (tabular data), regression (tabular data) | Model inputs | Recent production data or training data |

When you deploy your model to production in an Azure Machine Learning online endpoint and enable data collection, Azure Machine Learning automatically collects production inference data. The service stores this data in Azure Blob Storage. You can then use Azure Machine Learning model monitoring to continuously monitor this production inference data.

> [!NOTE]
> The full configuration and use of Azure Machine Learning model monitoring depends on multiple aspects and components of your environment. For full guidance on how to configure model monitoring, see the [Azure Machine Learning model monitoring](/azure/machine-learning/concept-model-monitoring) article.
