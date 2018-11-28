
## What is Microsoft Cognitive Services?

Microsoft Cognitive Services is a set of machine learning algorithms available as a service for anyone to use. Instead of building this intelligence for our apps from scratch, we can use these services for vision, speech, language, knowledge, and search. You can try each service for free. When you decide to integrate a service into your app, you sign up for a paid subscription. We'll focus our attention on the Computer Vision API in this model.

> [!TIP]
> To see a list of all Cognitive Services, check out the [Cognitive Services Directory](https://azure.microsoft.com/services/cognitive-services/directory/). 

## What is the Computer Vision API?

The Computer Vision API provides algorithms to process images and return insights. For example, you can find out if an image has mature content, or can use it to find all the faces in an image. It also has other features like estimating dominant and accent colors, categorizing the content of images, and describing an image with complete English sentences. Additionally, it can also intelligently generate images thumbnails for displaying large images effectively.

> [!TIP]
> The Computer Vision API is available in many regions across the globe. To find the region nearest you, see the [Products available by region](https://azure.microsoft.com/global-infrastructure/services/?products=cognitive-services&regions=all).

You can use the Computer Vision API to:

- Analyze images for insight
- Extract printed text from images using optical character recognition (OCR).
- Recognize printed and handwritten text from images
- Recognize celebrities and landmarks
- Analyze video 
- Generate a thumbnail of an image 

## How to call the Computer Vision API

You call Computer Vision in your application using client libraries or the REST API directly. We'll call the REST API in this module. To make a call:

1. Get an API access key

    You are assigned access keys when you sign up for a Computer Vision service account. A key must be passed in the header of **every** request. 

1. Make a POST call to the API

    Format the URL as follows:
   **region**.api.cognitive.microsoft.com/vision/v2.0/**resource**/**[parameters]** 

    - **region** - the region where you created the account, for example, *westus*.
    - **resource** - the Computer Vision resource you are calling such as `analyze`, `describe`, `generateThumbnail`, `ocr`, `models`, `recognizeText`, `tag`.

    You can supply the image to be processed either as a raw image binary or an image URL.

    The request header must contain the subscription key, which provides access to this API.

1. Parse the response

    The response holds the insight the Computer Vision API has about your image, as a JSON payload.

In this module, we'll run all exercises in the Azure CLI using the integrated Cloud Shell. Let's find out a little more about this setup.

## What is the Azure CLI

The Azure CLI is Microsoft's cross-platform command-line tool for managing Azure resources. It's available for macOS, Linux, and Windows, or in the browser using [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview).

> [!IMPORTANT]
> There are two versions of the Azure CLI tool available today: Azure CLI 1.0 and Azure CLI 2.0. We'll be using Azure CLI 2.0, which is the latest version and is recommended unless you're running legacy scripts. Azure CLI 1.0 is started with the `azure` command, and Azure CLI 2.0 is started with the `az` command.

## az cognitiveservices commands

The Azure CLI includes the `cognitiveservices` command to manage Cognitive Services accounts in Azure. We can supply several subcommands to do specific tasks. The most common include:

| Subcommand | Description |
|-------------|-------------|
| `list` | List available Azure Cognitive Services accounts. |
| `account show` | Get the details of an Azure Cognitive Services account. |
| `account create` | Create an Azure Cognitive Services account. |
| `account delete` | Delete an Azure Cognitive Services account. |
| `keys list` | List the keys of an Azure Cognitive Services account. |

Let's create a Cognitive Services with the Azure CLI.

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]

## Create a Cognitive Services account

We need an API access key to make calls to the Computer Vision API. To get access keys, we need a Cognitive Services account for the Computer Vision API. We'll use `az cognitiveservices create` to create the account in our subscription.

 The command `az cognitiveservices create` is used to create a Cognitive Services account in a resource group.  The following five parameters must be supplied when calling this command.

> [!Tip]
> Most flags for Azure CLI parameters can be abbreviated to a single character. For example, we could say `-l` instead of `--location`. The long-form is used for clarity.

| Parameter | Description |
|-----------|-------------|
| `resource-group` | The resource group that will own the cognitive services account. In this interactive sandbox session, you'll use <rgn>[sandbox resource group name]</rgn> |
| `kind` | The API name of cognitive services account. |
| `name` | Cognitive service account name. |
| `sku` | The Sku of cognitive services account.|
| `location` | The location, or region, from which you want to make calls to this API. Select one of the locations from the list below. |

[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)] 

Execute the following command in Azure Cloud Shell. Make sure to replace `[location]` with a location near you.

```azurecli
az cognitiveservices account create \
--kind ComputerVision \
--name ComputerVisionService \
--sku S1 \
--resource-group <rgn>[sandbox resource group name]</rgn> \
--location [location]
```

> [!NOTE]
> Remember the location you have selected. You'll make all calls to the API from that region.

We've created a cognitive services account for the **ComputerVision** API. We selected the *S1* sku and named our account **ComputerVisionService**. Our account is owned by the resource group **<rgn>[sandbox resource group name]</rgn>** and we'll call the API from the location we set in the `--location` parameter. 

Once the command finishes creating the cognitive services account, you'll get a JSON response, which includes **provisioningState** property set to **Succeeded**.

## Get an access key

Once we have our account successfully created we can retrieve the subscription keys, or access keys, for this account.

1. Execute the following command in Azure Cloud Shell:

    ```azurecli
    az cognitiveservices account keys list \
    --name ComputerVisionService \
    --resource-group <rgn>[sandbox resource group name]</rgn>
    ```
    
    The above command returns the keys associated with the cognitive services account called **ComputerVisionService**, which is owned by the given resource group. It returns two keys - one is a spare key. The keys are difficult to remember, so we'll store the first key in a variable that we'll use for all calls to the API.

2.  Execute the following command in Azure Cloud Shell:

    ```azurecli
    key=$(az cognitiveservices account keys list \
    --name ComputerVisionService \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --query key1 -o tsv)
    ```
    
    The Azure CLI 2.0 uses the `--query` argument to execute a JMESPath query on the results of commands. JMESPath is a query language for JSON, giving you the ability to select and present data from CLI output. These queries are executed on the JSON output before any display formatting.
    The `--query` argument is supported by all commands in the Azure CLI. 
    
    In our example, we query the list of keys for an entry named "key1" and output the result to **tsv** format. This format removes quotations around the string value. We assign the result to a variable **key**.
    
    > [!IMPORTANT]
    > We're going to use this key throughout the module, so saving it in a variable is a good idea. If you lose the value or the variable becomes unset, run the command again to set it.  

3. To see the value of our key, execute the following command in Azure Cloud Shell:

    ```azurecli
    echo $key
    ```

Now that we have an account and a key, it's time to make some calls to the API.