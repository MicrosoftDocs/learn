## Lab exercise 5 - Setup EventGrid to process images that are uploaded

1. Navigate back to your functions app.
2. Select **New Function**
3. Enter `Event` into the filter box.
4. Select Event Grid trigger
5. Select **Javascript** from the **Language:** dropdown.
6. Enter `imageProcessing` into the **Name:** field.
7. Select **Create**.
8. Once the function creates Select **Add Event Grid subscription**.
9. Enter `imageProcessingGrid` in the **Name** field.
10. Change the Topic Type to **Storage Accounts**.
11. Select **serverlessRG** from the Use existing dropdown.
12. Select your storage account from the **Instance** menu.
13. Select **Create**.
14. Copy the following code into the text box > **Save**

```javascript
module.exports = function (context, eventGridEvent) {
    var path = eventGridEvent.data.url.split('/').pop();
    if (path.indexOf("/img/") > -1){
        var data = {
            id: path,
            url: eventGridEvent.data.url,
        };
        context.bindings.outputDocument = data;
    }
    context.done();
};
```

15. Select the **Integrate** sub-tab of the function.
16. Select **New Output**.
17. Locate **Azure Cosmos DB** > **Select**.
18. Change the **Database name** to `serverless-app`
19. Change the **Collection Name** to `images`
20. Select the checkbox to create the Azure Cosmos DB database and collection.
21. **Save**