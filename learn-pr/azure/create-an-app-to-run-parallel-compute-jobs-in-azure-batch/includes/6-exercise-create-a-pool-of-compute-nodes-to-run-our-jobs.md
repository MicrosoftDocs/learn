To run a batch job, we need to add a *pool* to our Batch account. A pool contains compute nodes, which are the engines that run your Batch job. You specify the number, size, and operating system of nodes at creation time. In this exercise, you'll modify the console app you made in the previous exercise to add a pool to your Batch account.

Your company wants to control the costs of the app, and has asked you to use a fixed number of nodes.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Add settings for your new pool

1. In the Cloud Shell, edit the `Program.cs` file in the editor:

    ```bash
    code Program.cs
    ```

1. Add the following properties to the Program class in **Program.cs**:

    ```csharp
    private const string PoolId = "WinFFmpegPool";
    private const int DedicatedNodeCount = 0;
    private const int LowPriorityNodeCount = 3;
    private const string PoolVMSize = "STANDARD_D2_v2";
    private const string appPackageId = "ffmpeg";
    private const string appPackageVersion = "3.4";
    ```

    The preceding settings are used in the code to create the pool. Looking at each variable, we can explain them as follows:
    - **PoolId**: The name our code uses to reference the pool in other batch client calls.
    - **LowPriorityNodeCount**: You're going to create a pool with three low-priority virtual machines (VMs).
    - **PoolVMSize**: The VMs will be STANDARD_A1_v2, which gives the nodes 1 CPU, 2 GB of RAM, and 10 GB of SSD storage.
    - **appPackageId**: The name of the application package to use on the nodes you create.
    - **appPackageVersion**: The version of the application to use on the nodes you create.

## Update the Main() method to support asynchronous calls

We'll be making several asynchronous calls to cloud services, so the first thing to do is to make `Main` asynchronous. With C# .NET version 7.1 and onwards, async `Main` methods in console applications are supported.

1. Change the console app to allow async method calls, by first adding the `System.Threading.Tasks` library.

    ```csharp
    using System.Threading.Tasks;
    using System.Collections.Generic; // Also add generics to allow the app to use Lists
    ```

1. Next, update the `Main` method signature as follows:

    ```csharp
    static async Task Main(string[] args)
    ```

## Create a pool

1. Add the following new method to the Program class to create a Batch pool. The method:

    - Creates an image-reference object to store the settings for the nodes to be added to the pool.
    - Uses the image reference to create a `VirtualMachineConfiguration` object.
    - Creates an unbound pool using the properties declared previously and the `VirtualMachineConfiguration`.
    - Adds an application package reference to the pool.
    - Creates the pool on Azure.
    - Takes two parameters, the `batchClient` and `PoolId`.

    ```csharp
      private static async Task CreateBatchPoolAsync(BatchClient batchClient, string poolId)
        {
            CloudPool pool = null;
            Console.WriteLine("Creating pool [{0}]...", poolId);
    
            // Create an image reference object to store the settings for the nodes to be added to the pool
            ImageReference imageReference = new ImageReference(
                    publisher: "MicrosoftWindowsServer",
                    offer: "WindowsServer",
                    sku: "2012-R2-Datacenter-smalldisk",
                    version: "latest");
    
            // Use the image reference to create a VirtualMachineConfiguration object
            VirtualMachineConfiguration virtualMachineConfiguration =
            new VirtualMachineConfiguration(
                imageReference: imageReference,
                nodeAgentSkuId: "batch.node.windows amd64");
    
            try
            {
                // Create an unbound pool. No pool is actually created in the Batch service until we call
                // CloudPool.CommitAsync(). This CloudPool instance is therefore considered "unbound," and we can
                // modify its properties.
                pool = batchClient.PoolOperations.CreatePool(
                    poolId: poolId,
                    targetDedicatedComputeNodes: DedicatedNodeCount,
                    targetLowPriorityComputeNodes: LowPriorityNodeCount,
                    virtualMachineSize: PoolVMSize,
                    virtualMachineConfiguration: virtualMachineConfiguration);  
    
                // Specify the application and version to install on the compute nodes
                pool.ApplicationPackageReferences = new List<ApplicationPackageReference>
                {
                    new ApplicationPackageReference
                    {
                    ApplicationId = appPackageId,
                    Version = appPackageVersion
                    }
                };
    
                // Create the pool
                await pool.CommitAsync();
            }
            catch (BatchException be)
            {
                // Accept the specific error code PoolExists as that is expected if the pool already exists
                if (be.RequestInformation?.BatchError?.Code == BatchErrorCodeStrings.PoolExists)
                {
                    Console.WriteLine("The pool [{0}] already existed when we tried to create it", poolId);
                }
                else
                {
                    throw; // Any other exception is unexpected
                }
            }
        }  
    ```

1. Call `CreateBatchPoolAsync`  from our `Main` method. The Main method should now be the following:

    ```csharp
    static async Task Main(string[] args)
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

        // Create the Batch pool, which contains the compute nodes that execute tasks.
        await CreateBatchPoolAsync(batchClient, PoolId);
    }
    ```

## Test the app

1. In the code editor, right-click and select **Save**, then right-click and select **Quit**.

1. In the Cloud Shell, compile and run the app with the following command:

    ```bash
    dotnet run
    ```

1. The app will take a few minutes to run, and you should get the following output:

    ```output
    URL: <your batch account url, Name: <your batch name>, Key: <your batch key>
    Creating pool [WinFFmpegPool]...
    ```

Remember that each node is a VM running Windows 2012 server, with only one CPU and 2 GB of ram. It takes time for the Batch to transfer those Windows VM images from the Azure Virtual Machine Marketplace, create the VM infrastructure and networking, and finally start each node. This is the most time consuming part of most Batch solutions. A typical Batch workflow doesn't clean up the pool and its nodes.
