Now that you have a resource available in Azure for content moderation, and you have a subscription key for that resource, let's run some tests by using the API web-based testing console.

1. Go to the [Content Moderator API Reference page](https://westus.dev.cognitive.microsoft.com/docs/services/57cf753a3f9b070c105bd2c1/operations/57cf753a3f9b070868a1f66f). This page is available in a number of regions for testing in the API console.
1. For the geographic region closest to you, select the appropriate location button to open the console.
1. Note the query parameters that you can select for your test. For the first test run, keep the default options.
1. Paste your subscription key into the **Ocp-Apim-Subscription-Key** box.

    ![Paste subscription key into Ocp-Apim-Subscription-Key box](../media/4-exercise-paste-key.png)

1. Leave the sample text in place, and then click **Send**.

## Evaluate the response

- Scroll down the page and evaluate the response from the testing console.

  This first test used _classification_ because the `classify` parameter was set to `true` at the top of the page. The response contains the following information:

  - A review is recommended.
  - The text is classified as category 3 (potential presence of language that might be considered offensive in certain situations).
  - The potentially offensive term is "crap."

## Run additional tests

1. To run the second test, scroll to the top of the page and set the `PII` parameter to `true`.

   ![Set PII parameter to true](../media/4-exercise-set-pii.png)

1. Select **Send**.

   Note that PII content is now displayed, showing that the email address, IP address, phone number, mailing address, and Social Security number are all considered potential PII.

1. To run additional tests, enter some of your own text values from an existing document and run the tests again to see the results returned.

1. Study the JSON response and the Request URL syntax to see how your custom applications can call this API.

> [!TIP]
> To test this API by using a C# application, see [Quickstart: Analyze text content for objectionable material in C#](https://docs.microsoft.com/azure/cognitive-services/content-moderator/text-moderation-quickstart-dotnet).