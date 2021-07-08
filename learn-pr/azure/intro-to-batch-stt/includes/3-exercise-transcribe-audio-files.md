Batch Transcription can process WAV (PCM Codec), MP3 (PCM Codec), and OGG (Opus Codec) files sampled at 8 kHz or 16 kHz. These must be at a publicly accessible or shared access signature (SAS) URI.  It can process one or more files per batch. If more than one file is provided, the system attempts to process these in parallel, minimizing turn-around time.
​
We will prepare an environment, submit our jobs, check the job status, then view the results. We will work in Bash here, though note most commands can be executed through languages such as C#. 
​​
## Preparing the environment
​
Let's start by preparing our environment. The following script creates our cognitive services account and storage container.

As you come to code below:
1. Select **Copy**

```bash

# Get and set the subscription and Resource Group
subscription=$(az account list --query [0].id -o tsv)
resourceGroupName=$(az group list --query "[0] | name" -o tsv)
​​
# Create the cognitive services account
az cognitiveservices account create \
    --name cognitive-services-account-resource-speech \
    --resource-group $resourceGroupName \
    --kind SpeechServices \
    --sku S0 \
    --location westus2 \
    --subscription $subscription \
    --yes
​

# Create a blob and container to hold our audio files
# Create blob
blobName=sttblob$RANDOM
az storage account create \
    --name $blobName \
    --resource-group $resourceGroupName \
    --location westus2 \
    --sku Standard_ZRS
​
# Create container
blobContainerName=sttcontainer$RANDOM
blobConnectionString=$(az storage account show-connection-string -g $resourceGroupName -n $blobName --query "connectionString" -o tsv)
az storage container create \
    --name $blobContainerName \
    --public-access blob \
    --connection-string $blobConnectionString

```

1. Paste the code into the Cloud Shell session by selecting Ctrl+Shift+V on Windows and Linux, or Cmd+Shift+V on macOS.
1. Press <kbd>Enter</kbd> to run the command.

​## Load audio files into the storage container
​
1. Run the following command to download the audio files.
​
    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-batch-stt.git
    ```
​
1. Now run the following command to copy the audio files into our storage container
​
    ```bash
    az config set extension.use_dynamic_install=yes_without_prompt
    az storage azcopy blob upload -c $blobContainerName --account-name $blobName -s "mslearn-batch-stt/audiofiles/*" --recursive
    ```
​
## Set up access keys and tokens
​
To produce and use transcriptions, we need tokens and access keys.
​
Firstly, the transcription service will need to be passed a URI that allows it to read our data. As we have security preventing public access we will need to generate an access token that can be appended to the URL. Run the following command to generate this token.
​
    ```bash
    # We will make a key that expires in just under an hour's time
    end=`date -u -d "59 minutes" '+%Y-%m-%dT%H:%MZ'`
    sasToken=$(az storage container generate-sas -n $blobContainerName --permissions rwl --expiry $end --connection-string $blobConnectionString -o tsv)
    echo "Our token is:" $sasToken
    ```
​
2. We also need a key for the API so that we can access the results. Run the following command to generate this
​
​
```bash
apiKeySpeech=$(az cognitiveservices account keys list -g $resourceGroupName -n cognitive-services-account-resource-speech --query [key1] -o tsv)
echo "Our Key Is:" $apiKeySpeech
```
​
​
## Submitting the job
​
To submit the transcription job, we need to create some simple JSON stating where our container is and the transcription options. Run the following code to create this JSON and submit the job
​
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
  "displayName": "Batch transcription",
  "createdDateTime": "0001-01-01T00:00:00Z",
  "lastActionDateTime": "0001-01-01T00:00:00Z"
}'
​
# Submit the job
response=$(curl -X POST https://westus2.api.cognitive.microsoft.com/speechtotext/v3.0/transcriptions  \
-H "Content-Type:application/json" \
-H "Ocp-Apim-Subscription-Key:$apiKeySpeech" \
--data "$json")
​
```
​
Our captured `response` provides some information about where our results will be stored. If you would like, echo it to the terminal.
​
```bash
echo "$response"
```
​
Query again now to see the status of our transcriptions:
​
```bash
# Find the URI that will tell us the status. This is found in the original submission response
info_uri=$(echo "$response" | grep -oP -m 1 "(\s*\"self\":\s*\"\K)([^\"]*)")
​
# Check the status with a simple GET request
job_information=$(curl -X GET $info_uri -H "Ocp-Apim-Subscription-Key:$apiKeySpeech")
echo "$job_information"
```
​
Take note of the status. It it states 'Succeeded', then move on. If it states the job is still running, wait 20 seconds and run the code again. Repeat this until the job is complete!
​
## Viewing the results
​
To view our results, we need to see where they are saved to in general. We can extract this information from results we previously looked at. We use Regex here to do this
​
```bash
result_info_uri=$(echo $job_information | grep -oP -m 1 "(\s*\"files\":\s*\"\K)([^\"]*)")
echo "We can find information on our results at" $result_info_uri
```
​
Now make a list of individual files
```bash
transcription_information=$(curl -X GET $result_info_uri -H "Ocp-Apim-Subscription-Key:$apiKeySpeech")
echo "Information on our transcriptions:\n$transcription_information"
```
​
Let's now loop through these files, download them, and view the first transcript:
​
```bash
# Extract the URLs using Regex
# Note that this also collected the URL pointing to
# meta information about our job
transcript_uris=$(echo $transcription_information | grep -oP "(\s*\"contentUrl\":\s*\"\K)([^\"]*)")
​
# Download each transcript
i=0
for uri in $transcript_uris; do 
	echo "Downloading transcript" $i
	curl -X GET $uri -s -H "Ocp-Apim-Subscription-Key:$apiKeySpeech" > transcript_$i.json
	let "i++"
done
​
echo "Files Available: "$(ls transcript_*.json)
```
​
Let's take a look at the first transcript
​
```bash
# View the first transcript in nano
# Note that the transcript_0.json is meta information
nano transcript_1.json
```
​
That's it! 
If you'd like, use nano to view the other transcripts we have created.
