## Set up Event Grid to process images that are uploaded to your website

1. Go back to your functions app.
2. Select **New Function**.
3. In the filter box, enter *Event*.
4. Select the Event Grid trigger.
5. In the **Language** drop-down list, select *Javascript*.
6. In the **Name** field, enter *imageProcessing*.
7. Select **Create**.
8. After the function is created, select **Add Event Grid subscription**.
9. In the **Name** field, enter *imageProcessingGrid*.
10. In the **Topic Type** field, change the setting to *Storage Accounts*.
11. In the **Use existing** drop-down list, select *serverlessRG*.
12. On the **Instance** menu, select your storage account. 
13. Select **Create**.
14. In the text box, paste the following code:

    ```javascript
    const request = require('request');
    
    module.exports = function (context, eventGridEvent) {
        var path = eventGridEvent.data.url.split('/').pop();
        if (eventGridEvent.data.url.indexOf("/img/") > -1) {
            var eventData = {
                id: path,
                url: eventGridEvent.data.url
            };
            processImage(context, eventData);
        }
    };
    
    function processImage(context, eventData) {
        // Replace <subscription key> string value with your valid subscription key.
        var subscriptionKey = "<subscription key>";
    
        // Replace or verify the region.
        var uriBase = "https://eastus.api.cognitive.microsoft.com";
    
        var options = {
            url: uriBase + "/vision/v1.0/describe?maxCandidates=1",
            body: '{"url": ' + '"' + eventData.url + '"}',
            headers: {
                "Content-Type": "application/json",
                "Ocp-Apim-Subscription-Key": subscriptionKey
            }
        };
    
        request.post(options, function (error, response, body) {
            var temp = JSON.parse(body);
            eventData.caption = temp.description.captions[0].text;
            eventData.tags = temp.description.tags;
            context.bindings.outputDocument = eventData;
            context.done();
        });
    }
    ```

15. Select **Save**.
16. Select the **Integrate** sub-tab of the function.
17. Select **New Output**.
18. Search for **Azure Cosmos DB** > **Select**.
19. In the **Database name** field, change the setting to *serverless-app*.
20. In the **Collection Name** field, change the setting to *images*.
21. To create the Azure Cosmos DB database and collection, select the check box.
22. Select **Save**.