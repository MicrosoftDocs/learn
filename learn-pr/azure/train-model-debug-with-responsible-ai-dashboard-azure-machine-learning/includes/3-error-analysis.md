Traditional performance metrics for machine learning models focus on calculations based on correct vs incorrect predictions. The aggregated accuracy scores or average error loss show how good the model is, but don't reveal conditions causing model errors. While the overall performance metrics such as classification accuracy, precision, recall or Mean Absolute Error (MAE) scores are good proxies to help you build trust with your model, they're insufficient in locating where in the data the model has inaccuracies.  Often, model errors aren't distributed uniformly in your underlying dataset.  For instance, if your model is 89% accurate, does that mean it's 89% fair as well? 

Model fairness and model accuracy aren't the same thing and must be considered. Unless you take a deep dive in the model error distribution, it would be challenging to discover the different regions of your data for where the model is failing 42% of the time (see the red region in diagram below). The consequence of having errors in certain data groups can lead to fairness or reliability issues. To illustrate, the data group with the high number of errors might contain sensitive features such as age, gender, disabilities, or ethnicity. Further analysis could reveal that the model has a high error rate with individuals with disabilities compared to ones without disabilities.  So, it's essential to understand areas where the model is performing well or not, because the data regions where there are a high number of inaccuracies in your model might turn out to be an important data demographic you can't afford to ignore.

:::image type="content" source="./media/error-distribution.png" alt-text="Diagram showing benchmark and ML model pointing to 89% accurate pointing to different regions fail for different reasons.":::

This is where the error analysis component of Azure Machine Learning Responsible AI dashboard helps in identifying a model’s error distribution across its test dataset. Throughout this module we'll be using the diabetes hospital readmission classification model scenario to learn and explain the responsible AI dashboard. Later in the lab, you'll train and create your own dashboard using the same dataset.

## How to interpret Error Analysis insights

The Responsible AI dashboard illustrates how model failure is distributed across various cohorts with a tree visualization. The root node displays the total number of incorrect predictions from a model and the total test dataset size. The nodes are groupings of data (cohorts) that are formed by splits from feature conditions (for example, “Time_In_Hospital < 5” vs “Time_In_Hospital ≥ 5”). Hovering the mouse over each node on the tree reveals the following information for the selected feature condition:

:::image type="content" source="./media/error-nodes.png" alt-text="Screenshot of.":::

- **Incorrect vs Correct predictions**: The number of incorrect vs correct predictions for the datapoints that fall in the node.
- **Error Rate**: represents the number of error occurrence in the node.  The shade of red shows what percentage of this node’s datapoints are receiving erroneous predictions. The darker the red the higher the error rate.
- **Error Coverage**: represents how many of your model’s overall errors are happening in a given node. The fullness of the node shows the coverage of errors the node has. The fuller the node, the higher error coverage it has.

## Identifying model errors from a tree map

The tree map displays how model failure is distributed across various data cohorts. For our diabetes hospital readmission model, one of the first things we observe from the root node is that out of the 994 total test records, the error analysis component found 168 errors while evaluating the model.

:::image type="content" source="./media/tree-map.png" alt-text="Screenshot of.":::

The tree map provides visual indicators to make locating nodes or tree path with the error rate quicker. In the above diagram, you can see the tree path with the darkest red color has a leaf-node on the bottom right-hand side of the tree. To select the path leading up to the node, double-click on the leaf node. This highlights the path and displays the feature condition for each node in the path. Since this tree path contains nodes with the highest error rate, it's a good candidate to create a cohort with the data represented in the path in order to later perform analysis to diagnose the root cause behind the errors.

:::image type="content" source="./media/1-select-error-tree.png" alt-text="Screenshot of.":::

According to this tree path with the highest error rate, diabetes patients that have prior hospitalization and taking several medications between 11 and 22 are a cohort of patients where the model has the highest number of incorrect predictions. To investigate what's causing the high error rate with this group of patients, we'll create a cohort for these groups of patients.

