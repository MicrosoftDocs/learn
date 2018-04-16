## Lab exercise 3 - Create Azure Functions

The stateless web app that we are building will use four Azure functions. One of the functions will be used by Event Grid for new pictures that are uploaded and send them over to be processed by the computer vision API.  The other three will back the three APIs that the website uses (to upload images, retrieve the list of images, retrieve the metadata).

## Create the functions

1. **Create a resource** -> **Compute** -> **Functions App**

2. **App Name**.

3. Select use an existing resource group
4. Storage - use the storage account created in lab 1.
5. once your functions app is created, navigate to the functions app console.
6. Click the + next to Functions and create a new javascript function.
  * HTTP Trigger
  * Select Javascript
  * Give it a name
  * Authorization Level: anonymous?
7. Repeat 4 times.
8. Download the code from the **artifact repository**, and upload it to each function.

## Create the swagger definition

1. PutImage
  * Click on Integrate
  * Allowed HTTP methods: Selected methods
  * Uncheck everything but POST
  * Authorization Level: Anonymous
  * Mode: Standard
  * Route template: /image/put
2. GetImageList
  * Click on integrate
  * Allowed HTTP methods: Selected methods
  * Uncheck everything but GET
  * Authorization Level: Anonymous
  * Mode: Standard
  * Route template: /image/list
3. GetImageMetaData
  * Click on Integrate
  * Allowed HTTP methods: selected methods
  * Uncheck everything but GET
  * Authorization Level: Anonymous
  * Mode Standard
  * Route Template: /image/get/{imageId}
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

## Reference

Look at this doc more and see if we need to update it
https://docs.microsoft.com/en-us/azure/azure-functions/functions-openapi-definition
