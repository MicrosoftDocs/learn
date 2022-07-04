In this exercise, we'll introduce using *Azure Data Migration Services* (***DMS***) to migrate to an Azure Cosmos DB API for MongoDB account. 

> [!NOTE]
> To complete this exercise, you'll need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at ***https://azure.microsoft.com/free***. You cannot use a Microsoft Learn sandbox subscription for this exercise..

## Prerequisites for this exercise

You'll need to complete some steps before we can create our DMS migration project and start our migration. Some steps will be performed on your local client machine others will be prerequisites on the Azure portal. Logically if you already completed some of these prerequisites, just move to the next step.

### Download and setup Visual Studio Code and Visual Studio Code Azure CLI tools extension

Azure DMS has three different modes to select your source for the migration, Standard mode where you input your MongoDB server address, port and sign-in information, connection string mode, and data from Azure storage mode. For this lab, we'll use a MongoDB backup so we'll choose the data from Azure storage mode.

> [!NOTE]
> While we will use a MongoDB Backup for this migration exercise, a similar set of steps will be taken to migrate from a live MongoDB database. The main difference will be the options we will input when selecting the source mode.

Let's prepare our environment to move the backup to the Azure Storage account. In this exercise, we'll use Visual Studio Code to copy the files to the Azure Storage account. If you've previously completed any of these steps, just move to the next step.

1. Download and setup [Visual Studio Code][/products/visual-studio-code/] in your client environment.

    1. [Download][/download] Visual Studio Code.
    1. [Install/Setup][/docs/setup/setup-overview] Visual Studio Code.

1. Once Visual Studio Code has been installed on your client, let's go ahead and open it. The Bash script we'll run need to connect and run Azure CLI commands, so we'll need to add the Azure Extensions to your Visual Studio Code environment. Let's search for Azure or cloud extensions in the VS Code Extensions view (**Ctrl**+**Shift**+**X**) and type ***Azure CLI Tools***. If the extension is already installed, go to the next section.

