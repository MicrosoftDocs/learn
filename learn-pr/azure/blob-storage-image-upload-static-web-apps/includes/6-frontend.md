For the frontend, we are going to build an image upload form that will load a file from the user's computer, and then upload that file to your Azure Blob Storage account.

## Building image upload URLs for your users

While your users will enjoy a seamless experience of uploading images to your application, behind the scenes you know they are sending them to the storage container from your Blob Storage account. To grant them access, behind the scenes you'll be contacting the serverless API you created before to retrieve the required information to build proper Blob Storage destination URLs so your users can upload images.

Remember that your storage backend returns the following JSON:

```javascript
{
  "sasKey": "sv=2020-06-12&se=2021-04-26T19%3A32%3A43Z&sr=c&sp=c&sig=<SecretSignature>",
  "url": "https://uploadimages.blob.core.windows.net"
}
```

Using those values you are going to build the following URL. Your application will use it to authenticate your user's image uploads.


```javascript
`${url}/${container}/${blobName}?${sasKey}`
```

* `url` points to your storage account. 
* `container` points in this case to the `images` container that you created before.
* `blobName` will be a randomly generated string that will be the image file name.
* `sasKey` is the Shared Access Signature retrieved from the serverless API.

Your code will listen to the form's file `change` event to detect when the user has selected the image to upload. Once that event fires, you will pass that information to a function called `blobUpload`. That function will take the file the user selected, the storage URL, container, and SAS token to build the request to upload the file to blob storage.

## Bundling your JavaScript with Webpack

Since the upload function uses code from the `@azure/storage-blob` package, which runs on node.js, you'll use `webpack` to extract the required functionality and make it ready to be used browser side.

Once the frontend is ready, you'll be able to test it locally using the Azure Functions Core Tools package.

> [!TIP]
>To run your project locally make sure the Live Server VS Code extension is installed. You can obtain it from here: [Live Server extension](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer). Also you will need [Azure Functions Core Tools](/azure/azure-functions/functions-run-local?tabs=linux%2Ccsharp%2Cbash) installed. Finally, your node.js version should be 12.0.0.

Let's move on to the exercise to build the frontend.
