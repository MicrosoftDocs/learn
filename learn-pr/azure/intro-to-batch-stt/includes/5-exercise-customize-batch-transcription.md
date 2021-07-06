## Train and evaluate a model

The first step to train a model is to upload training data. See [Prepare and test your data](./how-to-custom-speech-test-and-train.md) for step-by-step instructions to prepare human-labeled transcriptions and related text (utterances and pronunciations). After you upload training data, follow these instructions to start training your model:

learn.docs.microsoft.com?azure-portal=true

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

1. Select your newly created endpoint

    Notice how Speech Studio provides code to connect to your custom model in multiple programming languages via the SDK, REST API, and WebSocket.


After your endpoint is deployed, the endpoint name appears as a link. Select the link to see information specific to your endpoint, like the endpoint key, endpoint URL, and sample code. Take a note of the expiration date and update the endpoint's model before that date to ensure uninterrupted service.