**Cohort # 1**: Patients with number of Prior_Inpatient > 0 days and number of medications between 11 and 22

To save the selected path for further investigation:

1. Select the “Save as a new cohort” button on the upper right-hand side of the error analysis component.
1. We’ll name the cohort: “Err: Prior_Inpatient >0; Num_meds >11.50 & <= 21.50”.

:::image type="content" source="./media/1-save-error-tree.png" alt-text="Screenshot of.":::

### Error tree map

The first pane of the error analysis component is a tree map, which illustrates how model failure is distributed across various cohorts with a tree visualization. Select any node to see the prediction path on your features where an error was found.

:::image type="content" source="./media/error-analysis-tree-map-selected.png" alt-text="Screenshot of the dashboard showing an error analysis on the tree map pane." lightbox="./media/how-to-responsible-ai-dashboard/error-analysis-tree-map-selected.png":::

1. **Heat map view**: Switches to heat map visualization of error distribution.
2. **Feature list:** Allows you to modify the features used in the heat map using a side panel.
3. **Error coverage**: Displays the percentage of all error in the dataset concentrated in the selected node.
4. **Error (regression) or Error rate (classification)**: Displays the error or percentage of failures of all the data points in the selected node.
5. **Node**: Represents a cohort of the dataset, potentially with filters applied, and the number of errors out of the total number of data points in the cohort.
6. **Fill line**: Visualizes the distribution of data points into child cohorts based on filters, with the number of data points represented through line thickness.
7. **Selection information**: Contains information about the selected node in a side panel.
8. **Save as a new cohort:** Creates a new cohort with the specified filters.
9. **Instances in the base cohort**: Displays the total number of points in the entire dataset and the number of correctly and incorrectly predicted points.
10. **Instances in the selected cohort**: Displays the total number of points in the selected node and the number of correctly and incorrectly predicted points.
11. **Prediction path (filters)**: Lists the filters placed over the full dataset to create this smaller cohort.

## Discovering model errors from the feature list

The feature list pane displays the list of feature names in the test dataset that are error contributors (included in the creation of your error tree map). The list is sorted based on the contribution of the features to the errors. The higher a feature is on this list, the higher its contribution importance to your model errors. This sorted list is vital to know the problematic features that are causing issues with the model’s performance.  It's also an opportunity to check if sensitive features such as age, race, gender, political view, religion, etc. are among top error contributors.   This is an indicator to examine if your model encounters potential fairness issues.

:::image type="content" source="./media/1-view-feature-list.png" alt-text="Screenshot of.":::

In our Diabetes Hospital Readmission model, the “Feature List” indicates the following features to be among the top contributors of the model’s errors:

- `Age`
- `num_medications`
- `medicare`
- `time_in_hospital`
- `num_procedures`
- `insulin`
- `discharge_destination`

Although “Age” is a sensitive feature, we must check if there's a potential age bias with the model having a high inaccuracy with this feature. In addition, you might have noticed that not all the features on this list appeared on the Tree map nodes. The user can control how granular or high-level tree map should be displayed the error contributors, from the “Feature List” pane:

- **Maximum depth**: controls how tall the error tree should be. Meaning the maximum number of nodes that can be displayed from the root node to the leaf node (for any branch)
- **Number of leaves**: the total number of features with errors from the trained model. (for example, 21 is the number of features highlighted on the bar to show the level of error contribution from the list)
- **Minimum number of samples in one leaf**: controls the threshold for the minimum number of data samples to create one leaf.

Try adjusting the control levels for the minimum number of samples in one leaf field to different values between 1 and 100 to see how the tree expands or shrinks. If you want to see a more granular breakdown of the errors in your dataset, you should reduce the level for the minimum number of samples in one leaf field.

### Feature list

Select the **Feature list** button to open a side panel, from which you can retrain the error tree on specific features.

