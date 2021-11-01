You use Azure Storage to authorize access to files with a shared key, with a shared access signature (SAS), or via Azure Active Directory (Azure AD). With a SAS, you control what a client can do with the files and for how long.

Your company's image diagnostic system accesses its patient images internally via a shared key. Your team needs to create an API to allow third parties access to diagnostic images. You'll create a test page on your web app to see how a SAS helps you grant secure access to third-party clients.

In this exercise, you'll create a storage account and upload some example patient images. You'll deploy your team's existing web app and test that it can access the storage. The last step is to add C# and JavaScript code to generate a SAS token on demand to view the images securely.

:::image type="content" source="../media/4-app-running.png" alt-text="Screenshot your company's patient diagnostic image system showing three example images loaded." loc-scope="other"::: <!-- no-loc -->

### Create a storage account and upload images

1. Using Azure Cloud Shell, create a storage account for patient images.

    ```azurecli
    export STORAGENAME=medicalrecords$RANDOM

    az storage account create \
        --name $STORAGENAME \
        --access-tier hot \
        --kind StorageV2 \
        --resource-group <rgn>[sandbox resource group]</rgn>
    ```

1. Create a container to store the images in.

    ```azurecli
    az storage container create \
        --name patient-images \
        --account-name $STORAGENAME \
        --public-access off
    ```

1. Clone your team's existing web app. The repository also contains example images used by your team for testing.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-control-access-to-azure-storage-with-sas.git sas
    ```

1. Use the Azure CLI upload-batch command to upload the images into the storage account.

    ```azurecli
    az storage blob upload-batch \
        --source sas \
        --destination patient-images \
        --account-name $STORAGENAME \
        --pattern *.jpg
    ```

### Test the patient diagnostic image system

1. First you need to copy the connection string to your storage account.

    ```azurecli
    az storage account show-connection-string --name $STORAGENAME
    ```

    You should see results in this format:

    ```json
    {
      "connectionString": "DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=medicalrecords3215;AccountKey=UGLNuJWUBtodz+VbhhFcMwkzDpX49Wf7FxtuQDTOHhH+LpCtSQ2LBP0Ju8TQby5CeOt7DMYBgH45SX9yFwqPvA=="
    }
    ```

    Copy the connectionString value in Cloud Shell output from your command. Include the quotation marks.

1. Edit the **appsettings.json** file to add the connection credentials.

    ```bash
    code sas/appsettings.json
    ```

1. In the code editor, replace the ConnectionString value `"[connection string]"` with the string you copied.

1. Change AccountName to the randomly generated name.

1. In the editor, copy the string after the `AccountKey=` parameter up to the `"` in the connection string.

1. Replace the `"[account key]"` string with the account key you copied.

1. The **appsettings.json** file should now look similar to this output.

    ```json
    {
      "Logging": {
        "LogLevel": {
          "Default": "Warning"
        }
      },
      "AllowedHosts": "*",
      "StorageAccount": {
        "ConnectionString": "DefaultEndpointsProtocol=https;AccountName=medicalrecords3215;AccountKey=UGLNuJWUBtodz+VbhhFcMwkzDpX49Wf7FxtuQDTOHhH+LpCtSQ2LBP0Ju8TQby5CeOt7DMYBgH45SX9yFwqPvA==;EndpointSuffix=core.windows.net",
        "Container" : "patient-images",
        "AccountName":"medicalrecords3215",
        "AccountKey":"UGLNuJWUBtodz+VbhhFcMwkzDpX49Wf7FxtuQDTOHhH+LpCtSQ2LBP0Ju8TQby5CeOt7DMYBgH45SX9yFwqPvA=="
      }  
    }
    ```

    Make sure you have the `==` at the end of the `AccountKey` line.

1. Save and close the code editor by selecting <kbd>Ctrl+S</kbd>, and then selecting <kbd>Ctrl+Q</kbd>.

