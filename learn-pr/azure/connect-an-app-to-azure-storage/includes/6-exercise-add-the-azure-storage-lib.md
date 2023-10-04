::: zone pivot="csharp"

Let's integrate the Azure Storage Blobs client library into your .NET Core console application. The Azure Storage Blobs client library for .NET is distributed with NuGet. You'll want to add the **Azure.Storage.Blobs** package to your .NET or .NET Core applications.

## Add the Azure Storage NuGet package

1. In Unit 3, you created a .NET Core Console application called *PhotoSharingApp*. In Azure Cloud Shell, `cd` to the **PhotoSharingApp** directory if you aren't already there.

1. Enter the following code to add the **Azure.Storage.Blobs** package to the application:

    ```dotnetcli
    dotnet add package Azure.Storage.Blobs
    ```

1. You'll see some console activity while the client library and all the required dependencies are downloaded. When the download is complete, let's build and run the app again to make sure everything is ready to go. Enter the following command:

    ```dotnetcli
    dotnet run
    ```

1. As before, the return output "Hello World!" appears.

::: zone-end

::: zone pivot="javascript"

Let's integrate the **Azure Storage Blob Client Library for JavaScript** into your application. The Node.js client library is available through the Node Package manager (npm). You'll want to add the **@azure/storage-blob** package to your **packages.json** file.

## Add the Azure Storage package

1. In Azure Cloud Shell, `cd` to the **PhotoSharingApp** directory if you aren't already there.

1. Enter the following code to add the **@azure/storage-blob** package to the application. Make sure to supply the `--save` option so it persists to **packages.json**.

    ```bash
    npm install @azure/storage-blob --save
    ```

1. You'll see some console activity while the client library and all the required dependencies are downloaded. When the download is complete, let's build and run the app again to make sure everything is ready to go. Enter the following command:

    ```bash
    node index.js
    ```

1. As before, the return output "Hello, World!" appears.

::: zone-end

Now that we have the necessary libraries in place, let's look at the common tasks you'll do in your code to work with Azure storage.
