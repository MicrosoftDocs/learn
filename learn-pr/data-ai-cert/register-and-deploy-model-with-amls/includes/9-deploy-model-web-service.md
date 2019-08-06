Now that we have an image that contains our trained model, we can use Azure Container Instances to deploy the trained model as a web service. There are two steps involved:

1. Define the deployment configuration. The deployment configuration defines the compute to be created to serve the model to scoring applications. For example, the following code defines a container that uses 1 CPU and 1 GB of memory:

```python
from azureml.core.webservice import AciWebservice
aciconfig = AciWebservice.deploy_configuration(cpu_cores = 1, 
                                          memory_gb = 1, 
                                          tags = {"data": "mnist", "type": "classification"}, 
                                          description = 'Handwriting recognition')
```

2. In a prior unit, you created an image and stored it in an object named image.  To deploy the image, you can use code similar to the code below:

```python
from azureml.core.webservice import Webservice
service_name = 'aci-mnist-13'
service = Webservice.deploy_from_image(deployment_config = aciconfig,
                                            image = image,
                                            name = service_name,
                                            workspace = ws)
service.wait_for_deployment(show_output = True)
```

It takes around 3-4 minutes for the web service to deploy. Once it's deployed, we can call it from a client application.