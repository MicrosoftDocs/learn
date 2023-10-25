The typical workflow for apps that use Azure Blob storage is as follows:

1. **Retrieve configuration**: At startup, load the storage account configuration, typically a storage account connection string.

1. **Initialize client**: To initialize the Azure Storage client library, use the connection string. This initialization creates the objects that the app uses to work with the Blob storage API.

1. **Use**: To operate on containers and blobs, make API calls by using the client library.

## Configure your connection string

Before you run your app, get the connection string for the storage account you use. You can use any Azure management interface to get it, including the Azure portal, the Azure CLI, and Azure PowerShell. When you set up the web app to run your code near the end of this module, use the Azure CLI to get the connection string for the storage account that you created earlier.

Storage account connection strings include the account key. Consider the account key a secret. Store it securely. Here, you store the connection string in an App Service app setting. App Service app settings are a secure place for app secrets. This design doesn't support local development and isn't a robust, end-to-end solution on its own.

> [!WARNING]
> **Do not place storage account keys in code or in unprotected configuration files.** Storage account keys enable full access to your storage account. Leaking a key can result in unrecoverable damage and large bills. For storage guidance and advice about how to recover from a leaked key, see the *Further Reading* section at the end of this module.

## Initialize the Blob storage object model

::: zone pivot="csharp"

In the Azure Storage SDK for .NET, the standard pattern for using Blob storage is as follows:

1. Instantiate a new `BlobServiceClient` object and provide the connection string to your storage account.

1. To get a `BlobContainerClient`, call `GetBlobContainerClient` on the `BlobServiceClient` with the name of the container you want to interact with or create.

In code, these steps look like this.

```csharp
BlobServiceClient blobServiceClient = new BlobServiceClient(storageConfig.ConnectionString);
BlobContainerClient containerClient = blobServiceClient.GetBlobContainerClient(storageConfig.FileContainerName);
```

None of this initialization code makes calls over the network. This fact means that some exceptions that occur because of incorrect information aren't thrown until later. For example, if an incorrectly formatted connection string is supplied to the constructor of the `BlobServiceClient` class, an exception is thrown immediately. However, if the connection string points to a storage account that doesn't exist, no exception is thrown until you attempt an operation against the storage account.

::: zone-end

::: zone pivot="java"

In the Azure Storage SDK for Java, the standard pattern for using Blob Storage consists of the following steps:

1. Build a `BlobServiceClient` by instantiating a new `BlobServiceClientBuilder` object using the connection string to your storage account.

1. Get a `BlobContainerClient` by calling the `getBlobContainerClient` method on the `BlobServiceClient`with the name of the container you want to interact with or create.

In code, these steps look like this.

```java
BlobServiceClient blobServiceClient = BlobServiceClientBuilder()
    .connectionString(connectionString)
    .buildClient();
BlobContainerClient containerClient = blobServiceClient.getBlobContainerClient(containerName);
```

None of this initialization code makes calls over the network. This fact means that some exceptions that occur because of incorrect information aren't thrown until later. For example, if an incorrectly formatted connection string is supplied to the `BlobServiceClientBuilder`, an exception is thrown immediately. However, if the connection string points to a storage account that doesn't exist, no exception is thrown until you attempt an operation against the storage account.

::: zone-end

## Create containers at startup

::: zone pivot="csharp"

To create a container when your app starts or when the app first tries to use a container, call `CreateIfNotExistsAsync` on a `BlobContainerClient`.

`CreateIfNotExistsAsync` doesn't throw an exception if the container already exists, but it does make a network call to Azure Blob Storage. Call it once during initialization, not every time you try to use a container.

::: zone-end

::: zone pivot="java"

To create a container when your app starts or when it first tries to use it, call `exists` on a `BlobContainerClient` to check whether a container already exists. If it doesn't exist, then call `create`. Call it once during initialization, not every time you try to use a container.

::: zone-end

## Exercise

::: zone pivot="csharp"

### Clone and explore the unfinished app

1. First, clone the starter app from GitHub. To get a copy of the source code and open it in the editor, run the following commands in Azure Shell CLI:

    ```console
    git clone https://github.com/MicrosoftDocs/mslearn-store-data-in-azure.git
    cd mslearn-store-data-in-azure/store-app-data-with-azure-blob-storage/src/start
    code .
    ```

1. In the editor, open the file *Controllers/FilesController.cs*. There's no work to do here, but have a quick look at what the app does.

    This controller implements an API with three actions:

    - **Index**: (`GET /api/Files`) returns a list of URLs, one for each file that's been uploaded. The app front end calls this method to build a list of hyperlinks to the uploaded files.
    - **Upload**: (`POST /api/Files`) receives an uploaded file and saves it.
    - **Download**: (`GET /api/Files/{filename}`) downloads an individual file by its name.

    To do its work, each method uses an `IStorage` instance called `storage`. There's an incomplete implementation of `IStorage` in *Models/BlobStorage.cs* to fill in.

