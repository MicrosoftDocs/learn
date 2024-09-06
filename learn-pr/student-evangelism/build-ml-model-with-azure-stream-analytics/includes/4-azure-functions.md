In this unit, you'll use Azure Functions to write an app that's triggered each time an image is uploaded to the `photos` container in your storage account. The function app will use the Custom Vision model you created to determine whether the photo contains a polar bear.

## Create a function app in Azure

You can write a function app in Azure Functions in the Azure portal or externally by using tools like Visual Studio. In this exercise, you'll write a function app in the portal. You'll use JavaScript to write the function app, and you'll run the function app by using the Azure Functions Node.js runtime. The function app is triggered each time an image is uploaded to the `photos` container you created in Blob Storage. Then, the function app passes each blob that's uploaded to Custom Vision to be analyzed for polar bears.

1. In your browser, return to the [Azure portal](https://portal.azure.com?azure-portal=true). In **Azure services**, select **Create a resource**. In the resource menu, select **Compute**, and then select **Function App**.

   :::image type="content" source="../media/select-create-resource-compute-function-app.png" alt-text="Screenshot that shows numbered elements in the Azure portal that you select to create a new function app resource.":::

   *Create a new function app in Azure*

1. In **Create Function App**, on the **Basics** tab, enter, or select the following values:

   - **Subscription:** Select the subscription you want to use.
   - **Resource Group:** Select **polar-bear-rg**.
   - **Function App name:** Enter a name that's unique in Azure for your new app.
   - **Publish:** Leave **Code** selected.
   - **Runtime stack:** Select **Node.js**.
   - **Region:** Select **South Central US**.
   - **Operating System:** Select your system.
   - **Plan Type:** Select **Consumption (Serverless)**.
   - Select **Next : Hosting**.

   :::image type="content" source="../media/create-new-function-app-basic-settings.png" alt-text="Screenshot that shows the basic settings to select or enter for a new function app.":::

   *Configure the basic settings for a new function app*

1. On the **Hosting** tab, select the storage account you created to upload wildlife photos to. Then select **Review + create**.

   :::image type="content" source="../media/create-new-function-app-hosting-settings.png" alt-text="Screenshot that shows the hosting tab settings for a new function app.":::

   *Configure the hosting settings for a new function app*

1. Wait for validation to finish, and then select **Create**.
1. Wait for the function app to deploy, and then open the app in the Azure portal. In the resource menu, under **Functions**, select **Functions**, and then select **Create**.

   :::image type="content" source="../media/create-new-function-app-add-function.png" alt-text="Screenshot that highlights the elements to select to add a function in the Azure portal.":::

   *Add a function*

1. In **Add function**:

   1. For **Development environment**, select **Develop in portal**.
   1. Under **Template**, select **Azure Blob Storage trigger**.

   :::image type="content" source="../media/create-new-function-choose-template.png" alt-text="Screenshot that highlights the elements to select for a new function.":::

   *Configure the settings and choose a template for a function*

   > [!NOTE]
   > If you're prompted to install the `Microsoft.Azure.WebJobs.Extensions.Storage` extension, select **Install**.
   >
   > Wait for the installation to finish, and then select **Continue**.
   >
   > (If you're *not* prompted to install the extension, you might have to wait a few minutes before you can proceed to the next step.)

1. In **Template details**:

   1. For **New Function**, enter *BlobTrigger*.
   1. For **Path**, enter *photos/{name}* so that the function app triggers when blobs are uploaded to the `photos` container.
   1. Under **Storage account connection**, select **New**.
      > [!NOTE]
      > Copy and then save the value that's shown in **Storage account connection**. You'll use the value in a later step.

   1. In **New Storage Account connection**, select the storage account you created earlier, and then select **OK**.

   :::image type="content" source="../media/create-new-function-template-details.png" alt-text="Screenshot that shows settings to use to set up the template to create a blob-triggered function.":::

   *Configure the template to create a blob-triggered function*

1. Select **Add**. The portal view changes to show the new app.

1. On the overview page for the new trigger function, under **Developer**, select **Code + Test**. The *index.js* file for the trigger opens in the portal.

   :::image type="content" source="../media/blob-triggered-function-update-code.png" alt-text="Screenshot that highlights the portal elements to select to open the index dot J S file for the blob-triggered function.":::

   *Open the index.js file for the trigger function*

1. Copy the following code and replace the function app code in the Azure portal with the code:

   ```javascript
   module.exports = function (context, myBlob) {
       var predictionUrl = process.env.PREDICTION_URL;
       var predictionKey = process.env.PREDICTION_KEY;
       var storageConnectionString = process.env.<CONNECTION_STRING_NAME>;

       var storage = require('azure-storage');
       var blobService = storage.createBlobService(storageConnectionString);
       var blobName = context.bindingData.name;
       var blobUri = context.bindingData.uri;

       // Read the blob's metadata
       blobService.getBlobMetadata('photos', blobName, (err, result, response) => {
           if (!err) {
               var latitude = result.metadata.latitude;
               var longitude = result.metadata.longitude;
               var id = result.metadata.id;

               // Generate a shared access signature for the Custom Vision service
               var now = new Date();
               var expiry = new Date(now).setMinutes(now.getMinutes() + 3);

               var policy = {
                   AccessPolicy: {
                       Permissions: storage.BlobUtilities.SharedAccessPermissions.READ,
                       Start: now,
                       Expiry: expiry
                   },
               };

               var sas = blobService.generateSharedAccessSignature('photos', blobName, policy);

               // Pass the blob URL to the Custom Vision service
               var request = require('request');

               var options = {
                   url: predictionUrl,
                   method: 'POST',
                   headers: {
                       'Prediction-Key': predictionKey
                   },
                   body: {
                       'Url': blobUri + '?' + sas
                   },
                   json: true
               };

               request(options, (err, result, body) => {
                   if (!err) {
                       var probability =  body.predictions.find(p => p.tagName.toLowerCase() === 'polar-bear').probability;
                       var isPolarBear = probability > 0.8; // 80% threshold
                        if (isPolarBear) {
                           context.log('POLAR BEAR detected by ' + id + ' at ' + latitude + ', ' + longitude);
                       }
                       else {
                           context.log('Other wildlife detected by ' + id + ' at ' + latitude + ', ' + longitude);
                       }

                       context.done();
                   }
                   else {
                       context.log(err);
                       context.done();
                   }
               });
           }
           else {
               context.log(err);
               context.done();
           }
       });
   };
   ```

   The modified function app uses the npm [request](https://www.npmjs.com/package/request?azure-portal=true) module to call the Custom Vision service, passing the URL of the image to be analyzed. It parses the JSON results and retrieves the value that indicates the probability that the image contains a polar bear. Then, it writes the results to the output log. The threshold for determining whether an image contains a polar bear is 80 percent:

   ```javascript
   var isPolarBear = probability > 0.8; // 80% threshold
   ```

   Another notable aspect of this code is its use of a [shared access signature](/azure/storage/common/storage-dotnet-shared-access-signature-part-1?azure-portal=true).

   The `photos` container that you created is private. To access the blobs stored there, you must have access to the storage account or have the storage account's access key. A shared access signature allows other users and services to access individual blobs, but only for a specified length of time and optionally with read-only access.

   The code that you pasted into the portal uses the Azure Storage SDK for Node.js ([azure-storage](https://www.npmjs.com/package/azure-storage?azure-portal=true)) to generate a read-only shared access signature for the blob associated with the URL that's passed to Custom Vision. The code appends the shared access signature to the blob URL as a query string. The shared access signature is valid for 3 minutes and it allows read access only. Your code can submit private blobs to Custom Vision for analysis without putting the blobs in a public container, in which anyone could download them.

1. Replace `<CONNECTION_STRING_NAME>` on line 4 with the storage account connection string that you saved earlier (for example, `polarbearstorage_STORAGE`). This connection string was added to the application settings when you added the `BlobTrigger` function to the function app. Its name derives from the storage account name. If needed, you can look up the storage account connection string in the **Application settings** of the function app.

   After you add your storage account connection string, select **Save** to finish making changes to the *index.js* file. When the file is saved, the function's output log opens at the bottom of the page.

1. In the Azure portal, open a console.

   - On the function app overview page, in the resource menu, under **Development Tools**, select **Console**.

   :::image type="content" source="../media/open-function-app-console.png" alt-text="Screenshot that shows how to open a console for a function app.":::

   *Open a function app console*

1. In the console, run the following commands to install the npm [request](https://www.npmjs.com/package/request) package and the [Azure Storage SDK for Node.js](https://www.npmjs.com/package/azure-storage?azure-portal=true), so your function app can use them.

   ```console
   npm install request
   npm install azure-storage
   ```

   > [!NOTE]
   > Ignore any warning messages that appear. For simplicity, we're using an older version of a JavaScript library.

1. Wait for the installation commands to finish. Then, you'll add two application settings to the function app.

   1. In the resource menu, under **Settings**, select **Configuration**.
   1. In **Application settings**, select **New application setting**.
   1. In **Add/Edit application setting**, add a setting named *PREDICTION_URL*. Set the value to the Custom Vision prediction URL that you saved in the preceding unit. Leave **Deployment slot setting** cleared. Select **OK**.
   1. Repeat the preceding step to add a setting named *PREDICTION_KEY*. Set the value to the Custom Vision prediction key that you saved in the preceding unit. Leave the **Deployment slot setting** cleared. Select **OK**.

   :::image type="content" source="../media/function-app-application-settings.png" alt-text="Screenshot that shows selections to make in the Azure portal for application settings for a function app.":::

   *Configure the application settings for the function app*

   To finish, select **Save**. If you're prompted, select **Continue** to finish the save action.

   > [!NOTE]
   > Instead of hard-coding the Custom Vision URL and authentication key in the function app code, you're storing the values in the function app's application settings. The values are more secure when they're saved in the application settings.

1. To return to your `BlobTrigger` function app, in the resource menu, under **Functions**, select **Functions**, and then select **BlobTrigger**:

   :::image type="content" source="../media/open-function-output-log-1.png" alt-text="Screenshot that shows selections to make in the Azure portal to view the blob trigger function app.":::

   *Open the BlobTrigger function app*

1. In the resource menu, under **Developer**, select **Code + Test**. Below the code that's shown, select the **Logs** up arrow. The log output pane opens.

   :::image type="content" source="../media/open-function-output-log-2.png" alt-text="Screenshot that shows how to open the output log for a function.":::

   *Open the function's output log*

   Keep the **Logs** pane open because we'll use it in a later step.

1. To open the `photos` Blob Storage container, in the resource menu, under **Data storage**, select **Containers**. In the list of containers, select the `photos` container.

   :::image type="content" source="../media/open-photos-container.png" alt-text="Screenshot that highlights the items you select in the Azure portal to open the photos container.":::

   *Open the photos container for your Blob Storage account*

1. Next, upload an image to the photos container to try out your function app.
   1. In the `photos` container pane, select **Upload**.
   1. In **Upload blob**, under **Files**, select the folder icon.
   1. In Windows Explorer, go to the *photos* folder in your project directory.
   1. Select the *image_12.jpg* file, and select **Open**.
   1. In **Upload blob**, select **Upload**. When the upload is finished, select **X** to close the pane.

   :::image type="content" source="../media/upload-photo-to-container.png" alt-text="Screenshot that shows how to upload a photo to a container.":::

   *Upload a photo to the container*

   Here's what **image_12.jpg** looks like:

   :::image type="content" source="../media/image-12.jpg" alt-text="Image 12 dot j p g, which shows a polar bear.":::

   *Image 12 in Blob Storage*

1. In your browser, return to the function app log. Confirm that the function app executed, and that Custom Vision indicates that *image_12.jpg* contains a polar bear.

   :::image type="content" source="../media/function-output-1.png" alt-text="Screenshot that shows the output log details for uploading and analyzing image 12 dot j p g.":::

   *View the output log details for uploading and analyzing image 12*

The text *undefined at undefined, undefined* appears in the log output because the function attempted to read the latitude, longitude, and camera ID from blob metadata and include them in the output. Those metadata values don't exist because you uploaded the blob manually. That condition will change when your virtual cameras upload photos to Blob Storage.

## Run the camera array

Next, run the simulated camera array you created earlier. Then, you'll check the log output from the function app to verify that images are being uploaded to Blob Storage and analyzed for polar bears.

1. In a Command Prompt or terminal window, return to the project directory. Run the following code to run *run.js*:

   ```bash
   node run.js
   ```

1. In the Azure portal, return to the `BlobTrigger` function and watch the output log for a minute or two. Confirm that the function is being triggered and that it's calling Custom Vision to determine whether each photo uploaded to the `photos` container contains a polar bear.

   :::image type="content" source="../media/function-output-2.png" alt-text="Screenshot that shows logs in a terminal, with the log entry Polar Bear detected for one of the cameras and the camera's latitude and longitude.":::

   *There be polar bears!*

1. Return to the Command Prompt or terminal window in which *run.js* is running, and select Ctrl+C.

Congratulations! You've built a system that transmits wildlife photos to Blob Storage and uses an Azure AI Custom Vision model to determine which photos contain polar bears. The next step is to make the output more visual, and that starts with creating a SQL database by using Azure SQL Database.
