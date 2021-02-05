Recall that you are a lead developer researching how Video Indexer can help you build a solution for travelers to share their vacation videos.

## Understand the upload and index features

Extracting insights from videos starts with uploading and indexing the videos. Azure Video Indexer provides several options for uploading videos: upload from URL, send file as byte array, or reference existing asset ID. Many file formats are supported including WMV, MOV, MPG, and AVI. Once the video is uploaded, the indexing process starts automatically. Once completed, you can examine the indexer results.

The preferred option for uploading your video is to use a URL. Your video URL should point directly to a supported media file. You cannot upload media by referencing a webpage, such as a video page on youtube.com. If the file requires an access token, it should be included in the URI.

Another option for uploading your video is to include the content in the API request. To upload the video this way, first read in the media file as a byte array. Then add the byte array as multipart/form content. This method allows you to upload a media file from your computer directly to the Video Indexer service. This byte array option has limits of 2 GB in size and a 30-minute timeout.

## Environment setup

The environment for this exercise will make use of Visual Studio Code as the editor. Depending on the programming language you choose, the setup will differ. Follow the steps outlined here to configure your local computer for completion of the exercises.

1. Install [Visual Studio Code](https://code.visualstudio.com/) for your operating system.
1. If you will be completing your coding with **Python**, ensure you have a [Python environment](https://www.python.org/downloads/) installed locally.
1. Once you have **Python** installed, you will need to [install the extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) for VS Code.
1. If you will be using **C#** as your code language, start by installing the latest [.NET Core](https://docs.microsoft.com/dotnet/core/install/windows?tabs=netcore31) package for your platform. You can choose Windows, Linux, or macOS from the drop-down on this page.
1. Once you have .NET Core installed, you will need to add the **C# Extension** to VS Code. Select the **Extensions** option in the left nav pane, or press **CTRL+SHIFT+X** and enter C# in the search dialog.

With your environment setup, you are now ready to begin the coding exercise.

## Upload and index with the API

:::zone pivot="python"

Let’s use the API to upload and index videos.

1. Using the terminal window in Visual Studio Code, import the **requests** library with this command.

    ```bash
    pip install requests
    ```

1. Set the variables to access your account.

    ```python
    import requests
    import os

    account_id = os.environ["VIDEO_INDEXER_ACCOUNT"]
    location = os.environ["VIDEO_INDEXER_LOCATION"]
    api_key = os.environ["VIDEO_INDEXER_API_KEY"]
    api_url = "https://api.videoindexer.ai"
    ```

1. Create the HTTP client and get access token.

    ```python
    headers = {"Ocp-Apim-Subscription-Key": api_key}

    access_token_url = "{0}/auth/{1}/Accounts/{2}/AccessToken?allowEdit=true".format(api_url, location, account_id)
    access_token_result = requests.get(access_token_url, headers=headers)
    account_access_token = access_token_result.json()
    ```

1. Set video data and URL to video file. Choose your own video that is available via public URL or use the example included here. You can change the videoUrl, videoName, and videoDescription to customize the code.

    ```python
    video_url = "https://github.com/datakickstart/sample-content/blob/master/beach_waves_narrated.mp4?raw=true"
    video_name = "Beach waves"
    video_description = "Test video"

    form_data = None
    video_url_query_string = "&videoUrl={0}".format(video_url)
    ```

1. Alternatively, you can upload a file from your computer rather than using a URL. If so, use the following code instead. You will want to change the videoPath and videoName.

    ```python
    video_path = "local_media/waves_short.MOV"
    video_name = "waves"
    video_description = "Test video"

    form_data = {'file': open(video_path, 'rb')}
    video_url_query_string = ""
    ```

1. Upload and index video then print the Video ID to be used later.

    ```python
    base_url = "{0}/{1}/Accounts/{2}".format(api_url, location, account_id)
    video_upload_url = "{0}/Videos?accessToken={1}&name={2}&description={3}&privacy=private&partition=default{4}".format(
        base_url, account_access_token, video_name, video_description, video_url_query_string)
    upload_result = requests.post(video_upload_url, files=form_data)

    video_id = upload_result.json().get("id")
    print("Uploaded Video ID: " + video_id)
    ```

1. View the output, which will be a unique ID for your video upload.
    *Uploaded Video ID: 60eb06669e*

You will know your API call was successful if it outputs a Video ID. You can browse your media library in the Video Indexer Portal to see the resulting video. The indexing may take some time to complete. In the next section, you will learn more about the insights generated by the indexing process.

:::zone-end

:::zone pivot="csharp"

Let’s use the API to upload and index videos.

1. Using the terminal window in Visual Studio Code, import the Newtonsoft package for JSON parsing, with this command.

    ```bash
    dotnet add package Newtonsoft.Json
    ```

1. Import required libraries.

    ```csharp
    using System;
    using System.IO;
    using static System.Environment;
    using System.Net.Http;
    using Newtonsoft.Json;
    ```

1. Set the variables to access your account.

    ```csharp
    var accountId = GetEnvironmentVariable("VIDEO_INDEXER_ACCOUNT"); 
    var location = GetEnvironmentVariable("VIDEO_INDEXER_LOCATION");
    var apiKey = GetEnvironmentVariable("VIDEO_INDEXER_API_KEY"); 
    var apiUrl = "https://api.videoindexer.ai";
    ```

1. Create the HTTP client and get access token.

    ```csharp
    System.Net.ServicePointManager.SecurityProtocol = System.Net.ServicePointManager.SecurityProtocol | System.Net.SecurityProtocolType.Tls12;

    var handler = new HttpClientHandler(); 
    handler.AllowAutoRedirect = false; 
    var client = new HttpClient(handler);
    client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", apiKey); 

    var accountAccessTokenRequestResult = client.GetAsync($"{apiUrl}/auth/{location}/Accounts/{accountId}/AccessToken?allowEdit=true").Result;
    var accountAccessToken = accountAccessTokenRequestResult.Content.ReadAsStringAsync().Result.Replace("\"", "");

    client.DefaultRequestHeaders.Remove("Ocp-Apim-Subscription-Key");
    ```

1. Set video data and URL to video file. Choose your own video that is available via public URL or use the example included here. You can change the videoUrl, videoName, and videoDescription to customize the code.

    ```csharp
    var content = new MultipartFormDataContent();

    var videoUrl = "https://github.com/datakickstart/sample-content/blob/master/beach_waves_narrated.mp4?raw=true";
    var videoName = "Beach waves";
    var videoDescription = "Test video";

    var videoUrlQueryString = $"&videoUrl={videoUrl}";
    ```

1. Alternatively, you can upload a file from your computer rather than using a URL. If so, use the following code instead. You will want to change the videoPath and videoName.

    ```csharp
    var content = new MultipartFormDataContent();
    var videoPath = "local_media/waves_short.MOV";
    var videoName = "waves";
    var videoDescription = "Test video";

    var videoUrlQueryString = "";

    // Set content with data to upload
    FileStream video =File.OpenRead(videoPath);
    byte[] buffer = new byte[video.Length];
    video.Read(buffer, 0, buffer.Length);
    content.Add(new ByteArrayContent(buffer));
    ```

1. Upload and index video then print the Video ID to be used later.

    ```csharp
    var uploadRequestResult = client.PostAsync($"{apiUrl}/{location}/Accounts/{accountId}/Videos?accessToken={accountAccessToken}&name={videoName}&description={videoDescription}&privacy=private&partition=default{videoUrlQueryString}", content).Result;

    var uploadResult = uploadRequestResult.Content.ReadAsStringAsync().Result;

    // Get uploaded video ID
    var videoId = JsonConvert.DeserializeObject<dynamic>(uploadResult)["id"];
    Console.WriteLine("Uploaded Video ID: " + videoId);
    ```

1. View the output, which will be a unique ID for your video upload.
    *Uploaded Video ID: 60eb06669e*

You will know your API call was successful if it outputs a Video ID. You can browse your media library in the Video Indexer Portal to see the resulting video. The indexing may take some time to complete. In the next section, you will learn more about the insights generated by the indexing process.

:::zone-end

## Errors to consider

If you try to upload a video file that has not finished processing, you will receive an error that video upload is in progress. You can still upload that file again once the current upload completes.

Example error message:

```bash
{
"ErrorType": "VIDEO_ALREADY_IN_PROGRESS",
"Message": "This video is currently being uploaded (video id: '0f9700105e'). If you’d like to upload it again, please wait for the current upload to finish, and try again."
}
```

You also want to be aware of upload limits. If you are using a trial account, you may upload five videos per minute. For a paid account, the limit is 50 per minute.

Example error message:

```bash
{
"statusCode": 429,
"message": "Rate limit is exceeded. Try again in 43 seconds."
}
```

In the next section, you will learn how to examine the Video Indexer output once processing is complete.
