[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

The Azure Batch client API allows you to programmatically control creating, executing, and monitoring all the resources in a Batch account.

In this exercise, we'll create a new console application and connect it to the Azure Batch account we created earlier using the `Microsoft.Azure.Batch NuGet` package. To test that this setup is working, we'll query the Batch account to check that **ffmpeg** has been added correctly to the account.

## Create a local console application

Use Cloud Shell to complete the remaining exercises in this module.

1. Launch Cloud Shell in the Azure portal by selecting the **Cloud Shell** icon in the top menu of the portal.
1. Use the drop-down at the top of the Cloud Shell window to select **Bash**.  
1. Run the following commands in the Cloud Shell to make a new directory for your app:

    ```bash
    mkdir cutifypets
    cd cutifypets
    ```

1. Create new .NET Core console application with the `dotnet new` command, then run it:

    ```bash
    dotnet new console
    dotnet run
    ```

    If you've successfully created the console app, you should see the following printed to the console:

    ```output
    Hello World!
    ```  

## Set up connection details for the application

1. In the Cloud Shell, add the Azure Batch NuGet package with the following `dotnet add package` command:

    ```bash
    dotnet add package Microsoft.Azure.Batch
    ```

1. Run the following command in the Cloud Shell to save your resource group to an environment variable so we can use it in subsequent commands. Replace `[YOUR RESOURCE GROUP]` with the name of the resource group you used when creating the Batch account.

    ```bash
    export RESOURCE_GROUP=[YOUR RESOURCE GROUP]
    ```

1. Use the following commands to store the batch account credentials in environment variables that can be accessed via the console app:

    ```bash
    export BATCH_URL='https://'$(az batch account list --query "[?contains(name,'cuti')].accountEndpoint" --output tsv)
    export BATCH_NAME=$(az batch account list --query "[?contains(name,'cuti')].name" --output tsv)
    export BATCH_KEY=$(az batch account keys list --name $BATCH_NAME --query primary -o tsv --resource-group $RESOURCE_GROUP)
    ```

1. Use the following command to check that the stored values are correct:

    ```bash
    echo 'URL='$BATCH_URL 'NAME='$BATCH_NAME 'KEY='$BATCH_KEY
    ```

    Make sure you have these values set. If you have to restart the Cloud Shell at any point, you'll need to set these variables again.

1. Use the following code to edit the `Program.cs` file in the editor:

    ```bash
    code Program.cs
    ```

1. Replace all the existing code with the following:

    ```csharp
    namespace cutifypets
    {
        using System;
        using Microsoft.Azure.Batch;
        using Microsoft.Azure.Batch.Auth;
        using Microsoft.Azure.Batch.Common;

        class Program
        {
            private const string envVarBatchURI = "BATCH_URL";
            private const string envVarBatchName = "BATCH_NAME";
            private const string envVarKey = "BATCH_KEY";

            private static string batchAccountName;
            private static string batchAccountUrl;
            private static string batchAccountKey;

            static void Main(string[] args)
            {
                // Read the environment variables to allow the app to connect to the Azure Batch account
                batchAccountUrl = Environment.GetEnvironmentVariable(envVarBatchURI);
                batchAccountName = Environment.GetEnvironmentVariable(envVarBatchName);
                batchAccountKey = Environment.GetEnvironmentVariable(envVarKey);

                // Show the user the batch the app is attaching to
                Console.WriteLine("URL: {0}, Name: {1}, Key: {2}", batchAccountUrl, batchAccountName, batchAccountKey);

                // The batch client requires a BatchSharedKeyCredentials object to open a connection
                var sharedKeyCredentials = new BatchSharedKeyCredentials(batchAccountUrl, batchAccountName, batchAccountKey);
                var batchClient = BatchClient.Open(sharedKeyCredentials);

                // The batchClient object can reference all the application packages, and get a summary of their details
                foreach (var app in batchClient.ApplicationOperations.ListApplicationSummaries() ) {
                    // For each application package, print to the console their name and version number
                    Console.WriteLine("Installed app: {0}({1})", app.Id, app.Versions[0]);
                }
            }
        }
    }
    ```

    Read through the preceding code and comments. The console app imports the `Microsoft.Azure.Batch` client library to add Azure Batch features. Using the environment variables you stored in the previous steps, the app opens a connection to the Batch account you created in the Azure portal. The batch client can then query properties of the services in the batch. The example code iterates through the application packages, showing the details of the ffmpeg app you uploaded.

1. In the code editor, right-click and select **Save**, then right-click and select **Quit**.

1. In the Cloud Shell, compile and run the app with the following command:

    ```bash
    dotnet run
    ```

1. Running the app writes the application package to the console. You should get the following result:

    ```output
    Installed app: ffmpeg(3.4)
    ```

Congratulations! You've successfully integrated Azure Batch and Azure Storage libraries into your app to retrieve a list of installed applications in the Batch account. The next step is to create a pool of compute nodes to run our jobs.