1. Select **Azure CLI Tools** from the list and select **Install** on the *Extension: Azure CLI Tools* tab.

    > [![Diagram showing the Visual Studio Code Azure CLI Tools Extension installation tab](../media/6-visual-studio-code-azure-cli-extensions.png)](../media/6-visual-studio-code-azure-cli-extensions.png#lightbox)

1. Once the Install icon in the tab changes for a *Disable* and *Uninstall* button, you can close the tab since that means the extension is now installed.

### Download the GitHub repository using Visual Studio

Let's put Visual studio Code to some good use, first, we need to clone the lab repo.

1. Once Visual Studio Code has been installed on your client, let's go ahead and open it.
1. Press ***Ctrl***+***Shift***+***P*** to *Show All Commands*.
1. On the text box that opens on the top, type **Git:Clone** to clone the repository.
1. Input the git URL

    > ```bash
    > https://github.com/MicrosoftLearning/mslearn-cosmosdb.git
    > ```

    1. Choose a folder to copy the repository to. It might be a good idea to create a new empty directory for this clone, that you can easily find later.
    1. Once it has completed downloading the repository it will ask ***Would you like to open the clone repository?***, select the **Open** button.

    > [!NOTE]
    > If you did not selected the ***Open*** button, select ***File*** -> ***Open folder*** and select the folder where you cloned the repo to open it.

    1. If a dialog pops-up asking if you trust the authors, just check the checkbox, and select ***Yes, I trust the authors***.
    1. You can **x** out of any other pop-ups that might have appeared on the lower right hand side.
    1. You can close the ***Get Started*** tab if it's opened.

You should have now installed Visual Studio Code, and cloned the lab repo. Time to run some setup scripts.

> [!NOTE]
> The Bash script in the following section will use the **unzip** command so make sure it's installed and mapped in your client machine, if you have not install it, do so now and restart Visual Studio Code.

### Download and install AzCopy

There are many ways we can get our Backup files to the Azure Blob Storage Account we'll create in this lab. For this exercise, we'll use [AzCopy][/azure/storage/common/storage-use-azcopy] to copy those files from our client to the Cloud.

- [Download][/azure/storage/common/storage-use-azcopy#download-azcopy] the AzCopy program to your client.
- Use your favorite decompressing tool to expand the compressed file.
- Move the **azcopy.exe** file (or **azcopy** under Linux) to the ***mslearn-cosmosdb*** directory created when we cloned the repo in the previous section. The *init.sh* script will expect to find the *azcopy* file in that directory.

### Create your Azure Cosmos DB account, Azure Storage Account, and upload the backup files to Azure storage

We'll run a script that will create the Azure storage and Azure Cosmos DB account. The script will then copy the database backup files from the client to our Azure blob storage account.

1. Open Visual Studio Code and open the cloned repository folder if not already opened. 
1. Right click on the **api-for-mongo-db** folder and select ***Open in integrated Terminal***.

    > [![Diagram showing the Visual Studio Code integrated terminal](../media/6-visual-studio-code-integrated-terminal.png)](../media/6-visual-studio-code-integrated-terminal.png#lightbox)

1. The terminal might have opened by default in PowerShell mode, if so let's change it to Bash. On the upper right hand side of the terminal, select the pulldown to the right of ***`pwsh +`*** and select **Git Bash** from the menu.

    > [![Diagram showing the Visual Studio Code bash terminal](../media/6-visual-studio-code-select-bash.png)](../media/6-visual-studio-code-select-bash.png#lightbox)

1. In Visual Studio Code Bash terminal, copy and paste the following commands.

    1. If you already have a resource group you want to use, replace the string ***YOURRESOURCEGROUPHERE*** below for the name of your resource group. If you want the script to create a resource group for you, use the next step. *Note that this script will open a browser window to sign in to your Azure account.*

    > ```bash
    > GitRepositoryRoot=$(pwd)
    > # Open a browser window to login to Azure, once you are logged in,
    > # close the browser window and continue running the script.
    > az login
    >
    > # Create an Azure Cosmos DB API for MongoDB account and add the customer collection
    > # replace YOURRESOURCGROUPNAMEHERE with your Resource Group Name 
    > bash $GitRepositoryRoot/api-for-mongodb/03-migrating-to-azure-cosmos-db-using-dms/init.sh -r YOURRESOURCEGROUPNAMEHERE
    > ```

    1. If you want the script to create a resource group for you, run the following script. *Note that this script will open a browser window to sign in to your Azure account.*

    > ```bash
    > GitRepositoryRoot=$(pwd)
    > cd $GitRepositoryRoot/api-for-mongodb/03-migrating-to-azure-cosmos-db-using-dms
    > # Open a browser window to login to Azure, once you are logged in,
    > # close the browser window and continue running the script.
    > az login
    >
    > # Create an Azure Cosmos DB API for MongoDB account and add the customer collection
    > bash $GitRepositoryRoot/api-for-mongodb/03-migrating-to-azure-cosmos-db-using-dms/init.sh
    > ```

    > [!NOTE]
    > This bash script will create the Azure Cosmos DB API for MongoDB account, create an Azure blob storage and copy the MongoDB backup into the blob storage. ***It can take 5-10 minutes to create these accounts*** so it might be a good time to get a cup of coffee or tea.

[/products/visual-studio-code/]: https://azure.microsoft.com/products/visual-studio-code/
[/download]: https://code.visualstudio.com/download
[/docs/setup/setup-overview]: https://code.visualstudio.com/docs/setup/setup-overview
[/azure/storage/common/storage-use-azcopy]: https://docs.microsoft.com/azure/storage/common/storage-use-azcopy
[/azure/storage/common/storage-use-azcopy#download-azcopy]: https://docs.microsoft.com/azure/storage/common/storage-use-azcopy#download-azcopy