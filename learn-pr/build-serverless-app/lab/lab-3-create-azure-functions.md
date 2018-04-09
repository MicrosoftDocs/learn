## Lab exercise 3 - Create Azure Functions

The stateless web app that we are building will use four Azure functions. One of the functions will be used by Event Grid for new pictures that are uploaded and send them over to be processed by the computer vision API.  The other three will back the three APIs that the website uses (to upload images, retrieve the list of images, retrieve the metadata).

## Create the functions

1. **Create a resource** -> **Compute** -> **Functions App**

2. **App Name**.

3. Select use an existing resource group
4. Storage - use the storage account created in lab 1.
5. once your functions app is created, navigate to the functions app console.
6. Click the + next to Functions and create a new javascript function.
    a. HTTP Trigger
    b. Select Javascript
    c. Give it a name
    d. Authorization Level: anonymous?
7. Repeat 4 times.
8. Download the code from the **artifact repository**, and upload it to each function.

## Create the swagger definition

1. PutImage
    a. Click on Integrate
    b. Allowed HTTP methods: Selected methods
    c. Uncheck everything but POST
    d. Authorization Level: Anonymous
    e. Mode: Standard
    f. Route template: /image/put
2. GetImageList
    a. Click on integrate
    b. Allowed HTTP methods: Selected methods
    c. Uncheck everything but GET
    d. Authorization Level: Anonymous
    e. Mode: Standard
    f. Route template: /image/list
3. GetImageMetaData
    a. Click on Integrate
    b. Allowed HTTP methods: selected methods
    c. Uncheck everything but GET
    d. Authorization Level: Anonymous
    e. Mode Standard
    f. Route Template: /image/get/{imageId}
4. ProcessImage
    a. Don't make it an HTTP trigger?
    b. Delete it?
5. Now to create the actual swagger file
    a. Click on the function high level definition
    b. Click on platform features
    c. Click on API definition
    d. Click on Function
    e. Click on Generate API Definition template
    f. Click Save

## Reference 

Look at this doc more and see if we need to update it
https://docs.microsoft.com/en-us/azure/azure-functions/functions-openapi-definition
