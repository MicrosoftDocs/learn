Assessing a model isn't just about understanding how accurately it can make a prediction, but also why it made the prediction. Understanding a model’s behavior is a critical part of debugging and helps drive responsible outputs. By evaluating which data features are driving a model’s prediction, you can identify if they're acceptable sensitive or nonsensitive features to base a decision on. For instance, if a model is using race or gender to predict a diabetic patient’s time in the hospital, then that’s a red flag to investigate the model. In addition, being able to explain a model’s outcome provides shared understanding for data scientists, decision-makers, end-users and auditors. Some industries have compliance regulations that require organizations to provide an explanation for how and why a model made the prediction it did. If an AI system is driving the decision-making, then data scientists need to specify the data features driving the model to make a prediction.

This is where the Responsible AI dashboard is beneficial. The feature importance component provides an interactive user interface (UI) that enables data scientists or AI developers to see the top features in their dataset that influence their model’s prediction. In addition, it provides both global explanations and local explanations. With global explanations, the dashboard displays the top features that affect the model’s overall predictions. For local explanations, it shows which features most influenced a prediction for an individual data point. In our diabetes hospital readmission use case, every patient is different, so what features drove the model to make a prediction for one patient might not be as important for another patient.

The feature importance component has built-in model explainability and interpretability capabilities to help users answer questions in scenarios such as:

- Model debugging: Why did my model make this mistake? How can I improve my model?
- Human-AI collaboration: How can I understand and trust the model’s decisions?
- Regulatory compliance: Does my model satisfy legal requirements?

By using the model explanation component, you can see which features were most important in your model’s predictions. You can view what features affected your model’s prediction overall on the **Aggregate feature importance** pane or view feature importances for individual data points on the **Individual feature importance** pane.

## Aggregate feature importances (global explanations)

:::image type="content" source="../media/aggregate-feature-importance.png" alt-text="Screenshot of the dashboard, showing aggregate feature importances on the 'Feature importances' pane." lightbox= "../media/aggregate-feature-importance.png":::

1. **Top k features**: Lists the most important global features for a prediction and allows you to change it by using a slider bar.
2. **Aggregate feature importance**: Visualizes the weight of each feature in influencing model decisions across all predictions.
3. **Sort by**: Allows you to select which cohort's importances to sort the aggregate feature importance graph by.
4. **Chart type**: Allows you to select between a bar plot view of average importances for each feature and a box plot of importances for all data.

    When you select one of the features in the bar plot, the dependence plot is populated, as shown in the following image. The dependence plot shows the relationship of the values of a feature to its corresponding feature importance values, which affect the model prediction.  

    :::image type="content" source="../media/aggregate-feature-importance-2.png" alt-text="Screenshot of the dashboard, showing a populated dependence plot on the 'Aggregate feature importances' pane." lightbox="../media/aggregate-feature-importance-2.png":::

5. **Feature importance of [feature] (regression) or Feature importance of [feature] on [predicted class] (classification)**: Plots the importance of a particular feature across the predictions. For regression scenarios, the importance values are in terms of the output, so positive feature importance means it contributed positively toward the output. The opposite applies to negative feature importance.  For classification scenarios, positive feature importances mean that feature value is contributing toward the predicted class denoted in the y-axis title. Negative feature importance means it's contributing against the predicted class.
6. **View dependence plot for**: Selects the feature whose importances you want to plot.
7. **Select a dataset cohort**: Selects the cohort whose importances you want to plot.

### Aggregate features importance example 

feature-importance.png

:::image type="content" source="../media/feature-importance.png" alt-text="Screenshot of." lightbox= "../media/feature-importance.png":::

A user can toggle the slider back-and-forth on top of the chart to display all the features, which are ordered in descending order of importance on the x-axis. The y-axis shows how much weight a feature has in driving a model’s prediction in comparison to the rest of the other features. The color of bar(s) on the chart corresponds to the cohorts created on the dashboard. In our case, we have “All data”, which is the default cohort with the test dataset as well as the cohorts with the highest and least number of errors.  It looks like prior hospitalization (prior_Inpatient), age, number of other health diagnoses (number_diagnoses), prior emergency admission (prior_emergency), and the number of medications an individual is taking (num_medication) are the top five features driving our diabetic hospital readmission classification model predictions.

### Feature influence on a model prediction

In the debugging process, users have the ability to evaluate features to see how their values positively or negatively influence a model’s outcome. This can help pinpoint any anomalies in the model’s decision making.

By selecting the *Class: Not Readmitted* option under the *Class importance weights* drop-down menu:

- The dashboard gives you the ability to double-click on any bar or box on the chart to get details. In our case, we’ll double-click on the “number_diagnoses” bar from the “All data” cohort (in blue color).
- This generates another chart below the Aggregate feature importance chart.
- The x-axis displays the number of diagnoses that were entered into the system for the diabetic patient.
- The y-axis displays the level of contribution to the model making a prediction of Not Readmitted.
  - Numbers above 0 show the level of positive contribution to the model’s prediction of a patient Not Readmitted.
  - Numbers below 0 show the level of negative contribution against the model’s prediction from Not Readmitted to Readmitted.

