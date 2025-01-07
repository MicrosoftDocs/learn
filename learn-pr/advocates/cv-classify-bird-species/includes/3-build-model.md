Now let's build our model! The first step is to download the dataset and create our Azure service.

### Activate the sandbox

The process of signing in to activate the sandbox runs outside the learning module. You're automatically returned to the module after you sign in.

To activate the sandbox:

1. Select **Sign in to activate Sandbox**.  Enter your credentials to authenticate.

1. If prompted, select **Review permissions**.

    :::image type="content" source="../media/sandbox-review-permissions.png" alt-text="Screenshot that shows the sandbox, with the Review Permissions button highlighted.":::

1. Verify the permissions settings, and select **Accept**.

    :::image type="content" source="../media/sandbox-accept-permissions.png" alt-text="Screenshot that shows the sandbox, with permissions details and the Accept button highlighted.":::

The message **Sandbox activated!** appears, and you can continue with the learning module.

## Download the dataset

Data is the first thing we need to create a machine learning model. We'll use a subset of the NABirds dataset from the Cornell Lab to train our model. 

Download the zip file that contains the dataset:

1. In your web browser, go to the [dataset](https://github.com/MicrosoftDocs/mslearn-cv-classify-bird-species/blob/master/bird-photos.zip?azure-portal=true) in GitHub.

1. Select **Download**. 

   :::image type="content" source="../media/github-download-dataset.png" alt-text="Screenshot that shows GitHub in a web browser, with the dataset zip file and the Download button highlighted."::: 

   The zip file is copied to your computer and stored in your default location for downloaded files. 

1. When the download is finished, unzip the file. Note the folder location because you’ll need it in a later step.

## Create a Custom Vision API resource

Next, we'll create an API resource in Azure AI Custom Vision.

1. In the [Azure portal](https://portal.azure.com/?azure-portal=true), select **Create a resource**.

1. Search for **custom vision**. In the **Custom Vision** card in the search results, select **Create**.

    :::image type="content" source="../media/azure-portal-create-resource.png" alt-text="Screenshot that shows searching for Custom Vision resource templates in the Azure portal."::: 

1. On the **Basics** tab, enter or select the required values:

   1. Select your Azure subscription.

   1. Create a new resource group:

      1. Beside **Resource group**, select the **Create new** link. 

      1. In the dialog box, enter *BirdResourceGroup*, and then select **OK**.

      :::image type="content" source="../media/azure-portal-create-resource-group.png" alt-text="Screenshot that shows how to create a new resource group in the Azure portal."::: 

   1. Enter a name for your new Custom Vision service resource (for example, *BirdCustomVisionService*).

   1. Under **Instance Details**:

      1. Set **Region** to *(US) South Central US*.
 
      1. Enter a **Name** for your resource, using only alphanumeric characters and hyphens.
 
   1. Under **Training Resource**, set **Training pricing tier** to *Free F0 (2 Transactions per second…)*.

   1. Under **Prediction Resource**, set **Prediction pricing tier** to *Free F0 (2 Transactions per second…)*.

1. Select **Review + create**.

1. Select **Create**.

   :::image type="content" source="../media/azure-portal-create-resource-details.png" alt-text="Screenshot that highlights the elements to select in the Azure portal to create a new Custom Vision resource.":::

When the deployment finishes, select **Go to resource group**.

:::image type="content" source="../media/azure-portal-deployment-finished.png" alt-text="Screenshot that shows the deployment finished page in the Azure portal, with the Go to resource button highlighted.":::

You should see two resources listed in this new resource group: a _training resource_, and a _prediction resource_.
