This procedure demonstrates how to manage access to Azure Storage by uploading files, setting locks, and using shared access tokens.

## Step 1: Upload a File to the Storage Container

1. Go to the storage account and select **Containers**.
2. Open the container created earlier.
3. Click **Upload** and select a file from your computer.
4. Click **Upload**.

## Step 2: Set a Delete Lock on the File

1. Go to the storage account and click **Locks** under **Settings**.
2. Click **+ Add**.
3. Name the lock and select **Delete** as the lock type.
4. Click **OK**.

## Step 3: Upload a File to Azure Files

1. Go to the storage account and select **File shares**.
2. Open the file share created earlier.
3. Click **Upload** and select a file.
4. Click **Upload**.

## Step 4: Create Shared Access Tokens

1. Go to the storage account and click **Shared access signature**.
2. Select permissions and expiration time.
3. Generate SAS tokens using **Key 1** and **Key 2**.
4. Copy the URLs.

## Step 5: Access the File Using SAS Token

1. Paste the SAS URL in a browser or use a tool like `curl` to access the file.

## Step 6: Rotate Key 1 and Test Access

1. Go to the storage account and click **Access keys**.
2. Regenerate **Key 1**.
3. Try accessing the file using the SAS URL generated with Key 1.
4. Notice that access is denied.
