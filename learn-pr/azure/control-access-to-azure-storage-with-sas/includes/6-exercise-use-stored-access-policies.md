Instead of creating SASs individually, each with its own access permissions and expiration dates, you can associate them with a stored access policy. Changing the policy affects all the SASs associated with it.

You now know there's a better way to create and manage your company's SASs. You can update your new test pages to use stored access policies.

In this exercise, you update your web app to create SASs with stored access policies. Then you use Azure CLI commands to change the policies and test that access is revoked.

## Add a method to create stored access policies

1. In Azure Cloud Shell, edit the **PatientRecordController.cs** file.

    ```bash
    code ~/sas/Controllers/PatientRecordController.cs
    ```

1. At the bottom of the class, under the `GetBlobSas` method, write a method to create stored access policies.

    ```csharp
    // Use a stored access policy for the SAS
    private void CreateStoredAccessPolicy()
    {
        // Create a stored access policy for our blobs
        BlobSignedIdentifier identifier = new BlobSignedIdentifier
        {
            Id = _storedPolicyID,
            AccessPolicy = new BlobAccessPolicy
            {
                ExpiresOn = DateTimeOffset.UtcNow.AddHours(1),
                Permissions = "r"
            }
        };
    
        _container.SetAccessPolicy(permissions: new BlobSignedIdentifier[] { identifier });
    } 
    ```

1. This method uses a global variable for the access policy identifier. Add this variable at the top of the class under the declaration for the `BlobContainerClient` variable named `_container`.

    ```csharp
    private String _storedPolicyID = "patient-images-policy";
    ```

1. The stored access policy is used for each SAS token that's generated, so call the new method on the class instantiation. Add a call at the bottom of the method.

    ```csharp
    public PatientRecordsController(ILogger<PatientRecordsController> logger, IConfiguration iconfiguration)
    {
        _logger = logger;
        _iconfiguration = iconfiguration; 
        _container = new BlobContainerClient(
            _iconfiguration.GetValue<string>("StorageAccount:ConnectionString"),
            _iconfiguration.GetValue<string>("StorageAccount:Container")
        );
        CreateStoredAccessPolicy();
    }
    ```

1. Now `GetBlobSas` can be simplified to use the access policy. Change the method to use it.

   ```csharp
    // Build a SAS token for the given blob
    private string GetBlobSas()
    {
        // Create a user SAS that only allows reading for a minute
        BlobSasBuilder sas = new BlobSasBuilder 
        {
            Identifier = _storedPolicyID,
            BlobContainerName = _iconfiguration.GetValue<string>("StorageAccount:Container")
        };
    
        // Use the shared key to access the blob
        var storageSharedKeyCredential = new StorageSharedKeyCredential(
            _iconfiguration.GetValue<string>("StorageAccount:AccountName"),
            _iconfiguration.GetValue<string>("StorageAccount:AccountKey")
        );
    
        return '?' + sas.ToSasQueryParameters(storageSharedKeyCredential).ToString();
    }
    ```

1. The code that handles the SAS token requests needs a small fix to call the updated method.

    ```csharp
    // GET PatientRecord/patient-nnnnnn/secure
    [HttpGet("{Name}/{secure}")]
    public PatientRecord Get(string name, string flag)
    {
        BlobClient blob = _container.GetBlobClient(name);
        return new PatientRecord { name=blob.Name, imageURI=blob.Uri.AbsoluteUri, sasToken=GetBlobSas() };
    }
    ```

1. Save your code changes by selecting <kbd>Ctrl</kbd>+<kbd>S</kbd> and then selecting <kbd>Ctrl</kbd>+<kbd>Q</kbd>.

### Test the new code

1. In Cloud Shell, build the app.

    ```bash
    cd ~/sas/
    dotnet build
    ```

1. In case the port has closed since you finished the previous exercise, run the `curl` command to open it again.

    ```bash
    curl -X POST http://localhost:8888/openPort/8000;
    ```

1. Run the update web app.

    ```bash
    dotnet run
    ```

1. Go to the web app's URL, and make sure it ends in a slash (/).

1. On the home page, select **Get all patients**.

1. Copy an image filename. An example is **patient-32589.jpg**.

1. Select the **External companies** menu link at the top of the page.

1. Paste the image filename into the **Patient image filename** field.

1. Select **Get Key** to populate the SAS token.

1. Select **View scan** to view the image.

### Edit the stored access policy

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true) using the same credentials you used to activate the sandbox.

1. In the Azure portal resource menu, select **All resources**.

1. In the list of resources, select the **medical records** storage account.

1. On the Overview pane, select **Containers**, and then select **patient-images**.

1. On the patient images menu, under **Settings**, select **Access policy**.

1. Notice that your web app created a **patient-images-policy** stored access policy.

1. On the right, select the **...** menu, and then select **Edit** from the pop-up menu.

1. In the Edit policy, change the **Permission** from **read** to **list** and select **OK** to confirm.

1. Select **Save** on the **patient-images | Access policy** pane.

### Test a new SAS

1. Return to your web app. On the **External companies** page, create a new SAS token by selecting **Get Key**.

1. Select **View scan**.

    :::image type="content" source="../media/7-sas-fails.png" alt-text="Screenshot of the web app failing to view a patient image." loc-scope="other":::

The image isn't returned from Azure Storage and you get a 403 authentication error.
