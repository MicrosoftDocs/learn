In this unit, you get ready to work with the Azure Digital Twins APIs. You create your Azure Digital Twins instance and configure Postman, including creating a bearer token for authentication and importing the API collection. Then, you review the API categories to understand their capabilities before using them in the next unit.

[!INCLUDE [Instructions to set up Azure Digital Twins instance](../../includes/set-up-azure-digital-twins.md)]

## Configure Postman for Azure Digital Twins

This module uses the **Postman API** platform, accessible in the browser or as a desktop application. The instructions are for the browser version, but you can also download and use the desktop version if you prefer.

### Create workspace

Start by navigating to [Postman](https://web.postman.co/) in a browser window. Create a free account or log in to an existing account. 

Select **Workspaces > Create Workspace**.

:::image type="content" source="../media/2-create-workspace.png" alt-text="Screenshot showing the Create Workspace button in Postman." border="true" lightbox="../media/2-create-workspace.png":::

Follow the prompts to create a new blank workspace with a name that you'll remember.

### Get bearer tokens

Bearer tokens are used by Postman to authorize your API requests.

The CLI commands in this section will give you two Azure Digital Twins bearer tokens: one for the **control plane** and one for the **data plane**. Control plane APIs are ARM APIs used to manage Azure resources related to Azure Digital Twins, so they cover operations like creating/deleting your entire instance and creating/deleting endpoints. Data plane APIs are used to manage the elements within your Azure Digital Twins instance, such as models, twins, relationships, and event routes. **You need both tokens to send all the API requests in this module.**

In your browser, return to the [Azure Cloud Shell](https://ms.portal.azure.com/#cloudshell/).

Run the following command to get a token for the control plane APIs. It includes a static value for the token context: `https://management.azure.com/`. This value is same for everyone.

```azurecli
az account get-access-token --resource https://management.azure.com/
```

Copy the value of `accessToken` from the result, and save it to use in the next section. This is your **control plane token** value.

Next, run the following command to get a token for the data plane APIs. The static value for the token context is `0b07f429-9f4b-4714-9392-cc5e8e80c8b0` (the resource ID for the Azure Digital Twins service endpoint). This value is also the same for everyone.

```azurecli
az account get-access-token --resource 0b07f429-9f4b-4714-9392-cc5e8e80c8b0
```

Copy the value of `accessToken` from the result, and save it to use in the next section. This is your **data plane token** value.

>[!IMPORTANT]
>These tokens are valid for up to 60 minutes. If you run out of time allotted for the current tokens, you can repeat the steps in this section to generate new ones.

### Set up collections

Requests in Postman can be grouped and saved into **Collections**. This allows you to apply common authorization details and settings to many requests at once. In this section, you create two collections in Postman: *Control plane* and *Data plane*.

#### Import Swagger files

To create the *Control plane* collection, select **Import** from your Postman workspace. This will open a window with an option to enter a URL.

:::image type="content" source="../media/2-import.png" alt-text="Postman screenshot showing the Import button." border="true" lightbox="../media/2-import.png":::

Enter the following URL, which represents the Azure Digital Twins control plane Swagger:

```URL
https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/specification/digitaltwins/resource-manager/Microsoft.DigitalTwins/stable/2023-01-31/digitaltwins.json
```

Continue the prompts to import the Swagger as a Postman collection. It will import as *AzureDigitalTwinsManagementClient*.

Next, select **Import** again to create the *Data plane* collection.

Enter the following URL, which represents the Azure Digital Twins data plane Swagger:

```URL
https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/specification/digitaltwins/data-plane/Microsoft.DigitalTwins/stable/2023-10-31/digitaltwins.json
```
Continue the prompts to import the Swagger as a Postman collection. It will import as *Azure Digital Twins API*.

Now you should see both collections in your Postman workspace. You can use the options for each collection to rename them: change **Azure Digital Twins API** to *Data plane* and **AzureDigitalTwinsManagementClient** to *Control plane* for clarity on which is which.

:::image type="content" source="../media/2-rename.png" alt-text="Postman screenshot showing the Rename collection option." border="true" lightbox="../media/2-rename.png":::

#### Configure authentication

Select the *Control plane* collection in the workspace and switch to the **Authorization** tab. Make sure **Type** is set to *OAuth 2.0*. In the box under **Token**, paste your **control plane token** value from earlier in this unit. The change should save automatically.

:::image type="content" source="../media/2-token.png" alt-text="Postman screenshot showing the Authorization tab for a collection." border="true" lightbox="../media/2-token.png":::

Switch to the *Data plane* collection and repeat the token entry step. Make sure to use the **data plane token** value for this collection.

#### Configure variables

Select the *Control plane* collection in the workspace and switch to the **Variables** tab. Create the following variables:

| Variable | Initial value |
| --- | --- |
| `subscriptionId` | Your Azure subscription ID (if you ran the Cloud Shell commands for this module exactly as provided, you can get this value from the `AZURE_SUBSCRIPTION` variable in your Cloud Shell). |
| `resourceGroupName` | The name of the resource group you created at the start of this unit (if you kept the default name, it's *azure-digital-twins-training*, and it's stored in the `$RESOURCE_GROUP` variable in your Cloud Shell). |
| `resourceName` | The name of the Azure Digital Twins instance you created at the start of this unit (if you ran the Cloud Shell commands for this module exactly as provided, you can get this value from the `$INSTANCE_NAME` variable in your Cloud Shell). |

Select **Save**.

:::image type="content" source="../media/2-variables-control.png" alt-text="Postman screenshot showing the Variables tab for the Control plane collection." border="true" lightbox="../media/2-variables-control.png":::

Switch to the *Data plane* collection and edit the following variable:

| Variable | Current value |
| --- | --- |
| `baseURL` | Replace the *digitaltwins-hostname* part of the variable with the host name of your Azure Digital Twins instance. You can find this value by running `az dt show -n $INSTANCE_NAME --query "hostName" --output tsv` in the Azure CLI. |

Select **Save**.

:::image type="content" source="../media/2-variables-data.png" alt-text="Postman screenshot showing the Variables tab for the Data plane collection." border="true" lightbox="../media/2-variables-data.png":::

Now your Postman environment is set up to run Azure Digital Twins API requests. Leave the Postman window open, as you'll use it to run requests in upcoming units.

## View and understand the API categories

This section provides more detail about the APIs used in this module. You'll begin crafting requests with them in the next unit.

>[!TIP]
>For a complete list of API operations, see the [Azure Digital Twins REST API reference](/rest/api/azure-digitaltwins/).

### Control plane APIs

Control plane APIs are ARM APIs used to manage Azure resources related to Azure Digital Twins, so they cover operations like creating/deleting your entire instance and creating/deleting endpoints. 

An **endpoint** is a recognized destination outside of Azure Digital Twins that can receive digital twin events, so we'll use these requests later in the module to prepare your graph to export data externally. Although the Postman collection imported from the control plane Swagger contains many folders and operations, this module only uses the endpoint ones.

To see the endpoint request templates, expand the following folder path in your Postman collections: _Control plane > subscriptions > {subscriptionId} > resourceGroups > {resourceGroupName} > providers > Microsoft.DigitalTwins > digitalTwinsInstances > {resourceName} > endpoints_.

This folder contains request templates for endpoint operations, including create/update, get, delete, and list.

### Data plane APIs

Data plane APIs are used to manage the elements within your Azure Digital Twins instance, such as models, twins, relationships, and event routes. The Postman collection imported from the data plane Swagger has been organized into folders for different API areas that are used in this module:

* **models**: This folder contains request templates for managing models in an Azure Digital Twins instance. Models are custom definitions of a type of entity in your environment. Each type of entity, such as a *Generator*, will have one model to describe it.
* **query**: This folder contains request templates for querying an Azure Digital Twins graph. You can query for digital twins based on their properties, models, and relationships.
* **digitaltwins**: This folder contains request templates for managing digital twins in an Azure Digital Twins instance. Digital twins are instances of a model that represent specific entities in your environment. You may have one *Generator* model definition, and several digital twins based on it that represent *Generator A*, *Generator B*, and *Generator C*.
* **eventroutes**: This folder contains request templates for managing event routes from an Azure Digital Twins instance. Event routes are used to direct digital twin data throughout an Azure Digital Twins graph and to external endpoints, which can send data along to downstream services.
* **jobs**: This folder contains request templates for managing long-running jobs. The *imports* category allows you to create a long running, asynchronous action to import models, twins, and relationships in bulk.
