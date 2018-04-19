## Lab exercise 3 - Create Azure Functions

The stateless web app that we are building will use four Azure functions. One of the functions will be used by Event Grid for new pictures that are uploaded and send them over to be processed by the computer vision API.  The other three will back the three APIs that the website uses (to upload images, retrieve the list of images, retrieve the metadata).

## Create the functions app

1. **Create a resource** > **Compute** > **Functions App**
2. Enter a unique name into the **App name** text box, this tutorial will use `serverlessApp`
3. Select your subscription.
4. Select use an existing resource group and then select `serverlessRG`
5. Confirm your location is the same as your storage - this defaults to a different region.
6. Select **Consumption** for the Hosting Plan.
7. Select **Windows** for the OS.
8. Select **Use existing** for your storage account, and then select `serverlessStorage`.
9. **Create** 

## Update the CORS settings

Go to the functions app and remove all the existing CORS entries, then add a * to allow access from all resources.

In a production environment it is safer to only allow access from your own URL.

## Enable Managed service identity (MSI)

Managed service identity allows your all of your functions in the app to communicate with other Azure services as themselves.  You will use this feature to communicate with Cosmos DB instead of storing keys or passwords in your code.

1. In the platform features section select Managed service identity.
2. Select **On**
3. Select **Save**

![Enable MSI][enable-msi]

## Create the PutImage Function

1. Click the + next to Functions and create a new javascript function.
  * Select **HTTP Trigger**
  * Select **JavaScript** from the Language dropdown
  * Enter `PutImage` in the name field
  * Authorization Level: anonymous

2. Create a output binding to write to blob storage
  * Select **Integrate**
  * Select **New Output**
  * Select Azure Blob storage > **Select**
  * Leave outputBlob as the Blob parameter name
  * Path should be `serverlessContainer/img/{name}` be sure to replace serverlessContainer with your own container.
  * **Save**

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

3. **Save**

## Grant Azure functions access to your Cosmos DB

1. Navigate to the Cosmos DB console
2. Select the Cosmos DB you created in the previous section.
3. Select Access control (IAM)
4. Select **Add**
5. Select **Contributor** in the Role dropdown
6. Select **Function App** in the Assign access to dropdown
7. Select your subscription.
8. Select the resource group you created in the first lab.
9. Select the functions app.
10. **Save**

## Create the GetImageList Function

1. Navigate back to your functions app
2. Select the + next to Functions.
  * Select **HTTP Trigger**
  * Select **JavaScript** from the Language dropdown
  * Enter `GetImageList` in the name field
  * Select **Anonymous** from the Authorization level dropdown.
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
  * Select Azure Cosmos DB > **Select**
  * Enter `images` in the Document parameter name field.
  * Enter `serverless-app` in the Database name field.
  * Enter `images` in the Collection Name field.
  * Select **new** next to the Cosmos DB account connection field.
  * Select your Cosmos DB that was created in the previous lab.
  * **Save**

## Create the swagger definition

1. PutImage
  * Click on Integrate
  * Allowed HTTP methods: Selected methods
  * Un-check everything but POST
  * Authorization Level: Anonymous
  * Mode: Standard
  * Route template: /image/put/{name}
  * **Save**
2. GetImageList
  * Select Integrate, ensure that the trigger is selected: HTTP (req)
  * Change the Allowed HTTP methods dropdown to **Selected methods**
  * Un-check everything but GET
  * Authorization Level: Anonymous
  * Mode: Standard
  * Route template: /image/list
  * **Save**
3. Now to create the actual swagger file
  * Select platform features
  * Click on API definition
  * Click on Function
  * Click on Generate API Definition template
  * Click Save

## Hook your serverless app to your new functions

1. Select the function app
2. Select **Overview**
3. Copy the URL
4. Navigate to your storage account.
5. **Blobs** > **serverlessContainer** > **js** > **uploader.js** > **Edit blob**
6. Paste your URL into the quotations on line 1.

<!-- Images -->
[enable-msi]: ../media/lab-3-functions-msi.png