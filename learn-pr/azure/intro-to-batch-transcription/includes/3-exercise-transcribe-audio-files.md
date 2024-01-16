
Batch Transcription can transcribe entire storage containers with a single POST request. You can use the SDK to integrate transcription into your existing applications. However, in this exercise we use a POST request so that we can closely examine the entire end-to-end process.

First, we prepare an environment, then submit our jobs, check the job status, and view the results. Though we're using Bash in our Cloud Shell session, most commands can be executed through languages such as C# and Python. If you want to dive deeper, we have a [GitHub repository](https://github.com/MicrosoftDocs/mslearn-batch-stt) available.

## Preparing the environment

Let's start by preparing our environment. The following script creates our Azure AI services account and storage container.

1. Select **Copy**

    ```bash
    # Get and set the subscription and Resource Group
    subscription=$(az account list --query [0].id -o tsv)
    resourceGroupName=$(az group list --query "[0] | name" -o tsv)

    # Create the cognitive services account
    az cognitiveservices account create \
        --name cognitive-services-account-resource-speech \
        --resource-group $resourceGroupName \
        --kind SpeechServices \
        --sku S0 \
        --location westus2 \
        --subscription $subscription \
        --yes

    # Create a blob and container to hold our audio files
    # Create blob
    lastchars=${resourceGroupName: -10}
    blobName=blob$lastchars
    az storage account create \
        --name $blobName \
        --resource-group $resourceGroupName \
        --location westus2 \
        --sku Standard_ZRS

    # Create container
    blobContainerName=container$lastchars
    blobConnectionString=$(az storage account show-connection-string -g $resourceGroupName -n $blobName --query "connectionString" -o tsv)
    az storage container create \
        --name $blobContainerName \
        --public-access blob \
        --connection-string $blobConnectionString

    ```

1. Paste the code into the Cloud Shell session by selecting Ctrl+Shift+V on Windows and Linux, or Cmd+Shift+V on macOS
1. Press <kbd>Enter</kbd> to run the command

## Load audio files into the storage container

Batch Transcription can process WAV (PCM Codec), MP3 (PCM Codec), and OGG (Opus Codec) files sampled at 8 kHz or 16 kHz. These files must be at a publicly accessible or shared access signature (SAS) URI. Next, copy the example audio files from GitHub into the storage container you created in the previous step.

1. Run the following command to download the audio files

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-batch-stt.git
    ```

1. Now run the following command to copy the audio files into our storage container

    ```bash
    az config set extension.use_dynamic_install=yes_without_prompt
    az storage azcopy blob upload -c $blobContainerName --account-name $blobName -s "mslearn-batch-stt/audiofiles/*" --recursive

    ```

## Set up access keys and tokens

To produce and use transcriptions, you need tokens and access keys. Next, generate a SAS URI that allows the Batch Transcription service to securely access the audio files in your storage container.

First, we pass the SAS URI to the transcription service. This URI tells the service where the files are kept, and gives the service access to list and read our data. As Azure provides security by default, preventing public access to your files, we need to generate an access token that can be appended to the URL for the container.

1. Run the following command to generate the SAS token

    ```bash
    # We will make a key that expires in just under an hour's time
    end=`date -u -d "59 minutes" '+%Y-%m-%dT%H:%MZ'`
    sasToken=$(az storage container generate-sas -n $blobContainerName --permissions rwl --expiry $end --connection-string $blobConnectionString -o tsv)
    echo "Our token is:" $sasToken

    ```

1. We also need a key for the API so that we can access the results. Run the following command to generate this

    ```bash
    apiKeySpeech=$(az cognitiveservices account keys list -g $resourceGroupName -n cognitive-services-account-resource-speech --query [key1] -o tsv)
    echo "Our Key Is:" $apiKeySpeech

    ```

## Submitting the job

Now all the services are set up, you're going to submit the transcription job. We need to create a JSON body for the request, stating where our container is and the transcription options. Batch Transcription can process one or more files per batch. If more than one file is provided, the system attempts to process the files in parallel, minimizing turn-around time.

First, the command creates the secure URL for the container where the audio files are kept. It creates the command by using the names of the blob and container, and appending the SAS token you generated to the end of the URL. Then, the command creates a JSON object that contains the optional settings and locale for the transcription, along with the secure URL for the audio files.

> [!TIP]
>
> You can also include the URL of a container to save the transcription results directly by using `"destinationContainerUrl": "<URL for destination container>"`.
> When not specified, Microsoft stores the results in a storage container managed by Microsoft.

1. Run the following command to create the JSON body for your request

    ```bash
    # Create the JSON  
    contentContainerUrl="https://$blobName.blob.core.windows.net/$blobContainerName/?$sasToken"
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
      "locale": "en-US",
      "displayName": "Batch transcription"
    }'

    ```

1. Now, we're going to use cURL to submit the transcription job with a POST request. Notice we have the URL, and our Speech API key as a header. The `--data "$json"` is the request body, which is the JSON created in the previous step. Run the following command to submit your Batch Transcription job

    ```bash
    # Submit the job
    response=$(curl -X POST https://westus2.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions  \
    -H "Content-Type:application/json" \
    -H "Ocp-Apim-Subscription-Key:$apiKeySpeech" \
    --data "$json")

    ```

1. Our captured `response` provides some information about where our results are stored. To view it, paste the following echo command into the terminal.

    ```bash
    echo "$response"
    ```

1. Run the following query to see the status of the transcriptions:

    ```bash
    # Find the URI that will tell us the status. This is found in the original submission response
    info_uri=$(echo "$response" | grep -oP -m 1 "(\s*\"self\":\s*\"\K)([^\"]*)")

    # Check the status with a simple GET request
    job_information=$(curl -X GET $info_uri -H "Ocp-Apim-Subscription-Key:$apiKeySpeech")
    echo "$job_information"

    ```

    Take note of the status. When it states 'Succeeded', then move on. If it states the job is still running, wait 20 seconds, then paste the previous command into the terminal and run it again. Repeat this process until the status is 'Succeeded'!

## Viewing the results

To view our results, we need to see where they're saved to. We can extract this information from the results we previously looked at by using Regex.

1. Run the following command to retrieve the URI for the transcription information, and create a list of the individual transcription files.

    ```bash
    result_info_uri=$(echo $job_information | grep -oP -m 1 "(\s*\"files\":\s*\"\K)([^\"]*)")
    transcription_information=$(curl -X GET $result_info_uri -H "Ocp-Apim-Subscription-Key:$apiKeySpeech")
    echo "Information on our transcriptions:\n$transcription_information"

    ```

    > [!TIP]
    > You can select any of the contentUrl's to view the raw output of each transcription.

1. Let's now loop through these files, download them, and view the first transcript. Run the following command to extract the URLs with Regex, and download each transcript.

    ```bash
    # Extract the URLs using Regex
    # Note that this also collected the URL pointing to
    # meta information about our job
    transcript_uris=$(echo $transcription_information | grep -oP "(\s*\"contentUrl\":\s*\"\K)([^\"]*)")

    # Download each transcript
    i=0
    for uri in $transcript_uris; do 
    	echo "Downloading transcript" $i
    	curl -X GET $uri -s -H "Ocp-Apim-Subscription-Key:$apiKeySpeech" > transcript_$i.json
    	let "i++"
    done

    echo "Files Available: "$(ls transcript_*.json)

    ```

1. Run the following command to take a look at the first transcript.

    ```bash
    # View the first transcript in nano
    # Note that the transcript_0.json is meta information
    nano transcript_1.json

    ```

That's it! You can press <kbd>Ctrl+X</kbd> to exit the nano text editor.
