The first step to train a model is to upload training data. See [Prepare and test your data](./azure/cognitive-services/speech-service/how-to-custom-speech-test-and-train) for step-by-step instructions to prepare human-labeled transcriptions and related text (utterances and pronunciations).

## Train and evaluate a model

1. Sign in to the [Custom Speech portal](https://speech.microsoft.com/customspeech)
1. Go to **Speech-to-text** > **Custom Speech**
1. Select **Resource** then **select your new Speech Services resource**
1. Select **Use resource**
1. Select **Create a new project**
1. Name your project, and select **Create**

## Use audio data to create a custom speech model

1. Select your new project
1. Select **Upload data**
1. Make sure 'Audio + human-labeled transcript' is highlighted, and select **Next**
1. Select **Azure Blob or shared location**
1. Copy the following URL, and paste it into the 'Audio + transcript' box

    ```
    https://github.com/Azure-Samples/cognitive-services-speech-sdk/raw/master/sampledata/customspeech/en-US/training/audio-and-trans.zip
    ```

1. Select **Next**
1. Choose a name for your dataset, and select **Next**
1. Select **Save and close**

## Train a custom model

After a few seconds, you will see a message saying your files have successfully processed. Next, let's train a custom model using the data.

1. Select the dataset, then select **Train**
1. Select **Next**
1. Select **Next**
1. Choose a name for your model, and select **Next**
1. Select **Save and close**

## Create an endpoint for your model

While your model trains, let's create and endpoint so your model can be used in applications.

1. On the left-hand menu, select **Deploy models**
1. Select **Deploy model**
1. Choose a name for your model, accept the terms of use, and select **Add**

It might take a minute for your endpoint to be created.

## Use your custom model

Now, we need to transfer the details for the endpoint over to the Cloud Shell.

1. Select your newly created endpoint

    Notice how Speech Studio provides code to connect to your custom model in multiple programming languages via the SDK, REST API, and WebSocket.
1. Return to the Cloud Shell and paste in the following command

    ```
    subKey=<Paste key here>
    ```

1. Return to the Custom Speech portal, copy your subscription key
1. Return to the Cloud Shell and replace the `<Paste key here>` in the command with your Subscription key from the Custom Speech portal
1. Select <kbd>Enter</kbd>
1. Run the following command to set the environment variable for your .NET application, allowing it to access your newly created endpoint.

    ```
    cd mslearn-batch-stt
    dotnet user-secrets set CognitiveServices:BatchSTT:customKey $subKey
    ```

1. Run the following command in the Cloud Shell to use your custom model

    ```dotnet
    dotnet restore
    dotnet run
    ```