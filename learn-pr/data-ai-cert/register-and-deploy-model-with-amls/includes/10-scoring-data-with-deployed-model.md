Since the model is deployed as a web service that exposes a REST API, it can be tested with many tools. Azure Machine Learning SDK has a built-in testing tool that can work with the deployed web service as shown below.

```python
import json

# scrape the first row from the test set.
test_samples = json.dumps({"data": X_test[0:1, :].tolist()})

print(test_samples) # here is what we are sending to the service.

#score on our service
service.run(input_data = test_samples)
```

The key part of the code is the `service.run` call, which sends a JSON formatted document to the deployed web service and the result is displayed.

### Clean up resources

If you are going to continue with this Learning Path, don't run the code below.  If you are done and do not plan to continue with the other modules, you can run the code below to delete the Azure Machine Learning service resources you created. 

```python
      ws.delete(delete_dependent_resources=True)
```