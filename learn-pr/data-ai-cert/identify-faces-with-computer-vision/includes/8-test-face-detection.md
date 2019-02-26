Next, let's use the Face subscription you just created to detect faces in images from a URL.

1. Visit your Face subscription that you created earlier.
1. Copy one of the keys for that subscription by using the **Copy** button at the right of the key value.
1. Open the [Face Detect testing console](https://westus.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236/console/?azure-portal=true) in your browser.
1. Paste your key into the **Ocp-Apim-Subscription-Key** text box.

    ![Copying the Face API key to the test page](../media/7-test-face-detection-key.png)

1. Next, you need an image with a face in it. Here's an example one you can use - or you can use your own image URL.

    ![Reference image showing a face to be tested](../media/CLO19_Ubisoft_Azure_068.png)

1. In the **Request body** section of the tester, paste in the URL as a JSON block as shown below. Here we're using the above image URL, but if you want to try your own image, replace the `url` value below.

```JSON
{
    "url": "https://docs.microsoft.com/learn/data-ai-cert/identify-faces-with-computer-vision/media/clo19_ubisoft_azure_068.png"
}

```

6. If you pasted the correct key and URL, your response should look something like this:

![The response from the API test showing the face rectangle locations](../media/7-test-face-detection-response.png)