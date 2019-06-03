Your manager has asked that you explore the use of managed identities on an existing VM in the companies Azure subscription with the view to them being more widely adopted by the developers of the latest cloud applications.

In the unit, you'll configure a managed identity on a virtual machine. You'll create a system-assigned identity for the VM, and see how an application running in the VM can use this identity to access resources.

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]

## Configure a system-assigned managed identity for an Azure VM

1. Create a new VM.  Give your VM a unique name:

    ```azurecli
    az vm create \
      --name <vm name> \
      --resource-group <rgn>[Sandbox resource group]</rgn>> \
      --image UbuntuLTS
    ```

    > [!NOTE]
    > This process can take a couple of minutes to complete

1. Assign a system-managed identity to the VM:

    ```azurecli
    az vm identity assign \
      --name <vm name> `
      --resource-group <rgn>[Sandbox resource group]</rgn> 
    ```

    This command should return a response similar to that shown below:

    ```JSON
    {
        "systemAssignedIdentity": "a78ddd60-183b-4e27-9f0d-c11a11c417d8",
        "userAssignedIdentities": {}
    }
    ```

    Make a note of the value of the *systemAssignedIdentity* property.

1. Find the subscription ID of your Azure account. You'll need this ID later:

    ```azurecli
    az account show
    ```

    The subscription ID is the first ID property in the JSON document returned by this command.

## Retrieve the system-managed identity in an application

1. Find the public IP address of your VM:

    ```azurecli
    az vm list-ip-addresses \
      --name <vm name> \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      | grep ipAddress
    ```

2. Sign in to your VM:

    ```bash
    ssh <public ip address of VM>
    ```

3. In the VM, install the .NET Core SDK:

    ```bash
    sudo snap install dotnet-sdk --classic
    export PATH=$PATH:/snap/dotnet-sdk/current
    ```

4. Run the following command to download the source code for the sample app for this exercise:

    <!-- TODO: Replace <location of repository> with the name of the repository containing the sample code in GitHub. The source code is currently supplied in the src folder for this module -->

    ```bash
    git clone http://github.com/<location of repository> identity
    ```

5. Move to the `identity/identityapp` folder:

    ```bash
    cd identity/identityapp
    ```

6. Open the `Program.cs` file using the *nano* editor:

    ```bash
    nano Program.cs
    ```

    This file contains the C# source code for the sample app.

7. Examine the `Main` method:

    ```C#
    static void Main()
    {
        AzureServiceTokenProvider azureServiceTokenProvider = new AzureServiceTokenProvider();
        GetResourceGroups(azureServiceTokenProvider).Wait();

        if (azureServiceTokenProvider.PrincipalUsed != null)
        {
            Console.WriteLine($"{Environment.NewLine}Principal used: {azureServiceTokenProvider.PrincipalUsed}");
        }
    }
    ```

    This code performs the following tasks:

    - It creates an `AzureServiveTokenProvider` object, which the application can use to retrieve an access token for a service, based on the identity provided by the application. In this case, the identity is the service principal of the VM.
    - It calls a method named `GetResourceGroups` (defined later) with this `AzureServiveTokenProvider` object.
    - It displays the details of the service principal in the access token that was generated.

8. Scroll down to the `GetResourceGroups` method:

    ```C#
    private static async Task GetResourceGroups(AzureServiceTokenProvider azureServiceTokenProvider)
    {
        Console.WriteLine($"{Environment.NewLine}{Environment.NewLine}Please enter the subscription Id");

        var subscriptionId = Console.ReadLine();

        try
        {
            var serviceCreds = new TokenCredentials(await azureServiceTokenProvider.GetAccessTokenAsync("https://management.azure.com/").ConfigureAwait(false));

            var resourceManagementClient =
                new ResourceManagementClient(serviceCreds) { SubscriptionId = subscriptionId };

            var resourceGroups = await resourceManagementClient.ResourceGroups.ListAsync();

            foreach (var resourceGroup in resourceGroups)
            {
                Console.WriteLine($"Resource group {resourceGroup.Name}");
            }

        }
        catch (Exception exp)
        {
            Console.WriteLine($"Something went wrong: {exp.Message}");
        }
    }
    ```

    The code in the `try` block calls the `GetAccessTokenAsync` method of the `AzureServiceTokenProvider` object to retrieve a token for the Azure Management Service. This service provides access to resource groups. The code then creates a `ResourceManagementClent` object, which invokes the Azure Management Service to retrieve a list of resource groups for a specified subscription. The `ResourceManagementClent` object uses the token to authenticate the request, and verify that the associated id has the authority to view resource groups in this subscription.

## Build and run the sample app

1. Run the following command to build the application:

    ```bash
    dotnet build
    ```

1. Run the application:

    ```bash
    dotnet run
    ```

1. When you're prompted, enter the subscription ID for your Azure account that you noted earlier.

    The application should report the error *Something went wrong: The client 'nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn' with object id 'nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn' does not have authorization to perform action 'Microsoft.Resources/subscriptions/resourcegroups/read' over scope '/subscriptions/nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn'.*

    This occurs because you haven't given the principal ID for the VM the rights to view your resource groups.

    You should also see the details of the principal ID. Although the ID itself isn't included in the output, the application shows the principal was authenticated, together with an AppId and the TenantId of your Azure account.

## Assign Reader access to the service principal

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true)

2. Click **Resource groups**, and then select the <rgn>[Sandbox resource group]</rgn> resource group.

3. Click **Access Control (IAM)**

4. In the **Access control** pane, click **+Add*, and then click **Role assignment**.

5. In the **Add role assignment** pane, specify the following settings, and then click **Save**

    | Property  | Value  |
    |---|---|
    | Role | Reader |
    | Assign access to | Virtual Machine  |
    | Subscription | Concierge subscription |
    | Select |  <vm name> |

6. Return to your VM and run the app again:

    ```bash
    dotnet run
    ```

7. When you're prompted, enter the subscription ID. This time, you should see the message *Resource group <rgn>[Sandbox resource group]</rgn>* appear rather than an error.