In this unit, you get ready to work with the Azure Digital Twins APIs. You create your Azure Digital Twins instance and set up `.http` files in Visual Studio with bearer tokens for authentication. Then, you review the API categories to understand their capabilities before using them in the next unit.

[!INCLUDE [Instructions to set up Azure Digital Twins instance](../../includes/set-up-azure-digital-twins.md)]

## Set up .http files for Azure Digital Twins APIs

This module uses **Visual Studio 2022** with the **ASP.NET and web development** workload. 

In this section, you set up two `.http` files in Visual Studio. One `.http` file will be for *control plane* requests, and the other will be for *data plane* requests. [Control plane APIs](#control-plane-apis) are ARM APIs used to manage Azure resources related to Azure Digital Twins, so they cover operations like creating/deleting your entire instance and creating/deleting endpoints. [Data plane APIs](#data-plane-apis) are used to manage the elements within your Azure Digital Twins instance, such as models, twins, relationships, and event routes.

### Create project

Open Visual Studio 2022 on your machine, and create a new project. Use the **ASP.NET Core Empty** project template.

:::image type="content" source="../media/2-new-project.png" alt-text="Screenshot of an ASP.NET Core Empty project template in Visual Studio." border="true" lightbox="../media/2-new-project.png":::

Add a new `.http` file to the project called *control.http* (this file will be used for control plane requests). For instructions, see [Create an .http file](/aspnet/core/test/http-files#create-an-http-file).

Add a second new `.http` file to the project called *data.http* (this file will be used for data plane requests).

### Add variables

In *control.http*, create the following variables. They contain placeholders for your resource data. 

>[!TIP]
>If you've run the Cloud Shell commands for this module exactly as provided, you can find these values stored in the `AZURE_SUBSCRIPTION`, `RESOURCE_GROUP`, and `INSTANCE_NAME` variables in your Cloud Shell.

```http
@instance=<name-of-your-Azure-Digital-Twins-instance>
@subscription=<ID-of-your-Azure-subscription>
@resourceGroup=<resource-group>
@CPversion=2023-01-31
```

:::image type="content" source="../media/2-variables-control.png" alt-text="Visual Studio screenshot showing sample variables in control.http." border="true" lightbox="../media/2-variables-control.png":::

In *data.http*, create the following variables. There's one placeholder for your Azure Digital Twins instance's host name.

>[!TIP]
> You can find the host name by running `az dt show -n $INSTANCE_NAME --query "hostName" --output tsv` in the Azure CLI.

```http
@hostName=<host-name-of-your-Azure-Digital-Twins-instance>
@DPversion=2023-10-31
```

### Get bearer tokens

Bearer tokens are used by Visual Studio to authorize your API requests.

The CLI commands in this section will give you two Azure Digital Twins bearer tokens: one for the control plane and one for the data plane. **You need both tokens to send all the API requests in this module.**

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

### Add tokens to project

In *control.http* in Visual Studio, add the following variable to hold the value of your control plane token. Replace the placeholder with your token value.

```http
@CPtoken=<paste-control-plane-token>
```

:::image type="content" source="../media/2-variables-control-token.png" alt-text="Visual Studio screenshot showing token variable in control.http." border="true" lightbox="../media/2-variables-control-token.png":::

In *data.http*, add the following variable to hold the value of your data plane token. Replace the placeholder with your token value.

```http
@DPtoken=<paste-data-plane-token>
```

>[!IMPORTANT]
>If the tokens expire while you're still working on this module, generate new tokens and replace the values of these variables with the new token values.

Now your Visual Studio project is set up to run Azure Digital Twins API requests. Leave your project open, as you'll use it to run requests in upcoming units.

## View and understand the API categories

This section provides more detail about the APIs used in this module. You'll begin crafting requests with them in the next unit.

>[!TIP]
>For a complete list of API operations, see the [Azure Digital Twins REST API reference](/rest/api/azure-digitaltwins/).

### Control plane APIs

Control plane APIs are ARM APIs used to manage Azure resources related to Azure Digital Twins, so they cover operations like creating/deleting your entire instance and creating/deleting endpoints. 

An **endpoint** is a recognized destination outside of Azure Digital Twins that can receive digital twin events, so you'll use these requests later in the module to prepare your graph to export data externally. Although the control plane contains many operations, this module only uses the endpoint ones.

**Endpoints** operations include create/update, delete, get, and list. To see the details of the endpoint operations, view the [Endpoints API documentation](/rest/api/digital-twins/controlplane/endpoints).

### Data plane APIs

Data plane APIs are used to manage the elements within your Azure Digital Twins instance, such as models, twins, relationships, and event routes. The data plane is organized into several key areas that are used in this module:

* **Event Routes**: These requests are for managing event routes from an Azure Digital Twins instance. Event routes are used to direct digital twin data throughout an Azure Digital Twins graph and to external endpoints, which can send data along to downstream services.
* **Jobs**: These requests are for managing long-running jobs. The *ImportJobs* operations allow you to create and manage a long running, asynchronous action to import models, twins, and relationships in bulk.
* **Models**: These requests are for managing models in an Azure Digital Twins instance. Models are custom definitions of a type of entity in your environment. Each type of entity, such as a *Generator*, will have one model to describe it.
* **Query**: These requests are for querying an Azure Digital Twins graph. You can query for digital twins based on their properties, models, and relationships.
* **Twins**: TThese requests are for managing digital twins in an Azure Digital Twins instance. Digital twins are instances of a model that represent specific entities in your environment. You may have one *Generator* model definition, and several digital twins based on it that represent *Generator A*, *Generator B*, and *Generator C*.

To see the details of the data plane API operations, view the [Data plane API documentation](/rest/api/digital-twins/dataplane/operation-groups).
