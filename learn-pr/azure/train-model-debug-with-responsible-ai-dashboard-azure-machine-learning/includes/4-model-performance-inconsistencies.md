An effective approach to evaluating the performance of machine learning models is getting a holistic understanding of their behavior across different scenarios. One way to approach this includes calculating and assessing model performance metrics like accuracy, recall, precision, root mean squared error (RSME), mean absolute error (MAE), or R<sup>2</sup> scores. However, just analyzing one metric or alternatively, the aggregated metrics for the overall model is insufficient to debug a model and identify the root cause of errors or inaccuracies. In conjunction with measuring performance metrics, data scientists and AI developers need to conduct comparative analysis to aid their holistic decision making.

Comparative analysis shines a light on how models are performing for one subgroup of the dataset versus another. One of the advantages is that the Model Overview component of the Responsible AI dashboard isn't just reliant on high-level numeric calculations on datasets, it dives down to the data features as well. This is especially important when one cohort has certain unique characteristics compared to another cohort. For example, discovering that the model is more erroneous with a cohort that has sensitive features (for example, patient race, gender or age) can help expose potential unfairness.

The model overview component provides a comprehensive set of performance and fairness metrics for evaluating your model, along with key performance disparity metrics along specified features and dataset cohorts.  

The Model Overview component within the Responsible AI dashboard helps analyze model performance metric disparities across different data cohorts that the user creates.

## Dataset cohorts

On the **Dataset cohorts** pane, you can investigate your model by comparing the model performance of various user-specified dataset cohorts (accessible via the **Cohort settings** icon at the top right of the dashboard).

:::image type="content" source="./media/model-overview-dataset-cohorts.png" alt-text="Screenshot of the 'Model overview' pane, showing the 'Dataset cohorts' tab." lightbox= "./media/model-overview-dataset-cohorts.png":::

1. **Help me choose metrics**: Select this icon to open a panel with more information about what model performance metrics are available to be shown in the table. Easily adjust which metrics to view by using the multi-select dropdown list to select and deselect performance metrics. 
2. **Show heat map**: Toggle on and off to show or hide heat map visualization in the table. The gradient of the heat map corresponds to the range normalized between the lowest value and the highest value in each column.  
3. **Table of metrics for each dataset cohort**: View columns of dataset cohorts, the sample size of each cohort, and the selected model performance metrics for each cohort.
4. **Bar chart visualizing individual metric**: View mean absolute error across the cohorts for easy comparison. 
5. **Choose metric (x-axis)**: Select this button to choose which metrics to view in the bar chart. 
6. **Choose cohorts (y-axis)**: Select this button to choose which cohorts to view in the bar chart. **Feature cohort** selection might be disabled unless you first specify the features you want on the **Feature cohort tab** of the component. 

Select **Help me choose metrics** to open a panel with a list of model performance metrics and their definitions, which can help you select the right metrics to view.

| Machine learning scenario | Metrics |
|---|---|
| Regression | Mean absolute error, Mean squared error, R-squared, Mean prediction. |
| Classification | Accuracy, Precision, Recall, F1 score, False positive rate, False negative rate, Selection rate. |

### Dataset cohort analysis

For our investigation, we’ll be evaluating the cohort with the highest model error rate and the least error rate. To start with, we're going to analyze and compare cohort performance for two separate cohorts. Since the dashboard knows we're working with a classification model, it already preselected the parameters: Accuracy score, False Positive rate, False Negative rate and Selection rate.  Next, we’ll select the “Dataset Cohorts” pane. This displays the different cohorts created in a table with the model metrics.

:::image type="content" source="./media/4-dataset-cohort-metrics.png" alt-text="Screenshot of ." lightbox= "./media/4-dataset-cohort-metrics.png":::

As we compare the cohort with the most errors *Err: Prior_Inpatient > 0; Num_Meds > 11 and ≤ 21.50* verse the least errors *Prior_inpatient = 0; num_diagnose ≤ 6.50; lab_procedures < 56.50*, we can see that the accuracy score for the erroneous cohort is 0.657, which isn't optimal. The rate of False Positive is very low; meaning there's a low number of cases where the model is inaccurately predicting patients that are going to be readmitted back to the hospital in 30 days. Contrarily, the False Negative rate of 0.754 is high. This indicates that there's a high number of cases where the model is falsely predicting that many of the patients won't be readmitted, however the actual outcome is they'll be readmitted in 30 days back to the hospital. The cohort with the least errors has an accuracy score of 0.94, which is far better than the overall accuracy score of the model with all the data. However, this cohort also has a lower false positive rate.

