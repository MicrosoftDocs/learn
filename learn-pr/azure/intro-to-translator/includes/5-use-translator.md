Feel free to treat this exercise as a demo, just to see what you can do with Translator. You fully control these resources. So, if you're interested in peeking at the technical details, you can choose to dive deeper by browsing the code on GitHub or checking out the resources in the Azure portal.

For more guided hands-on learning on Translator, we have more Learn modules for you to check out. After learning more, you can always come back here to apply what you've learned in the free sandbox.

## Deploy Translator

To create the Translator resource and deploy the webapp, complete the following three steps:

1. Once the Cloud Shell is loaded and shows a prompt, copy the following command and paste it into the Cloud Shell. Paste by selecting Ctrl+Shift+V on Windows and Linux, or by selecting Cmd+Shift+V on macOS.

    Run the following command in the Cloud Shell:

    ```azurecli
    curl -s https://raw.githubusercontent.com/MicrosoftDocs/mslearn-intro-translator-text-to-speech/main/scripts/deploy-in-sandbox.sh | bash
    ```

2. Wait several minutes for the command to run. You may finish reading this page and navigate to other pages within this module - it doesn't affect the running script.

3. Activate the link to the URL displayed at the bottom of the shell. The web app opens, letting you use Translator. You can also cut and paste the URL from here, but remember, it doesn't work until the script finishes running: https://fr-<rgn>[sandboxName]</rgn>.azurewebsites.net

After you run the code, you can play around with Translator at your own pace.

## Optional: Browse or clone the code in GitHub

The source code for this entire demo is fully available. Browse it, use it to debug the demo app, or ignore it entirely. If you fork it and do something cool, let us know on Twitter @MicrosoftLearn.

You can [visit the GitHub repository here.](https://github.com/MicrosoftDocs/mslearn-immersive-reader-stt)

An example of a good place to start browsing is [where we use the service via REST](https://github.com/MicrosoftDocs/mslearn-intro-translator-text-to-speech/blob/main/src/Services/TranslatorService.cs?azure-portal=true#L28-L56):

```csharp
public async Task<TranslationResult> Translate(string text, IList<string> targetLanguages)
{
    var body = new object[] { new { Text = text } };
    var requestBody = JsonConvert.SerializeObject(body);
    var languages = string.Join("&to=", targetLanguages);

    var client = _clientFactory.CreateClient();
    using (var request = new HttpRequestMessage())
    {
        // Build the request.
        request.Method = HttpMethod.Post;

        // For a complete list of options, see API reference.
        // https://learn.microsoft.com/azure/ai-services/translator/reference/v3-0-translate
        request.RequestUri = new Uri(_options.Endpoint + Route + $"&to={languages}");
        request.Content = new StringContent(requestBody, Encoding.UTF8, "application/json");
        request.Headers.Add("Ocp-Apim-Subscription-Key", _options.ApiKey);
        request.Headers.Add("Ocp-Apim-Subscription-Region", _options.Region);

        // Send the request and get response.
        var response = await client.SendAsync(request);

        // Read response as a string.
        var result = await response.Content.ReadAsStringAsync();
        var translationResults = JsonConvert.DeserializeObject<TranslationResult[]>(result);

        return translationResults.OrderByDescending(x => x.DetectedLanguage.Score).FirstOrDefault();
    }
}
```

Notice that we specify the languages on the end of the `request.RequestUri` and we have ApiKey and Region specified by `_options`, so they can be added during deployment instead of being left in the codebase.

## Optional: Review the resource in the CLI or Azure portal

You can look at the resource created in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true#blade/HubsExtension/BrowseAll).

Or if you prefer a command-line experience, you can use the Cloud Shell again to browse. You could start by listing the Cognitive Services resources:

```azurecli
az cognitiveservices account list
```
