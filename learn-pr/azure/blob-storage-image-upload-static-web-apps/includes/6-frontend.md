For the frontend, we'll build an image-upload form that will load a file from the user's computer, then upload that file to your Azure Blob Storage account.

## Building image upload URLs for your users

While your users will enjoy a seamless experience of uploading images to your application, behind the scenes they're sending the images to the storage container in your Blob Storage account. To grant them access, behind the scenes you'll be contacting the serverless API you created to retrieve the required information to build proper Blob Storage destination URLs so your users can upload images.

Remember that your storage backend returns the following JSON:

```javascript
{
  "sasKey": "sv=2020-06-12&se=2021-04-26T19%3A32%3A43Z&sr=c&sp=c&sig=<SecretSignature>",
  "url": "https://uploadimages.blob.core.windows.net"
}
```

You use those values build the following URL, which your application uses to authenticate your users' image uploads:

```javascript
`${url}/${container}/${blobName}?${sasKey}`
```

* `url` points to your storage account.
* `container` points to the `images` container that you previously created.
* `blobName` is a randomly generated string that becomes the image file name.
* `sasKey` is the shared access signature retrieved from the serverless API.

Your code will listen to the form's file `change` event to detect when the user has selected the image to upload. Once that event fires, you'll pass that information to a function called `blobUpload`. That function will take the file the user selected, the storage URL, container, and the SAS token to build the request to upload the file to blob storage.

## Bundling your JavaScript with Webpack

Because the upload function uses code from the `@azure/storage-blob` package, which runs on node.js, you'll use `webpack` to extract the required functionality and make it ready to be used browser side.

Once the frontend is ready, you'll be able to test it locally using the Azure Functions Core Tools package.

> [!TIP]
>To run your project locally, make sure you've installed the [Live Server Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer). You'll also need [Azure Functions Core Tools](/azure/azure-functions/functions-run-local?tabs=linux%2Ccsharp%2Cbash) installed. Finally, your node.js version should be 12.0.0.

Let's move on to the exercise to build the frontend.
