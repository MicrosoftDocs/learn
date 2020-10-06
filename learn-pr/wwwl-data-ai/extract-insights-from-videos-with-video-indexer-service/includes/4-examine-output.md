You have uploaded a video and browsed the results in the Video Indexer portal. Now you want to use the results to understand more about the video. The information created by the indexing process will help you improve the experience for travelers browsing your site. For example, you may use the generated labels for your video search algorithm or take identified sentiments as input into a recommendations model. Let’s explore the information generated when a video is indexed.

What is included?
The Video Indexer output is where you find the key details that were extracted from the video. This output includes unique identifiers, video metadata, summarized insights, and video detail insights.

As an overview of the type of information available, here are just some of the important elements. A sample of items from the videos section:

| Name | Description |
|---|---|
| insights | An important object with the insight details for the video. See the next table for more detail. |
| publishedUrl | URL used to stream the video. |
| viewToken | A temporary token to access the streaming video. |
| statistics | Attributes include SpeakerWordCount and SpeakerTalkToListenRatio. |

A sample of items from the insights section (within each video object and summarized insights):

| Name | Description |
|---|---|
| transcript | Transcript text lines as a list with start and end time of each. |
| ocr | Text detected in the video using optical character recognition. |
| keywords | Keywords extracted from speech and visual text. |
| labels | Identified objects, actions, and setting. |
| faces | Faces detected in the video, based on a person model |
| brands | Brand names identified through speech to text transcript or OCR. |
| sentiments | Sentiments detected (Positive, Negative, or Neutral) and score. |
| emotions | Emotions detected from speech and audio: joy, sadness, anger, or fear. |

To fully explore the output, you can run your own example from the API or download insights as JSON from the Video Indexer portal.

## Retrieve indexer results with the API

The insights are available for you to use once a video has been uploaded and the indexer process has completed. You can view results by using the portal or the API. You will want to get the output using the API since users of your site will not be able to sign on to the Video Indexer portal.

You can use either an account level access token or a video level access token. The video level token has a smaller scope, which is preferred for most applications. For learning purposes, it is fine to continue using the account level token that was required for uploading the video.

Let’s look at how you use the API to get the results of the video indexing.

:::zone pivot="python"

1. Use similar code as the previous section to set up the client and get an access token.

    ```python
    import requests
    import os

    account_id = os.environ["VIDEO_INDEXER_ACCOUNT"]
    location = os.environ["VIDEO_INDEXER_LOCATION"]
    api_key = os.environ["VIDEO_INDEXER_API_KEY"]
    api_url = "https://api.videoindexer.ai"

    headers = {"Ocp-Apim-Subscription-Key": api_key}

    access_token_url = "{0}/auth/{1}/Accounts/{2}/AccessToken?allowEdit=true".format(api_url, location, account_id)
    access_token_result = requests.get(access_token_url, headers=headers)
    account_access_token = access_token_result.json()
    ```

1. Add the code to Get the indexer results using the Index endpoint. Replace the videoId value with the output of the upload code.

    ```python
    video_id = "60eb06669e"

    base_url = "{0}/{1}/Accounts/{2}".format(api_url, location, account_id)
    video_index_url = "{0}/Videos/{1}/Index?accessToken={2}&language=English".format(
        base_url, video_id, account_access_token)

    index_result = requests.get(video_index_url)

    processing_state = index_result.json().get("state")
    if processing_state != "Uploaded" and processing_state != "Processing":
        print("Full JSON:")
        print(index_result.json())
    else:
        print("Video has not finished processing. Wait a minute then try again.")
    ```

1. View the output, which will include many attributes. One useful section is the summarizedInsights object, which starts similar to the following.

    ```json
    "summarizedInsights": {
    "name": "Beach waves",
    "id": "60eb06669e",
    "duration": {
        "time": "0:00:13.355",
        "seconds": 13.4
    },
    "faces": [],
    "keywords": [],
    "sentiments": [{
        "sentimentKey": "Neutral",
        "seenDurationRatio": 0.3744,
        }],
    "emotions": [],
    "audioEffects": [],
    "labels": [{
        "id": 1,
        "name": "outdoor",
        "appearances": [{
            "startTime": "0:00:00",
            "endTime": "0:00:13.3",
            "startSeconds": 0,
            "endSeconds": 13.3
        }]
    }
    ```

:::zone-end

:::zone pivot="csharp"

1. Use similar code as the previous section to set up the client and get an access token.
1. Add this client setup code to your main class.

    ```csharp
    using System;
    using System.IO;
    using static System.Environment;
    using System.Net.Http;
    using Newtonsoft.Json;

    // Get configs from environment variables
    var accountId = GetEnvironmentVariable("VIDEO_INDEXER_ACCOUNT"); 
    var location = GetEnvironmentVariable("VIDEO_INDEXER_LOCATION");
    var apiKey = GetEnvironmentVariable("VIDEO_INDEXER_API_KEY"); 
    var apiUrl = "https://api.videoindexer.ai";

    // Create http client and get access token
    System.Net.ServicePointManager.SecurityProtocol = System.Net.ServicePointManager.SecurityProtocol | System.Net.        SecurityProtocolType.Tls12;
    var handler = new HttpClientHandler();
    handler.AllowAutoRedirect = false;
    var client = new HttpClient(handler);
    client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", apiKey);

    var accountAccessTokenRequestResult = client.GetAsync($"{apiUrl}/auth/{location}/Accounts/{accountId}/AccessToken?allowEdit=true").Result;
    var accountAccessToken = accountAccessTokenRequestResult.Content.ReadAsStringAsync().Result.Replace("\"", "");

    client.DefaultRequestHeaders.Remove("Ocp-Apim-Subscription-Key");
    ```

1. Add the code to Get the indexer results using the Index endpoint. Replace the videoId value with the output of the upload code.

    ```csharp
    var videoId = "60eb06669e";
    var videoGetIndexRequestResult = client.GetAsync($"{apiUrl}/{location}/Accounts/{accountId}/Videos/{videoId}/Index?accessToken={accountAccessToken}&language=English").Result;
    var videoIndexResult = videoGetIndexRequestResult.Content.ReadAsStringAsync().Result;

    var processingState = JsonConvert.DeserializeObject<dynamic>(videoIndexResult)["state"];

    // Print results if indexing finished successfully
    if (processingState != "Uploaded" && processingState != "Processing")
    {
       Console.WriteLine("Full JSON:");
       Console.WriteLine(JsonConvert.DeserializeObject<dynamic>(videoIndexResult));
    }
    else
    {
       Console.WriteLine("Video has not finished processing. Wait a minute then try again.");
    }
    ```

1. View the output, which will include many attributes. One useful section is the summarizedInsights object, which starts similar to the following.

    ```json
    "summarizedInsights": {
    "name": "Beach waves",
    "id": "60eb06669e",
    "duration": {
        "time": "0:00:13.355",
        "seconds": 13.4
    },
    "faces": [],
    "keywords": [],
    "sentiments": [{
        "sentimentKey": "Neutral",
        "seenDurationRatio": 0.3744,
        }],
    "emotions": [],
    "audioEffects": [],
    "labels": [{
        "id": 1,
        "name": "outdoor",
        "appearances": [{
            "startTime": "0:00:00",
            "endTime": "0:00:13.3",
            "startSeconds": 0,
            "endSeconds": 13.3
        }]
    }
    ```
:::zone-end
