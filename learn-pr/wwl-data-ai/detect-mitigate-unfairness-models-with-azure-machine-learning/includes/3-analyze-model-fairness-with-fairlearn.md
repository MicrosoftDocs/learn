**Fairlearn** is a Python package that you can use to analyze models and evaluate disparity between predictions and prediction performance for one or more sensitive features.

It works by calculating group metrics for the sensitive features you specify. The metrics themselves are based on standard **scikit-learn**  model evaluation metrics, such as *accuracy*, *precision*, or *recall* for classification models.

The Fairlearn API is extensive, offering multiple ways to explore disparity in metrics across sensitive feature groupings. For a binary classification model, you might start by comparing the selection rate (the number of positive predictions for each group) by using the **selection_rate** function. This function returns the overall selection rate for the test dataset. You can also use standard **sklearn.metrics** functions (such as **accuracy_score**, **precision_score**, or **recall_score**) to get an overall view of how the model performs.

Then, you can define one or more *sensitive features* in your dataset with which you want to group subsets of the population and compare selection rate and predictive performance. Fairlearn includes a **MetricFrame** function that enables you to create a dataframe of multiple metrics by the group.

For example, in a binary classification model for loan repayment prediction, where the sensitive feature **Age** consists of two possible categorical values (**25-and-under** and **over-25**), a MetricFrame for these groups might be similar to the following table:

| Age | selection_rate | accuracy | recall | precision |
| --- | -------------- | -------- | -------| -------- |
| 50 or younger | 0.298178 | 0.89619 | 0.825926 | 0.825926 |
| Over 50 | 0.708995 | 0.888889 | 0.937984 | 0.902985 |

## Visualizing metrics in a dashboard

It's often easier to compare metrics visually, so Fairlearn provides an interactive dashboard widget that you can use in a notebook to display group metrics for a model. The widget enables you to choose a sensitive feature and performance metric to compare, and then calculates and visualizes the metrics and disparity, like this:

![A dashboard compares recall performance and selection rates for two age groups within a loan prediction dataset.](../media/model-dashboard.png)

## Integration with Azure Machine Learning

Fairlearn integrates with Azure Machine Learning by enabling you to run an experiment in which the dashboard metrics are uploaded to your Azure Machine Learning workspace. This enables you to share the dashboard in Azure Machine Learning studio so that your data science team can track and compare disparity metrics for models registered in the workspace.
