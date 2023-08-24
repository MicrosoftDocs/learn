Microsoft Azure AI Language service provides several NLP capabilities, including the key phrase identification, text summarization, and sentiment analysis. The Azure AI Language service also provides custom features like custom question answering and custom text classification.

To test the custom text classification of the Azure AI Language service, we'll configure the model using Azure AI Language Studio then use a small command-line application that runs in the Cloud Shell to test it. The same pattern and functionality used here can be followed for real-world applications.

## Create a *Azure AI Language service* resource

To use custom text classification, you'll need to create an Azure AI Language service resource and select **Custom text classification & extraction** custom feature.

If you haven't already done so, create a **Azure AI Language service** resource in your Azure subscription.

1. In a browser, open the [Azure portal](https://portal.azure.com?azure-portal=true), and sign in with your Microsoft account.
2. Select the **Create a resource** button, search for *Language*, and create a **Azure AI Language service** resource. When asked about *Additional features*, select **Custom text classification & extraction**. Create the resource with the following settings:
    - **Subscription**: *Your Azure subscription*.
    - **Resource group**: *Select or create a resource group with a unique name*.
    - **Region**: *Choose any available region*:
    - **Name**: *Enter a unique name*.
    - **Pricing tier**: Standard S pricing tier
    - **Storage account**: Create new
      - **Name**: *Enter a unique name*
      - **Account kind**: Storage (general purpose v1)
      - **Performance**: Standard
      - **Replication**: Locally redundant storage (LRS)
    - **Legal terms**: Selected.
    - **Responsible AI notice**: Selected.

    >[!TIP]
    >You can reuse existing resources from previous labs if you have them available. Be sure to use a new container in the storage account to connect the custom entity extraction project to.

3. Review and create the resource.

### Get Azure AI Language resource key and endpoint

1. Go to the resource group in the [Azure portal](https://portal.azure.com?azure-portal=true), and select the Azure AI Language resource
2. Select **Keys and Endpoint** from the menu on the left side, located under **Resource Management**. You can copy it to your clipboard with the icon next to the key. We'll need one of the keys and the endpoint later, so either paste these values into Notepad for now or we'll come back to this page at that time.

## Upload sample articles

Once you've created the Azure AI Language service and storage account, you'll need to upload example articles to train your model later.

1. [Download sample articles](https://aka.ms/classification-articles) from this repository on GitHub. Extract the files in the `.zip` provided.

2. In the [Azure portal](https://portal.azure.com?azure-portal=true), navigate to the storage account you created, and select it

3. In your storage account, select **Containers** from the left menu, located below **Data storage**. On the screen that appears, select **+ Container**. Give the container the name `articles`, and set **Public access level** to *Container (anonymous read access for containers and blobs)*.

    > [!NOTE]
    > When you configure a storage account outside of this module, be careful to assign the appropriate access level. To learn more about each access level, see the [docs on Azure Storage](/azure/storage/blobs/anonymous-read-access-configure).

4. After creating the container, select it and click the **Upload** button to upload the sample articles you downloaded.

## Create a custom text classification project

After configuration is complete, create a custom text classification project. This project provides a working place to build, train, and deploy your model.

> [!NOTE]
> This lab utilizes **Azure AI Language Studio**, but you can also create, build, train, and deploy your model through the REST API.

1. Log into the [Azure AI Language Studio](https://aka.ms/languageStudio) with your Azure account, and select the Azure subscription that you created your Azure AI Language resource in, and select your Azure AI Language resource
2. Under the **Classify text** section, select **Custom text classification**
3. Select **Create new project**
4. In the **Create a project** pop out, choose the following and create your project:
  
    - **Select project type**: Single label classification
    - **Name**: ClassifyLab
    - **Description**: Custom text lab
    - **Text primary language**: English (US)
    - **Blob store container**: articles
    - **Are your files labeled with classes?**: No, I need to label my files as part of this project

## Label your data

Now that your project is created, you need to label, or tag, your data to train your model how to classify text.

1. On the left, click on **Data labeling**. You'll see a list of the files you uploaded to your storage account.
2. On the right side, in the **Labeling** pane, click on **Add class**. The articles in this lab fall into four classes you'll need to create: Classifieds, Sports, News, and Entertainment.

    ![Screenshot showing the tag data page and the add class button.](../media/tag-data-add-class.png#lightbox)

3. After you've created your four classes, start by clicking on *Article 1*. Here you can read the article, define which class this file is, and which dataset to assign it to.
4. Assign each article the appropriate class and dataset. For the purposes of this lab, we'll define which are to be used for training the model vs. testing the model.

    | Article  | Class  | Dataset  |
    |---------|---------|---------|
    | Article 1 | Sports | Training |
    | Article 10 | News | Training |
    | Article 11 | Entertainment | Testing |
    | Article 12 | News | Testing |
    | Article 13 | Sports | Testing |
    | Article 2 | Sports | Training |
    | Article 3 | Classifieds | Training |
    | Article 4 | Classifieds | Training |
    | Article 5 | Entertainment | Training |
    | Article 6 | Entertainment | Training |
    | Article 7 | News | Training |
    | Article 8 | News | Training |
    | Article 9 | Entertainment | Training |

    > [!NOTE]
    > Files in Azure AI Language Studio are listed alphabetically, which is why the above list is not in sequential order. Make sure you visit both pages of documents when labeling your articles.

5. Click **Save labels**

## Train your model

Once you've labeled your data, you need to train your model.

1. Select **Training jobs** on the left side menu
2. Click **Start a training job**
3. Name your model `ClassifyArticles`
4. Choose **Use a manual split of training and testing data**

    > [!TIP]
    > In your own classification projects, the Azure AI Language service will automatically split the testing set by percentage which is useful with a large dataset. With smaller datasets, it's important to train with the right class distribution.

5. Click **Train**

> [!IMPORTANT]
> Training your model can sometimes take several minutes. You'll get a notification when it's complete.

## Evaluate your model

In real world applications of text classification, it's important to evaluate and improve your model to verify it's performing as you expect. Two pages on the left show you the details of your trained model, and any testing that failed.

1. Select **Model performance**, and select your *ClassifyArticles* model. There you can see the scoring of your model, performance metrics, and when it was trained. You'll notice the score of your model might not be 100%, meaning one of the articles used for testing didn't evaluate to what it was labeled. These failures help you understand where to improve.
2. Select **Improve model**. Your model is already selected in the drop-down, and it defaults to show incorrect predictions only. Toggle that selection to see the articles you indicated for testing and what they predicted as.

## Deploy your model

Once you're satisfied with the training of your model, it's time to deploy it, which allows you to start classifying text through the API.

1. On the left panel, select **Deploying model**
2. Select **Add deployment**, then enter `articles` and select *ClassifyArticles* to select your trained model
3. Click **Submit** to deploy your model
4. Once your model is deployed, leave that page open since you'll need your project and deployment name in the next step

## Send text classification to your model

To test the text analytics capabilities of the Azure AI Language service, we'll use a small command-line application that runs in the Cloud Shell on Azure.

### Run Cloud Shell

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), select the **[>_]** (*Cloud Shell*) button at the top of the page to the right of the search box. This button opens a Cloud Shell pane at the bottom of the portal.

    ![Screenshot of starting the Cloud Shell by clicking on the icon to the right of the top search box.](../media/powershell-portal-guide-1.png#lightbox)

2. The first time you open the Cloud Shell, you may be prompted to choose the type of shell you want to use (*Bash* or *PowerShell*). Select **PowerShell**. If you don't see this option, skip the step.  

3. If you're prompted to create storage for your Cloud Shell, ensure your subscription is specified and select **Create storage**. Then wait a minute or so for the storage to be created.

4. Make sure the type of shell indicated on the top left of the Cloud Shell pane is switched to *PowerShell*. If it's *Bash*, switch to *PowerShell* by using the drop-down menu.

5. Wait for PowerShell to start. You should see the following screen in the Azure portal:  

    ![Screenshot of waiting for PowerShell to start.](../media/powershell-prompt.png#lightbox)

### Configure and run PowerShell

Now that you have a custom model, you can run a client application that uses the Azure AI Language service.

1. In the command shell, enter the following command to download the sample application and save it to a folder called ai-language.

    ```powershell
    git clone https://github.com/MicrosoftLearning/ai-language ai-language
    ```
  
    > [!TIP]
    > If you already used this command in another lab to clone the *ai-language* repository, you can skip this step.

2. The files are downloaded to a folder named **ai-language**. Now we want to see all of the files in your Cloud Shell storage and work with them. Navigate to the `Text Classification` folder and type the following command into the shell:

    ```powershell
    cd ai-language/text-classification
    ```

    ```powershell
    code classify-text.ps1
    ```

3. In `classify-text.ps1`, note the top two lines of the script with places for your Azure AI Language service key and endpoint, as well as your project and model names. Replace the placeholders for `$key` and `$endpoint` with your resource values (`$projectName`, and `$modelName` should match what you entered above), and save the file.

    > [!TIP]
    > If you don't have these values readily available, navigate to the [Azure portal](https://portal.azure.com?azure-portal=true), find the Azure AI Language resource you created earlier, and select the **Keys and endpoint** page on the left

4. Run the following command to call your model and classify the text provided. The script won't output the whole file it's classifying for the sake of space, but you can view the contents [here on GitHub](https://aka.ms/text-classification-repo). Review the output.

    ```powershell
    .\classify-text.ps1 test1.txt
    ```

    > [!NOTE]
    > You can update the script variable `$verbose` to `$true`to see the raw response JSON

5. Run the following command again, this time with a different file to classify. Review the output.

    ```powershell
    .\classify-text.ps1 test2.txt
    ```

## Clean up

When you don't need your project anymore, you can delete if from your **Projects** page in Azure AI Language Studio. You can also remove the Azure AI Language service and associated storage account in the [Azure portal](https://portal.azure.com?azure-portal=true).
