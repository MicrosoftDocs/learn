## Lab exercise 3 - Create Azure Functions

The stateless web app that we are building will use four Azure functions. One of the functions will be used by Event Grid for new pictures that are uploaded and send them over to be processed by the computer vision API.  The other three will back the three APIs that the website uses (to upload images, retrieve the list of images, retrieve the metadata).

## Create the functions app

1. **Create a resource** > **Compute** > **Functions App**
2. **App Name**.
3. Select use an existing resource group
4. Storage - use the storage account created in lab 1.
5. once your functions app is created, navigate to the functions app console.

## Update the CORS settings

Go to the functions app and remove all the existing CORS entries, then add a * to allow access from all resources.

In a production environment it is safer to only allow access from your own

## Create the PutImage Function

1. Click the + next to Functions and create a new javascript function.
  * HTTP Trigger
  * Select Javascript
  * Give it a name
  * Authorization Level: anonymous?

2. Create a trigger to write to blob storage
  * Directions go here

```javascript
module.exports = function (context, req) {
    context.log('JavaScript image uploader processed a request.');
    var base64 = req.body.split('\r\n');

    context.bindings.outputBlob = Buffer.from(base64[3], 'base64');
    context.res = {
            // status: 200, /* Defaults to 200 */
            data: "Upload Successful!"
        };
    context.done();
};
```

## Create the GetImageLIst Function

## Create the GetImageMetaData Function

## Create the swagger definition

1. PutImage
  * Click on Integrate
  * Allowed HTTP methods: Selected methods
  * Un-check everything but POST
  * Authorization Level: Anonymous
  * Mode: Standard
  * Route template: /image/put/{name}
2. GetImageList
  * Click on integrate
  * Allowed HTTP methods: Selected methods
  * Un-check everything but GET
  * Authorization Level: Anonymous
  * Mode: Standard
  * Route template: /image/list
3. GetImageMetaData
  * Click on Integrate
  * Allowed HTTP methods: selected methods
  * Un-check everything but GET
  * Authorization Level: Anonymous
  * Mode Standard
  * Route Template: /image/get/{name}
4. ProcessImage
  * Don't make it an HTTP trigger?
  * Delete it?
5. Now to create the actual swagger file
  * Click on the function high level definition
  * Click on platform features
  * Click on API definition
  * Click on Function
  * Click on Generate API Definition template
  * Click Save

## Hook your serverless app to your new functions

Go to the correct screen
and copy the url
go to your storage account
go to your container
go to the js folder
Edit the file
paste the url on line ???
