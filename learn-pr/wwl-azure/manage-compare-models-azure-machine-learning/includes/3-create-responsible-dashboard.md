To help you implement the **Responsible Artificial Intelligence** (**Responsible AI**) principles in Azure Machine Learning, you can create the **Responsible AI dashboard**.

The Responsible AI dashboard allows you to pick and choose insights you need, to evaluate whether your model is safe, trustworthy, and ethical.

Azure Machine Learning has built-in **components** that can generate Responsible AI insights for you. The insights are then gathered in an interactive dashboard for you to explore. You can also generate a scorecard as PDF to easily share the insights with your colleagues to evaluate your models.

## Create a Responsible AI dashboard

To create a Responsible AI (RAI) dashboard, you need to create a **pipeline** by using the built-in components. The pipeline should:

1. Start with the `RAI Insights dashboard constructor`.
1. Include one of the **RAI tool components**.
1. End with `Gather RAI Insights dashboard` to collect all insights into one dashboard.
1. *Optionally* you can also add the `Gather RAI Insights score card` at the end of your pipeline.

## Explore the Responsible AI components

The available tool components and the insights you can use are:

- `Add Explanation to RAI Insights dashboard`: Interpret models by generating explanations. Explanations show how much features influence the prediction.
- `Add Causal to RAI Insights dashboard`: Use historical data to view the causal effects of features on outcomes.
- `Add Counterfactuals to RAI Insights dashboard`: Explore how a change in input would change the model's output.
- `Add Error Analysis to RAI Insights dashboard`: Explore the distribution of your data and identify erroneous subgroups of data.

## Build and run the pipeline to create the Responsible AI dashboard

To create the Responsible AI dashboard, you build a pipeline with the components you selected. When you run the pipeline, a Responsible dashboard (and scorecard) is generated and associated with your model.

After you've trained and registered a model in the Azure Machine Learning workspace, you can create the Responsible AI dashboard in three ways:

- Using the Command Line Interface (CLI) extension for Azure Machine Learning.
- Using the Python Software Development Kit (SDK).
- Using the Azure Machine Learning studio for a no-code experience.

### Using the Python SDK to build and run the pipeline

To generate a Responsible AI dashboard, you need to:

- Register the training and test datasets as MLtable data assets.
- Register the model.
- Retrieve the built-in components you want to use.
- Build the pipeline.
- Run the pipeline.

If you want to build the pipeline using the Python SDK, you first have to retrieve the components you want to use.

You should start the pipeline with the `RAI Insights dashboard constructor` component:

```python
rai_constructor_component = ml_client_registry.components.get(
    name="microsoft_azureml_rai_tabular_insight_constructor", label="latest"
)
```

Then, you can add any of the available insights, like the explanations, by retrieving the `Add Explanation to RAI Insights dashboard component`:

```python
rai_explanation_component = ml_client_registry.components.get(
    name="microsoft_azureml_rai_tabular_explanation", label="latest"
)
```

> [!Note]
> The parameters and expected inputs vary across components. [Explore the component for the specific insights](/azure/machine-learning/how-to-responsible-ai-insights-sdk-cli?view=azureml-api-2&tabs=python?azure-portal=true) you want to add to your dashboard to find which inputs you need to specify.

And finally, your pipeline should end with a `Gather RAI Insights dashboard` component:

```python
rai_gather_component = ml_client_registry.components.get(
    name="microsoft_azureml_rai_tabular_insight_gather", label="latest"
)
```

Once you have the components, you can build the pipeline:

```python
from azure.ai.ml import Input, dsl
from azure.ai.ml.constants import AssetTypes

@dsl.pipeline(
    compute="aml-cluster",
    experiment_name="Create RAI Dashboard",
)
def rai_decision_pipeline(
    target_column_name, train_data, test_data
):
    # Initiate the RAIInsights
    create_rai_job = rai_constructor_component(
        title="RAI dashboard diabetes",
        task_type="classification",
        model_info=expected_model_id,
        model_input=Input(type=AssetTypes.MLFLOW_MODEL, path=azureml_model_id),
        train_dataset=train_data,
        test_dataset=test_data,
        target_column_name="Predictions",
    )
    create_rai_job.set_limits(timeout=30)

    # Add explanations
    explanation_job = rai_explanation_component(
        rai_insights_dashboard=create_rai_job.outputs.rai_insights_dashboard,
        comment="add explanation", 
    )
    explanation_job.set_limits(timeout=10)

    # Combine everything
    rai_gather_job = rai_gather_component(
        constructor=create_rai_job.outputs.rai_insights_dashboard,
        insight=explanation_job.outputs.explanation,
    )
    rai_gather_job.set_limits(timeout=10)

    rai_gather_job.outputs.dashboard.mode = "upload"

    return {
        "dashboard": rai_gather_job.outputs.dashboard,
    }

```

## Exploring the Responsible AI dashboard

After building the pipeline, you need to run it to generate the Responsible AI dashboard. When the pipeline successfully completed, you can select to **view** the Responsible AI dashboard from the pipeline overview.

:::image type="content" source="../media/responsible-pipeline.png" alt-text="Screenshot of completed pipeline to create Responsible AI dashboard.":::

Alternatively, you can find the Responsible AI dashboard in the **Responsible AI** tab of the registered model.

:::image type="content" source="../media/responsible-model.png" alt-text="Screenshot of the Responsible AI tab of the registered model in the Azure Machine Learning studio.":::