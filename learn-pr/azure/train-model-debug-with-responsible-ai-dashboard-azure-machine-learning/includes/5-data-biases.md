The traditional method of evaluating the trustworthiness of a model’s performance is to look at calculated metrics such as accuracy, recall, precision, root mean squared error (RSME), mean absolute error (MAE), or R<sup>2</sup> depending on the type of use-case you have (for example, classification or regression). Data scientists and AI developers can also measure confidence levels for areas the model correctly predicted or the frequency of making correct predictions. You can also try to isolate your test data in separate cohorts to observe and compare how the model performs with some groups vs. others. However, all of these techniques ignore a major blind spot: the underlying data.

Data can be overrepresented in some cases and underrepresented in others. This might lead to data biases, causing the model to have fairness, inclusiveness, safety, and/or reliability issues.

The Responsible AI dashboard includes a data analysis component that enables users to explore and understand the dataset distributions and statistics. It provides an interactive user interface (UI) to enable users to visualize datasets based on the predicted and actual outcomes, error groups, and specific features. This is useful for ML professionals to be able to quickly debug and identify issues of data over- and under-representation and to see how data is clustered in the dataset. As a result, they can understand the root cause of errors and any fairness issues introduced via data imbalances or lack of representation of a particular data group.

With the data analysis component, the **Table view** pane shows you a table view of your dataset for all features and rows.  

:::image type="content" source="../media/data-analysis-table-view.png" alt-text="Screenshot of the dashboard, showing the data analysis." lightbox= "../media/data-analysis-table-view.png":::

The **Chart view** panel shows you aggregate and individual plots of datapoints. You can analyze data statistics along the x-axis and y-axis by using filters such as predicted outcome, dataset features, and error groups. This view helps you understand overrepresentation and underrepresentation in your dataset.  

- **Select a dataset cohort to explore**: Specify which dataset cohort from your list of cohorts you want to view data statistics for.
- **X-axis**: Displays the type of value being plotted horizontally. Modify the values by selecting the button to open a side panel.
- **Y-axis**: Displays the type of value being plotted vertically. Modify the values by selecting the button to open a side panel.
- **Chart type**: Specifies the chart type. Choose between aggregate plots (bar charts) or individual data points (scatter plot).

   By selecting the **Individual data points** option under **Chart type**, you can shift to a disaggregated view of the data with the availability of a color axis.

:::image type="content" source="../media/data-analysis-individual-datapoints.png" alt-text="Screenshot of the dashboard, showing the data analysis with the 'Individual data points' option selected." lightbox= "../media/data-analysis-individual-datapoints.png":::

## Table view

The **Table view** pane under Data Analysis helps visualize all the features and rows of the data in a selected cohort. The advantage of using this view is that we get to see records of the raw data where the model made correct vs. incorrect predictions. In addition, for each row of data, the dashboard includes a field for *TrueY* and *PredictedY* columns to help users decipher common feature attributes from records where the model is incorrect.

Let’s take a closer look at the actual data in our cohort that has the highest error rate: *Err: Prior_Inpatient >0; Num_meds >11.50 & <= 21.50*. To filter the dashboard data to focus on data in this cohort, we’ll select the **switch cohort** on top of the dashboard.

:::image type="content" source="../media/switch-cohort.png" alt-text="Screenshot of." lightbox= "../media/switch-cohort.png":::

In our Diabetes Hospital Readmission use case, the Table view confirms what the true vs. predicted outcomes are for our sample data. In addition, you can view details on the incorrect vs. correct predictions from the different data cohorts you’ve created.

:::image type="content" source="../media/table-view.png" alt-text="Screenshot of." lightbox= "../media/table-view.png":::

## Chart view (aggregate)

The chart view of the dashboard is another useful tool to visualize the data representation. When viewing the data in a chart view, you have the option to look at the aggregated presentation of the data.

For example to see data imbalance issues with test dataset, we'll use the all the test data for our analysis:

1. Select the *All data* option from the *Select a dataset cohort to explore* drop-down menu.
2. On the y-axis, we’ll select the current selected “race” value, which will launch a pop-up menu.
3. Under *Select your axis value*, we’ll choose **Count**.
    select-data-chart
    :::image type="content" source="../media/select-data-chart.png" alt-text="Screenshot of." lightbox= "../media/select-data-chart.png":::

