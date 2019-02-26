Now that you have a service available on Azure for content moderation, and you have a key for that service, let's run some tests using the API web-based console.

1. Navigate to the [Content Moderator API Reference page](https://westus.dev.cognitive.microsoft.com/docs/services/57cf753a3f9b070c105bd2c1/operations/57cf753a3f9b070868a1f66f). This service is available in a number of regions for testing in the API console. 
1. Select the appropriate location on this page for the geographic region closest to you.  
1. Click the region button to open the test console.
1. Note the query parameters that you can select for your test. Leave the default options for the first test run
1. Paste your Key into the **Ocp-Apim-Subscription-Key** value text box.

    ![Paste API key into header key text box](../media/4-exercise-paste-key.png)

1. Leave the sample text in place and click **Send**.

## Evaluate the response

Scroll down on the page and evaluate the response that was returned.

This first test was accomplished using _classification_ because the **Classify** parameter was set to **True** at the top of the page. The following information is contained in the response:
    - A review is recommended
    - The text was classified as category 3 (potential presence of language that may be considered offensive in certain situations)
    - The "offending" term that was found was 'crap'

1. Scroll to the top of the page and set the PII parameter to **true**.

    ![Set PII parameter to true](../media/4-exercise-set-pii.png)

1. Click **Send** again.

    Notice that PII content is now displayed showing that the email, IP address, phone, address, and social security numbers are all considered PII.

1. Locate, or enter, some of your own text values from an existing document and run the tests again to see the results returned

1. Evaluate the JSON response and the Request URL to gain an understanding of how your custom applications may call this API

> [!TIP]
> If you want to test this API using a C# application, complete the [Quickstart on the docs site](https://docs.microsoft.com/azure/cognitive-services/content-moderator/text-moderation-quickstart-dotnet).