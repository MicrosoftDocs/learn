Farmers around the world must carefully watch the weather to guarantee the optimal growth or even survival of their crops. Many farmers not only need to ensure a sufficient food supply for their community but even for themselves. 

In 2015, it was estimated that 2 billion people living in rural areas of developing nations are involved in subsistence farming, growing what they need to eat and trade for daily essentials. The failure of their crops can literally mean having nothing to eat.

In the developed world, widespread access to the internet via computers and smartphones can provide detailed weather reports to allow farmers to plan how to best water or protect their crops. This data can be combined with sensors to track temperature, rainfall, and soil moisture, as well as with complex AI models to make predictions or provide guidance. In remote locations around the world, access to such technology is limited, however mobile phones with text messaging are common.

In this module, you'll deploy an application that allows farmers to use SMS messaging to set up temperature alerts for specific locations. These alerts would help farmers know when to plant, when to water, or when to protect their crops.

![Screenshot of text messages sent to and received by our application](../media/text-message.png)

The temperature and location services needed by this app will use Azure Maps. Azure Maps is a collection of geospatial services that use fresh mapping data to provide geographic context to web and mobile applications. These services include APIs for maps, vehicle routing, weather, and geofencing. A third-party communications service called Twilio will be used to manage sending and receiving SMS messages, and app functionality will be coordinated using Azure Functions.

## Learning objectives

In this module, you'll:

- Learn about the Azure Maps APIs for obtaining the weather forecast for a location.
- Create and configure a Twilio account with a programmable SMS phone number to send and receive text messages.
- Deploy an existing application to Azure Functions using Twilio and Azure Maps to manage and send temperature alerts for specific locations.

## Prerequisites

- Basic familiarity with Azure Functions.

    > [!TIP]
    > You may want to complete the Microsoft Learn module: [Create serverless logic with Azure Functions](https://docs.microsoft.com/learn/modules/create-serverless-logic-with-azure-functions/)