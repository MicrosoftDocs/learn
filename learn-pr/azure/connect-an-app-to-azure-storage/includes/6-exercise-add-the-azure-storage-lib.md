::: zone pivot="csharp"
Let's integrate the Azure Storage Blobs client library into your .NET Core console application.

The Azure Storage Blobs client library for .NET is distributed with NuGet. You'll want to add the **Azure.Storage.Blobs** package to your .NET or .NET Core applications.

## Add the Azure Storage NuGet package

1. Recall in unit 3 that you created a a new .NET Core Console application called *PhotoSharingApp*. In the terminal, `cd` to the **PhotoSharingApp** directory if you aren't already there.

1. Add the **Azure.Storage.Blobs** package to the application.

    ```bash
    dotnet add package Azure.Storage.Blobs
    ```

1. This should result in some console activity while the client library, and all the required dependencies are downloaded. After it's done, go ahead and build and run the app again to make sure everything is ready to go.

    ```bash
    dotnet run
    ```

1. As before, it should output "Hello World!".

::: zone-end

::: zone pivot="javascript"

Let's integrate the **Azure Storage Blob Client Library for JavaScript** into your application.

The client library for Node.js is available through the Node Package manager (npm). You'll want to add the **@azure/storage-blob** package to your **packages.json** file.

## Add the Azure Storage package

1. In Cloud Shell, `cd` to the PhotoSharingApp directory if you aren't already there.

1. Add the **@azure/storage-blob** package to the application. Make sure to supply the `--save` option so it persists to **packages.json**.

    ```bash
    npm install @azure/storage-blob --save
    ```

1. This should result in some console activity while the client library and all the required dependencies are downloaded. After it's done, go ahead and build and run the app again to make sure everything is ready to go.

    ```bash
    node index.js
    ```

1. As before, it should output "Hello, World!"

::: zone-end

Now that we have the necessary libraries in place, let's look at the common tasks you'll do in your code to work with Azure storage.