## Feature cohorts

On the **Feature cohorts** pane, you can investigate your model by comparing model performance across user-specified sensitive and nonsensitive features (for example, performance across various gender, race, and income level cohorts).

:::image type="content" source="./media/model-overview-feature-cohorts.png" alt-text="Screenshot of the dashboard 'Model overview' pane, showing the 'Feature cohorts' tab." lightbox= "./media/model-overview-feature-cohorts.png":::

1. **Help me choose metrics**: Select this icon to open a panel with more information about what metrics are available to be shown in the table. Easily adjust which metrics to view by using the multi-select dropdown to select and deselect performance metrics.
2. **Help me choose features**: Select this icon to open a panel with more information about what features are available to be shown in the table, with descriptors of each feature and their binning capability (see below). Easily adjust which features to view by using the multi-select dropdown to select and deselect them.

    :::image type="content" source="./media/model-overview-choose-features.png" alt-text="Screenshot of the dashboard 'Model overview' pane, showing how to choose features." lightbox= "./media/model-overview-choose-features.png":::
3. **Show heat map**: Toggle on and off to see a heat map visualization. The gradient of the heat map corresponds to the range that's normalized between the lowest value and the highest value in each column.
4. **Table of metrics for each feature cohort**: A table with columns for feature cohorts (subcohort of your selected feature), sample size of each cohort, and the selected model performance metrics for each feature cohort.
5. **Fairness metrics/disparity metrics**: A table that corresponds to the metrics table and shows the maximum difference or maximum ratio in performance scores between any two feature cohorts.
6. **Bar chart visualizing individual metric**: View mean absolute error across the cohorts for easy comparison.
7. **Choose cohorts (y-axis)**: Select this button to choose which cohorts to view in the bar chart.

    Selecting **Choose cohorts** opens a panel with an option to either show a comparison of selected dataset cohorts or feature cohorts, depending on what you select in the multi-select dropdown list below it. Select **Confirm** to save the changes to the bar chart view.  

    :::image type="content" source="./media/model-overview-choose-cohorts.png" alt-text="Screenshot of the dashboard 'Model overview' pane, showing how to choose cohorts." lightbox= "./media/model-overview-choose-cohorts.png":::
8. **Choose metric (x-axis)**: Select this button to choose which metric to view in the bar chart.

### Feature cohort analysis

The Responsible AI dashboard gives us the ability to examine model performance across different cohorts within a given feature as well. On the Feature cohort's pane, you can investigate a model by comparing model performance across user-specified sensitive and non-sensitive features (for example, performance across patient age, diagnoses or insulin results). Whether it's one feature, or a combination of two features, the Responsible AI dashboard has built-in intelligence to divide feature values into various meaningful cohorts for users to do feature-based analysis and compare where the model isn't doing well.

To look closer at the data, we’ll switch to the **Feature cohorts** tab. Since the cohort with the highest error has patients with the number of Prior_Inpatient > 0 days and number of medications between 11 and 22 was where the model had a higher error rate, we’ll take a closer look at the `Prior_Inpatient` and `Num_medications`.

Under the *Feature(s)* drop-down menu, select the `Prior_Inpatient` checkbox. This will display three different feature cohorts and the model performance metrics.

:::image type="content" source="./media/5-feature-cohort-metrics.png" alt-text="Screenshot of. " lightbox= "./media/5-feature-cohort-metrics.png":::

Here we see a breakdown of the different `prior_inpatient` cohorts generated:

- prior_inpatient < 3
- prior_inpatient ≥ 3 and < 6
- prior_inpatient ≥ 6

We see that the *prior_inpatient < 3* cohort has a sample size of 943. This means a majority of patients in the test data were hospitalized less than three times in the past. The model’s accuracy rate for this cohort is 0.838, which is good. Only 39 patients from the test data fall in the *prior_inpatient ≥ 3 and < 6* cohort. The model’s accuracy rate is 0.692, which isn't very accurate. Lastly, just 12 patients from the test data have a prior hospitalization greater than or equal to six days. The model accuracy of 0.75 for this cohort is ok.

