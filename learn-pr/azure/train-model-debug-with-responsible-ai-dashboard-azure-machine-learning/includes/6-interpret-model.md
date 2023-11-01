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

:::image type="content" source="../media/individual-feature-importance-ice-plot.png" alt-text="Screenshot of the dashboard, showing an ICE plot on the 'Individual feature importances' pane." lightbox="./media/individual-feature-importance-ice-plot.png":::

- **Min (numerical features)**: Specifies the lower bound of the range of predictions in the ICE plot.
- **Max (numerical features)**: Specifies the upper bound of the range of predictions in the ICE plot.
- **Steps (numerical features)**: Specifies the number of points to show predictions for within the interval.
- **Feature values (categorical features)**: Specifies which categorical feature values to show predictions for.
- **Feature**: Specifies the feature to make predictions for.
