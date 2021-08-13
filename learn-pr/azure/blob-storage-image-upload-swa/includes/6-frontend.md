For the frontend we are going to build an image upload form that will load a file from the user's computer, and then upload that file to your Azure Blob Storage account. 

First you need to retrieve your storage account URL, and the SAS Token from the serverless API you created in the previous exercise. To do that you will use the Axios JavaScript library to perform the API call that will retrieve those values.

Your code will listen to the form's file `change` event to detect when the user has selected the image to upload. Once that event fires, you will pass that information to a function called `blobUpload`. That function will take the file the user selected, the storage URL, container, and SAS token to build the request to upload the file to blob storage.

Since the upload function uses code from the `@azure/storage-blob` package which runs on node.js, you will use `webpack` to extract the required functionality and make it ready to be used browser side.

Once the frontend is ready, you'll be able to test it locally using the Azure Functions Core Tools package.

>To run your project locally make sure the Live Server VSCode extension is installed. You can obtain it from here: [Live Server extension](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer). Also you will need [Azure Functions Core Tools](https://docs.microsoft.com/azure/azure-functions/functions-run-local?tabs=linux%2Ccsharp%2Cbash) installed. Finally, your node.js version should be 12.0.0. See [Develop Azure Functions by using Visual Studio Code](https://docs.microsoft.com/azure/azure-functions/functions-develop-vs-code?tabs=nodejs) for more details.

Let's move onto the exercise to build the frontend.
