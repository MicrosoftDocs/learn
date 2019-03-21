In this unit, you use Azure Container Instances to deploy the trained model as a web service. There are two steps involved:

1. Define the deployment configuration. For example, the following code defines a container that uses 1 CPU and 1 GB of memory:

```python
from azureml.core.webservice import AciWebservice

aciconfig = AciWebservice.deploy_configuration(cpu_cores=1, 
                                               memory_gb=1, 
                                               tags={'sample name': 'AML 101'}, 
                                               description='This is a great example.')
```

2. To deploy the image created in the previous unit, you can use code similar to the code below.  This may take a few minutes to finish.

```python
%%time
from azureml.core.webservice import Webservice

# Create the webservice 
service = Webservice.deploy_from_model(name='my-aci-svc3',
                                       deployment_config=aciconfig,
                                       models=[model],
                                       image_config=image_config,
                                       workspace=ws)

# Wait for the service deployment to complete while displaying log output.  This can take several minutes.
service.wait_for_deployment(show_output=True)

print('Execution complete')
```

It takes around 3 minutes for the web service to deploy. You will call this web service in the next unit.