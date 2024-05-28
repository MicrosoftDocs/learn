
In this exercise, you will:

1. Create an API Center resource.

1. Define metadata properties.  

1. Add APIs to your API Center.

1. Add deployments and environments.

## Prerequisites

To start managing your APIs through API Center, you need:

1. An Azure Subscription.
1. If you haven't already, you need to register the **Microsoft.ApiCenter resource provider** in your subscription. 

1. At least a Contributor role assignment or [equivalent permissions](/azure/role-based-access-control/role-assignments-list-portal) in the Azure subscription.

## Step 1: Create an API Center resource

::: zone pivot="azure-portal"

   1. [Sign in](https://portal.azure.com/) to the Azure portal.
   1. Enter *API Centers* in the search bar.
   1. Select **+ Create**.
   1. On the **Basics** tab, select or enter the following settings:

        a. Select your Azure subscription.

        b. Select an existing resource group or select **New** to create a new one.

        c. Enter a **Name** for your API center. It must be unique in the region where you're creating your API center.

        d. In **Region**, select one of the [available regions](/azure/api-center/overview#available-regions) for API Center.

        e. For the pricing plan, select **Free trial ($0 for 90 days)**.

        f. Select **Review + create**.

        h. After validation completes, select **Create**.

        After deployment, your API center is ready to use!
        :::image type="content" source="../media/3-contoso-api-center-create.png" alt-text="Screenshot     showing successful creation of the API Center instance.":::

::: zone-end

::: zone pivot="azure-cli"

   To run CLI reference commands locally, [install](/cli/azure/install-azure-cli) the Azure CLI, and log in using the following command.

   ```bash
   az login
   ```

   Create a resource group by running the following command passing the:

- name of your resource group **--name** Example. *Contoso*
- location of your resource group **--location** Example. *Eastus*

 ```bash
 az group create –-name contoso –-location eastus  
 ```

   :::image type="content" source="../media/3-az-group-create.png" alt-text="Screenshot showing successful az group create CLI command":::

 Create an API Center by running the following command, passing the:

- name of your API center resource **--name** Example. *Contoso-apis*
- resource group to create the API center in **-r** Example. *Contoso*
- location of your resource group **--location** Example. *Eastus*

 ```bash
 az apic service create –name contoso-apis –resource-group contoso –location eastus  
 ```

   :::image type="content" source="../media/3-az-apic-service-create.png" alt-text="Screenshot showing successful az apic service create CLI command":::
   > [!NOTE]
   > By default, the API Center will be created under the **Free pricing tier.**

::: zone-end

::: zone pivot="vs-code"

> [!NOTE]
> Creating an API Center resource is currently not supported on VS Code. Create one using Azure CLI or the Azure portal.

::: zone-end

## Step 2: Define metadata properties

API Center uses metadata properties to organize the APIs in your inventory and enable operations such as filtering, search etc.

> [!NOTE]
> Do not include any sensitive, confidential, or personal information in the metadata properties titles/ names.

Contoso, like many other organizations would like to have all their APIs pass through an approver before they become available for use and ensure that a compliance review is conducted for all APIs. The organization also has APIs that are public facing and those built exclusively for internal use only. To enforce this at scale across all APIs, we add three custom metadata properties:

- *API Approver* of type String
- *Compliance review* of type Predefined choices
- *Public facing* of type Boolean

1. On the left menu, select **Assets > Metadata > + New metadata.**
    :::image type="content" source="../media/3-add-metadata-portal.png" alt-text="Screenshot showing steps to add new metadata on azure portal":::

1. On the **Details** tab, enter information about the property.

    a. In **Title**, enter *API Approver*

    b. In **Description**, enter *Default API Approver*

    c. Select type **String** and select **Next**

1. On the **Assignments** tab, select **Required** for APIs. Select **Optional** for Deployments and Environments. Select **Next**
1. Select **Create**
1. Repeat the same steps for the *Public-facing* property as shown in the image below. For type, select **Boolean**
1. On the **Assignments** tab, select **Required** for APIs. Select **Not applicable** for Deployments and Environments. Select **Next**
1. Select **Create**
1. Repeat the same steps for the *Compliance-review* property as shown in the image below. For the type, select **Predefined choices** and add 3 choices, *Not Started*, *In Progress* and *Completed*
1. On the **Assignments** tab, select **Required** for APIs. Select **Not applicable** for Deployments and Environments
1. Select **Next**

A JSON metadata schema for your APIs is now available for you to view, edit, and download. To view, select **View metadata schema** and select **APIs** from the dropdown.

This opens a modal on the right with metadata details, which include built-in properties from API Center such as *LifecycleStage*, *Name*, *Description*, *TermsOfService* among others. If you scroll to the bottom of the file, you'll see the custom metadata you’ve added in the previous steps as shown below.
    :::image type="content" source="../media/3-view-schema.png" alt-text="Screenshot showing steps to view metadata schema on Azure portal":::

> [!NOTE]
> You can add and edit properties in the schema at any time and instantly apply them to all APIs in your API Center

## Step 3: Add APIs to the inventory

The Contoso organization would like to recommend technical conferences for their engineering teams as part of their internal skilling drive. We'll add a Conference API with speakers, sessions, and topics.

Conference API URL: <https://conferenceapi.azurewebsites.net/>

::: zone pivot="azure-portal"

1. In the portal, navigate to your API center.
1. In the left menu, select **Assets > APIs > + Register API.**
:::image type="content" source="../media/3-register-api-portal.png" alt-text="Screenshot showing steps to add a new API on Azure portal":::

1. In the **Register API** page, add the following required information for the API. You'll see the custom *API Approver*, *Public-facing, and *compliance-review* metadata properties that you defined in the previous steps at the bottom of the page.
:::image type="content" source="../media/3-apic-register-api-portal-gif.gif" alt-text="GIF showing steps to register a new API on Azure portal":::

To view your created API, on the left menu, select **Assets > APIs > Conference API**.

The **Overview** tab gives a view of the API configuration. Expand **Details** to see and edit additional information such as API version and deployments (we have no deployments at this point).

You would normally want to add an API definition for your API version and API Center supports text specification formats including OpenAPI 2, OpenAPI 3 for REST.

To add a Definition,

1. In the left menu, select **Assets > APIs > Select your API (Conference API)**.
2. Expand **Details** and select **Versions**.
3. Select your version (v1), and expand **Details**.
4. Under details, select **Definitions > Add definition**.
    :::image type="content" source="../media/3-add-definition-portal.png" alt-text="Screenshot showing steps to add an API definition on Azure portal":::

::: zone-end

::: zone pivot="vs-code"

You can use the [Azure API Center extension](https://marketplace.visualstudio.com/items?itemName=apidev.azure-api-center) for Visual Studio Code to register an API into your API instance.

**Step 1:** [Install](https://marketplace.visualstudio.com/items?itemName=apidev.azure-api-center) the extension

**Step 2:** Open the command pallet, ‘Ctrl + Shift +  P’ and type **API Center: Register API**

Follow the prompts to provide the following information for your API:

| Register API| Step by step |
|----------|----------|
| Select API Center Service  | Select your API Center instance   |
| API Title   | Enter the name of your API **(Conference API)**   |
| API Type   | *REST*   |
| API Version Title   | Enter a version name for your API **(v1)**    |
| API Version Lifecycle  | Select a lifecycle from the dropdown **(Development)**    |
| API Definition Title  | Enter a name for your definition **(Conference API Definition)**  |
| API Specification Name | Select a specification from the dropdown **(OpenAPI 2)**  |
| Select API Definition File to Import | Browse and select the definition file from your storage  |

:::image type="content" source="../media/3-vscode-apic-register-api.png" alt-text="Screenshot showing steps to register an API on VS Code":::

Refresh the API Center extension tab and your newly created API appears in the respective APIC instance/ resource.

::: zone-end

::: zone pivot="azure-cli"

Use the following command to create a new API, passing in the:

- name of your resource group **-g** Example. *Contoso*
- name of your API center resource **-s** Example. *contoso-api-center*
- name of the API **--name** Example. *Conference-api*
- title **--title** Example. *Conference API*

```bash
az apic api create -g <resource-group-name> -s <api-center-name> --name <API-name> --title “API-name” –kind rest
```

:::image type="content" source="../media/3-apic-api-create.png" alt-text="Screenshot showing CLI command to create a new API in API Center":::

Create an API version using the following command, passing in the:

- name of your resource group **-g** Example. *contoso*
- name of your API center resource **-s** Example. *Contoso-api-center*
- name of the API **-–api-name** Example. *Conference-api*
- name of the version **--version** Example. *V1*
- title **--title** Example. *V1*

```bash
az apic api version create --r <resource-group-name> -s <api-center-name> --api-name <API-name> --version <api-version> --title "v1-0-0"
```

:::image type="content" source="../media/3-create-version-cli.png" alt-text="Screenshot showing CLI command to create a new API version in API Center":::

You would normally want to add an API definition for your API version and API Center support text specification formats including OpenAPI 2, OpenAPI 3 for REST.

To add a Definition, use the following command, passing in:

- name of your resource group **-g** Example. contoso
- name of your API center resource **-s** Example. Contoso-api-center
- name of the API **-–api-name** Example. Conference-api
- name of the version **--version** Example. V1
- name of the definition **--name** Example Conference-API-definition
- title **--title** Example. OpenAPI

```bash
az apic api definition create --resource-group myResourceGroup --service myAPICenter --api-name petstore-api --version v1-0-0 --name "openapi" --title "OpenAPI"
```

:::image type="content" source="../media/3-create-definition-cli.png" alt-text="Screenshot showing CLI command to create a new API definition in API Center":::

You then use the **az apic api definition import-specification** command to import an OpenAPI definition file from a publicly accessible url. Example: <https://conferenceapi.azurewebsites.net/?format=json>

```bash
az apic api definition import-specification --resource-group myResourceGroup --service myAPICenter --api-name petstore-api --version-name v1-0-0 --definition-name openapi --format "link" --value 'https://petstore3.swagger.io/api/v3/openapi.json' --specification '{"name":"openapi","version":"3.0.2"}'
```

   :::image type="content" source="../media/3-api-definition-import-cli.png" alt-text="Screenshot showing CLI command to imprt a definition from a url":::

::: zone-end

## Step 4: Add deployments and environments

### Environments

An environment (Development, Testing, Staging, or Production), represents a location where an API runtime is deployed. Contoso IT Administrators define two environments – Testing and production, in their API Center instance to manage and track different API runtimes in their organization.

To create an environment,

1. On the left menu, select **Assets > Environments > + New environment.**
2. Add the following information.
    :::image type="content" source="../media/3-environment-create-portal.png" alt-text="Screenshot showing steps to create a new environment on Azure portal":::

3. Select **Create**.
4. Repeat the same steps for the *Production environment*.

    :::image type="content" source="../media/3-contoso-production-env-portal.png" alt-text="Screenshot showing steps to create a new environment of production type on Azure portal":::

### Deployments

A unique location (address) for users to interact with your API is provided for each API runtime in a given environment. This location is called a deployment, and a single API version could have two deployments - a staging and a production deployment.

Contoso has one API, the Conference API, which we associate with the environments we created.

1. In the portal, navigate to your API center.
2. In the left menu, select **APIs** and then select an API, for example, the *Conference API.*
3. On the **Conference API** page, expand **Details > Deployments > + Add deployment.**
4. Add the following information:

    a. Select **Contoso Testing** from the dropdown for the *Environment* field.

    b. For the definition, click **Select**, choose the API version **v1** from the dropdown and select the definition you added earlier. Click **Select**.

    c. After successfully adding the definition, add a base runtime URL that will be specific for the API in the selected environment.

    :::image type="content" source="../media/3-add-deployment-portal.png" alt-text="Screenshot showing steps to create a new deployment on Azure portal":::
