To interact with individual blobs in Blob Storage, you use a `BlobClient` object.  You get an `BlobClient` by requesting it with the blob's name from the `BlobContainerClient` the blob is located in.  `BlobClient` has methods to upload, download and manage individual blobs in Blob Storage.

## Getting a BlobClient object

To get an `BlobClient` by name, call the `getBlobClient` methods on the `BlobContainerClient` that contains the blob with the name of the blob.  A `BlobClient` object allows you to interact with the blob &dash;that is upload, download or manage the blob in Blob Storage.

A recommendation when working with large data objects is to use streams instead of in-memory structures like byte arrays or strings. This avoids buffering the full content in memory before sending it to the target.

## Create new blobs

To create a new blob, call one of the `upload` methods on a reference to a blob that doesn't exist in storage. This does two things: creates the blob in storage, and uploads the data.

```java
BlobClient blobClient = blobContainerClient.getBlobClient(name);
blobClient.upload(inputStream, contentLength);
```

## Exercise

Let's finish your application by adding upload and download code, then deploy it to Azure App Service for testing.

### Upload

- To upload a blob, you'll implement the `BlobStorage.save` method.  First, you will get a `BlobClient` object that represents the blob by calling `getBlobClient` on a `BlobContainerClient`. Then, you will use the `upload` method on the `BlobClient` to save the `InputStream` of data passed to this method up to Blob Storage.

    In the editor, in `BlobStorage.java`, replace `save` with the following code.

    ```java
    public void save(String name, InputStream inputStream, long contentLength) {
        BlobClient blobClient = blobContainerClient.getBlobClient(name);
        blobClient.upload(inputStream, contentLength);
    }
    ```

### Download

To download a file use the `openInputStream` method on the `BlobClient`. This method returns an `InputStream`, meaning that your code doesn't need load all of the bytes from Blob Storage at once &mdash; you just need to return a reference to the blob stream which can be used by `IndexBean` to stream the content to the browser.

- Replace `read` with this code and save your work.

    ```java
    public InputStream read(String name) {
        BlobClient blobClient = blobContainerClient.getBlobClient(name);
        return blobClient.openInputStream();
    }
    ```

### Deploy and run in Azure

1. Your application is finished &mdash; let's deploy it and see it work. Create an App Service application and configure it with application settings for your storage account connection string and container name. Get the storage account's connection string with `az storage account show-connection-string`, and set the name of the container to be `files`.

    The application name needs to be globally unique, so you'll need to choose your own name to fill in `<your-unique-app-name>`.

    ```azurecli
    az appservice plan create \
    --name blob-exercise-plan \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --is-linux \
    --sku P1V3 --location westus2
    ```

    ```azurecli
    az webapp create \
    --name <your-unique-app-name> \
    --plan blob-exercise-plan \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --runtime "JBOSSEAP|7.3-java8"
    ```

    ```console
    CONNECTIONSTRING=$(az storage account show-connection-string \
    --name <your-unique-storage-account-name> \
    --output tsv)
    ```

    ```azurecli
    az webapp config appsettings set \
    --name <your-unique-app-name> --resource-group <rgn>[sandbox resource group name]</rgn> \
    --settings STORAGE_CONNECTION_STRING=$CONNECTIONSTRING STORAGE_CONTAINER_NAME=files
    ```

1. Now, you'll deploy your application. The following commands will build the application into `ROOT.war`, and deploy the WAR file to App Service.

    > [!NOTE]
    > Make sure your shell is still in the `mslearn-store-data-in-azure/store-java-ee-application-data-with-azure-blob-storage/start` directory before running the following commands.  You can use `cd mslearn-store-data-in-azure/store-java-ee-application-data-with-azure-blob-storage/start` to change directory to this location. 

    ```bash
    ./mvnw clean package
    ```

    ```azurecli
    az webapp deploy \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name <your-unique-app-name> \
    --src-path target/ROOT.war
    ```

    To see the running application, in a browser, open `https://<your-unique-app-name>.azurewebsites.net`. It should look like the following image.

    :::image type="content" source="../media/7-fileuploader-empty.PNG" alt-text="Screenshot of the FileUploader web application." loc-scope="other"::: <!-- no-loc -->

1. Try uploading and downloading some files to test the application. After you've uploaded a few files, to see the blobs that have been uploaded to the container, run the following code in the shell.

    ```console
    az storage blob list --account-name <your-unique-storage-account-name> --container-name files --query [].{Name:name} --output table
    ```