1. To access your web app when it's running in Cloud Shell, you need to open a port.

    ```bash
    curl -X POST http://localhost:8888/openPort/8000;
    ```

    This command returns a `url1 where your app can be accessed.

    ```json
    {"message":"Port 8000 is open","url":"https://gateway11.northeurope.console.azure.com/n/cc-4016c848/cc-4016c848/proxy/8000/"}
    ```

1. Run your app.

    ```bash
    cd sas
    dotnet run
    ```

    When the app is ready to be viewed, you'll see the following details in the console.

    ```bash
    Hosting environment: Development
    Content root path: /home/yourusername/sas
    Now listening on: https://localhost:8001
    Now listening on: http://localhost:8000
    Application started. Press Ctrl+C to shut down.
    ```

1. Go to your personal URL, which should be in this format: https:\//gateway11.northeurope.console.azure.com/n/cc-4016c848/cc-4016c848/proxy/8000/. Make sure you have a slash (/) at the end of the address.

1. Select **Get all patients** to view all the images stored in the storage account.

### Add code to create a SAS

1. Stop the web app by selecting <kbd>Ctrl+C</kbd>.

1. You'll enhance the **PatientRecordController** class to create an on-demand SAS and return it to the front end of the web app.

1. Edit the **PatientRecordController.cs** file.

    ```bash
    code Controllers/PatientRecordController.cs
    ```

1. Add the following code to the bottom of the class under the `GET PatientRecord/patient-nnnnnn` method.

    ```C#
    // GET PatientRecord/patient-nnnnnn/secure
    [HttpGet("{Name}/{secure}")]
    public PatientRecord Get(string name, string flag)
    {
        BlobClient blob = _container.GetBlobClient(name);
        return new PatientRecord { name=blob.Name, imageURI=blob.Uri.AbsoluteUri, sasToken=GetBlobSas(blob) };
    }
    ```

1. This method returns the requested patient image with a SAS that can be used to access it.

1. Add a method that creates the SAS for the blob.

    ```C#
    // Build a SAS token for the given blob
    private string GetBlobSas(BlobClient blob)
    {
        // Create a user SAS that only allows reading for a minute
        BlobSasBuilder sas = new BlobSasBuilder 
        {
            BlobContainerName = blob.BlobContainerName,
            BlobName = blob.Name,
            Resource = "b",
            ExpiresOn = DateTimeOffset.UtcNow.AddMinutes(1)
        };
        // Allow read access
        sas.SetPermissions(BlobSasPermissions.Read);

        // Use the shared key to access the blob
        var storageSharedKeyCredential = new StorageSharedKeyCredential(
            _iconfiguration.GetValue<string>("StorageAccount:AccountName"),
            _iconfiguration.GetValue<string>("StorageAccount:AccountKey")
        );

        return '?' + sas.ToSasQueryParameters(storageSharedKeyCredential).ToString();
    }
    ```

    The method uses the passed `BlobClient` object to create a `BlobSasBuilder`. You'll generate a SAS that is read-only and expires in one minute.

1. Save and quit the editor by selecting <kbd>Ctrl+S</kbd>, and then selecting <kbd>Ctrl+Q</kbd>.

### Add code to use the SAS

1. You'll now add code to the webpage to request the SAS for the image.

1. Edit the **external.cshtml** page.

    ```bash
    code Pages/external.cshtml
    ```

1. At the bottom of the file, above the last `</script>` tag, add this code:

    ```javascript
    $('#btn-getKey').click(function(){
        $.get('api/PatientRecords/' + $('#patientID').val() + '/secure', function (data) {
            $('#sasKey').val(data.sasToken);
        }, 'json');
    });
    ```

    This jQuery code adds a click listener on the `btn-getKey` button. The code executes an Ajax call to the new secure URL for the given image file. When it returns, it populates the key input box with the SAS.

1. Save the changes, and quit the editor by selecting <kbd>Ctrl+S</kbd>, and then selecting <kbd>Ctrl+Q</kbd>.

### Test your changes

1. Run your updated app.

    ```bash
    dotnet run
    ```

1. Select **Get all patients**, and then copy one of the image filenames.

1. In the menu at the top of the page, select **External companies**.

1. Paste the filename into the **Patient image filename** field.

1. Select **View scan**. The image won't be accessible because you haven't created a SAS.

    > [!NOTE]
    > If you view the console in your browser, you'll see the web server returned a 404 error-code message.

1. Select **Get Key**, which should populate the **Key** field with a SAS.

1. Select **View scan**. The patient's diagnostic image should appear.

    :::image type="content" source="../media/4-viewing-image.png" alt-text="Screenshot of the patient diagnostic image web app showing a patient's image." loc-scope="other":::

1. In your browser, right-click the image and copy the image address.

1. Open a new browser window.

1. Go to the copied image address in the new window. If it's been longer than a minute since you created the SAS, you'll see this message. You might need to refresh the page.

    ```xml
    <Error>
        <Code>AuthenticationFailed</Code>
        <Message>Server failed to authenticate the request. Make sure the value of Authorization header is formed correctly including the signature.
        RequestId:03eda893-f01e-0028-2d73-c5c947000000
        Time:2020-01-07T16:02:55.3752851Z</Message>
        <AuthenticationErrorDetail>Signed expiry time [Tue, 07 Jan 2020 16:02:00 GMT] must be after signed start time [Tue, 07 Jan 2020 16:02:55 GMT]</AuthenticationErrorDetail>
    </Error>
    ```

    > [!NOTE]
    > To see this message, you need to use a new browser window that won't have cached the image.

1. In Cloud Shell, quit the web app by selecting <kbd>Ctrl+C</kbd>.