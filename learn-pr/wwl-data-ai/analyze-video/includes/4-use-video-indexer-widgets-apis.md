While you can perform all video analysis tasks in the Azure Video Indexer portal, you may want to incorporate the service into custom applications. There are two ways you can accomplish this.

## Azure Video Indexer widgets

The widgets used in the Azure Video Indexer portal to play, analyze, and edit videos can be embedded in your own custom HTML interfaces. You can use this technique to share insights from specific videos with others without giving them full access to your account in the Azure Video Indexer portal.

![Video Analyzer widgets in a custom web page](../media/widgets.png)

## Azure Video Indexer API

Azure Video Indexer provides a REST API that you can use to obtain information about your account, including an access token.

```http
https://api.videoindexer.ai/Auth/<location>/Accounts/<accountId>/AccessToken
```

You can then use your token to consume the REST API and automate video indexing tasks, creating projects, retrieving insights, and creating or deleting custom models.

For example, a GET call to `https://api.videoindexer.ai/<location>/Accounts/<accountId>/Customization/CustomLogos/Logos/<logoId>?<accessToken>` REST endpoint returns the specified logo. In another example, you can send a GET request to `https://api.videoindexer.ai/<location>/Accounts/<accountId>/Videos?<accessToken>`, which returns details of videos in your account, similar to the following JSON example:

```JSON
{
    "accountId": "SampleAccountId",
    "id": "30e66ec1b1",
    "partition": null,
    "externalId": null,
    "metadata": null,
    "name": "test3",
    "description": null,
    "created": "2018-04-25T16=50=00.967+00=00",
    "lastModified": "2018-04-25T16=58=13.409+00=00",
    "lastIndexed": "2018-04-25T16=50=12.991+00=00",
    "privacyMode": "Private",
    "userName": "SampleUserName",
    "isOwned": true,
    "isBase": true,
    "state": "Processing",
    "processingProgress": "",
    "durationInSeconds": 13,
    "thumbnailVideoId": "30e66ec1b1",
    "thumbnailId": "55848b7b-8be7-4285-893e-cdc366e09133",
    "social": {
        "likedByUser": false,
        "likes": 0,
        "views": 0
    },
    "searchMatches": [],
    "indexingPreset": "Default",
    "streamingPreset": "Default",
    "sourceLanguage": "en-US"
}
```

## Deploy with ARM template

Azure Resource Manager (ARM) templates are available to create the Azure AI Video Indexer resource in your subscription, based on the parameters specified in the template file.

For a full list of available APIs, see the [Video Indexer Developer Portal](https://api-portal.videoindexer.ai/).
