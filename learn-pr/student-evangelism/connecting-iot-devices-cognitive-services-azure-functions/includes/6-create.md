To build a translator application, we'll firstly create a Cognitive Speech Service in Azure. Then we'll call Cognitive Speech API for real-time speech translation and configure its API key in Azure Function.

You use the following components for this unit: 

**Speech API:** It allows you to access Azure AI services and add real-time speech translations to your app.

**Speech API key:** It's a unique identifier used to authenticate your app with the API.

**Speech API endpoint:** It s a base URL that associates with the network address of API service. 

We’ll use the following steps in this unit:

1.  Go to Azure portal
2.  Create **Speech** resource
3.  Fill out the form to create a Speech API

Once the Speech API is generated, you can navigate to the Keys blade and copy any of the keys. This key will be used by the Azure Functions Runtime to connect to and consume the Azure AI Speech service API so that Azure function will be able to access it programmatically. Also, make a note of the location where you're creating the speech service. You'll edit the key and location in the Azure function for IoT DevKit accessing to it. That is important when you're passing the information to the Speech API to ensure that the endpoint of the API starts with the location name.
