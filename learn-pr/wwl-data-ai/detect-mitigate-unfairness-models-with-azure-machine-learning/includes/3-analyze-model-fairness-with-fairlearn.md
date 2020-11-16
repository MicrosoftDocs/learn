**Fairlearn** is a Python package that you can use to analyze models and evaluate disparity between predictions and prediction performance for one or more sensitive features.

It works by calculating group metrics for the sensitive features you specify. The metrics themselves are based on standard **scikit-learn**  model evaluation metrics, such as *accuracy*, *precision*, or *recall* for classification models.

The Fairlearn API is extensive, offering multiple ways to explore disparity in metrics across sensitive feature groupings. For a binary classification model, you might start by comparing the selection rate (the number of positive predictions for each group) by using the **selection_rate_group_summary** function. This function returns an **sklearn.utils.bunch** object (an extended **dictionary**) containing the overall selection rate for the test dataset, and the selection rate for each sensitive feature group. In a binary classification model for loan repayment prediction, where the sensitive feature **Age** consists of two possible categorical values (**25-and-under** and **over-25**), a selection rate group summary might be similar to the following output (formatted to improve readability):

```
{
    'overall': 0.454545,
    'by_group':
    {
        '25-and-under': 0.363636,
        'Over-25': 0.545454
    }
}
```

To explore disparity in prediction performance, you can use the  **group_summary** function, which enables you to calculate group metrics based on any relevant **sklearn.metrics** metric enumeration (such as **accuracy_score**, **precision_score**, or **recall_score**). A group summary for the loan repayment model based on *recall* might look similar to the following output:

```
{
    'overall': 0.666667,
    'by_group':
    {
        '25-and-under': 0.500000,
        'Over-25': 0.833333
    }
}
```

## Visualizing metrics in a dashboard

It's often easier to compare metrics visually, so Fairlearn provides an interactive dashboard widget that you can use in a notebook to display group metrics for a model. The widget enables you to choose a sensitive feature and performance metric to compare, and then calculates and visualizes the metrics and disparity, like this:

![A dashboard compares recall performance and selection rates for two age groups within a loan prediction dataset.](../media/model-dashboard.png)

## Integration with Azure Machine Learning

Fairlearn integrates with Azure Machine Learning by enabling you to run an experiment in which the dashboard metrics are uploaded to your Azure Machine Learning workspace. This enables you to share the dashboard in Azure Machine Learning studio so that your data science team can track and compare disparity metrics for models registered in the workspace.
