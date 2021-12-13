The following is the typical workflow for applications that use Azure Blob storage:

1. **Retrieve configuration**: At startup, load the storage account configuration. This is typically a storage account connection string.

1. **Initialize client**: To initialize the Azure Storage client library, use the connection string. This creates the objects the application will use to work with the Blob storage API.

1. **Use**: To operate on containers and blobs, make API calls with the client library.

## Configure your connection string

Before running your application, you'll need the connection string for the storage account you will use. You can use any Azure management interface to get it, including the Azure portal, the Azure CLI, or Azure PowerShell. When you set up the web application to run your code near the end of this module, you'll use the Azure CLI to get the connection string for the storage account you created earlier.

Storage account connection strings include the account key. The account key is considered a secret and should be stored securely. Here, you will store the connection string in an App Service application setting. App Service application settings are a secure place for application secrets, but this design does not support local development and is not a robust, end-to-end solution on its own.

> [!WARNING]
> **Do not place storage account keys in code or in unprotected configuration files.** Storage account keys enable full access to your storage account. Leaking a key can result in unrecoverable damage and large bills. For storage guidance and advice about how to recover from a leaked key, at the end of this module, see the *Further Reading* section.

## Initialize the Blob storage object model

In the Azure Storage SDK for Java, the standard pattern for using Blob Storage consists of the following steps:

1. Instantiate a new `BlobServiceClientBuilder` object and provide the connection string to your storage account and build `BlobServiceClient`.

1. To get a `BlobContainerClient`, call `getBlobContainerClient` on the `BlobServiceClient` with the name of the container you want to interact with or create.

In code, these steps look like this.

```java
BlobServiceClient blobServiceClient = BlobServiceClientBuilder()
    .connectionString(connectionString)
    .buildClient();
BlobContainerClient containerClient = blobServiceClient.getBlobContainerClient(containerName);
```

None of this initialization code makes calls over the network. This means that some exceptions that occur because of incorrect information won't be thrown until later. For example, if an incorrectly formatted connection string is supplied to the `BlobServiceClientBuilder`, an exception will throw an exception immediately.  However, if the connection string points to a storage account that does not exist, no exception will be thrown until you attempt an operation against the storage account.

## Create containers at startup

To create a container when your application starts or when it first tries to use it, call `exists` on a `BlobContainerClient` to check whether container already exist, if it doesn't then call `create`. Call it once during initialization; not every time you try to use a container.

## Exercise

### Clone and explore the unfinished app

1. First, let's clone the starter application from GitHub. In the Azure Shell CLI, to get a copy of the source code and open it in the editor, run the following command.

    ```console
    git clone https://github.com/kasobol-msft/mslearn-store-data-in-azure.git
    # TODO git clone https://github.com/MicrosoftDocs/mslearn-store-data-in-azure.git
    cd mslearn-store-data-in-azure/store-java-ee-application-data-with-azure-blob-storage/start
    code .
    ```

1. In the editor, open the file `src/main/java/com/microsoft/azure/samples/jsf/IndexBean.java`. There's no work to do here, but you're going to have a quick look at what the application does.

    This request scoped bean implements three actions that are used by `src/main/webapp/index.xhtml` JSF (Java Server Faces) page:

    - **listFileNames**: returns a list of file names, one for each file that's been uploaded. The `index.xhtml` page calls this method to build a list of hyperlinks to the uploaded files.
    - **upload**: receives an uploaded file content and saves it. The file content and metadata is injected into `uploadedFile` property by JSF framework.
    - **download**: downloads an individual file by its name.

    To do its work, each method uses a `Storage` instance called `storage`. There is an incomplete implementation of `Storage` in `src/main/java/com/microsoft/azure/samples/service/BlobStorage.java` that you're going to fill in.

### Add the Azure Storage SDK for Java reference

The recommended way of adding Azure client libraries to the project is to utilize BOM. It provides a simple and elegant way to orchestrate using multiple Azure client libraries while ensuring minimal dependency conflicts.

1. In the editor, open the file `pom.xml`.

1. To add Azure BOM to the project add the following `dependencyManagement` section under the `project` xml tag.

    ```xml
    <dependencyManagement>
      <dependencies>
        <dependency>
          <groupId>com.azure</groupId>
          <artifactId>azure-sdk-bom</artifactId>
          <version>1.0.6</version>
          <type>pom</type>
          <scope>import</scope>
        </dependency>
      </dependencies>
    </dependencyManagement>
    ```

1. To add Azure Storage SDK for Java add the following `dependency` to `project/dependencies` xml section.

    ```xml
    <dependency>
      <groupId>com.azure</groupId>
      <artifactId>azure-storage-blob</artifactId>
    </dependency>
    ```

### Configure

The configuration values we need are the storage account connection string and the name of the container the application will use to store files. In this module, you're only going to run the application in Azure App Service, so you'll follow App Service best practice and store the values in App Service application settings. You'll do that when we create the App Service instance, so there's nothing you need to do at the moment.

When it comes to *using* the configuration, the App Service application settings are passed as environment variables to the application code. You'll read them in the initialization code.

### Initialize

1. In the editor, open `src/main/java/com/microsoft/azure/samples/service/BlobStorage.java`. To the top of the file, add the following `import` statements to prepare it for the code you're going to add during the exercise.

    ```java
    import java.util.stream.Collectors;

    import com.azure.storage.blob.BlobContainerClient;
    import com.azure.storage.blob.BlobServiceClient;
    import com.azure.storage.blob.BlobServiceClientBuilder;
    import com.azure.storage.blob.models.BlobItem;
    ```

1. Add a class property in the `BlobStorage` class to hold the `BlobContainerClient` reference.

    ```java
    private BlobContainerClient blobContainerClient;
    ```

> [!TIP]
> Azure clients are stateless and thread-safe. It is recommended to cache their instances where applicable. For example, the application you're working on uses single container with constant name, therefore it's best to cache it in application lifetime scope. `BlobStorage` is annotated with `@Singleton` therefore storing `BlobContainerClient` reference in its field is recommended.

1. Locate the `init` method with `@PostConstruct` annotation. Your application will call this method after `BlobStorage` instance is created and before it is used for the first time.

    `init` is where you want to create your container if it doesn't already exist. Replace the current implementation of `init` with the following code, and save your work.

    ```java
    @PostConstruct
    private void init() {
        String connectionString = System.getenv("STORAGE_CONNECTION_STRING");
        String containerName = System.getenv("STORAGE_CONTAINER_NAME");
        BlobServiceClient blobServiceClient = new BlobServiceClientBuilder()
            .connectionString(connectionString)
            .buildClient();
        blobContainerClient = blobServiceClient.getBlobContainerClient(containerName);
        if (!blobContainerClient.exists()) {
            blobContainerClient.create();
        }
    }
    ```