:::image type="content" source="../media/features-influence.png" alt-text="Screenshot of." lightbox= "../media/features-influence.png":::

As you can see from the graph, as we progress from 1 to 9 in “number_diagnoses” the model’s confidence decreases in a patient’s outcome to be not readmitted within 30 days back to the hospital. The chart shows that after the number of diagnoses is 7 or greater, the feature starts to negatively impact the model’s prediction, by falling below the 0 axis, for a “Not Readmitted classification”.  Hence this leads to a “Readmitted” classification. This makes intuitive sense because a diabetic patient with additional medical conditions is more likely to get sick and return to the hospital again.

## Individual feature importances (local explanations)

The following image illustrates how features influence the predictions that are made on specific data points. You can choose up to five data points to compare feature importances for.

:::image type="content" source="../media/individual-feature-importance.png" alt-text="Screenshot of the dashboard, showing the 'Individual feature importances' pane." lightbox= "../media/individual-feature-importance.png":::

**Point selection table**: View your data points and select up to five points to display in the feature importance plot or the ICE plot below the table.

:::image type="content" source="../media/individual-feature-importance-bar-plot.png" alt-text="Screenshot of the dashboard, showing a bar plot on the 'Individual feature importances' pane." lightbox="../media/individual-feature-importance-bar-plot.png":::

**Feature importance plot**: A bar plot of the importance of each feature for the model's prediction on the selected data points.

1. **Top k features**: Allows you to specify the number of features to show importances for by using a slider.
2. **Sort by**: Allows you to select the point (of those checked above) whose feature importances are displayed in descending order on the feature importance plot.
3. **View absolute values**: Toggle on to sort the bar plot by the absolute values. This allows you to see the most impactful features regardless of their positive or negative direction.
4. **Bar plot**: Displays the importance of each feature in the dataset for the model prediction of the selected data points.

**Individual conditional expectation (ICE) plot**: Switches to the ICE plot, which shows model predictions across a range of values of a particular feature.

:::image type="content" source="../media/individual-feature-importance-ice-plot.png" alt-text="Screenshot of the dashboard, showing an ICE plot on the 'Individual feature importances' pane." lightbox="../media/individual-feature-importance-ice-plot.png":::

- **Min (numerical features)**: Specifies the lower bound of the range of predictions in the ICE plot.
- **Max (numerical features)**: Specifies the upper bound of the range of predictions in the ICE plot.
- **Steps (numerical features)**: Specifies the number of points to show predictions for within the interval.
- **Feature values (categorical features)**: Specifies which categorical feature values to show predictions for.
- **Feature**: Specifies the feature to make predictions for.

### Individual feature importance example

The feature importance section has a table view that enables users to see which records the model made a correct vs. incorrect prediction. You can use each individual patient’s record to see which features positively or negatively drove that individual outcome. This is especially useful when debugging to see where the model is performing erroneously for a specific patient, and which features are positive or negative contributors.

:::image type="content" source="../media/feature-importance-table-view.png" alt-text="Screenshot of." lightbox="../media/feature-importance-table-view.png":::

If we need to look at specific record(s) and see what features the model used in making an incorrect prediction, we can use that for our investigation.

In our case, we’re going to:

1. Select **Switch cohort**, to select the **Err: Prior_Inpatient >0; Num_meds >11.50 & <= 21.50** where the model has the highest error rate.
2. Next, we’ll select record index *882*. This will generate a feature important plot chart under the Table view. Here we see that `Prior_Inpatient`, `Age`, `Max_Glu_Serum` and `num_medications` are the top four features that are negative contributors to driving our model incorrectly predicting that the selected patient won't be readmitted within 30 days (the outcome should be Readmitted).

feature-importance-selected-data-influence

:::image type="content" source="../media/feature-importance-selected-data-influence.png" alt-text="Screenshot of." lightbox="../media/feature-importance-selected-data-influence.png":::

We can see that the four features from record index #882 are different from the top four features we saw with the models’ overall predictions from the **Aggregate feature importance** tab.

Next, the **Individual feature importance** graph shows that the `Admission_source`, `prior_emergency`, `gender` and `insulin` positively contributed to the model’s outcome (Not Readmitted). Since the model incorrectly predicted record index #882 as Not Readmitted, that means the positively contributing features are erroneous: `Admission_source`, `prior_emergency`, `gender` and `insulin` since they played a significant role in skewing the model’s output for this data point.

Now we’ll add record index *865*, another record where the model predicted the opposite outcome, that a patient would be readmitted back to a hospital, incorrectly.

:::image type="content" source="../media/feature-importance-data-feature-contribution.png" alt-text="Screenshot of." lightbox="../media/feature-importance-data-feature-contribution.png":::

Here, we can see that the key features positively contributing to that model's prediction are `prior_emergency`, and `insulin`. Once again, we see the top important features (in blue color) that drove the model’s prediction have changed. In this case, `prior_emergency` was the top positive contributor. That means it had a major impact on the model’s incorrect prediction in our selected cohort. In trying to debug why a model’s prediction is erroneous for a given data point, this chart provides machine learning professionals an explanation of which features positively influenced the poor outcome.  

