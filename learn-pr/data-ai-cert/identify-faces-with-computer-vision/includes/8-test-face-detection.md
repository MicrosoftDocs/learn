Next, let's use the Face subscription you just created to detect faces in images from a URL.

We're going to use the Azure Cognitive Services _testing console_ which is a built-in website you can use to build and send the REST requests for any of the AI services.

1. Visit your Face subscription that you created earlier.
1. Copy one of the keys for that subscription by using the **Copy** button at the right of the key value.

1. Open the [Face Detect API service page](https://westus.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/?azure-portal=true).

1. Scroll down to the **Face Detect** section and click the **Open API testing console** button associated with the location you created your Azure service in. For example, if you used _WestUS_, then click the **West US** button in the testing console section. This will open up a new testing page where you can enter the parameters you want to send to the service, submit the request, and then see the response right in the browser.

1. Scroll down to the **Headers** section and paste your subscription key into the **Ocp-Apim-Subscription-Key** text box.

    ![Copying the Face API key to the test page](../media/7-test-face-detection-key.png)

1. Next, you need an image with a face in it. Here's an example one you can use - or you can use your own image URL.

    ![Reference image showing a face to be tested](../media/CLO19_Ubisoft_Azure_068.png)

1. In the **Request body** section of the tester, paste in the URL as a JSON block as shown below. Here we're using the above image URL, but if you want to try your own image, replace the `url` value below.

    ```json
    {
        "url": "https://docs.microsoft.com/learn/data-ai-cert/identify-faces-with-computer-vision/media/clo19_ubisoft_azure_068.png"
    }
    
    ```
1. Click **Send** to send the request.

The HTTP response should look something like this:

![The response from the API test showing the face rectangle locations](../media/7-test-face-detection-response.png)