In this exercise, you'll create and deploy a web service that acts as a custom skill in a Cognitive Search pipeline. The web skill calls Azure AI Document Intelligence to extract invoice fields, such as customer names, so that they can be included in the index.

## Run Cloud Shell

To start the exercise, let's connect to Cloud Shell, which you'll use to run the setup script:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select the **[>_]** (Cloud Shell) button at the top of the page to the right of the search box. This opens a Cloud Shell pane at the bottom of the portal.

    :::image type="content" source="../media/4-open-cloud-shell.png" alt-text="Screenshot showing how to open Cloud Shell in the Azure portal.":::

1. The first time you open the Cloud Shell, you may be prompted to choose the type of shell you want to use (*Bash* or *PowerShell*). Select **Bash**. If you don't see this option, skip the step.
1. If you're prompted to create storage for your Cloud Shell, ensure your subscription is specified and select **Create storage**. Then wait a minute or so for the storage to be created.
1. Make sure the type of shell indicated on the top left of the Cloud Shell pane is switched to *Bash*. If it's *PowerShell*, switch to *Bash* by using the drop-down menu.
1. Wait for Bash to start.

## Set up resources

We'll use a script to create the Azure Forms Recognizer resource, a resource group, and the Cognitive Search resource:

1. In the Cloud Shell, to clone the code repository, enter this command:

    ``` bash
    git clone https://github.com/MicrosoftLearning/mslearn-formrecognizer.git
    ```

1. Change to the **Mod5** directory and then execute the setup script:

   ``` bash
   cd mslearn-formrecognizer/Mod5/
   bash setup.sh
   ```

## Create an Azure Function

You'll host your custom skill in an Azure Function App. Let's create that Function App:

1. In the Azure portal, select **Create a resource**.
1. In the **Search services and marketplace** textbox, type **Function App** and then select **Function App**.
1. In the **Function App** page, select **Create**.
1. In the **Subscription** drop-down list, select your subscription.
1. In the **Resource group** drop-down list, select **FormsRecognizerResources**.
1. In the **Function app name** textbox, type a unique name.
1. Next to **Publish** select **Code**.
1. In the **Runtime stack** drop-down list, select **Python**.
1. In the **Version** drop-down list, select **3.7**.
1. In the **Region** drop-down list, select **West US**.
1. In the **Plan type** drop-down list, select **Consumption (Serverless)** and then select **Review + create**.

    :::image type="content" source="../media/4-create-function.png" alt-text="Screenshot showing how to create a new Function App in the Azure portal." lightbox="../media/4-create-function.png":::

1. Review your configuration and then select **Create**. Azure creates the function app.

## Configure the deployed Function

The Python code that you'll deploy needs to know the endpoint and API key for your Azure AI Document Intelligence resource. We'll obtain those values from the Azure portal and use the Function Apps application settings to configure them:

1. In the Azure portal, select **All resources** and then select **FormsRecognizer**.
1. Select **Keys and Enpoint** tab. To the right of the **Endpoint** textbox, select the **Copy to clipboard** button.
1. Open Notepad and paste the endpoint value.
1. In the Azure portal, to the right of the **KEY 1** textbox, select the **Copy to clipboard** button.
1. Switch to Notepad and paste the key on a new line.
1. In the Azure portal, select **All resources** and then select the function app you created above.
1. Under **Settings**, select **Configuration** and then select **+ New application setting**.
1. In the **Add/Edit application setting** dialog, in the **Name** textbox, type **FORMS_RECOGNIZER_ENDPOINT**.
1. Copy the endpoint value from Notepad, paste it in the **Value** textbox, and then select **OK**.
1. Select **+ New application setting**.
1. In the **Add/Edit application setting** dialog, in the **Name** textbox, type **FORMS_RECOGNIZER_KEY**.
1. Copy the key from Notepad, paste it in the **Value** textbox, and then select **OK**. 
1. At the top of the **Configuration** page, select **Save** and then select **Continue**. The function app configuration is complete.

    :::image type="content" source="../media/4-application-settings.png" alt-text="Screenshot showing application settings in the Azure portal." lightbox="../media/4-application-settings.png":::

## Publish the Function

Next, deploy the Python code for the Function App:

1. In the Cloud Shell, change to the **customskill** folder:

    ```bash
    cd ~/mslearn-formrecognizer/Mod5/customskill
    ```

1. To use the Azure Functions Core Tools to deploy the Python code to your Function App, type this command and substitute `<FunctionName>` for the name you used when you created the Function App:

    ```bash
    func azure functionapp publish <FunctionName> --python
    ```

