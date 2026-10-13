While most Azure Data Factory users develop using the user interface, Azure Data Factory is available in a variety of software development kits (SDKs) for anyone who wishes to develop programmatically. When using an SDK, a user works directly against the Azure Data Factory service and all updates are immediately applied to the factory. 

Azure Data Factory libraries for Python enable you to manage the service.

To use the Python SDK, install the following packages:

```Python
pip install azure-mgmt-resource
pip install azure-mgmt-datafactory
pip install azure-identity
```

These packages require a supported version of Python 3. From there you can perform a range of activities, such as creating a data factory in your subscription in the East US region, as shown in the following code.

```Python
from azure.identity import DefaultAzureCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.datafactory import DataFactoryManagementClient
from azure.mgmt.datafactory.models import *
import time

#Create a data factory
subscription_id = '<Specify your Azure Subscription ID>'
rg_name = '<Specify your resource group name>'
df_name = '<Specify your data factory name>'
credentials = DefaultAzureCredential()
adf_client = DataFactoryManagementClient(credentials, subscription_id)

df_resource = Factory(location='eastus')
df = adf_client.factories.create_or_update(rg_name, df_name, df_resource)
while df.provisioning_state != 'Succeeded':
    df = adf_client.factories.get(rg_name, df_name)
    time.sleep(1)
```

In addition to Python, you can also programmatically interact with Azure Data Factory with the following languages, SDKs, and tools:

- .NET
- REST APIs
- PowerShell
- Azure Resource Manager Templates
- Data flow scripts

Data flow script (DFS) is the underlying metadata, similar to a coding language, that is used to execute the transformations that are included in a mapping data flow. Every transformation is represented by a series of properties that provide the necessary information to run the job properly. The script is visible and editable from ADF by clicking on the "script" button on the top ribbon of the browser UI.