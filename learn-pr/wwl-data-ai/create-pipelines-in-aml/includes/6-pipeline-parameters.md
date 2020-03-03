You can increase the flexibility of a pipeline by defining parameters.

## Defining Parameters for a Pipeline

To define parameters for a pipeline, create a **PipelineParameter** object for each parameter, and specify each parameter in at least one step.

For example, you could use the following code to include a parameter for a regularization rate in the script used by an estimator:

```python
from azureml.pipeline.core.graph import PipelineParameter

reg_param = PipelineParameter(name='reg_rate', default_value=0.01)

...

step2 = EstimatorStep(name = 'train model',
                      estimator = sk_estimator,
                      compute_target = 'aml-cluster',
                      inputs=[prepped],
                      estimator_entry_script_arguments=['--folder', prepped,
                                                        '--reg', reg_param])
```

> [NOTE!]
> You must define parameters for a pipeline before publishing it.

## Running a Pipeline with a Parameter

After you publish a parameterized pipeline, you can pass parameter values in the JSON payload for the REST interface:

```python
response = requests.post(rest_endpoint,
                         headers=auth_header,
                         json={"ExperimentName": "run_training_pipeline",
                               "ParameterAssignments": {"reg_rate": 0.1}})
```