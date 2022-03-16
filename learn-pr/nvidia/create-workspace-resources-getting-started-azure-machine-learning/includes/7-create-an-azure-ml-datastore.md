Datastores allow for the ability to securely connect to your storage services in Microsoft Azure without putting your authentication credentials or the integrity of your original data source at risk. They store connection information, like your subscription ID and token authorization in a secure Key Vault that's associated with the Azure Machine Learning workspace.  In this way, you can securely access your storage without having to hard code connection information into your scripts. In this section, we will create a Datastore that we will later reference in a Jupyter notebook that will run on our previously deployed compute instance.

## Create an Azure Machine Learning Datastore

1. If you are not already launched into the Azure Machine Learning Studio that was used in the previous section, sign in to [Azure Machine Learning Studio](https://ml.azure.com/) now, and select your workspace.

1. Select **Datastores** on the left pane under **Manage**

    :::image type="content" source="../media/7-SelectDatastores.png" alt-text="The Datastore option is highlighted." lightbox="../media/7-SelectDatastores.png":::  

1. Select **+ New datastore**

    :::image type="content" source="../media/7-SelectNewDatastore.png" alt-text="The New datastore option is highlighted." lightbox="../media/7-SelectNewDatastore.png":::  

1. Complete the form to create and register a new datastore.  The form intelligently updates itself based on your selection for Azure storage type and authentication type.  Name the Datastore `computervisionimagesraw`.  For **Datastore type** choose **Azure Blob Storage** and ensure the **From Azure subscription** option is selected.  You will need to reference the values saved previously and select the appropriate **Storage account** and **Blob container** from the respective drop-down.  For **Authentication type**, select **Account key** and provide the value of the Access Key used by your storage account.  The completed form should look like the following:

    :::image type="content" source="../media/7-NewDatastore.png" alt-text="The New datastore option is highlighted." lightbox="../media/7-NewDatastore.png":::  

    When you have verified the form information is correct, select **Create** to create the Datastore.

    If validation fails, see the [storage access and permissions section](https://docs.microsoft.com/azure/machine-learning/how-to-connect-data-ui) to understand where to find the authentication credentials you need to populate this form.

1. You will see the newly created Datastore is now populated in the **Datastores** section of your Azure Machine Learning Studio instance.

    :::image type="content" source="../media/7-DatastoreCreated.png" alt-text="The New Datastore is created." lightbox="../media/7-DatastoreCreated.png"::: 
