In addition to other natural lange processing capabilities, Microsoft Azure Language service provides the ability to extract custom entities from various files.

To test the custom entity extraction, we'll create a model and train it through Language Studio, then use a simple command line application to test it.

## Create a *Language service* resource

To use custom entity recognition, you'll need to create an Azure Language service resource and select **Custom text classification & extraction** custom feature.

If you haven't already done so, create a **Language service** resource in your Azure subscription.

1. In a browser, open the [Azure portal](https://portal.azure.com?azure-portal=true), and sign in with your Microsoft account.
2. Select the **Create a resource** button, search for *Language*, and create a **Language service** resource. When asked about additional features, select **Custom text classification & extraction**. Create the resource with the following settings:
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

    > [!TIP]
    > You can reuse existing resources from previous labs if you have them available. Be sure to use a new container in the storage account to connect the custom entity extraction project to.

3. Review and create the resource. 

### Get Language resource key and endpoint

1. Navigate to the resource group in the [Azure portal](https://portal.azure.com?azure-portal=true), and select the Language resource
2. Select **Keys and Endpoint** from the menu on the left side, located under **Resource Management**. Save one of the keys and the endpoint for later.

## Upload sample ads

Once you have created the language service and storage account, you'll need to upload example ads to train your model later.

1. [Download sample classified ads](https://aka.ms/entity-extraction-ads) from this repo on GitHub. Extract the files from the `.zip` provided.

2. In the [Azure portal](https://portal.azure.com?azure-portal=true), navigate to the storage account you created, and select it

3. In your storage account, select **Containers** from the left menu, located below **Data storage**. On the screen that appears, select **+ Container**. Give the container a name you'll remember, and set **Public access level** to *Container (anonymous read access for containers and blobs)*.

  > [!NOTE]
  > When you configure a storage account outside of this module, be careful to assign the appropriate access level. To learn more about each access level, see the [docs on Azure Storage](/azure/storage/blobs/anonymous-read-access-configure).

4. After creating the container, select it and click the **Upload** button to upload the sample ads you downloaded.

## Create project

Once configuration is complete, create a custom named entity recognition project. This project provides a working place to build, train, and deploy your model.

  > [!NOTE]
  > You can also create, build, train, and deploy your model through the REST API, if you prefer.

1. Log into the [Language Studio](https://aka.ms/languageStudio) with your Azure account, and select the Azure subscription that you created your Language resource in, and select your Language resource

  > [!NOTE]
  > If you've already logged into Language Studio, it is already linked to your previous Language resource. When creating the project in the following steps, be sure to switch that project to the correct resource.

2. Under the **Extract information** section, select **Custom named entity recognition**
3. Select **Create new project**
4. In the **Create a project** popout, choose the following and create your project:
  - **Connect storage**: *This is likely already filled out. Change resource if it is not pointing to the resource you just created*
  - **Name**: *Enter a unique name*
  - **Description**: *Enter short description*
  - **Text primary language**: English (US)
  - **Blob store container**: *Choose the container you created*
  - **Are you files tagged**: No, I need to tag my files as part of this project

## Tag your data

Now that your project is created, you need to tag your data to train your model how to identity entities. 

1. On the left, click on **Tag data**. You'll see a list of the files you uploaded to your storage account. 
2. On the right side, in the **Tagging** pane, click on **Add entity**. The files for this lab contain three you'll need to create: ItemForSale, Price, and Location

    ![Tag data and add entity](../media/tag-data-add-entity.png)

3. After you've created your three entities, start by clicking on *Ad 1*. Here you can read the ad, specify the entity, and which dataset to assign it to.
4. Assign the entities for each ad to their respective values by selecting the beginning and end, which will then highlight the entity. Specify which entity it is. 
5. Each file has the option to specify the dataset; leave all to the default  *Training* dataset.
6. Click **Save tags**

## Train your model

Once you've tagged your data, you need to train your model.

1. Select **Train model** on the left side menu
2. Click **Start a training job**
3. Enter a name for your model, such as *ExtractAds*
4. Choose **Automatically split the testing set from training data**

  > [!TIP]
  > In your own extraction projects, use the testing split that best suits your data. For more consistent data and larger datasets, the Language service will automatically split the testing set by percentage. With smaller datasets, it's important to train with the right variety of possible input documents.

5. Click **Train**

## Improve your model

In real world applications, it's important to evaluate and improve your model to verify it's performing as you expect. Two pages on the left show you the details of your trained model, and any testing that failed.

1. Select **View model details**. There you can see the scoring of your model, performance metrics, and when it was trained.
2. Select **Improve model**. Your model is already selected in the dropdown, and it defaults to show incorrect predictions only. Toggle that selection to see the documents you indicated for testing and what was extracted

## Deploy your model

Once you're satisfied with the training of your model, it's time to deploy it, which allows you to start extracting entities through the API.

1. On the left panel, select **Deploy model**
2. Select **Add deployment**, then enter a new deployment name and select your trained model from the dropdown
3. Click **Submit** to deploy your model
4. Once your model is deployed, save your *deployment name*, and your *project name* for use in the next step

## Send entity recognition task to your model

To test the text analytics capabilities of the Language service, we'll use a simple command-line application that runs in the Cloud Shell on Azure.

### Run Cloud Shell 

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), select the **[>_]** (*Cloud Shell*) button at the top of the page to the right of the search box. This opens a Cloud Shell pane at the bottom of the portal. 

    ![Start Cloud Shell by clicking on the icon to the right of the top search box](../media/powershell-portal-guide-1.png)

2. The first time you open the Cloud Shell, you may be prompted to choose the type of shell you want to use (*Bash* or *PowerShell*). Select **PowerShell**. If you do not see this option, skip the step.  

3. If you are prompted to create storage for your Cloud Shell, ensure your subscription is specified and select **Create storage**. Then wait a minute or so for the storage to be created. 

4. Make sure the type of shell indicated on the top left of the Cloud Shell pane is switched to *PowerShell*. If it is *Bash*, switch to *PowerShell* by using the drop-down menu. 
    
5. Wait for PowerShell to start. You should see the following screen in the Azure portal:  

    ![Wait for PowerShell to start.](../media/powershell-prompt.png) 

### Configure and run Powershell

Now that you have a custom model, you can run a simple client application that uses the Language service.

1. In the command shell, enter the following command to download the sample application and save it to a folder called ai-language.

  ```
  git clone https://github.com/MicrosoftLearning/ai-language ai-language
  ```
  
  > [!TIP] 
  > If you already used this command in another lab to clone the *ai-language* repository, you can skip this step.

2. The files are downloaded to a folder named **ai-language**. Now we want to see all of the files in your Cloud Shell storage and work with them. In the shell, navigate to the `Named Entity Recognition` folder and type the following command: 

  ```
  code .
  ```

3. Open `extract-entities.ps1`, and note the top two lines of the script with places for your Language service key and endpoint, as well as your project and model names. Replace the placeholders for `$key`, `$endpoint`, `$projectName`, and `$modelName` with your values, and save the file.

  > [!TIP]
  > If you don't have these values readily available, navigate to the [Azure portal](https://portal.azure.com?azure-portal=true), find the Language resource you created earlier, and select the **Keys and endpoint** page on the left

4. Run the following command to call your model and extract the entities from the test file. Review the output.

  ```
  .\extract-entities.ps1 test1.txt
  ```

5. Run the following command again, this time with a different file to extract. Review the output.

  ```
  .\extract-entities.ps1 test2.txt
  ```

## Clean up

When you don't need your project anymore, you can delete if from your **Projects** page in Language Studio. You can also remove the Language service and associated storage account in the [Azure portal](https://portal.azure.com?azure-portal=true).
