Model monitoring is the last step in the machine learning end-to-end lifecycle. This step tracks model performance in production and analyzes the performance from both data science and operational perspectives. The behavior of machine learning systems is governed by rules specified in code and by model behavior learned from data.

Data distribution changes, training-serving skew, data quality issues, shifts in environments, or consumer behavior changes can all cause a model to become stale. When a model becomes stale, its performance can degrade to the point that it fails to add business value or starts to cause serious compliance issues in highly regulated environments.

Azure Machine Learning provides the following capabilities for continuous model monitoring:

- Built-in monitoring signals for tabular data, including data drift, prediction drift, data quality, feature attribution drift, and model performance.
- Out-of-box model monitoring for online endpoints. If you deploy your model to production in an online endpoint, Azure Machine Learning collects production inference data automatically and uses it for continuous monitoring.
- Multiple monitoring signals in one monitoring setup. For each monitoring signal, you can select your preferred metrics and alert threshold.
- Choice of reference data for comparison. For monitoring signals, you can set reference data using training data or recent past production data.
- Top N features for data drift or data quality monitoring. If you use training data as the reference data, you can define data drift or data quality signals layered over feature importance.
- Ability to define custom monitoring signals. If the built-in monitoring signals aren't suitable for your business scenario, you can define your own monitoring signal with a custom monitoring signal component.
- Flexibility to use production inference data from any source. If you deploy models outside of Azure Machine Learning or deploy models to batch endpoints, you can still collect production inference data yourself to use in Azure Machine Learning model monitoring.

Each machine learning model and its use cases are unique. Therefore, model monitoring is unique for each situation. The following list describes recommended best practices for model monitoring.

- Start model monitoring immediately after you deploy a model to production.
- Work with data scientists who are familiar with the model to set up monitoring. Data scientists who have insight into the model and its use cases can recommend monitoring signals and metrics and set the right alert thresholds for each metric to avoid alert fatigue.
- Include multiple monitoring signals in your setup. With multiple monitoring signals, you get both broad and granular monitoring views. For example, you can combine data drift and feature attribution drift signals to get early warnings about model performance issues.
- Use appropriate reference data as the comparison baseline. For reference data used as the comparison baseline, you can use recent past production data or historical data, such as training or validation data. For more meaningful comparison, use training data as the comparison baseline for data drift and data quality. Use validation data as the comparison baseline for prediction drift.
- Specify monitoring frequency based on production data growth over time. For example, if your production model has heavy daily traffic and the daily data accumulation is sufficient, set the monitoring frequency to daily. Otherwise, consider a weekly or monthly monitoring frequency based on the growth of your production data over time.
- Monitor top N features or a feature subset. If you use training data as the comparison baseline, you can easily configure data drift monitoring or data quality monitoring for the top N important features. For models that have a large number of features, consider monitoring a subset of those features to reduce computation cost and monitoring noise.
- Use the model performance signal when you have access to ground truth data. If you have access to ground truth data, also called actuals, based on your machine learning application, use the model performance signal to compare the ground truth data to model output. This comparison provides an objective view of model performance in production.
