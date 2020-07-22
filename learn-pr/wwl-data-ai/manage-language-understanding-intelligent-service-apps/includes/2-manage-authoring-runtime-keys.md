Managing keys for your Language Understanding (LUIS) service involves an understanding of the two services and API sets that LUIS has, along with resources included with LUIS.  LUIS uses an **authoring** service/API and a **prediction** service/API.

| Key | Purpose |
| --- | --- |
| Authoring Key | Access and manage data of application with authoring, training, publishing, and testing. Create a LUIS authoring key if you intend to programmatically author LUIS apps. |
| Prediction Key | Query prediction endpoint requests. Create a LUIS prediction key before your client app requests predictions beyond the 1,000 requests provided by the starter resource. |
| Cognitive Service Multi-Service Resource Key | Query prediction endpoint requests shared with LUIS and other supported Cognitive Services. |

The first key listed in the table is the **authoring key**.  The authoring key is used to permit programmatically managing your LUIS apps and any models you have.  You can use the authoring key for training and publishing tasks as well.  You also use the authoring key to control the permissions to the LUIS authoring resource through assignment of users to the **Contributor** role.

## LUIS authoring key

Creation of the LUIS authoring key is accomplished when you create a LUIS service in the Azure portal.  During the creation of your LUIS service, you can select the **Authoring** option, the **Prediction** option, or choose both at the same time.

:::image type="content" source="../media/language-understanding-intelligent-service-create-options.png" alt-text="Create LUIS app with Authoring, Prediction, or Both options":::

Once you have your LUIS service created, the authoring keys are available to you on the **Keys and Endpoint** page.  Select the **Keys and Endpoint** option from the **Resource Management** section in the left tool bar.

:::image type="content" source="../media/author-keys.png" alt-text="LUIS authoring keys and endpoint":::

With the authoring key, users can access the LUIS app from either the LUIS portal or through the [authoring APIs](https://go.microsoft.com/fwlink/?linkid=2092087). Authoring access provides the following abilities.

- Add or remove endpoint keys
- Export or import a version
- Export endpoint logs
- Make the app public
- Modify a model
- Publish the app
- Review endpoint utterances for active learning
- Train the model

## Starter key

When you first create a LUIS application, a starter key is created for you automatically.  You can use this starter key for the following.

- free authoring service requests to your app.  This can be accomplished using the LUIS portal or through the supported SDKs.
- with this starter key, you are permitted 1000 prediction endpoint requests per month for free.  These requests may come in through the browser, API, or SDK.

The starter key is a good choice to initial creation and simple testing but once your requests to the prediction endpoint go beyond 1000, you need to consider using a **Prediction key**.  The prediction key is used for requests against your LUIS app and is not used for authoring purposes.  You may decide to work with developers to author the LUIS app through the SDKs.  In that case, do not use the prediction key for authoring.

## Create a prediction key

1. Sign in to your LUIS portal.
1. Select the LUIS app that you want to create the prediction key for.
1. Select the **Manage** option in the top toolbar.
1. Select **Azure Resources** in the left tool bar.
1. Unless you have already created a prediction key, your screen should look similar to this. The key information is obscured on purpose.  
   
   :::image type="content" source="../media/add-prediction-key.png" alt-text="LUIS App showing only starter key and no prediction key"

    >[!NOTE]
    > Azure services are updated on a regular basis and screen shots are representative of the state at the time of the course authoring.  Screen shots may differ if the service has had changes since the content creation.

1. To create a new **Prediction key**, select the **Add prediction resource** button.
1. Select the **Subscription Name** that you will associate with your LUIS prediction resource.
1. Select an existing **LUIS resource name** if you have already created a LUIS resource in the Azure portal and then select **Done**.

   >[!TIP]
   >Existing resources will be listed in the drop-down that are valid for the region in which your subscriptions exist.  You can choose a **LUIS** resource from this list, if one exists already.

1. If you do not have an existing **LUIS** resource available, you can select the **Create new resource** to create a new **LUIS** resource.  When selecting this option, complete the information fields in the dialog that is displayed to create your new LUIS resource.
1. Once your new prediction resource is created, you will notice a couple of key aspects,
    - You now have a new **Primary Key** and **Secondary Key** associated with the prediction resource
    - There is a new **Endpoint URL** available.
        - In the **Starter Key**, the endpoint URL starts with the region, such as westus.api.cognitiveservices.....
        - In the new **Prediction** resource, the endpoint URL starts with the name of the LUIS resource such as, gerai-102luis.cognitiveservices.....
1. Notice that the **pricing tier** is no longer set at **F0 (Free)** but instead has changed to **S0 (Standard)**.  This correlates to the discussion earlier in the topic about the number of requests supported.

## Programmatically create and manage LUIS apps

There are various APIs and SDK options that you can use to create and manage LUIS apps.  The support varies by programming language.  Some aspects are available via REST and others via the SDK options.  For current support of the SDK and API options, view the sample code and information found on the [LUIS Samples Git hub Repository](https://github.com/Azure-Samples/cognitive-services-language-understanding).
