You have the option to treat this as a demo to just see what you can do with Text-to-Speech. You fully control these resources, so if you're interested in peeking at the technical details, you can choose to dive deeper by browsing the code on GitHub or checking out the resources in the Azure portal.

For more guided hands-on learning on Text-to-Speech, we have more Learn modules for you to check out. After learning more, you can always come back here to apply what you've learned in the free sandbox.

## Deploy Text-to-speech

To create the Text-to-Speech resource and deploy the webapp, complete the following three steps:

1. Once the Cloud Shell is loaded and shows a prompt, copy the command below and paste it into the Cloud Shell by selecting Ctrl+Shift+V on Windows and Linux, or by selecting Cmd+Shift+V on macOS.

    Run the following command in the Cloud Shell:

    ```azurecli
    curl -s https://raw.githubusercontent.com/MicrosoftDocs/mslearn-intro-translator-text-to-speech/main/scripts/deploy-in-sandbox.sh | bash
    ```

2. Wait several minutes for the command to run. You may finish reading this page and navigate to other pages within this module - it won't impact the running script.

3. Activate the link to the URL displayed at the bottom of the shell. The web app will open letting you use Text-to-Speech. You can also cut and paste the URL from here, but remember, it won't work until the script finishes running: https://fr-<rgn>[sandboxName]</rgn>.azurewebsites.net

After you run the code, you can play around with Text-to-Speech at your own pace.

## Optional: Browse or clone the code in GitHub

The source code for this entire demo is fully available. Browse it, use it to debug the demo app, or ignore it entirely. If you fork it and do something cool, let us know on Twitter @MicrosoftLearn.

You can [visit the GitHub repository here.](https://github.com/MicrosoftDocs/mslearn-intro-translator-text-to-speech)

An example of a good place to start browsing is [where we use the SDK to synthesize text to an audio file](https://github.com/MicrosoftDocs/mslearn-intro-translator-text-to-speech/blob/main/src/Services/TextToSpeechService.cs?azure-portal=true#L63-L88):

```csharp
        private async Task<string> SynthesizeSsmlToFileAsync(string text, SpeechTranslationOption options)
        {
            var synthesizer = GetSpeechSynthesizer(null);

            var ssmlTemplate = await File.ReadAllTextAsync(SSMLTemplate);
            var ssml = string.Format(
                ssmlTemplate,
                options.VoiceName,
                options.Adjustments.Style,
                options.Adjustments.StyleDegree,
                options.Adjustments.Rate,
                options.Adjustments.Pitch,
                text);

            using var result = await synthesizer.SpeakSsmlAsync(ssml);
            var audioUrl = await ProcessSynthesisResult(text, result);

            if (string.IsNullOrEmpty(audioUrl))
            {
                throw new Exception("Couldn't synthesize the text.");
            }
            return audioUrl;
        }
```

Notice that we're using the optional SSML, and we return a URL for the audio file.

## Optional: Review the resource in the CLI or Azure portal

You can look at the resource created in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true#blade/HubsExtension/BrowseAll).

Or if you prefer a command-line experience, you can use the Cloud Shell again to browse. You could start by listing the Cognitive Services resources:

```azurecli
az cognitiveservices account list
```