### Add the NuGet package

- Add a reference to the Azure Storage SDK. Run the following commands in Azure Shell CLI:

    ```console
    dotnet add package Azure.Storage.Blobs
    dotnet restore
    ```

    This command ensures you're using the newest version of the Blob Storage client library.

### Configure

The configuration values you need are the storage-account connection string and the name of the container the app uses to store files. In this module, you're only going to run the app in Azure App Service. Follow App Service best practice and store the values in App Service app settings. You do that when you create the App Service instance. There's nothing you need to do at the moment.

When it comes to *using* the configuration, the starter app includes the plumbing you need. The `IOptions<AzureStorageConfig>` constructor parameter in `BlobStorage` has two properties: the storage-account connection string and the name of the container your app uses to store blobs. There's code in the `ConfigureServices` method of `Startup.cs` that loads the values from configuration when the app starts.

### Initialize

1. In the editor, open *Models/BlobStorage.cs*. At the top of the file, add the following `using` statements to prepare it for the code that you're going to add.

    ```csharp
    using Azure;
    using Azure.Storage.Blobs;
    using Azure.Storage.Blobs.Models;
    ```

1. Locate the `Initialize` method. Your app calls this method when it uses `BlobStorage` for the first time. If you're curious, you can look at `ConfigureServices` in *Startup.cs* to see how call is done.

    `Initialize` is where you want to create your container if it doesn't already exist. Replace the current implementation of `Initialize` with the following code, and save your work using **CTRL**+**S**.

    ```csharp
    public Task Initialize()
    {
        BlobServiceClient blobServiceClient = new BlobServiceClient(storageConfig.ConnectionString);
        BlobContainerClient containerClient = blobServiceClient.GetBlobContainerClient(storageConfig.FileContainerName);
        return containerClient.CreateIfNotExistsAsync();
    }
    ```

::: zone-end

::: zone pivot="java"

### Clone and explore the unfinished app

1. First, clone the starter app from GitHub. To get a copy of the source code and open it in the editor, run the following commands in Azure Shell CLI:

    ```console
    git clone https://github.com/MicrosoftDocs/mslearn-store-data-in-azure.git
    cd mslearn-store-data-in-azure/store-java-ee-application-data-with-azure-blob-storage/start
    code .
    ```

1. In the editor, open the file *src/main/java/com/microsoft/azure/samples/jsf/IndexBean.java*. There's no work to do here, but have a quick look at what the app does.

    This request scoped bean implements three actions that are used by *src/main/webapp/index.xhtml* Java Server Faces (JSF) page:

    - **listFileNames**: returns a list of file names, one for each file that's been uploaded. The *index.xhtml* page calls this method to build a list of hyperlinks to the uploaded files.
    - **upload**: receives an uploaded file and saves it. The file content and metadata is injected into the `uploadedFile` property by the JSF framework.
    - **download**: downloads an individual file by its name.

    To do its work, each method uses a `Storage` instance called `storage`. There's an incomplete implementation of `Storage` in *src/main/java/com/microsoft/azure/samples/service/BlobStorage.java* to fill in.

### Add the Azure Storage SDK for Java reference

We recommend using the Azure BOM to add Azure client libraries to the project. It provides a simple and elegant way to orchestrate using multiple Azure client libraries while ensuring minimal dependency conflicts.

1. In the editor, open the file *pom.xml*.

1. To add Azure BOM to the project, add the following `dependencyManagement` section under the `project` xml tag.

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

1. To add Azure Storage SDK for Java, add the following `dependency` to the `project/dependencies` xml section.

    ```xml
    <dependency>
      <groupId>com.azure</groupId>
      <artifactId>azure-storage-blob</artifactId>
    </dependency>
    ```

### Configure

The configuration values you need are the storage account connection string and the name of the container the app uses to store files. In this module, you're only going to run the app in Azure App Service. Follow App Service best practice and store the values in App Service app settings. You do that when we create the App Service instance. There's nothing you need to do at the moment.

When it comes to *using* the configuration, the App Service app settings are passed as environment variables to the app code. You read them in the initialization code.

### Initialize

1. In the editor, open *src/main/java/com/microsoft/azure/samples/service/BlobStorage.java*. At the top of the file, add the following `import` statements to prepare it for the code you're going to add.

    ```java
    import java.util.stream.Collectors;

    import com.azure.storage.blob.BlobClient;
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
    > Azure clients are stateless and thread-safe. It is recommended to cache their instances where applicable. For example, the app you're working on uses a single container with a constant name, therefore it's best to cache it in app lifetime scope. `BlobStorage` is annotated with `@Singleton` therefore, storing the `BlobContainerClient` reference in its field is recommended.

1. Locate the `init` method with `@PostConstruct` annotation. Your app calls this method after the `BlobStorage` instance is created and before it's used for the first time.

    `init` is where to create your container if it doesn't already exist. Replace the current implementation of `init` with the following code, and save your work.

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

::: zone-end
