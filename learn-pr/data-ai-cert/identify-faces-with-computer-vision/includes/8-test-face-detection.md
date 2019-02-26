Next, let's use the Face subscription you just created to detect faces in images from a URL.

1. Visit your Face subscription that you created in the previous topic.
1. Copy one of the keys for that subscription by using the Copy button at the right of the key
1. Open https://westus.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236/console in your browser
1. Paste your key into the Ocp-Apim-Subscription-Key text box as shown here:

![Copying the Face API key to the test page](../media/7-test-face-detection-key.png)

5. Paste this URL into the Request body, https://raw.githubusercontent.com/MicrosoftDocs/mslearn-work-with-vision-cognitive-services/master/CLO19_Ubisoft_Azure_068.png?token=AJAEHQbaokX0zmeFzxe8gaePqKCDjYidks5cPRBWwA%3D%3D.

> [!NOTE]
> Currently the request body consists of the following JSON.  Replace the example URL with the URL provided for the sample image in step 4.

```JSON
{
    "url": "http://example.com/1.jpg"
}

```

6. If you pasted the correct key and URL, your response should look like this:

![The response from the API test showing the face rectangle locations](../media/7-test-face-detection-response.png)

For reference, this is the image that was uploaded for the test.

![Reference image showing the face in the image that was tested](../media/CLO19_Ubisoft_Azure_068.png)