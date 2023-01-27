

When an automated machine learning (AutoML) experiment has completed, you'll want to review the models that have been trained and decide which one performed best.

In the Azure Machine Learning studio, you can select an AutoML experiment to explore its details. 

On the **Overview** page of the AutoML experiment run, you can review the input data asset and the summary of the best model. To explore all models that have been trained, you can select the **Models** tab:

:::image type="content" source="../media/models-overview.png" alt-text="Screenshot of the models tab in an automated machine learning experiment run in the Azure Machine Learning studio.":::

## Explore preprocessing steps

When you've enabled featurization for your AutoML experiment, data guardrails will automatically be applied too. The three data guardrails that are supported for classification models are:

- Class balancing detection.
- Missing feature values imputation.
- High cardinality feature detection.

Each of these data guardrails will show one of three possible states: 

- **Passed**: No problems were detected and no action is required.
- **Done**: Changes were applied to your data. You should review the changes AutoML has made to your data.
- **Alerted**: An issue was detected but couldn't be fixed. You should review the data to fix the issue.

Next to data guardrails, AutoML can apply scaling and normalization techniques to each model that is trained. You can review the technique applied in the list of models under **Algorithm name**.

For example, the algorithm name of a model listed may be `MaxAbsScaler, LightGBM`. `MaxAbsScaler` refers to a scaling technique where each feature is scaled by its maximum absolute value. `LightGBM` refers to the classification algorithm used to train the model. 

## Retrieve the best run and its model

When you're reviewing the models in AutoML, you can easily identify the best run based on the primary metric you specified. In the Azure Machine Learning studio, the models are automatically sorted to show the best performing model at the top. 

In the **Models** tab of the AutoML experiment, you can **edit the columns** if you want to show other metrics in the same overview. By creating a more comprehensive overview that includes various metrics, it may be easier to compare models. 

To explore a model even further, you can generate explanations for each model that has been trained. When configuring an AutoML experiment, you can specify that explanations should be generated for the best performing model. If however, you're interested in the interpretability of another model, you can select the model in the overview and select **Explain model**.

> [!Note]
> Explaining a model is an approximation to the model's interpretability. Specifically, explanations will estimate the relative importance of features on the target feature (what the model is trained to predict). Learn more about [model interpretability](/azure/machine-learning/how-to-machine-learning-interpretability?azure-portal=true).

> [!Tip]
> Learn more about [how to evaluate AutoML runs](/azure/machine-learning/how-to-understand-automated-ml?azure-portal=true).
