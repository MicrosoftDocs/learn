The first step to train a model is to upload training data. For more information, see [Prepare and test your data](/azure/cognitive-services/speech-service/how-to-custom-speech-test-and-train) for step-by-step instructions to prepare human-labeled transcriptions and related text (utterances and pronunciations).

## Train and evaluate a model

1. Sign in to the [Custom Speech portal](https://speech.microsoft.com/customspeech)

1. Go to **Speech-to-text** > **Custom Speech**

    :::image type="content" source="../media/5-azure-speech-portal.png" alt-text="Screenshot showing the home page of the speech portal with a red line around custom models.":::
    
1. Select **Resource** then **select your new Speech Services resource**
1. Select **Use resource**
1. Select **Create a new project**
1. Name your project, and select **Create**

    :::image type="content" source="../media/5-new-project.png" alt-text="Screenshot showing the Create a New Project window with an example name.":::

## Use audio data to create a custom speech model

1. Select your new project
1. Select **Upload data**
1. Make sure 'Audio + human-labeled transcript' is highlighted, and select **Next**
1. Select **Azure Blob or shared location**
1. Copy the following URL, and paste it into the 'Audio + transcript' box

    ```
    https://github.com/Azure-Samples/cognitive-services-speech-sdk/raw/master/sampledata/customspeech/en-US/training/audio-and-trans.zip
    ```

    :::image type="content" source="../media/5-azure-blob-link.png" alt-text="Screenshot showing an example of steps 4 and 5 in the speech portal.":::

1. Select **Next**
1. Choose a name for your dataset, and select **Next**
1. Select **Save and close**

## Train a custom model

After a few seconds, you will see a message saying your files have successfully processed. Next, let's train a custom model using the data.

1. On the left-hand side, select the check box for the dataset, then select **Train**

    :::image type="content" source="../media/5-training-a-model.png" alt-text="Screenshot showing the example model selected and train outlined in the portal.":::

1. Select **Next**, then select **Next** again
1. Choose a name for your model, and select **Next**
1. Select **Save and close**

## Create an endpoint for your model

While your model trains, let's create and endpoint so your model can be used in applications.

1. On the left-hand menu, select **Deploy models**
1. Select **Deploy model**

    :::image type="content" source="../media/5-deploy-a-model.png" alt-text="Screenshot showing red boxes around the buttons needed to select to complete steps 1 and 2.":::

1. Choose a name for your model, accept the terms of use, and select **Add**

    :::image type="content" source="../media/5-new-endpoint.png" alt-text="Screenshot showing an example of creating an endpoint in the Azure portal.":::

It might take a minute for your endpoint to be created.

## Use your custom model

Now, we need to transfer the details for the endpoint over to the Cloud Shell. It may take a minute or two for everything to finish processing.

1. Select your newly created endpoint

    Notice how Speech Studio provides code to connect to your custom model in multiple programming languages via the SDK, REST API, and WebSocket.

1. **Copy your Endpoint ID**



Congratulations, you're now transcribing your entire storage container of audio files with your Custom Speech model.




    **LEE**: Add this into the .NET, not the user secrets https://westus2.api.cognitive.microsoft.com/speechtotext/v3.0/models/<id will go here>
