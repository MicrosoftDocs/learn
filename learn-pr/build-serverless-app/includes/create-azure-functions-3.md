## Create Azure functions

As mentioned previously, the serverless solution that you're building uses three Azure functions. One is used by Event Grid for new pictures that are uploaded and sent to be processed by the Computer Vision API. The other two functions back the APIs that the website uses, to upload images and retrieve the list of images.

## Create the Function app

1. Go to the [Azure portal](https://portal.azure.com/).
2. Select **Create a resource**.
3. Select **Compute**.
4. Select **Functions App**.
5. In the **App name** box, enter a unique name. This tutorial uses *serverlessApp*.
6. Select your subscription.
7. Select **Use an existing resource group**.
8. Select *serverlessRG*.
9. Update your location to the same location as your storage.
10. For **Hosting Plan**, select *Consumption Plan*.
11. For the OS, select *Windows*.
12. For your storage account, select *Use existing*.
13. Select *serverlessStorage*.
14. Select **Create**.

## Update the Cross-Origin Resource Sharing (CORS) settings

1. Select the Function app, and then select the **Platform features** tab.
2. Under **API**, select **CORS**. 
3. Remove all the existing CORS entries, and then add an asterisk (*) to allow access from all resources.  
4. Select **Save**.

> [!NOTE] 
> In a production environment, it is safer to allow access from your own domains only.

![Set up Cross-Origin Resource Sharing(CORS)][cors]

## Enable Managed Service Identity

When you use the Managed Service Identity (MSI) feature, all of the functions in your app can communicate with other Azure services as themselves. If you don't use an MSI, you have to store keys or passwords in your code. You use this feature to communicate directly with the Cosmos DB instance.

1. In the platform features section, select *Managed service identity*.
2. Select **On**.
3. Select **Save**.

![Enable MSI][enable-msi]

## Create the PutImage function

1. Select the plus sign (+) next to **Functions**.
2. Select **Custom function**.

   ![Create the first function][function-create]
3. Select **HTTP Trigger**.
4. In the **Language** drop-down list, select *JavaScript*.
5. In the **Name** field, enter *PutImage*.
6. In the **Authorization level** drop-down list, select **Anonymous**.
7. Create an output binding to write to Azure Blob storage.
8. Select **Integrate**.
9. Select **New Output**.
10. Select **Azure Blob storage** > **Select**.
11. In the **Blob parameter name** field, leave *outputBlob*.
12. For **Path**, enter *serverlessContainer/img/{name}*. Be sure to replace serverlessContainer with your own container name.
13. Select **Save**.
14. Select the function name, and then replace the code in the editor with the following code:

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
15. Select **Save**.

## Grant Azure Functions access to your Cosmos DB instance

You previously turned on MSI in Functions, which created an identity for your Azure functions to run as. Now you need to authorize that identity to have access to your Cosmos DB instance.

1. Go to the Cosmos DB console.
2. Select your Cosmos DB instance.
3. Select **Access control (IAM)**.
4. Select **Add**.
5. In the **Role** drop-down list, select *Contributor*.
6. In the **Assign access to** drop-down list, select *Function App*.
7. Select your subscription.
8. Select the resource group that you created in the first lab.
9. Select your Function app.
10. Select **Save**.

## Create the GetImageList function

1. Go to your Function app.
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

4. Select **Save**.

5. Create an input binding to read from the Azure Cosmos DB instance by doing the following:

    a. Select **Integrate**.

    b. Select **New Input**.

    c. Select **Azure Cosmos DB** > **Select**.

    d. In the **Document parameter name** field, enter *images*. 

    e. In the **Database name** field, enter *serverless-app*. 

    f. In the **Collection Name** field, enter *images*. 

    g. Next to **Azure Cosmos DB account connection**, select *new*. 

    h. Select the Cosmos DB instance that you created in the previous lab.

6. Select **Save**.

## Create the Swagger definition

At this point you've created both of your Azure functions, which will serve as an API. The one remaining step is to create a Swagger definition, which then allows the functions to be published as APIs.

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
    
    a. Select your Azure Function app.
    
    b. Select the **Platform features** tab.
    
    c. Select **API definition**.
    
    d. Select **Function (preview)**.
    
    e. Select **Generate API Definition template**.
    
    f. Select **Save**.

## Hook your serverless app to your new functions

1. Select your Azure Function app.
2. Select **Overview**.
3. Copy the URL.
4. Go to your storage account.
5. Select **Blobs** > **serverlessContainer** > **js** > **uploader.js** > **Edit blob**.
6. Paste your URL into the quotation on line 1.

<!-- Images -->
[enable-msi]: ../media/lab-3-functions-msi.png
[cors]: ../media/lab-3-functions-cors.png
[function-create]: ../media/lab-3-functions-create.png

Congratulations! You've created some Azure functions and hooked them into your web application.
