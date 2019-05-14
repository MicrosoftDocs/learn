You've decided to evaluate the AzCopy command as an alternative to using the CLI. As before, you want to move blobs that contain the details for product specifications, and that are more than six months old, to an archive store in a separate blob storage account.

In this exercise, you'll investigate how to use the AzCopy to migrate blobs that haven't changed in the last six months to a separate storage account.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Setup

We'll start by downloading the latest version of AzCopy; currently version 10. The Azure CLI does include AzCopy but it may be an older version. We'll also generate SAS tokens for our storage accounts.

1. In the Cloud Shell window, run the following commands to download and extract the most recent version of *AzCopy* for Linux:

    ```bash
    wget -O azcopy.gz https://aka.ms/downloadazcopy-v10-linux
    gunzip azcopy.gz
    tar xvf azcopy
    ```

<!-- NOTE TO REVIEWER. I wanted to generate SAS tokens from the command line, using the Azure CLI. However, there are currently bugs in the CLI storage commands which cause dates and timestamps to be handled incorrectly (may also be responsible for some of the issues in Exercise 4), so I have used the portal to generate SAS tokens. -->

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Click **All resources**, and select your destination (cool) storage account.

1. On the storage account page, under **Settings**, click **Shared access signature**.

1. On the shared access signature page, click **Generate SAS and connection string**.

1. In the Cloud Shell, create an environment variable for SAS token and assign the value from the portal.

    ```bash
    COOL_SAS_TOKEN="<token from portal>"
    ```

1. Repeat the steps above and assign the hot storage token to **HOT_SAS_TOKEN**.

## Create a container for holding archived blobs

1.  In the Cloud Shell, navigate to the directory containing the *AzCopy* utility:

    ```bash
    cd azcopy_linux_amd64_10.1.0
    ```

2. Create a new container named *azcopy-archive* in the destination storage account. Replace *\<destination storage account>* with the name of the storage account. Replace *\<destination sas token>* with the SAS token of the destination storage account. The SAS token must be enclosed in quotes:

    ```bash
    ./azcopy make https://$COOL_STORAGE_NAME.blob.core.windows.net/azcopy-archive$COOL_SAS_TOKEN
    ```

    Verify that the command responds with the message *Successfully created the resource*.

## Copy blobs to *Cool* storage

1. In the Cloud Shell, run the following command to generate a list of blobs and their last modified times in the source container.

    ```bash
    az storage blob list \
      --account-name $HOT_STORAGE \
      --container-name "specifications" \
      --sas-token "<source sas token>" \
      --query '[].{name:name, properties:properties.lastModified}'
    ```

1. Now that you have a list of blobs and their last modified times, you can use this information to create a script that uses AzCopy to transfer each blob that has a last modified time of more than 6 months ago to *Cool* storage. As an example, run the following command to copy the *wheel_small.gif* file.

    ```bash
    ./azcopy copy https://$HOT_STORAGE_NAME.blob.core.windows.net/specifications/specification01.md$HOT_SAS_TOKEN https://$COOL_STORAGE_NAME.blob.core.windows.net/azcopy-archive$COOL_SAS_TOKEN
    ```

1. The blob being copied is small and the transfer will complete quickly, but imagine that the blob is several gigabytes in size. The transfer will take much longer. Run the following command to view azcopy jobs that have run recently, or are still running.

    ```bash
    ./azcopy jobs list
    ```

    Make a note of the *JobId* for the transfer operation.

1. Run the following command to determine the status of the job. Replace *\<jobid>* with the job ID that you noted in the previous step.

    ```bash
    ./azcopy jobs show <jobid>
    ```

1. Verify that the blob has been copied. Run the following command to list the blobs in the *azcopy-archive* container in the destination storage account.

    ```bash
    ./azcopy list https://$COOL_STORAGE_NAME.blob.core.windows.net/azcopy-archive$COOL_SAS_TOKEN
    ```

## Remove blobs from *Hot* storage

1. Copying a blob to *Cool* storage doesn't remove the blob from *Hot* storage. You must delete these blobs manually. Run the following command to delete the "specification01.md" blob from the source (hot) storage account.

    ```bash
    ./azcopy remove https://$HOT_STORAGE_NAME.blob.core.windows.net/specifications/$HOT_SAS_TOKEN
    ```