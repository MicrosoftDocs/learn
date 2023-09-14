You've built a search solution and now want to add Azure AI Language enrichments to your indexes.

:::image type="content" source="../media/exercise-overview.png" alt-text="A diagram showing the components of this exercise. Azure Cognitive Search, Azure AI Language, and a Function App." border="false":::

In this exercise, you'll create an Azure Cognitive Search solution and enrich an index with the results from a Language Studio custom text classification project. You'll create a function app to connect search and your classification model together.

> [!NOTE]
> To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free?azure-portal=true).


## Set up your development environment with Python, VSCode and VSCode Extensions

Install these tools to complete this exercise. You can still follow along with the steps without these tools.

1. Install [VS Code](https://code.visualstudio.com/)
1. Install [Azure Core Functions Tool](https://github.com/Azure/azure-functions-core-tools)
1. Install [Azure Tools Extensions for VSCode](https://code.visualstudio.com/docs/azure/extensions)
1. Install [Python 3.8](https://www.python.org/downloads/release/python-380/) for your operating system.
1. Install [Python Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-python.python)


## Set up your Azure resources

To save you time, select this Azure ARM template to create resources you'll need later in the exercise.

### Deploy a pre-built ARM template 

1. [![Deploy to Azure.](../media/deploy-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftLearning%2Fmslearn-doc-intelligence%2Fmain%2Fcognitive-search%2Fazuredeploy.json) select this link to create your starting resources.

    :::image type="content" source="../media/deploy-azure-resources.png" alt-text="A screenshot of the options shown when deploying resources to Azure.":::

1. In **Resource group**, select **Create new**, name it **cog-search-language-exe**.
1. In **Region**, select a [supported region](/azure/cognitive-services/language-service/custom-text-classification/service-limits#regional-availability) that is close to you.
1. The **Resource Prefix** needs to be globally unique, enter a random numeric and lower-case character prefix, for example **acs18245**.
1. In **Location**, select the same region you chose above.
1. Select **Review + create**.
1. Select **Create**.

    > [!NOTE]
    > There's an error shown, **You will need to Agree to the terms of service below to create this resource successfully.**, by selecting **Create** you are agreeing to them.
    
1. Select **Go to resource group** to see all the resources that you've created.

    :::image type="content" source="../media/azure-resources-created.png" alt-text="A screenshot of the deployed resources." lightbox="../media/azure-resources-created.png":::

You'll be setting up an Azure Cognitive Search index, creating an Azure function, and creating a Language Studio project to identify movie genres from their summaries.

### Upload sample data to train language services

This exercise uses 210 text files that contain a plot summary for a movie. The text files name is the movie title. The folder also contains a **movieLabels.json** file that maps the genres of a movie to the file, for each file there's a JSON entry like this:

```json
{
    "location": "And_Justice_for_All.txt",
    "language": "en-us",
    "classifiers": [
        {
            "classifierName": "Mystery"
        },
        {
            "classifierName": "Drama"
        },
        {
            "classifierName": "Thriller"
        },
        {
            "classifierName": "Comedy"
        }
    ]
},
```

1. Download the [sample data](https://github.com/Azure-Samples/cognitive-services-sample-data-files/blob/master/language-service/Custom%20text%20classification/Custom%20multi%20classification%20-%20movies%20summary.zip) from GitHub, save it locally on your machine.

    :::image type="content" source="../media/download-sample-data.png" alt-text="A screenshot showing where to select to download tha sample zip data." lightbox="../media/download-sample-data.png":::
1. Open the **Custom multi classification - movies summary.zip** file, and extract the folder containing all the files.

    > [!NOTE]
    > You use these files to train a model in Language Studio, and will also index all the files in Azure Cognitive Search.

    :::image type="content" source="../media/select-storage-account.png" alt-text="A screenshot showing where to select the storage account from." lightbox="../media/select-storage-account.png":::

1. In the [Azure portal](https://portal.azure.com/), select **All resources**, then select the storage account you created, for example **acs18245str**.

    :::image type="content" source="../media/select-azure-blob-storage.png" alt-text="A screenshot showing how to create a new storage container." lightbox="../media/select-azure-blob-storage.png":::

1. Select **Containers** from the left, then select **+ Containers**.
1. In the **New container** pane, in **Name**, enter **language-studio-training-data**.
1. In **Public access level**, choose **Container**.
1. Select **Create**.

    :::image type="content" source="../media/upload-files.png" alt-text="A screenshot of uploading files into the container." lightbox="../media/upload-files.png":::

1. Select the new container you just created, **language-studio-training-data**.
1. Select **Upload** at the top of the pane.
1. In the **Upload blob** pane, select the **file picker**.
1. Navigate to where you downloaded the sample files, select all the text (`.txt`) and json (`.json`) files.
1. Select **Upload** in the pane.
1. Close the **Upload blob** pane.

### Create a language service

1. In the breadcrumb link at the top of the page, select **All resources**.
1. Select **+ Create**.
1. Search for **language service**, then select **Language service**. 

    :::image type="content" source="../media/create-language-service.png" alt-text="A screenshot of  creating a Language Service.":::

1. Select **Create**.

    :::image type="content" source="../media/select-additional-features.png" alt-text="A screenshot showing adding the custom text classification feature.":::
1. Add the **Custom text classification & Custom named entity recognition feature**.
1. Select **Continue to create your resource**.

    :::image type="content" source="../media/enter-language-service-information.png" alt-text="A screenshot showing the information needed to create a language service.":::

1. In **Resource group**, choose **cog-search-language-exe**.
1. In **Region**, select the region you used above.
1. In **Name**, enter **learn-language-service-for-custom-text**.
1. In **Pricing** tier, select **S**.
1. In **New/Existing storage account**, select **Existing storage account**.
1. In **Storage account in current selected subscription and resource group**, select the storage account you created, for example **acs18245str**.
1. Agree to the **Responsible AI Notice** terms, then select **Review + create**.
1. Select **Create**.
1. Wait for the resources to be deployed, then select **Go to resource group**.
1. Select **learn-language-service-for-custom-text**.

    :::image type="content" source="../media/started-language-studio.png" alt-text="A screenshot showing where to select to start Language Studio.":::

1. Scroll down on the **Overview** pane, and select **Get started with Language Studio**.

### Create a custom text classification project in Language Studio

1. On the Language Studio home page, select **Create new**, then select **Custom text classification**.

    :::image type="content" source="../media/create-custom-text-classification-project.png" alt-text="A screenshot showing how to select the create a new custom text classification project.":::

1. Select **Next**.

    :::image type="content" source="../media/select-project-type.png" alt-text="A screenshot showing the multi label classification project type selected.":::

1. Select **Multi label classification**, then select **Next**.

    :::image type="content" source="../media/enter-basic-information.png" alt-text="A screenshot showing the basic information for a project.":::

1. In **Name**, enter **movie-genre-classifier**.
1. In **Description**, enter **A model that can identify a movie genre from the summary**.
1. In **Text primary language**, select **English (US)**.
1. Select **Next**.

    :::image type="content" source="../media/choose-container.png" alt-text="A screenshot showing selecting the container with sample data in.":::

1. In **Blob storage container**, choose **language-studio-training-data**.
1. Select **Yes, my documents are already labeled and I have a correctly formatted JSON labels file**.
1. In **Label documents**, choose **movieLabels**.
1. Select **Next**.
1. Select **Create project**.

### Train your custom text classification AI model

1. On the left, select **Training jobs**.

    :::image type="content" source="../media/train-jobs.png" alt-text="A screenshot showing how to create to training job.":::

1. Select **+ Start a training job**.

    :::image type="content" source="../media/start-training-job.png" alt-text="A screenshot showing the information needed to create a training job.":::
1. In **Train a new modal**, enter **movie-genre-classifier**.
1. Select **Train**.
1. Training the classifier model should take less than 10 minutes. Wait for the status to change to **Training succeeded**.

### Deploy your custom text classification AI model

1. On the left, select **Deploying a model**.

    :::image type="content" source="../media/deploy-model.png" alt-text="A screenshot showing how to deploy a model.":::

1. Select **Add a deployment**.

    :::image type="content" source="../media/add-deployment.png" alt-text="A screenshot showing the information needed to deploy a model.":::
1. In **Create a new deployment name**, enter **test-release**.
1. In **Model**, select **movie-genre-classifier**.
1. Select **Deploy**.

Leave this web page open for later in this exercise.

### Create a Cognitive Search index

Create a search index that you can enrich with this model, you'll index all the text files that contain the movie summaries you've already downloaded.

1. In the [Azure portal](https://portal.azure.com/), select **All resources**, then select the storage account you created, for example **acs18245str**.
1. Select **Containers** from the left, then select **+ Containers**.
1. In the **New container** pane, in **Name**, enter **search-data**.
1. In **Public access level**, choose **Container**.
1. Select **Create**.
1. Select the new container you just created, **search-data**.
1. Select **Upload** at the top of the pane.
1. In the **Upload blob** pane, select the **file picker**.
1. Navigate to where you downloaded the sample files, select **ONLY** the text (`.txt`) files.
1. Select **Upload** in the pane.
1. Close the **Upload blob** pane.

### Import documents into Cognitive Search

1. On the left, select **All resources**, then select your search service, for example **acs13245-search-service**.
    
    :::image type="content" source="../media/select-search-service.png" alt-text="A screenshot selecting a search service.":::
1. Select **Import data**.

    :::image type="content" source="../media/connect-data.png" alt-text="A screenshot showing the data connection information.":::

1. In **Data Source**, select **Azure Blob Storage**.
1. In **Data source name**, enter **movie-summaries**.
1. Select Choose an existing connection, then select the container you just created, **search-data**.
1. Select **Add cognitive skills**.

    :::image type="content" source="../media/attach-cognitive-services.png" alt-text="A screenshot showing attaching Azure AI services.":::

1. Expand the **Attach Azure AI Services** section, then select the cognitive service below free, for example **acs13245-ai-services**.
1. Expand the **Add enrichments** section.

    :::image type="content" source="../media/add-enrichments.png" alt-text="A screenshot showing the limited enrichments selected.":::
1. Leave all the fields with their default values, then select **Extract people names**.
1. Select **Extract key phrases**.
1. Select **Detect language**.
1. Select **Next: Customize target index**.

    :::image type="content" source="../media/customize-target-index.png" alt-text="A screenshot showing the field customizations.":::
1. Leave all the fields with their default values, for **metadata_storage_name** select **Retrievable** and **Searchable**.
1. Select **Next: Create an indexer**.
1. Select **Submit**.

The indexer will run and create an index of the 210 text files. You don't need to wait for it to continue with the next steps.

## Create a function app to enrich your search index

You'll now create a Python function app that your cognitive search custom skillset will call. The function app will use your custom text classifier model to enrich your search index.

1. On your local machine, in a terminal, clone this GitHub repository to your local machine. 

    ```bash
    git clone https://github.com/MicrosoftLearning/mslearn-doc-intelligence movie-genre-function
    ```

1. In Visual Studio Code, open the **movie-genre-function** folder.

    :::image type="content" source="../media/optimize-visual-studio-code.png" alt-text="A screenshot of Visual Studio Code showing the optimize function app dialog.":::
1. If you've installed all the required extensions, you're prompted to optimize the project. Select **Yes**.
    
    :::image type="content" source="../media/select-python-interpreter.png" alt-text="A screenshot showing selecting version 3.8 of the Python interpreter.":::

1. Select your Python interpreter, it should be version 3.8.
1. The workspace will be updated, if you're asked to connect it to the workspace folder, select **Yes**.
1. Press **F5** to debug the app.

    :::image type="content" source="../media/test-function-app.png" alt-text="A screenshot showing the function app running.":::
    
    If the app is running you should see a localhost URL that you can use for local testing.

1. Stop debugging the app, press **SHIFT** + **F5**.

### Deploy your local function app to Azure

1. In Visual Studio Code, press **F1** to open the command palette.
1. In the command palette, search for and select `Azure Functions: Create Function App in Azure...`.
1. Enter a globally unique name for your function app, for example **acs13245str-function-app**.
1. In **Select a runtime stack**, select **Python 3.8**.
1. Select the same location you used above.

1. In the left navigation, select the **Azure** extension.

    :::image type="content" source="../media/deploy-function-app.png" alt-text="A screenshot showing the menu option to deploy a function app to Azure.":::

1. Expand **Resources**, expand **Function App**, then right-click on the function, for example **acs13245-function-app**.
1. Select **Deploy to Function App**. Wait for the app to be deployed.
1. Expand the app, right-click on **Application Settings**, select **Download Remote Settings**.

    :::image type="content" source="../media/download-remote-settings.png" alt-text="A screenshot showing downloading remote app settings.":::

1. Select **local.settings.json**.
1. On the left, select **Explorer**, then select **local.settings.json**.

    :::image type="content" source="../media/edit-local-settings.png" alt-text="A screenshot of the download app settings.":::

The function app needs to be connected to your custom text classification model. Follow these steps to get the configuration settings.

1. In your browser, navigate to **Language Studio**, you should be on the **Deploying a model** page.

    :::image type="content" source="../media/copy-prediction-endpoint.png" alt-text="A screenshot showing where to copy the prediction endpoint from.":::

1. Select **Get prediction URL**.
1. Select the copy icon next to the **Prediction URL**.
1. In Visual Studio Code, at the bottom of **local.settings.json**, paste the prediction URL.
1. In **Language Studio**, on the left, select **Project settings**.

    :::image type="content" source="../media/project-settings-primary-key.png" alt-text="A screenshot showing where to copy the primary key for language services from.":::

1. Select the copy icon next to the **Primary key**.
1. In Visual Studio Code, at the bottom of **local.settings.json**, paste the primary key.
1. Edit the settings to add these four lines at the bottom, copy the endpoint into the `TA_ENDPOINT` value.

    ```json
    ,
    "TA_ENDPOINT": " [your endpoint] ",
    "TA_KEY": " [your key] ",
    "DEPLOYMENT": "test-release",
    "PROJECT_NAME": "movie-genre-classifier"
    ```

1. Copy the primary key into the `TA_KEY` value.

    ```json
    {
      "IsEncrypted": false,
      "Values": {
        "AzureWebJobsStorage": "DefaultEndpointsProtocol=https;AccountName=...",
        "FUNCTIONS_EXTENSION_VERSION": "~4",
        "FUNCTIONS_WORKER_RUNTIME": "python",
        "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING": "DefaultEndpointsProtocol=https;AccountName=...",
        "WEBSITE_CONTENTSHARE": "acs...",
        "APPINSIGHTS_INSTRUMENTATIONKEY": "6846...",
        "TA_ENDPOINT": "https://learn-languages-service-for-custom-text.cognitiveservices.azure.com/language/analyze-text/jobs?api-version=2022-05-01",
        "TA_KEY": "7105e938ce1...",
        "DEPLOYMENT": "test-release",
        "PROJECT_NAME": "movie-genre-classifier"
      }
    }

    ```

    The settings should look like above, with the values of your project.
 
1. Press **CTRL**+**S** to save your **local.settings.json** changes.
1. In the left navigation, select the **Azure** extension.
1. Expand **Resources**, expand **Function App**, then right-click on **Application Settings**, select **Upload Local Settings**.

### Test your remote function app

There's a sample query you can use to test that your function app and classifier model are working correctly.

1. On the left, select **Explorer**, expand the **customtectcla** folder, then select **sample.dat**.

    :::image type="content" source="../media/copy-sample-query.png" alt-text="A screenshot showing the sample JSON query.":::

1. Copy the contents of the file.
1. On the left, select the **Azure** extension.

    :::image type="content" source="../media/execute-remote-function.png" alt-text="A screenshot showing how to execute a remote function app from inside Visual Studio Code.":::

1. Under the **Function App**, expand **Functions**, right-click on **customtextcla**, then select **Execute Function now**.
1. In **Enter request body**, paste the sample data you copied, then press **Enter**.

    The function app will respond with JSON results.

1. Expand the notification to see the whole results.

    :::image type="content" source="../media/executed-function-json-response.png" alt-text="A screenshot of the JSON response from the executed function app.":::

    The JSON response should look like this:

    ```json
    {"values": 
        [
            {"recordId": "0", 
            "data": {"text": 
            [
                {"category": "Action", "confidenceScore": 0.99}, 
                {"category": "Comedy", "confidenceScore": 0.96}
            ]}}
        ]
    }
    ```

### Add a field to your cognitive search index

You need a place to store the enrichment returned by your new function app. Follow these steps to add a new compound field to store the text classification and confidence score.

1. In the [Azure portal](https://portal.azure.com/), select **All resources**, then select the cognitive search service you created, for example **acs18245-search-service**.

    :::image type="content" source="../media/select-search-index.png" alt-text="A screenshot of how to select a cognitive search index." lightbox="../media/select-search-index.png":::

1. On the **Overview** pane, select **Indexes**.
1. Select **azurebob-index**.
1. Select **Index definition (JSON)**.
1. Add the new fields to the index, paste the JSON below under the content field.

    ```json
    {
      "name": "textclass",
      "type": "Collection(Edm.ComplexType)",
      "analyzer": null,
      "synonymMaps": [],
      "fields": [
        {
          "name": "category",
          "type": "Edm.String",
          "facetable": true,
          "filterable": true,
          "key": false,
          "retrievable": true,
          "searchable": true,
          "sortable": false,
          "analyzer": "standard.lucene",
          "indexAnalyzer": null,
          "searchAnalyzer": null,
          "synonymMaps": [],
          "fields": []
        },
        {
          "name": "confidenceScore",
          "type": "Edm.Double",
          "facetable": true,
          "filterable": true,
          "retrievable": true,
          "sortable": false,
          "analyzer": null,
          "indexAnalyzer": null,
          "searchAnalyzer": null,
          "synonymMaps": [],
          "fields": []
        }
      ]
    },
    ```

    Your index should now look like this.

    :::image type="content" source="../media/edit-azure-blob-index-fields.png" alt-text="A screenshot of the edited index JSON." lightbox="../media/edit-azure-blob-index-fields.png":::

1. Select **Save**.

### Edit the custom skillset to call your function app

The cognitive search index needs a way to have these new fields populated. Edit the skillset you created earlier to call your function app.

1. At the top of the page, select the search service, for example **acs18245-search-service**.

    :::image type="content" source="../media/select-custom-skillset.png" alt-text="A screenshot showing selecting the custom skillset." lightbox="../media/select-custom-skillset.png":::

1. On the **Overview** pane, select **Skillsets**.
1. Select **azureblob-skillset**.
1. Add the custom skillset definition below, by pasting it as the first skillset.

    ```json
    {
      "@odata.type": "#Microsoft.Skills.Custom.WebApiSkill",
      "name": "Genre Classification",
      "description": "Identify the genre of your movie from its summary",
      "context": "/document",
      "uri": "URI",
      "httpMethod": "POST",
      "timeout": "PT30S",
      "batchSize": 1,
      "degreeOfParallelism": null,
      "inputs": [
        {
          "name": "lang",
          "source": "/document/language"
        },
        {
          "name": "text",
          "source": "/document/content"
        }
      ],
      "outputs": [
        {
          "name": "text",
          "targetName": "class"
        }
      ],
      "httpHeaders": {}
    },
    ```

    The JSON definition should look like this:

    :::image type="content" source="../media/edit-custom-skillset.png" alt-text="A screenshot showing the edited JSON for the skillset.":::

You need to change the `"uri": "URI"` to point to your function app. 

1. In Visual Studio Code, select the **Azure** extension.

    :::image type="content" source="../media/copy-function-url.png" alt-text="A screenshot showing how to select the URL for a function app.":::

1. Under **Functions**, right-click **customtextcla**, then select **Copy Function Url**.
1. On the Azure portal, replace the URI with the copied function URL. 
1. Select **Save**.

### Edit the field mappings in the indexer

You now have fields to store the enrichment, a skillset to call your function app, the last step is to tell the cognitive search where to put the enrichment.

1. At the top of the page, select the search service, for example **acs18245-search-service**.

    :::image type="content" source="../media/select-search-indexer.png" alt-text="A screenshot showing selecting the search indexer." lightbox="../media/select-search-indexer.png":::

1. On the **Overview** pane, select **Indexers**.
1. Select **azureblob-indexer**.
1. Select **Indexer Definition (JSON)**.
1. Add a new output field mapping, by pasting this field definition to the top of the output field section.

    ```json
    {
      "sourceFieldName": "/document/class",
      "targetFieldName": "textclass"
    },
    ```

    The indexer JSON definition should now look like this:

    :::image type="content" source="../media/add-output-fields-indexer.png" alt-text="A screenshot showing the edited JSON of an indexer with added output fields." lightbox="../media/add-output-fields-indexer.png":::

1. Select **Save**.
1. Select **Reset**, then select **Yes**.
1. Select **Run**, then select **Yes**.

    Your Azure cognitive search service runs your updated indexer. The indexer uses the edited custom skillset. The skillset calls your function app with the document being indexed. The custom text classifier model uses the text in the document to try and identify the genre of the movie. The model returns a JSON document with genres and confidence levels. The indexer maps the JSON results to the fields in your index using the new output field mapping.

1. Select **Execution history**.
1. Check that the indexer has successfully run against the 210 documents.

    :::image type="content" source="../media/check-indexer-results.png" alt-text="A screenshot showing the successful run of the indexer." lightbox="../media/check-indexer-results.png":::

    You might need to select **Refresh** to update the status of the indexer.

## Test your enriched search index

1. At the top of the page, select the search service, for example **acs18245-search-service**.

    :::image type="content" source="../media/select-search-index.png" alt-text="A screenshot of how to select a cognitive search index." lightbox="../media/select-search-index.png":::

1. On the **Overview** pane, select **Indexes**.
1. Select **azurebob-index**.

    :::image type="content" source="../media/enriched-index.png" alt-text="A screenshot showing an enriched search index." lightbox="../media/enriched-index.png":::

1. Select **Search**.
1. Explore the search results.

Each document in the index should have a new `textclass` field that can be searched. It contains a category field with the movies genres. It can be more than one. It also shows how confident the custom text classification model is about the identified genre.

Now that you've completed the exercise, delete all the resources you no longer need.

### Delete exercise resources

1. In the Azure portal, select **All resources**.

    :::image type="content" source="../media/delete-resources.png" alt-text="A screenshot showing how to delete resources." lightbox="../media/delete-resources.png":::

1. Select the resources you don't need, then select **Delete**.