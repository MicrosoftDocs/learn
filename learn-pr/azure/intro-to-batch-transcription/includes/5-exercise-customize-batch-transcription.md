In the previous exercise, we used the standard en-us model. For the customer service scenario, you need to investigate if it's possible to create a custom model from existing call center data. To create this model, use the Custom Speech portal.

The first step to train a model is to upload training data. For more information, see [Prepare and test your data](/azure/ai-services/speech-service/how-to-custom-speech-test-and-train) for step-by-step instructions to prepare human-labeled transcriptions and related text (utterances and pronunciations).

## Train and evaluate a model

1. Sign in to the [Custom Speech portal](https://speech.microsoft.com/customspeech)

1. Go to **Speech to text** > **Custom Speech**

    :::image type="content" source="../media/5-azure-speech-portal.png" alt-text="Screenshot showing the home page of the speech portal with a red line around custom models.":::

1. Select **Resource** then **select your new Speech Services resource**
1. Select **Use resource**
1. Select **Create a new project**
1. Name your project, and select **Create**

    :::image type="content" source="../media/5-new-project.png" alt-text="Screenshot showing the Create a New Project window with an example name.":::

## Use audio data to create a custom speech model

Now you've created a project, it's time to upload some training data. Here, you use the sample data from Azure Samples to reduce processing time. However, you can provide your own data if you wish.

1. Select your new project by clicking on its name
1. Select **Upload data**
1. Make sure **Audio + human-labeled transcript** is highlighted, and select **Next**
1. Select **Azure Blob or other shared web locations**
1. Copy the following URL, and paste it into the **Audio + transcript** box, then select **Next**

    ```http
    https://github.com/Azure-Samples/cognitive-services-speech-sdk/raw/master/sampledata/customspeech/en-US/training/audio-and-trans.zip
    ```

    :::image type="content" source="../media/5-azure-blob-link.png" alt-text="Screenshot showing an example of steps 4 and 5 in the speech portal.":::

1. Choose a name for your dataset, and select **Next**
1. Select **Save and close**

## Train a custom model

After a few seconds, you'll see a message saying your files have successfully processed. Next, let's train a custom model using the sample data.

1. On the left-hand side, select the checkbox for the dataset, then select **Train**

    :::image type="content" source="../media/5-training-a-model.png" alt-text="Screenshot showing the example model selected and train outlined in the portal.":::

1. Select **Next**, then select **Next** again
1. Choose a name for your model, and select **Next**
1. Select **Save and close**

It might take several minutes for your model to complete training. In the meantime, lets set things up to use it.

## Set up your custom transcription

1. In the exercise sandbox, paste in the following command to get our environment variables ready for the next transcription. These variables use the same resources that we set up in the last exercise.

    ```bash
    # Get and set the names from the previous exercise
    subscription=$(az account list --query [0].id -o tsv)
    resourceGroupName=$(az group list --query "[0] | name" -o tsv)
    lastchars=${resourceGroupName: -10}
    blobName=blob$lastchars
    blobContainerName=container$lastchars
    blobConnectionString=$(az storage account show-connection-string -g $resourceGroupName -n $blobName --query "connectionString" -o tsv)
    apiKeySpeech=$(az cognitiveservices account keys list -g $resourceGroupName -n cognitive-services-account-resource-speech --query [key1] -o tsv)
    # Create a new SAS Token
    end=`date -u -d "59 minutes" '+%Y-%m-%dT%H:%MZ'`
    sasToken=$(az storage container generate-sas -n $blobContainerName --permissions rwl --expiry $end --connection-string $blobConnectionString -o tsv)
    # Create the new URI for the storage container
    contentContainerUrl="https://$blobName.blob.core.windows.net/$blobContainerName/?$sasToken"

    ```

## Use your custom model

Now, to use the model we need to refer to it in the Cloud Shell.

We can do this using an endpoint, or linking directly to the model. Here, we link directly to the model.

1. **Return to the Custom Speech portal**, and navigate to the **Train custom models section** on the far left-hand menu of the website.

1. If your model has completed training, it's listed with its name in blue. If it isn't ready, wait a few minutes for training to complete. Once it's ready, select your model's name.

1. **Copy your Model ID** from the top of the page. It's listed as a GUID such as 0000000-1234-5678-9abc-def012345678.

1. Return to the sandbox terminal, and type `model_id=<your-model-id>`, replacing \<your-model-id\> with the GUID you copied in the previous step. Then, press <kbd>Enter</kbd>

1. Next, we follow the same steps as we did in the first exercise to create a new batch of transcriptions using the custom model. This time, you specify that Batch Transcription should use your newly created Custom Model in the JSON. Notice how we specify the endpoint with the Azure AI services URL, and the custom model ID. Run the following command to create the JSON.

    ```bash
    # Create the JSON  
    json='{
      "contentContainerUrl": "'$contentContainerUrl'",
      "properties": {
    	"diarizationEnabled": false,
    	"wordLevelTimestampsEnabled": false,
    	"punctuationMode": "None",
    	"profanityFilterMode": "None",
    	"duration": "PT0S",
    	"timeToLive": "P1D"
      },
        "model": {
            "self": "https://westus2.api.cognitive.microsoft.com/speechtotext/v3.0/models/'$model_id'"
        },
      "locale": "en-US",
      "displayName": "Batch transcription"
    }'

    ```

1. Now, we're going to use cURL to submit the transcription job with a POST request. Run the following command to submit your next Batch Transcription job.

    ```bash
    # Submit the job
    response=$(curl -X POST https://westus2.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions  \
    -H "Content-Type:application/json" \
    -H "Ocp-Apim-Subscription-Key:$apiKeySpeech" \
    --data "$json")

    ```

1. Run the following query again to see the status of the new transcriptions:

    ```bash
    # Find the URI that will tell us the status. This is found in the original submission response
    info_uri=$(echo "$response" | grep -oP -m 1 "(\s*\"self\":\s*\"\K)([^\"]*)")

    # Check the status with a simple GET request
    job_information=$(curl -X GET $info_uri -H "Ocp-Apim-Subscription-Key:$apiKeySpeech")
    echo "$job_information"

    ```

    Take note of the status. **Once it states 'Succeeded', then move on.** It might take a minute or two to run. If it states the job is still running, wait 20 seconds, then paste the previous command into the terminal and run it again. **Repeat this until the status is 'Succeeded'**

1. Run the following command to retrieve the URI for the transcription information and download the individual transcription files.

    ```bash
    result_info_uri=$(echo $job_information | grep -oP -m 1 "(\s*\"files\":\s*\"\K)([^\"]*)")
    transcription_information=$(curl -X GET $result_info_uri -H "Ocp-Apim-Subscription-Key:$apiKeySpeech")
    echo "Information on our transcriptions:\n$transcription_information"
    # Extract the URLs using Regex
    # Note that this also collected the URL pointing to
    # meta information about our job
    transcript_uris=$(echo $transcription_information | grep -oP "(\s*\"contentUrl\":\s*\"\K)([^\"]*)")

    # Download each transcript
    i=0
    for uri in $transcript_uris; do 
    	echo "Downloading transcript" $i
    	curl -X GET $uri -s -H "Ocp-Apim-Subscription-Key:$apiKeySpeech" > custom_transcript_$i.json
    	let "i++"
    done

    echo "Files Available: "$(ls custom_transcript_*.json)

    ```

1. Run the following command to take a look at the first transcript.

    ```bash
    # View the first transcript in nano
    # Note that the transcript_0.json is meta information
    nano custom_transcript_1.json

    ```

That's it! You can press <kbd>Ctrl+X</kbd> to exit the nano text editor.

Congratulations, you're now transcribing your entire storage container of audio files with your Custom Speech model.
