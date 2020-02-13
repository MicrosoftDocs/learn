To access your Speech Service from an application, you will need to get two pieces of information from the Azure portal:

- A *subscription key* that's passed with every request to authenticate the call.
- The *endpoint* that exposes your service on the network.

You will need the subscription key when using the Speech SDK or the REST APIs but the endpoint will only be required for the REST API access.   Using the Speech SDK in an application uses the key, but also requires a region.  You will see the use of the key and region information in the exercise later in the module.

## View the subscription keys and endpoint

1. In the left menu of the portal, select **Resource groups**, and then select the **mslearn-speechapi** resource group that you created for the Speech Translation API.
1. Select the Speech Translation subscription name (such as **SpeechTranslation**).
1. There are two locations that will display your endpoint and at least one key. 
1. Under the **RESOURCE MANAGEMENT** group, select the **Quick start** option to display **Key1** and **Endpoint** values.
1. The second option is used to view a second key for the service. Under the **RESOURCE MANAGEMENT** group, select **Keys and Endpoint** to view the Service name, the endpoint, and two API keys.
1. Copy the value of **KEY 1** or **KEY 2** to the clipboard for use in an application.
