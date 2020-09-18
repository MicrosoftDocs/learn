After you have created a pipeline, you can publish it to create a REST endpoint through which the pipeline can be run on demand.

## Publishing a pipeline

To publish a pipeline, you can call its **publish** method, as shown here:

```python
published_pipeline = pipeline.publish(name='training_pipeline',
                                          description='Model training pipeline',
                                          version='1.0')
```

 Alternatively, you can call the **publish** method on a successful run of the pipeline:

```python
# Get the most recent run of the pipeline
pipeline_experiment = ws.experiments.get('training-pipeline')
run = list(pipeline_experiment.get_runs())[0]

# Publish the pipeline from the run
published_pipeline = run.publish_pipeline(name='training_pipeline',
                                          description='Model training pipeline',
                                          version='1.0')
```

After the pipeline has been published, you can view it in Azure Machine Learning studio. You can also determine the URI of its endpoint like this:

```python
rest_endpoint = published_pipeline.endpoint
print(rest_endpoint)
```

## Using a published pipeline

To initiate a published endpoint, you make an HTTP request to its REST endpoint, passing an authorization header with a token for a service principal with permission to run the pipeline, and a JSON payload specifying the experiment name. The pipeline is run asynchronously, so the response from a successful REST call includes the run ID. You can use this to track the run in Azure Machine Learning studio.

For example, the following Python code makes a REST request to run a pipeline and displays the returned run ID.

```python
import requests

response = requests.post(rest_endpoint,
                         headers=auth_header,
                         json={"ExperimentName": "run_training_pipeline"})
run_id = response.json()["Id"]
print(run_id)
```