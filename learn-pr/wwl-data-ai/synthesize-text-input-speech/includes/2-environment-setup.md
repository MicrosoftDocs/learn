For you to be successful in completing the exercises for this module, you must have the proper resources in place on Azure. The following steps outline creating an Azure subscription, or using a trial key.  Creating the Speech Service resources on Azure is required for the exercises to work successfully for synthesizing text to speech.  Complete this section before moving on to the remaining exercises.

## Create an azure speech resource

You will require an Azure subscription in order to complete this exercise.  With the Azure subscription, you can create the necessary Speech Service resource. If you do not have an Azure subscription, [create one here](https://azure.microsoft.com/free).

### Using an azure subscription

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **+ Create a resource**. In the **Search the Marketplace** box, type **speech** and press Enter.

1. In the **Results** list, select **Speech**. In the **Speech** pane, select **Create**.
1. Enter a unique name for your Speech Service resource.
1. Select an appropriate subscription.
1. Choose a location to host the resource.  This is typically the region where the resource will be used.
1. For **Pricing tier**, select a tier.  The tiers may change but currently, you can select F0 or S0.  For testing, we selected F0.
1. Create a new resource group (RG) named **mslearn-speechapi** to hold your resources.  You can also choose an existing RG if you wish
1. Select **Create** to create a subscription to the Speech Translation API.

After a short delay, your new Speech Translation API subscription will be available, and new API keys will be generated for programmatic use.  

> [!TIP]
> If you miss the notification that your resource is published, select the notification icon in the top bar of the portal, and then select **Go to resource**, as shown in the following figure:

   ![Selecting "Go to resource" from the notification icon](../media/3-subscribe-speech-translation-go-resource.png)

### View the subscription keys and endpoint

To access your Speech Service from an application, you will need to get two pieces of information from the Azure portal:

- A *subscription key* that's passed with every request to authenticate the call.
- The *endpoint* that exposes your service on the network.

You will need the subscription key when using the Speech SDK or the REST APIs but the endpoint will only be required for the REST API access.   Using the Speech SDK in an application uses the key, but also requires a region.  You will see the use of the key and region information in the exercise later in the module.

1. In the left menu of the portal, select **Resource groups**, and then select the **mslearn-speechapi** resource group that you created for the Speech Translation API.
1. Select the Speech Translation subscription name (such as **SpeechTranslation**).
1. There are two locations that will display your endpoint and at least one key. 
1. Under the **RESOURCE MANAGEMENT** group, select the **Quick start** option to display **Key1** and **Endpoint** values.
1. The second option is used to view a second key for the service. Under the **RESOURCE MANAGEMENT** group, select **Keys and Endpoint** to view the Service name, the endpoint, and two API keys.
1. Copy the value of **KEY 1** or **KEY 2** to the clipboard for use in an application.