1. When the deployment is complete, in the Azure portal, select **All resources** and then select your Function App.
1. Under **Functions**, select **Functions**. If no functions are displayed in the list, wait for a minute and then select **Refresh**.

    :::image type="content" source="../media/4-published-functions.png" alt-text="Screenshot showing three published functions in the Azure portal.":::

    Azure displays three functions: **AnalyzeForm**, **AnalyzeInvoice**, and **ExtractTables**.

## Test the Function

We can use the Azure portal **Code + Test** tool to submit a test invoice to the function and see whether the inputs and output are as expected by Cognitive Search:

1. In a new browser tab, browse to the sample invoice and examine the PDF file:
https://raw.githubusercontent.com/MicrosoftLearning/mslearn-formrecognizer/master/Mod5/SampleInvoices/Invoice_1.pdf
1. In the Azure portal, in the Function App, under **Functions** select **Functions** and then select **AnalyzeInvoice**.
1. Under **Developer** select **Code + Test**.
1. At the top of the code window, select **Test/Run**.
1. In the **HTTP method** drop-down list, select **POST**.
1. In the **Body** textbox, enter this JSON code, and then select **Run**:

    ```json
    {
        "values": [
            {
                "recordId": "record1",
                "data": { 
                    "formUrl": "https://raw.githubusercontent.com/MicrosoftLearning/mslearn-formrecognizer/master/Mod5/SampleInvoices/Invoice_1.pdf",
                    "formSasToken": "?st=sasTokenThatWillBeGeneratedByCognitiveSearch"
                }
            }
        ]
    }
    ```

1. If the function is configured correctly, the output displayed includes values for **CustomerAddress**, **CustomerAddressRecipient**, and other keys. Compare the values returned with the original PDF file you opened above.

## Add the Function to the Cognitive Search skillset

To configure Azure AI Services to use the new Azure Function that calls Azure AI Document Intelligence, you must add a skillset:

1. In the Azure portal, select **All resources** and then select the Azure Function App you created above.
1. Next to the **URL** field, select the **Copy to clipboard** button.
1. Switch to Notepad and paste the URL on a new line.
1. In the Azure portal, under **Functions**, select **App keys** and then select **Show values**.
1. To the right of the **default** host key, select the **Copy to clipboard** button.
1. Switch to Notepad and paste the key on a new line.
1. In the Azure portal, select **All resources** and then select **enrichedcognitivesearch**.
1. On the **Overview** page for the Cognitive Search resource, select the **Skillsets** tab and then select **Add skillset**.
1. Copy the following JSON code and then paste it into the **Skillset definition (JSON)** textbox, replacing the default content:

    ```json
    { 
        "name": "[SkillsetName]",
        "description":"Skillset that calls an Azure AI Document Intelligence custom skill",
        "skills":[ 
            { 
                "@odata.type":"#Microsoft.Skills.Custom.WebApiSkill",
                "name":"formrecognizer",
                "description":"Analyze invoices and extract fields.",
                "uri":"[EndpointUrl]/api/analyze-form?code=[AzureFunctionDefaultHostKey]",
                "httpMethod":"POST",
                "timeout":"PT30S",
                "context":"/document",
                "batchSize":1,
                "inputs":[ 
                    { 
                        "name":"formUrl",
                        "source":"/document/metadata_storage_path"
                    },
                    { 
                        "name":"formSasToken",
                        "source":"/document/metadata_storage_sas_token"
                    }
                ],
                "outputs":[ 
                    { 
                        "name":"address",
                        "targetName":"address"
                    },
                    { 
                        "name":"recipient",
                        "targetName":"recipient"
                    }
                ]
            }
        ],
        "cognitiveServices": {
            "@odata.type": "#Microsoft.Azure.Search.DefaultCognitiveServices"
        }
    }
    ```

1. Replace `[SkillsetName]` with a unique name for your skillset.
1. From Notepad, copy the Function App URL and paste it into the above JSON code, replacing `[EndpointUrl]`.
1. From Notepad, copy the default host key and paste it into the above JSON code, replacing `[AzureFunctionDefaultHostKey]`.
1. At the top left, select **Save**. You've completed the integration of Cognitive Search with Forms Recognizer.

## Clean up

Let's remove the exercise resources from your Azure subscription:

1. In Azure portal, select **Resource groups**.
1. Select **FormsRecognizerResources** and then select **Delete resource group**.
1. In the **TYPE RESOURCE GROUP NAME** textbox, type **FormsRecognizerResources** and then select **Delete**. Azure removes the resource group, the Azure AI Document Intelligence resource, the Cognitive Search resource, and their associated resources.

## Learn more

- [Example: Create an Azure AI Document Intelligence custom skill](/azure/search/cognitive-search-custom-skill-form)
- [Create a skillset in Azure Cognitive Search](/azure/search/cognitive-search-defining-skillset)
- [Form Analyzer custom skill sample code](https://github.com/Azure-Samples/azure-search-power-skills/tree/main/Vision/AnalyzeFormV2)