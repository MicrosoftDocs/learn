You registered the model already if you did the prior unit 'Register an Azure ML model with Python'. But just so you have the model object variable handy, register it again with the code below.  

```python
# register model
model = run.register_model(model_name='sklearn_mnist_model.pkl',
                           model_path='outputs/sklearn_mnist_model.pkl')

print(model.name, model.id, model.version, sep='\t')
```

Now you will prepare the container image. The following Python code uses the Azure ML SDK to create the image.

```python
from azureml.core.image import Image, ContainerImage

image_config = ContainerImage.image_configuration(runtime= "python",
                                 execution_script="score.py",
                                 conda_file="myenv.yml",
                                 tags = {'data': "MNIST", 'type': "sklearn"},
                                 description = "Image for sklearn model")

image = Image.create(name = "myimage1",
                     # this is the model object 
                     models = [model],
                     image_config = image_config, 
                     workspace = ws)

image.wait_for_creation(show_output = True)

print('Done')
```

After the code is executed, you can view the images in the Azure Machine Learning service portal:

![Screenshot of Viewing Images in Azure Machine Learning Service Portal](../media/8-view-images.png)

View the detailed image information by clicking into it:

![Screenshot of Viewing Detailed Image Information in Azure Machine Learning Service Portal](../media/8-view-detailed-image-info.png)

In the next unit, you explore how to monitor the deployed models and collect metrics for the models.