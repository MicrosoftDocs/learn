While most Azure Data Factory users develop using the user experience, Azure Data Factory is available in a variety of software development kits (SDKs) for anyone who wish to develop programmatically. When using an SDK, a user works directly against the Azure Data Factory service and all updates are immediately applied to the factory. 

There are Azure Data Factory libraries for Python that enables you to perform the management of the service.

You can install the following package

```Python
pip install azure-mgmt-datafactory 
```

From there you can perform a range of activities, such as creating Azure Data Factory in your subscription on the East US region, as shown in the following code.

```Python
from azure.common.credentials import ServicePrincipalCredentials
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.datafactory import DataFactoryManagementClient
from azure.mgmt.datafactory.models import *
import time

#Create a data factory
subscription_id = '<Specify your Azure Subscription ID>'
credentials = ServicePrincipalCredentials(client_id='<Active Directory application/client ID>', secret='<client secret>', tenant='<Active Directory tenant ID>')
adf_client = DataFactoryManagementClient(credentials, subscription_id)

rg_params = {'location':'eastus'}
df_params = {'location':'eastus'}  

df_resource = Factory(location='eastus')
df = adf_client.factories.create_or_update(rg_name, df_name, df_resource)
print_item(df)
while df.provisioning_state != 'Succeeded':
    df = adf_client.factories.get(rg_name, df_name)
    time.sleep(1)
```

In addition to Python, you can also programmatically interact with Azure Data Factory with the other languages and SDKs as listed:

- .NET
- REST APIs
- PowerShell
- Azure Resource Manager Templates
- Data flow scripts

Data flow script (DFS) is the underlying metadata, similar to a coding language, that is used to execute the transformations that are included in a mapping data flow. Every transformation is represented by a series of properties that provide the necessary information to run the job properly. The script is visible and editable from ADF by clicking on the "script" button on the top ribbon of the browser UI.