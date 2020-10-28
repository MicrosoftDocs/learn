To access your Speech Service from an application, you will need to get two pieces of information from the Azure portal:

- A *subscription key* that's passed with every request to authenticate the call.
- The *endpoint* that exposes your service on the network.

You will need the subscription key when using the Speech SDK or the REST APIs but the endpoint will only be required for the REST API access.   Using the Speech SDK in an application uses the key, but also requires a region.  You will see the use of the key and region information in the exercise later in the module.

## View the subscription keys and endpoint

1. In the left menu of the portal, select **Resource groups**, and then select the **mslearn-speechapi** resource group that you created for the Speech Translation API.
1. Select the Speech Translation subscription name (such as **SpeechTranslation**). 
1. Under the **RESOURCE MANAGEMENT** group, select the **Keys and Endpoint** option to display **Key** and **Endpoint** values.
1. Copy the value of **KEY 1** or **KEY 2** to the clipboard for use in an application.
