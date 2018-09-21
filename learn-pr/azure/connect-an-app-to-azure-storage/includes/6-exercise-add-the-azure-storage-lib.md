::: zone pivot="csharp"
Let's integrate the Azure Storage client library into your .NET Core console application.

The Azure storage client library for .NET is distributed with NuGet. You will want to add the **WindowsAzure.Storage** package to your .NET or .NET Core applications.

## Add the Azure Storage NuGet package

1. In the terminal, `cd` to the PhotoSharingApp directory if you aren't already there.

1. Add the **WindowsAzure.Storage** package to the application.

    ```bash
    dotnet add package WindowsAzure.Storage
    ```

1. This should result in some console activity while the client library and all the required dependencies are downloaded. Once it's done, go ahead and build and run the app again to make sure everything is ready to go.

    ```bash
    dotnet run
    ```

1. As before, it should output "Hello World!".

::: zone-end

::: zone pivot="javascript"

Let's integrate the **Microsoft Azure Storage Client Library for Node.js and JavaScript** into your application.

The client library for Node.js is available through the Node Package manager (NPM). You will want to add the **azure-storage** package to your **packages.json** file.

> [!NOTE]
> The **Microsoft Azure Storage Client Library for Node.js and JavaScript** is intended for server applications. If you are doing client-side JavaScript, you will want to use the **Azure Storage Client Library for JavaScript**, which provides the same functionality but is tailored to running in a browser.

## Add the Azure Storage package

1. In Cloud Shell, `cd` to the PhotoSharingApp directory if you aren't already there.

1. Add the **azure-storage** package to the application. Make sure to supply the `--save` option so it persists to **packages.json**.

    ```bash
    npm install azure-storage --save
    ```

1. This should result in some console activity while the client library and all the required dependencies are downloaded. Once it's done, go ahead and build and run the app again to make sure everything is ready to go.

    ```bash
    node index.js
    ```

1. As before, it should output "Hello, World!"

::: zone-end

Now that we have the necessary libraries in place, let's look at the common tasks you'll do in your code to work with Azure storage.