:::image type="content" source="./media/error-analysis-feature-selection.png" alt-text="Screenshot of the dashboard side panel, which lists selectable features of an error analysis tree map." lightbox= "./media/error-analysis-feature-selection.png":::

1. **Search features**: Allows you to find specific features in the dataset.
2. **Features**: Lists the name of the feature in the dataset.
3. **Importances**: A guideline for how related the feature might be to the error. Calculated via mutual information score between the feature and the error on the labels. You can use this score to help you decide which features to choose in the error analysis.
4. **Check mark**: Allows you to add or remove the feature from the tree map.
5. **Maximum depth**: The maximum depth of the surrogate tree trained on errors.
6. **Number of leaves**: The number of leaves of the surrogate tree trained on errors.
7. **Minimum number of samples in one leaf**: The minimum amount of data required to create one leaf.

## Investigating model errors using the heat map

The Heat map is another visualization functionality that enables users to investigate the error rate through filtering by one or two features to see where most of the errors are concentrated. This helps you determine which areas to drill down further so you can start forming hypotheses of where the errors are originating.

From the Feature List, we saw that “Age” was the top contributor of the model inaccuracies.  So, we’re going to use the Heat map to see which cohorts within the “Age” feature are driving high model errors.

:::image type="content" source="./media/heatmap-age.png" alt-text="Screenshot of.":::

Under the Heat map tab, we’ll select “Age” in the *Rows: Feature 1* drop-down menu to see its influence in the model’s errors. The dashboard has a built-in intelligence to divide the feature into different cells with the possible data cohorts with the Age feature (for example, “Over 60 years”, “30–60 years” and “30 years or younger”). By hovering over each cell, we can see the number of correct vs incorrect predictions, error coverage and error rate for the data group represented in the cell. Here we see:

- The cell with “Over 60 years” has 536 correct and 126 incorrect model predictions. The error coverage is 73.81%, and error rate 18.79%. This means that out of 168 total incorrect predictions that the model made from the test data, 126 of the incorrect predictions came from “Age==Over 60 years”.
- Even though the error rate of 18.79% is low, an error coverage of 73.81% is a huge number. That means a majority of the model’s inaccuracies come from data where patients are older than 60 years old. This is problematic.

:::image type="content" source="./media/heat-map-elder-metrics.png" alt-text="Screenshot of.":::

- The cell with “30–60 years” has 273 correct and 25 incorrect model predictions. The error coverage is 25.60%, and error rate 13.61%. Even though, the patients with “Age==30–60 years” have a very low error rate, the error coverage of 25.60% is a quarter of all the model’s error, which is an issue.
- The cell with “30 years or younger” has 17 correct and 1 incorrect model predictions. The error coverage is 0.60%, and error rate 5.56%. Having 1 incorrect model prediction is insignificant. Plus, both the error coverage and error rate are low. It’s safe to say the model is performing very well in this cohort, however we must also consider that its total data size of 18 is a very small sample size.

### Error heat map

Select the **Heat map** tab to switch to a different view of the error in the dataset. You can select one or many heat map cells and create new cohorts. You can choose up to two features to create a heat map.

:::image type="content" source="./media/error-analysis-heat-map.png" alt-text="Screenshot of the dashboard, showing an error analysis heat map and list of features to compare." lightbox= "./media/error-analysis-heat-map.png":::

1. **Cells**: Displays the number of cells selected.
2. **Error coverage**: Displays the percentage of all errors concentrated in the selected cell(s).
3. **Error rate**: Displays the percentage of failures of all data points in the selected cell(s).
4. **Axis features**: Selects the intersection of features to display in the heat map.
5. **Cells**: Represents a cohort of the dataset, with filters applied, and the percentage of errors out of the total number of data points in the cohort. A blue outline indicates selected cells, and the darkness of red represents the concentration of failures.
6. **Prediction path (filters)**: Lists the filters placed over the full dataset for each selected cohort.