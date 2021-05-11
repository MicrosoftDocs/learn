In this exercise, you're going to see Form Recognizer in action by deploying a Form Recognizer resource and a webapp that will use it. All this will happen **simply by copying and pasting the Azure CLI command below**.
  
To start, you'll need to activate the Sandbox above – just select the ‘Activate sandbox’ button and sign in, no payment or Azure subscription required. Despite having full administrative access to the website and Azure resources, the resources in this exercise are created on Microsoft's subscription, meaning they won't cost you anything.

## Choose your learning experience

You have the option to treat this as a demo to just see what you can do with Form Recognizer. You fully control these resources, so if you're interested in peeking at the technical details, you can choose to dive deeper. Browse the code in GitHub, check out the resources in the Azure portal, or even use Visual Studio remote debugging and step through.
  
For more guided hands-on learning on Form Recognizer, we have more Learn modules for you to check out. After learning more, you can always come back here to apply what you've learned in the free sandbox.

## Deploy Form Recognizer

To create the Form Recognizer resource and deploy the webapp, complete the following three steps:
  
1. Once the Cloud Shell is loaded and shows a prompt, copy the command below and paste it into the Cloud Shell by selecting Ctrl+Shift+V on Windows and Linux, or by selecting Cmd+Shift+V on macOS.
  
    Run the following command in the Cloud Shell:
  
    ```azurecli
    curl -s https://raw.githubusercontent.com/MicrosoftDocs/mslearn-intro-to-form-recognizer/main/scripts/deploy-in-sandbox.sh | bash 
    ```
  
2. Wait several minutes for the command to run. You may finish reading this page and navigate to other pages within this module - it won't affect the running script.
  
3. Activate the link to the URL displayed at the bottom of the shell. The web app will open letting you use Form Recognizer. You can also cut and paste the URL from here, but remember, it won't work until the script finishes running: https://fr-<rgn>[sandboxName]</rgn>.azurewebsites.net
  
After you run the code, you can play around with Form Recognizer at your own pace.

## Optional: Browse or clone the code in GitHub

The source code for this entire demo is fully available. Browse it, use it to debug the demo app, or ignore it entirely. If you fork it and do something cool, let us know on Twitter @MicrosoftLearn.

You can [visit the GitHub repository here.](https://github.com/MicrosoftDocs/mslearn-intro-to-form-recognizer?azure-portal=true)

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

Or if you prefer a command-line experience, you can use the Cloud Shell again to browse. You could start by listing the Cognitive Services resources (there should only be one):

```azurecli
az cognitiveservices account list
```
