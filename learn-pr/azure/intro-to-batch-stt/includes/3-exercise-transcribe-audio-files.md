Batch Transcription can process WAV (PCM Codec), MP3 (PCM Codec), and OGG (Opus Codec) files sampled at 8kHz or 16kHz. These must be at a publicly accessible or shared access signature (SAS) URI.  It can process one or more files per batch. If more than one file is provided, the system attempts to process these in parallel, minimizing turn-around time.

Let's start by preparing our environment. We're going to create our cognitive services resources, and a storage blob to host the audio files.

```
# Get and set the subscription and RG
subscription=$(az account list --query [0].id -o tsv)
resourceGroupName=$(az group list --query "[0] | name" -o tsv)

# Create the cognitive services account
az cognitiveservices account create \
    --name cognitive-services-account-resource-speech \
    --resource-group $resourceGroupName \
    --kind SpeechServices \
    --sku S0 \
    --location westus2 \
    --subscription $subscription\
    --yes

# Set the key and endpoint for the speech service
apiKeySpeech=$(az cognitiveservices account keys list -g $resourceGroupName -n cognitive-services-account-resource-speech --query [key1] -o tsv)
endpointSpeech=https://westus2.api.cognitive.microsoft.com/sts/

# Create blob
blobName=blobstt$RANDOM
az storage account create \
    --name $blobName \
    --resource-group $resourceGroupName \
    --location westus2 \
    --sku Standard_ZRS \

# Create container
blobContainerName=sttblob$RANDOM
blobConnectionString=$(az storage account show-connection-string -g $resourceGroupName -n $blobName --query "connectionString" -o tsv)
az storage container create \
    --name $blobContainerName \
    --public-access blob \
    --connection-string $blobConnectionString
```



az storage account keys list -g $resourceGroupName -n $blobName --query [0].value

Get keys
az storage account keys list -g $resourceGroupName -n $blobName

az storage account keys list -g MyResourceGroup -n MyStorageAccount


New
end=`date -u -d "120 minutes" '+%Y-%m-%dT%H:%MZ'`
az storage blob generate-sas -c $blobContainerName -n $blobName --permissions w --expiry $end --https-only

Original
end=`date -u -d "30 minutes" '+%Y-%m-%dT%H:%MZ'`
az storage blob generate-sas -c myycontainer -n MyBlob --permissions r --expiry $end --https-only