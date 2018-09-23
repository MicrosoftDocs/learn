Azure Cognitive Services is a rich suite of intelligent services that we can use to enrich our apps. The Text Analytics API has several operations to turn text into meaningful insights. We used the service to discover sentiment in text feedback from customers. We created a solution hosted in Azure Functions to sort these text messages into different buckets, or queues, for further processing.

Once you know how to call a REST API, then you can easily integrate these intelligent services into your solutions. They all follow a similar pattern:

- Sign up for an access key.
- Explore in the API testing console.
- Formulate requests using the access key and the correct region.
- POST requests from your solution, and parse the responses for insights.

We added this intelligence to serverless logic created in Azure Functions. You can easily call these services from other types of apps. There are many client libraries, tutorials, and quickstarts to get you started.

## Suggestions for further enhancement of our solution

Here are some ideas for you to consider if you want to take what we did further.

- Test the solution with more text samples. Decide whether the thresholds we set to categorize sentiment scores into positive, negative, and neutral are appropriate.
- Consider adding another function into your function app that reads messages from the [!INCLUDE [negative-q](./q-name-negative.md)] queue and calls the Text Analytics API to find key phrases in the text.
- Our input queue contains raw text feedback. In the real world, we would associate feedback with some form of user ID, such as email address, account number, and so on. Enhance the input queue items to be JSON documents containing an ID field and the text. Then use that ID when working with the text message.
- Currently our solution is "hard coded" to English. Think about the changes you'd implement to make it capable of handling text in all languages supported by the Text Analytics API.
- If you are familiar with Logic Apps, visit the link to the built-in connector for text analytics in the Further Reading section.

Now that you know how to call one of these Cognitive Services APIs, explore some of the other services and think about how you might use them in your solutions.

## Further reading

- [Text Analytics overview](https://docs.microsoft.com/azure/cognitive-services/text-analytics/overview)
- [Text Analytics demo](https://azure.microsoft.com/services/cognitive-services/text-analytics/)
- [How to detect sentiment in Text Analytics](https://docs.microsoft.com/azure/cognitive-services/text-analytics/how-tos/text-analytics-how-to-sentiment-analysis)
- [Cognitive Services Documentation](https://docs.microsoft.com/azure/cognitive-services/)

- [Text Analytics Logic Apps Connector](https://docs.microsoft.com/connectors/cognitiveservicestextanalytics/)

[!include[](../../../includes/azure-sandbox-cleanup.md)]
