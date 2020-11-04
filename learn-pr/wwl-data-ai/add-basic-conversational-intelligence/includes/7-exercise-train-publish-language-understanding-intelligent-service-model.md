
We're now ready to train our model. In this exercise, you will perform a simple training operation in order to test your model.  The testing will take place using the built-in testing panel in the LUIS portal.

1. In the top toolbar, select **Train**. During training, LUIS builds a model to map utterances to intents based on the training data you’ve provided.

    > [!TIP]
    > Training is not always immediate. Sometimes it gets queued and can take several minutes.

## Create a public endpoint for the LUIS service

1. After training is finished, select **Manage** in the top toolbar. The following options will appear on the left toolbar:

    > [!NOTE]
    > The categories on the left pane may change as the portals are updated.  As a result, the keys and endpoints may fall under a different category than the one listed here.

    - **Publish settings**
    - **Azure Resources**
    - **Versions**
    - **Collaborators**

1. Select **Azure Resources**. This screen is used to manage the URL endpoints used to access the LUIS service.

    > [!NOTE]
    > An endpoint named **Starter_Key** is automatically created for testing purposes, and you could use that here - however to use the service in a production environment or inside of an application, you will always want to tie it to a real Language Understanding resource created in Azure.

1. You should see a **Prediction Resource** and a **Starter_Key** resource already created.  If you see the **Prediction Resource**, advance to the next section on **Publish the app**.
1. If you do not see an existing **Prediction Resource**, select **Add prediction resource**. The **Tenant** will already be selected.
1. Select your subscription, and the resource you created in the Azure portal earlier and then select **Done** to connect the Language Understanding resource to the LUIS service.

## Publish the app

1. In the top toolbar, select **Publish**.

   > [!NOTE]
   > You can publish to your **Production** or **Staging** endpoint. Select **Production**, and read about the reasons for the two endpoints.

1. Under **Choose your publishing slot and settings**, select **Production Slot** and then select **Done**.

    Publishing creates an endpoint to call the LUIS model. The endpoint URL will be displayed. Copy the endpoint URL and add it to your list of keys for future use.

1. In the top bar, select **Test**. Try typing a few utterances and see which intents are returned. Here are some examples you can try:

   | Utterance | Result | Score meaning |
   |---------|---------|---------|
   | **Show me pictures of a local beach** | Returns the **SearchPics** intent with a score | Positive match |
   | **Hello** | Returns the **Greeting** intent with a score | Fairly positive match |
   | **Send to Tom** | Returns the **Utilities** with a low score | Needs retraining or doesn't match any intents |

To retrain the model for utterances with low scores, take the following steps:

1. Beside the low-scoring utterance (in this case, **Send to Tom**), select **Inspect**.
1. Beside **Top-scoring intent**, select the drop-down and choose **SharePic** from the list.
1. Close the **Test** panel.
1. Select the **Train** button to retrain your model.
1. Test the **Send to Tom** utterance again. It should now return the **SharePic** intent with a higher score.

Your LUIS app is now ready to be used by client applications, tested in a browser through the listed endpoint, or integrated into a bot.

## Train and publish with code

This exercise will cover the aspects of using a code environment to train and publish your LUIS app.  Once all of the pieces are in place, intents, entities, and utterances, you can train the LUIS app and publish it to an endpoint for consumption.

:::zone pivot="csharp"

1. Using the same Visual Studio Code project that you created in this module, locate the **Program.cs** file and add the following code at the end, to perform the training task.

   ```csharp
   async static Task Train_App(LUISAuthoringClient client, ApplicationInfo app)
   {
       var response = await client.Train.TrainVersionAsync(app.ID, app.Version);
       Console.WriteLine("Training status: " + response.Status);
   }
   ```

1. This code uses the the same LUIS authoring client information and app info to target the correct LUIS app.
1. It will make a call to the **TrainVersionAsync** method and tell the LUIS backend to perform the training operation.
1. Once you receive the status, you can then publish the app with the following code.

   ```csharp
   // Publish app, display endpoint URL for the published application.
   async static Task Publish_App(LUISAuthoringClient client, ApplicationInfo app)
   {
       ApplicationPublishObject obj = new ApplicationPublishObject
       {
           VersionId = app.Version,
           IsStaging = true
      };
       var info = await client.Apps.PublishAsync(app.ID, obj);
       Console.WriteLine("Endpoint URL: " + info.EndpointUrl);
   }
   ```

   >[!TIP]
   >The training operation is not instantaneous and will take some time to complete.  You can setup a loop or other configuration of your choosing to periodically check the training status, before you place a call to the publish operation.  To check the status of the train operation, you could use code such as the following.  You should look for a status of **Success** or **UpToDate** before publishing.

   ```csharp
   async static Task CheckTrainStatus(LUISAuthoringClient client, ApplicationInfo app)
           {
               var response = await client.Train.GetStatusAsync(app.ID, app.Version);
               Console.WriteLine(response[0].Details.Status.ToString());
           }
   ```

1. Ensure that you modify **Main()** to include calls to these two new methods, after the previous calls.

   ```csharp
   async static Task Main(string[] args)
           {
               // Generate the credentials and create the client.
               var credentials = new Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring.ApiKeyServiceClientCredentials(authoring_key);
               var client = new LUISAuthoringClient(credentials, new System.Net.Http.DelegatingHandler[] { })
               {
                   Endpoint = authoring_endpoint
               };

               ApplicationInfo appInfo = await CreateApplication(client);
               Console.WriteLine(appInfo.ID + " " + appInfo.Version);
   
               await AddIntents(client, appInfo);
   
               await AddEntities(client, appInfo);

               await AddUtterances(client, appInfo);

               await Train_App(client, appInfo);

               // insert logic for a pause, then call this method to check the status before publishing
               await CheckTrainStatus(client, appInfo);

               await Publish_App(client, appInfo);

           }
   ```

:::zone-end

:::zone pivot="python"

1. Using the same Visual Studio Code project that you created in this module, add the following code to perform the training task.

   ```python
   def train_app(app_id, app_version):
       response = client.train.train_version(app_id, app_version)
       waiting = True
       while waiting:
           info = client.train.get_status(app_id, app_version)

           # get_status returns a list of training statuses, one for each model. Loop through them and make sure all are done.
           waiting = any(map(lambda x: 'Queued' == x.details.status or 'InProgress' == x.details.status, info))
           if waiting:
               print ("Waiting 10 seconds for training to complete...")
               time.sleep(10)
   ```

1. Once the app is trained and the status is either **Success** or **UpToDate**, you can use the following code to publish the app.

   ```python
   def publish_app(app_id, app_version):
       responseEndpointInfo = client.apps.publish(app_id, app_version, is_staging=True)
       print("Application published. Endpoint URL: " + responseEndpointInfo.endpoint_url)
   ```

:::zone-end
