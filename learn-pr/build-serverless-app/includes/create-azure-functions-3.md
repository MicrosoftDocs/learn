As mentioned previously, the serverless solution that you're building will use three Azure Functions. One will be used by Event Grid for new pictures that are uploaded and send them over to be processed by the computer vision API. The other two will back the APIs that the website uses, to upload images and retrieve the list of images.

## Create the Function app

1. Open the [Azure Portal](https://portal.azure.com/).
2. Select **Create a resource**
3. Select **Compute**
4. Select **Function App**
5. Enter a unique name into the **App name** text box. This tutorial uses `serverlessApp`
6. Select your subscription
7. Select **Use an existing resource group**
8. Select `serverlessRG`
9. Update your location so that it's in the same location as your storage
10. Select **Consumption Plan** for the Hosting Plan
11. Select **Windows** for the OS
12. Select **Use existing** for your storage account
13. Select `serverlessStorage`
14. **Create**

## Update the Cross-Origin Resource Sharing (CORS) settings

Select the Function app, select the **Platform features** tab. Under **API** > Select **CORS**. Remove all the existing CORS entries, then add a * to allow access from all resources.  Finally, select **Save**.

> [!NOTE] 
> In a production environment it is safer to only allow access from your own domains.

![Setup Cross-Origin Resource Sharing(CORS)][cors]

## Enable Managed Service Identity (MSI)

Managed service identities allow all of your Functions in your app to communicate with other Azure services as themselves. If you don't use a managed service identity, you have to store keys or passwords in your code. You're going to use this feature to communicate directly with Cosmos DB.

1. In the platform features section select **Managed service identity**
2. Select **On**
3. Select **Save**

![Enable MSI][enable-msi]

## Create the PutImage Function

1. Select the **+** next to **Functions**
2. Select **Custom function**

![Create the first function][function-create]

3. Select **HTTP Trigger**
4. Select **JavaScript** from the Language dropdown
5. Enter `PutImage` in the Name field
6. Select **Anonymous** from the Authorization level dropdown.
7. Create an output binding to write to Azure Blob storage
8. Select **Integrate**
9. Select **New Output**
10. Select **Azure Blob storage** > **Select**
11. Leave `outputBlob` as the **Blob parameter name**
12. The **Path** should be `serverlessContainer/img/{name}`. Make sure that you replace serverlessContainer with your own container name.
13. Select **Save**
14. Select the function name and replace the code in the editor with the following code:

```javascript
module.exports = function (context, req) {
    context.log('JavaScript image uploader processed a request.');
    var base64 = req.body.split('\r\n');

    context.bindings.outputBlob = Buffer.from(base64[3], 'base64');
    context.res = {
            body: "Upload Successful!"
        };
    context.done();
};
```

15. **Save**

## Grant Azure functions access to your Cosmos DB

You previously turned on MSI in Functions, which created an identity for your Azure Functions to run as.  Now you need to authorize that identity to have access to your Cosmos DB.

1. Navigate to the Cosmos DB console
2. Select your Cosmos DB
3. Select **Access control (IAM)**
4. Select **Add**
5. Select **Contributor** in the Role dropdown
6. Select **Function App** in the Assign access to dropdown
7. Select your subscription
8. Select the resource group you created in the first lab
9. Select your Function app
10. **Save**

## Create the GetImageList Function

1. Navigate to your Function app
2. Select the **+** next to **Functions**
  * Select **HTTP Trigger**
  * Select `JavaScript` from the **Language** dropdown
  * Enter `GetImageList` in the name field
  * Select `Anonymous` from the **Authorization level** dropdown
  * **Create**
3. Replace the code in the editor with the following:

```javascript
module.exports = function (context, req) {
    context.res = {
        body: context.bindings.images
    };

    context.done();
};
```

4. Create an input binding to read from Azure Cosmos DB
  * Select **Integrate**
  * Select **New Input**
  * **Azure Cosmos DB** > **Select**
  * Enter `images` in the **Document parameter name** field
  * Enter `serverless-app` in the **Database name** field
  * Enter `images` in the **Collection Name** field
  * Select **new** next to the **Azure Cosmos DB account connection** field
  * Select your Cosmos DB that was created in the previous lab
  * **Save**

## Create the Swagger definition

At this point you've created both of your Azure functions that will serve as an API, the one remaining step is to create a Swagger definition which will then allow them to be published as APIs.

1. Modify the PutImage function
  * Select **Integrate**, ensure that **HTTP(req)** is selected
  * Change the **Allowed HTTP methods** dropdown to `Selected methods`
  * In the **Selected HTTP methods** section, un-check everything but POST
  * Change the **Authorization level** dropdown to `Anonymous`
  * Mode: Standard
  * In the **Route template** field enter `/image/put/{name}`
  * **Save**
2. Modify the GetImageList function
  * Select **Integrate**, ensure that **HTTP(req)** is selected
  * Change the **Allowed HTTP methods** dropdown to `Selected methods`
  * In the **Selected HTTP methods** section, un-check everything but GET
  * Change the **Authorization level** dropdown to `Anonymous`
  * Mode: Standard
  * In the **Route template** field enter `/image/list`
  * **Save**
3. Generate the Swagger file
  * Select your Azure Function app
  * Select the **Platform features** tab
  * Select **API definition**
  * Select **Function (preview)**
  * Select **Generate API Definition template**
  * **Save**

## Hook your serverless app to your new functions

1. Select your Azure Function app
2. Select **Overview**
3. Copy the URL
4. Navigate to your storage account
5. **Blobs** > **serverlessContainer** > **js** > **uploader.js** > **Edit blob**
6. Paste your URL into the quotation on line 1

<!-- Images -->
[enable-msi]: ../media/lab-3-functions-msi.png
[cors]: ../media/lab-3-functions-cors.png
[function-create]: ../media/lab-3-functions-create.png

Congratulations - You've created some Azure Functions and hooked them into your web application!
