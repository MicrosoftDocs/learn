## Create Azure Functions

As mentioned previously, the serverless solution that you're building used three Azure Functions. One is used by Event Grid for new pictures that are uploaded and sent to be processed by the Computer Vision API. The other two Functions back the APIs that the website uses, to upload images and retrieve the list of images.

## Create the Functions app

1. Select **Create a resource** > **Compute** > **Functions App**.
2. In the **App name** box, enter a unique name. This tutorial uses *serverlessApp*.
3. Select your subscription.
4. Select **Use an existing resource group**, and then select *serverlessRG*.
5. Update your location to the same location as your storage.
6. For **Hosting Plan**, select *Consumption*.
7. For the OS, select *Windows*.
8. For your storage account, select *Use existing*, and then select *serverlessStorage*.
9. Select **Create**.

## Update the Cross-Origin Resource Sharing (CORS) settings

Go to the Functions app, remove all the existing CORS entries, and then add an asterisk (*) to allow access from all resources.

  > [!NOTE] 
  > In a production environment, it is safer to allow access from your own domains only.

![Set up Cross-Origin Resource Sharing(CORS)][cors]

## Enable Managed Service Identity

When you use the Managed Service Identity (MSI) feature, all of the functions in your app can communicate with other Azure services as themselves. If you don't use an MSI, you have to store keys or passwords in your code. You use this feature to communicate directly with Cosmos DB.

1. In the platform features section, select *Managed service identity*.
2. Select **On**.
3. Select **Save**.

![Enable MSI][enable-msi]

## Create the PutImage function

1. Select the plus sign (+) next to **Functions**, and then do the following:

   a. Select **HTTP Trigger**.

   b. In the **Language** drop-down list, select *JavaScript*.

   c. In the **Name** field, enter *PutImage*.

   d. In the **Authorization level** drop-down list, select **Anonymous**.

2. Create an output binding to write to Azure Blob storage by doing the following:

   a. Select **Integrate**.

   b. Select **New Output**.

   c. Select **Azure Blob storage** > **Select**.

   d. For **Blob parameter name**, leave *outputBlob*. 

   e. For **Path**, select *serverlessContainer/img/{name}*. Be sure to replace serverlessContainer with your own container name.

   f. Select **Save**.

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

3. Select **Save**

## Grant Azure Functions access to your Cosmos DB instance

You previously turned on MSI in Functions, which created an identity for your Azure Functions to run as. Now you need to authorize that identity to have access to your Cosmos DB instance.

1. Go to the Cosmos DB console.
2. Select your Cosmos DB instance.
3. Select **Access control (IAM)**.
4. Select **Add**.
5. In the **Role** drop-down list, select *Contributor*.
6. In the **Assign access to** drop-down list, select *Function App*.
7. Select your subscription.
8. Select the resource group that you created in the first lab.
9. Select your Functions app.
10. Select **Save**.

## Create the GetImageList function

1. Go to your Functions app.
2. Select the plus sign (+) next to **Functions**, and then do the following:

   a. Select **HTTP Trigger**.

   b. In the **Language** drop-down list, select *JavaScript*.

   c. In the **Name** field, enter *GetImageList*.

   d. In the **Authorization level** drop-down list, select *Anonymous*. 

   e. Select **Create**.

3. Replace the code in the editor with the following:

    ```javascript
    module.exports = function (context, req) {
        context.res = {
            body: context.bindings.images
        };
    
        context.done();
    };
    ```

4. Create an input binding to read from Azure Cosmos DB by doing the following:

    a. Select **Integrate**.

    b. Select **New Input**.

    c. Select **Azure Cosmos DB** > **Select**.

    d. In the **Document parameter name** field, enter *images*. 

    e. In the **Database name** field, enter *serverless-app*. 

    f. In the **Collection Name** field, enter *images*. 

    g. Next to **Azure Cosmos DB account connection**, select *new*. 

    h. Select the Cosmos DB instance that you created in the previous lab.

    i. Select **Save**.

## Create the Swagger definition

At this point you've created both Azure Functions that will serve as an API. The one remaining step is to create a Swagger definition, which then allows the functions to be published as APIs.

1. Modify the PutImage function by doing the following:

    a. Select **Integrate**, and ensure that *HTTP(req)* is selected.
    
    b. In the **Allowed HTTP methods** drop-down list, change the setting to *Selected methods*.
    
    c. In the **Selected HTTP methods** section, clear all selections except *POST*.
    
    d. In the **Authorization level** drop-down list, change the setting to *Anonymous*.
    
    e. For **Mode**, select *Standard*.
    
    f. In the **Route template** field, enter */image/put/{name}*.
    
    g. Select **Save**.
    
2. Modify the GetImageList function by doing the following:
    
    a. Select **Integrate**, and then ensure that *HTTP(req)* is selected.
    
    b. In the **Allowed HTTP methods** drop-down list, change the setting to *Selected methods*.
    
    c. In the **Selected HTTP methods** section, clear all selections except *GET*.
    
    d. In the **Authorization level** drop-down list, change the setting to *Anonymous*.
    
    e. For **Mode**, select *Standard*.
    
    f. In the **Route template** field, enter */image/list*.
    
    g. Select **Save**.
    
3. Generate the Swagger file by doing the following:
    
    a. Select your Azure Functions app.
    
    b. Select the **Platform features** tab.
    
    c. Select **API definition**.
    
    d. Select **Function (preview)**.
    
    e. Select **Generate API Definition template**.
    
    f. Select **Save**.

## Hook your serverless app to your new functions

1. Select your Azure Functions app.
2. Select **Overview**.
3. Copy the URL.
4. Go to your storage account.
5. Select **Blobs** > **serverlessContainer** > **js** > **uploader.js** > **Edit blob**.
6. Paste your URL into the quotation on line 1.

<!-- Images -->
[enable-msi]: ../media/lab-3-functions-msi.png
[cors]: ../media/lab-3-functions-cors.png

Congratulations! You've created some Azure Functions and hooked them into your web application.