1. On the x-axis, we’ll select the current selected “Index” value, then choose **True Y** under the *Select your axis value* menu.
    true-y
    :::image type="content" source="../media/true-y.png" alt-text="Screenshot of." lightbox= "../media/true-y.png":::

We can see that, out of the 994 diabetes patients represented in our test data, 798 patients aren't readmitted and 198 are readmitted back to a hospital within 30 days. These are the actual values of “TrueY.”

:::image type="content" source="../media/predicted-y.png" alt-text="Screenshot of." lightbox= "../media/predicted-y.png":::

For contrast, let’s compare those values with what our model actually predicts. To do that, let’s change the *True Y* value on the x-axis by selecting the **Predicted Y**.  Now, we see that the model’s number of patients readmitted back to the hospital is 41, while the number of patients not readmitted is 953. So, this exposes an extreme data imbalance issue where the model doesn't perform well for cases where patients are readmitted.

## Chart view (individual datapoints)

The Responsible AI dashboard provides an individual data point view of the data as well. With this, you can add a third field (for example, data feature, trueY, predicted, etc.) and see how the field is represented with individual data points if you want to isolate and examine each individual data point.

1. Under the *Select a dataset cohort to explore* drop-down menu, choose *All data*.
2. On the y-axis, we’ll select **Predicted Y**. You can enable the option for “Should dither” to display the unique values.
3. On the x-axis, we’ll select the **prior_inpatient**.  Make sure the "Should dither" radio button is selected.
4. Under the *Chart type*, select the **Individual datapoints** radio button.
5. Under *Color value*, select **age** from the Dataset.

age-predict-y-inpatient

:::image type="content" source="../media/age-predict-y-inpatient.png" alt-text="Screenshot of." lightbox= "../media/age-predict-y-inpatient.png":::

The chart should display two lines for “Predicted Y”:

- Line 0:  for “Not Readmitted”
- Line 1:  for “Readmitted

In this case, we want to see the data representation of age and the impact “prior_inpatient” has to a patient’s hospital readmission.  At first glance, we can see that line 0 (Not readmitted patients), has a higher concentration of “Over 60 years” patients (seen in green) compared to “30 years or younger” or “30–60 years” (seen in orange). For analysis, we’ll focus on where there's a higher concentration of patients in the different age groups when it comes to whether or not they'll be readmitted in 30 days.

On line 0 (representing “Not Readmitted”) we see the following individual datapoints:

- There's a higher concentration of datapoints with patients “Over 60 years” that aren't readmitted back to the hospital when they have a prior history of hospitalization between 0 and 4. The concentration slowly reduces as the number of prior_inpatients increases.
- The above is also true for patients age “30–60 years.”
- Patients aged “30 years or younger” only shows a high concentration of datapoints when prior_inpatients = 0. Meaning, patients in this age group have no prior of hospitalization, which drives the model’s outcome to be “Not Readmitted.”

On line 1 (representing “Readmitted”) we see the following individual datapoints:

- The concentration of datapoints for patients “Over 60 years” slowly increases in step with the higher number of prior_inpatients between 1 and 6. This shows that a prior history of hospitalization has a significant impact on whether a senior citizen patient is readmitted back to a hospital within 30 days.
- The above is also true for patients age “30–60 years.”
- Patients aged “30 years or younger” have a datapoint at prior_inpatient = 8 and 9. These could be outliers since there are no other datapoints to form a conclusion.

An alternative method of analysis is to change from the “All data” cohort to the cohort with the highest error rate: “Err: Prior_Inpatient >0; Num_meds >11.50 & <= 21.50”. When we change the cohort, we see that datapoints for patients “30 years or younger” no longer exist. However, the data pattern remains the same for patients “Over 60 years” and “30–60 years” with this erroneous cohort.  This means the likelihood of hospital readmission increases when the prior_inpatient => 4 for diabetic patients aged 30 or older.

:::image type="content" source="../media/age-predict-y-inpatient-error.png" alt-text="Screenshot of." lightbox= "../media/age-predict-y-inpatient-error.png":::