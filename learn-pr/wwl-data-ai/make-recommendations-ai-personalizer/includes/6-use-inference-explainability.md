Azure AI Personalizer's *inference explainability* helps you to better understand which specific features related to an action have the most or least influence on the underlying model during decision making. Inference explainability does this by adding *feature scores*  for different features from the model into the response from the Rank API. Feature scores are scores that you can use to find out why a particular recommendation was made to your users, and provide analysis on whether your model shows any bias against or for any particular users, actions, or contextual settings.

## Enable inference explainability

To enable inference explainability, you need to update your Azure AI Personalizer's service configuration. You can do this by using the [Service Configuration - Update API](/rest/api/personalizer/1.1preview1/service-configuration/update?tabs=HTTP).

You send a **PUT** request to `{Your-Endpoint}/personalizer/v1.1-preview.1/configurations/service`. Your request body should include the following options (the values can be different depending on your needs):

```json
{
  "rewardWaitTime": "PT10M",
  "defaultReward": 0,
  "rewardAggregation": "earliest",
  "explorationPercentage": 0.2,
  "modelExportFrequency": "PT5M",
  "logRetentionDays": 7,
  "isInferenceExplainabilityEnabled": true
}
```

Most importantly, the request body should include the **isInferenceExplainabilityEnabled** option, and it should be set to **true**.

|option  |Description  |
|---------|---------|
|defaultReward     |The reward to assign if a reward isn't received within the specified time.|
|rewardWaitTime|The time span to wait until a request is marked with the default reward and should be between five seconds and two days. For example, PT10M (10 mins).|
|rewardAggregation|The function to use to process rewards, in case multiple reward scores are received before rewardWaitTime has ended.|
|explorationPercentage     |The percentage of rank responses that should use exploration.|
|logRetentionDays     |Number of days to keep historical log data. You can use -1 to ensure the logs won't ever be deleted.|
|isInferenceExplainabilityEnabled|Set to **true** to enable inference explainability and **false** to disable it.|

## Interpret feature scores

Once you've enabled inference explainability, the JSON from Rank API's response will include an `inferenceExplanation` property like this:

```json
{
  "ranking": [
    {
      "id": "EntertainmentProduct",
      "probability": 0.8
    },
    {
      "id": "SportsProduct",
      "probability": 0.15
    },
    {
      "id": "HomeProduct",
      "probability": 0.05
    }
  ],
 "eventId": "75269AD0-BFEE-4598-8196-C57383D38E10",
 "rewardActionId": "EntertainmentProduct",
 "inferenceExplanation": [
    {
        "id": "EntertainmentProduct",
        "features": [
            {
                "name": "user.profileType",
                "score": 3.0
            },
            {
                "name": "user.latLong",
                "score": -4.3
            },
            {
                "name": "user.deviceType",
                "score" : 12.1
            },
        ]
    }
  ]
}
```

In this example, three action IDs are returned inside the ranking collection (EntertainmentProduct, SportsProduct, and HomeProduct) along with their probability scores. The action with the largest probability is the best action, according to the model trained on data provided to the Azure AI Personalizer API. In this case it is the following action:

```json
{
    "id": "EntertainmentProduct",
    "probability": 0.8
}
```

This same action ID is now also in the `inferenceExplanation` collection, together with the relevant feature names and their scores determined by the model for this action. Three features and their scores are provided for this action: a `user.profileType` feature with a score of **3.0**, a `user.latLong` feature with a score of **-4.3**, and a `user.deviceType` feature with a score of **12.1**. We can interpret these as follows:

- Larger positive scores provide more incentive for the model choosing an action.
- Larger negative scores provide more incentive for the model not choosing an action.
- Scores close to zero have a small effect on the decision to choose an action.

This means the `user.deviceType` feature with a score of **12.1** has the most positive influence on the action having been selected. Conversely, the `user.latLong` feature with a score of **-4.3** has the most influence on why the action would not have been selected.

> [!NOTE]
> When you enable inference explainability it could increase the latency of Rank API calls because feature information will be need to be processed. You should run experiments and measure the latency for your particular situation to see if it meets your application’s latency requirements. For more details see [Important considerations for inference explainability](/azure/ai-services/personalizer/how-to-inference-explainability).
