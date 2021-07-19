The next step is to share a dataset with Azure Data Share to an organization that Is the data consumer. 

1.	Navigate to the Data share resource to the ‘Overview’ page:

    ![Azure Data Share Overview Page](../media/azure-data-share-overview-page.png)

2.	In the overview page, select ‘Start sharing your data’  and you’ll be redirected to the following page:

    ![Azure Data Share Start Sharing Data](../media/azure-data-share-overview-page-start-share-data.png)

3.	If you want to create a dataset that you want to share  select ‘+Create’, which lands you into this screen:
    
    ![Azure Data Share Create Dataset Share Details ](../media/azure-data-share-overview-page-start-share-data.png)

    There are a couple of settings you need to specify:

    *Share name:*

    Fill out a name for the share you’re going to send to your data consumer

    *Share type:*

    Specify what type of share you want to use which determines how your data will be shared: that is Snapshot or In-Place.

    *Description:*

    Describe the dataset that will be shared and note that this description will be visible to whom you’re sending the data share. 

    *Term of use:*

    Specify the terms of use the data consumer needs to adhere to.
    Consumers will need to consent to the specified terms, in order to accept the share invitation.

    ![Azure Data Share Create Dataset Settings for Details](../media/azure-data-share-overview-page-start-share-data.png)

4.	Then select continue to go to the dataset page

    ![Azure Data Share Add Datasets](../media/azure-data-share-dataset-step-add-dataset.png)

5.	Navigate to ‘Add Datasets’ to add datasets to the data share, which you’ll then be directed to:
 
    ![Azure Data Share Select Dataset Type](../media/azure-data-share-select-dataset-type.png)

    Here you can select the type of dataset that you would like to add. 
    Depending on if you choose Snapshot or In-Place sharing, you’ll see different dataset type possibilities.

6.	In this exercise, we are going to share a dataset from an Azure Data Lake Storage Gen 2 account. 

    Therefore, select Azure Data Lake Storage Gen 2. 

    For using Azure Data Lake Storage Gen 2,  select the subscription the ADLS Gen 2 account is aligned to, the resource group in which you’ve deployed the ADLS Gen 2 as well as the ADLS Gen 2 Storage account that you’ve named the ADLS Gen 2. 

7.	Select ‘Next’. 

    ![Azure Data Share add Azure Data Lake Storage Gen2](../media/azure-data-share-add-dataset-azure-data-lake-storage-gen-2.png)

8.	Select the container in which the files are located in your ADLS Gen 2 of the dataset that you would like to share. You can choose to share the whole container, or if you double-click on the container itself, you can specify the file you’d like to share.

    ![Azure Data Share select container in Azure Data Lake Storage Gen2](../media/azure-data-share-container-azure-data-lake-storage-dataset-share.png)

9.	Once you’ve specified the file you would like to share, click on ‘next’:

    ![Azure Data Share Specification File in Azure Data Lake Storage Gen2](../media/azure-data-share-file-specification-azure-data-lake-storage-gen-2-dataset.png)

    If you are certain that the dataset that you’ve specified can be added as a dataset to your Azure Data Share, then navigate to Add Datasets. 

10.	Once the dataset is added, you’ll be redirected to the following screen:

    ![Azure Data Share Dataset Overview Page](../media/azure-data-share-dataset-added-from-azure-data-lake-storage.png)

11.	Navigate to the recipients tab where you can navigate to add recipients, and specify the email addresses of the data consumer that you want to share the dataset with. 

    ![Azure Data Share Add Recipients Overview](../media/azure-data-share-recipient-added.png)

12.	Select continue to move to the Settings tab. 

    Since we have selected a snapshot type share, the snapshot schedule can be configured in this tab, if you want to provide regular updates of the dataset to your data consumer

    In this tab, you can select a start time and a recurrence interval. It will specify how many times and at what time the dataset will be snapshotted to your data consumer. 

    ![Azure Data Share Dataset Schedule Settings](../media/azure-data-share-time-interval.png)

13.	Navigate to ‘Continue’, which will land you into the Review + Create Tab page, where you can review the package content, settings, recipients, and synchronization settings. 

    ![Azure Data Share Dataset Share Review and Create ](../media/azure-data-share-dataset-review-create.png)

14.	Select ‘Create’ and you have officially created an Azure Data Share that is sent to the recipient that you’ve specified whom is then ready to accept the Data Share. 
