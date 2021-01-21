Farmers around the world must carefully watch the weather to guarantee the optimal growth or even survival of their crops. Many farmers need to ensure a sufficient food supply not only for their community but for themselves as well. 

In 2015, it was estimated that 2 billion people living in rural areas of developing nations are involved in subsistence farming, growing what they need to eat and trade for daily essentials. The failure of their crops can literally mean having nothing to eat.

In the developed world, widespread access to the internet via computers and smartphones can provide detailed weather reports that help farmers plan how to best water or protect their crops. This data can be combined with sensors to track temperature, rainfall, and soil moisture. And it can be combined with complex AI models to make predictions or provide guidance. In remote locations around the world, access to such technology is limited, although mobile phones with text messaging are common.

In this module, you'll work with an application that lets farmers use text messaging to set up temperature alerts for specific locations. These alerts help farmers know when to plant, when to water, or when to protect their crops.

:::image type="content" source="../media/text-message.png" alt-text="Screenshot of text messages sent to and received by our application.":::

The temperature and location services needed by this app will use Azure Maps. Azure Maps is a collection of geospatial services that use fresh mapping data to provide geographic context to web and mobile applications. These services include APIs for maps, vehicle routing, weather, and geofencing.

You'll use a third-party communications service, Twilio, to manage sending and receiving text messages, and you'll coordinate app functionality by using Azure Functions.

## Learning objectives

In this module, you will:

- Learn about using the Azure Maps APIs to get a location's weather forecast.
- Create and configure a Twilio account with a programmable phone number to send and receive text messages.
- Deploy an existing application to a function app in Azure by using Twilio and Azure Maps to manage and send temperature alerts for specific locations.

## Prerequisites

- Basic familiarity with Azure Functions.

    > [!TIP]
    > Before you begin, you might want to complete the Microsoft Learn module [Create serverless logic with Azure Functions](https://docs.microsoft.com/learn/modules/create-serverless-logic-with-azure-functions/?azure-portal=true).
