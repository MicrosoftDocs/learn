Although you can use any Python IDE to use the Azure Machine Learning service, you're going to use Azure Notebooks because it has the required Python modules pre-installed. If you have not already set up your Azure Notebook service to run the code examples in, the instructions below will explain how to do this. 

Since you are using Azure Notebook, the Azure Machine Learning SDK is already installed.
If you were using a different IDE, you could install the Azure Machine Learning SDK with the following command.  Do not run this in your Azure Notebook. 

```python
pip install azureml-sdk
```

What are Azure Notebooks?

Azure Notebooks is a free hosted service to develop and run Jupyter notebooks in the cloud with no installation. Jupyter (formerly IPython) is an open source project that lets you easily combine markdown text, executable code (Python, R, and F#), persistent data, graphics, and visualizations onto a single, sharable canvas called a notebook.

To get started with Azure Notebooks, use this link:

https://docs.microsoft.com/azure/notebooks/quickstart-sign-in-azure-notebooks

Follow the directions on the web page to get yourself set up and started with Azure Notebooks.

There's lot of documentation at that link to help you learn how to use all the features of Azure Notebooks.

Once you have your Azure Notebook environment set up and you are logged in, follow the instructions below to use Azure Machine Learning service with Python.

In Azure Notebook, create a new notebook, choose the `Python 3.6` kernel. Sign in Azure portal if necessary.

Enter and execute the following Python code, which validates the SDK installation and prints out the version of the SDK:

```python
import azureml.core
from azureml.core import Workspace, Experiment, Run

print(azureml.core.VERSION)
```

If you have created an Azure Machine Learning service Workspace previously, run the code below to get a reference to it.  Replace the values in between the < and > with the appropriate value. You can get the values from the Overview screen of the Azure Machine Learning service Workspace in the Azure portal.  

You may be prompted in the notebook output to log into Azure with a provided link.  The login code will be provided in the output as well.  Follow the link and enter the code to login. 

```python
ws = Workspace.get(name='myworkspace',
                      subscription_id='<azure-subscription-id>', 
                      resource_group='myresourcegroup' 
                     )
```

If you do not have an Azure Machine Learning service Workspace already, you can create one with the code below. The value you need is the subscription ID. You can find it in the [subscriptions list in the Azure portal](https://ms.portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade). Find the subscription ID that you want to use and replace the `<azure-subscription-id>` below with the subscription ID value. The SDK will ask you to sign into your Azure account if you are not already signed in.

```python
from azureml.core import Workspace
ws = Workspace.create(name='myworkspace',
                 subscription_id='<azure-subscription-id>', 
                 resource_group='myresourcegroup',
                 create_resource_group=True,
                 location='eastus2' 
                 )
```

It takes a few minutes to set up the workspace. After the workspace is set up, you can view the workspace details, such as the associated BLOB storage account, docker container registry account, and key vault, by entering the following code:

```python
ws.get_details()
```