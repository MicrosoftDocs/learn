
In addition to other natural language processing capabilities, Azure AI Language enables you to extract custom entities from various files.

To test the custom entity extraction, we'll create a model and train it through Language Studio, then use a command line application to test it.

## Create an Azure AI Language service resource

To use custom entity recognition, you'll need to create an Azure AI Language service resource and select **Custom text classification & extraction** custom feature.

If you haven't already done so, create an **Azure AI Language service** resource in your Azure subscription.

1. In a browser, open the [Azure portal](https://portal.azure.com?azure-portal=true), and sign in with your Microsoft account.
1. Select the search field at the top of the portal button, search for **Azure AI services**, and create a **Language Service** resource.
1. Select the box that includes **Custom text classification** and **Custom named entity recognition**. Then select **Continue to create your resource**.
1. Create a resource with the following settings:
    - **Subscription**: *Your Azure subscription*.
    - **Resource group**: *Select or create a resource group with a unique name*.
    - **Region**: *Choose any available region*:
    - **Name**: *Enter a unique name*.
    - **Pricing tier**: *Standard S pricing tier*.
    - **Storage account**: *New storage account*.
      - **Storage account name**: *Enter a unique name*.
      - **Storage account type**: *Standard LRS*.
    - **Responsible AI notice**: *Selected*.

    > [!TIP]
    > You can reuse existing resources from previous labs if you have them available. Be sure to use a new container in the storage account to connect the custom entity extraction project to.

1. Select **Review + create,** then select **Create** to provision the resource.

### Get Azure AI Language resource key and endpoint

1. Navigate to the resource group in the [Azure portal](https://portal.azure.com?azure-portal=true), and select the Azure AI Language resource.
1. Select **Keys and Endpoint** from the menu on the left side, located under **Resource Management**. You can copy it to your clipboard with the icon next to the key. We'll need one of the keys and the endpoint later, so either paste these values into Notepad for now or we'll come back to this page at that time.

## Upload sample ads

After you've created the Azure AI Language service and storage account, you'll need to upload example ads to train your model later.

1. [Download sample classified ads](https://aka.ms/entity-extraction-ads) from this repo on GitHub. Extract the files from the `.zip` provided.

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), navigate to the storage account you created, and select it.

1. In your storage account, select **Containers** from the left menu, located below **Data storage**. On the pane that appears, select **+ Container**. Give the container the name **customner**, and set **Public access level** to **Container (anonymous read access for containers and blobs)**. Then select **Create**.

    > [!NOTE]
    > When you configure a storage account outside of this module, be careful to assign the appropriate access level. To learn more about each access level, see the [docs on Azure Storage](/azure/storage/blobs/anonymous-read-access-configure).

1. After you've created the container, select it then select the **Upload** button. Select **Browse for files** to browse for the sample ads you downloaded. Then select **Upload**.

## Create a custom named entity recognition project

Once configuration is complete, create a custom named entity recognition project. This project provides a working place to build, train, and deploy your model.

> [!NOTE]
> You can also create, build, train, and deploy your model through the REST API

1. Sign into the [Language Studio](https://aka.ms/languageStudio) with your Azure account, and select the Azure subscription that you created your Azure AI Language resource in. Make sure **Language** is selected for **Resource type** and select your Azure AI Language resource in the **Resource name** field. Then select **Done**.

    > [!NOTE]
    > If you've previously logged into Language Studio, it's already linked to your previous Azure AI Language resource. When creating the project in the following steps, be sure to switch that project to the correct resource.

1. Under the **Extract information** tab, select **Custom named entity recognition**.
1. Select **Create new project**.
1. In the **Create a project** pane that appears, choose the following and create your project:
1. For the **Connect storage** section: This is already filled, so select **Next**.
1. For the **Enter basic information** section set the following:
    - **Name**: customNERLab
    - **Text primary language**: English (US)
    - **Description**: Enter a short description
1. Select **Next**. Then set **Blob store container** to **customner**.
1. Select the **No, I need to label my files as part of this project** option.
1. Select **Next**, then select **Create Project**.

## Label your data

Now that your project is created, you need to label your data to train your model how to identity entities.

1. You'll see a list of the files you uploaded to your storage account.
1. On the right side, in the Activity pane, select **+ Add entity**. In the pane that appears, enter **ItemForSale** then select **Done**. Repeat this step for **Price** and **Location**.

    :::image type="content" source="../media/tag-data-add-entity-new-small.png" alt-text="Screenshot showing how to label data and add entity." lightbox="../media/tag-data-add-entity-new.png":::

1. After you've created your three entities, start by selecting **Ad 1**. Here you can read the ad, specify the entity, and which dataset to assign it to.
1. Assign the entities for each ad to their respective values by selecting the beginning and end, which will then highlight the entity. Specify which entity it is.
1. Each file can specify the dataset (bottom of the Activity pane); leave all to the default **Training** dataset.
1. Select **Save labels** to save your labels.

## Train your model

After you've labeled your data, you need to train your model.

1. Select **Training jobs** on the left side menu.
1. Select **Start a training job**.
1. Enter the name **ExtractAds**.
1. Choose **Automatically split the testing set from training data**.

    > [!TIP]
    > In your own extraction projects, use the testing split that best suits your data. For more consistent data and larger datasets, the Azure AI Language service will automatically split the testing set by percentage. With smaller datasets, it's important to train with the right variety of possible input documents.

1. Select **Train**

> [!IMPORTANT]
> Training your model can sometimes take several minutes. You'll get a notification when it's complete.

## Evaluate your model

In real world applications, it's important to evaluate and improve your model to verify it's performing as you expect. Two pages on the left show you the details of your trained model, and any testing that failed.

1. Select **Model performance** on the left side menu, and select your **ExtractAds** model. There you can see the scoring of your model, performance metrics, and when it was trained. You'll be able to see if any testing documents failed, and these failures help you understand where to improve.

## Deploy your model

When you're satisfied with the training of your model, it's time to deploy it, which allows you to start extracting entities through the API.

1. On the left panel, select **Deploying a model**.
1. Select **Add deployment**, then enter the name **customExtractAds**, and select **ExtractAds** from the **Model** drop-down.
1. Select **Deploy** to deploy your model.

## Send entity recognition task to your model

To test the text analytics capabilities of the Azure AI Language service, we'll use a short command-line application that runs in the Cloud Shell on Azure.

### Run Cloud Shell

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), select the **[>_]** (Cloud Shell) button at the top of the page to the right of the search box. A Cloud Shell pane will open at the bottom of the portal.

    :::image type="content" source="../media/powershell-portal-guide-1-small.png" alt-text="Screenshot of starting Cloud Shell by clicking on the icon to the right of the top search box." lightbox="../media/powershell-portal-guide-1.png":::

1. The first time you open the Cloud Shell, you may be prompted to choose the type of shell you want to use (Bash or PowerShell). Select **PowerShell**. If you don't see this option, skip this step.  

1. If you're prompted to create storage for your Cloud Shell, ensure your subscription is specified and select **Create storage**. Then wait a minute or so for the storage to be created.

1. Make sure the type of shell indicated on the top left of the Cloud Shell pane is switched to PowerShell. If it's Bash, switch to **PowerShell** by using the dropdown menu on the top left.

1. Wait for PowerShell to start. You should see the following screen in the Azure portal:  

    :::image type="content" source="../media/powershell-prompt-small.png" alt-text="Screenshot of waiting for PowerShell to start." lightbox="../media/powershell-prompt.png":::

### Configure and run PowerShell

Now that you have a custom model, you can run a client application that uses the Azure AI Language service.

1. In the command shell, enter the following command to download the sample application and save it to a folder called **ai-language**. Put the following command into the Cloud Shell, then press **Enter**:

    ```powershell
    git clone https://github.com/MicrosoftLearning/ai-language ai-language
    ```
  
    > [!TIP]
    > If you already used this command in another lab to clone the *ai-language* repository, you can skip this step.

1. The files are downloaded to a folder named **ai-language**. Now we want to see all of the files in your Cloud Shell storage and work with them. In the shell, enter the following commands:

    ```powershell
    cd ai-language/named-entity-recognition
    ```

    ```powershell
    code extract-entities.ps1
    ```

1. In `extract-entities.ps1`, note the top two lines of the script with places for your Azure AI Language service key and endpoint, as well as your project and model names. Replace the placeholders for **$key** and **$endpoint** with your resource values (**$projectName**, and **$modelName** should match what you entered above), and press **CTRL + S** to save the file.

    > [!TIP]
    > If you don't have these values readily available, navigate to the [Azure portal](https://portal.azure.com?azure-portal=true), find the Azure AI Language resource you created earlier, and select the **Keys and endpoint** page on the left

1. Run the following command to call your model and extract the entities from the test file. Review the output.

    ```powershell
    .\extract-entities.ps1 test1.txt
    ```

    > [!NOTE]
    > You can update the script variable `$verbose` to `$true`to see the raw response JSON

1. Run the following command again, this time with a different file to extract. Review the output.

    ```powershell
    .\extract-entities.ps1 test2.txt
    ```

## Clean up

When you don't need your project anymore, you can delete if from your **Projects** page in Language Studio. You can also remove the Azure AI  Language resource and associated storage account in the [Azure portal](https://portal.azure.com?azure-portal=true).
