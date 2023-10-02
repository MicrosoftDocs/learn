In this exercise, you can see Azure AI Document Intelligence in action by deploying a Document Intelligence resource and a webapp that uses it – just by **copying and pasting one Azure CLI command**.

To start, you need to activate the Sandbox – just select the **Activate sandbox** button and sign in, no payment or Azure subscription required. Despite having full administrative access to the website and Azure resources, the resources in this exercise are created on Microsoft's subscription, so they don't cost you anything.

## Choose your learning experience

You can treat this exercise as a demo, just to see what you can do with Document Intelligence. However, you fully control these resources, so if you're interested in checking out the technical details, you can choose to dive deeper. Browse the code in GitHub, check out the resources in the Azure portal, or even use Visual Studio remote debugging to step through the process.

For more guided hands-on learning about Document Intelligence, we have more Learn modules for you to check out. After that, you can always come back here to apply what you've learned in the free sandbox.

<a name='deploy-form-recognizer'></a>

## Deploy Document Intelligence

To create the Document Intelligence resource and deploy the webapp, complete the following steps:

1. Once the Cloud Shell is loaded and shows a prompt, copy the following command and paste it into the Cloud Shell. Just select Ctrl+Shift+V on Windows and Linux, or select Cmd+Shift+V on macOS.

    Run the following command in the Cloud Shell:

    ```azurecli
    curl -s https://raw.githubusercontent.com/MicrosoftDocs/mslearn-intro-to-form-recognizer/main/scripts/deploy-in-sandbox.sh | bash 
    ```

1. Wait several minutes for the command to run. You may finish reading this page and navigate to other pages within this module - it doesn't affect the running script.

1. Select the link to the URL displayed at the bottom of the shell. The web app opens and lets you use Document Intelligence. You can also cut and paste the URL from here, but remember, it doesn't work until the script finishes running: https://fr-<rgn>[sandboxName]</rgn>.azurewebsites.net

After you run the code, you can play around with Document Intelligence at your own pace.

## Optional: Browse or clone the code in GitHub

The source code for this entire demo is fully available to the public on GitHub. Browse it, use it to debug the demo app, or ignore it entirely.

You can [visit the GitHub repository here](https://github.com/MicrosoftDocs/mslearn-intro-to-form-recognizer?azure-portal=true).

An example of a good place to start browsing is [where we use the SDK to call the service](https://github.com/MicrosoftDocs/mslearn-intro-to-form-recognizer/blob/b1fe4f309fc4ff9b240dc599b542e577a206ec0e/src/Services/InvoiceRecognizerService.cs?azure-portal=true#L26-L33):

```csharp
public async Task<RecognizedForm> Analyze(Uri invoiceUri)
{
    RecognizeInvoicesOperation operation = await GetClient().StartRecognizeInvoicesFromUriAsync(invoiceUri, OperationOptions);
    Response<RecognizedFormCollection> operationResponse = await operation.WaitForCompletionAsync();
    RecognizedFormCollection invoices = operationResponse.Value;

    return ProcessResults(invoices);
}
```

Notice that we use a convenience method specifically for `Invoice` since it's one of the built-in form types.

## Optional: Review the resource in the CLI or Azure portal

You can look at the resource created in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true#blade/HubsExtension/BrowseAll).

Or if you prefer a command-line experience, you can use the Cloud Shell again to browse. You could start by listing the Azure AI services resources (there should only be one):

```azurecli
az cognitiveservices account list
```
