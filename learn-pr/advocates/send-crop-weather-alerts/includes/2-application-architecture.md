Let's look at the application you'll create in this module. The application has many components and is designed to implement a variety of features. Here’s a summary of its capabilities: 

- The application can request a text message alert for a location if a temperature outside a specific range is forecasted.
- The application can request a text message that reports a location's forecasted low and high temperatures.
- The application can check and report a location's weather forecast every 12 hours.

The following image demonstrates how the application works:

:::image type="content" source="../media/twilio-text-function.png" alt-text="Image that demonstrates how the application works." border="false":::

These are the resources we'll use to create the application:

- An Azure Maps account
- An Azure Storage account
- A function app that's hosted in Azure Functions
- An HTTP request endpoint
- A Twilio account

We'll do the work in a Microsoft-hosted instance of Azure CLI (a *sandbox*) that runs in this Learn module. You don't need to install software or have your own Azure account or subscription.

When the application is deployed, it can do these things:

#### Request a text message

Some cell phone users might have access to only a basic phone. To support the most users around the world, the application interface uses SMS text messaging. 

Twilio is a third-party service that can create programmable phone numbers for sending and receiving text messages. Every time a text message is sent to your application's phone number, custom code in Azure is triggered, with the help of the Azure Functions service. The code tracks all the locations and temperature ranges a farmer might want to know about. The code keeps the information in a table in Azure Storage.

The code sets up text message alerts in the following format:

```output
location maxTemp minTemp
```

For example, you might want to send "1 Microsoft Way, Redmond, WA 5C 25C" as an alert for the Microsoft corporate headquarters if the temperature will be below 5 degrees Celsius or above 25 degrees Celsius.

#### Convert a street address to map coordinates

The Azure Maps [Search - Get Search Address](https://docs.microsoft.com/rest/api/maps/search/getsearchaddress?azure-portal=true) API provides address geocoding. Geocoding is the process of converting a street address to a geospatial location as longitude and latitude. For example, *1 Microsoft Way, Redmond, WA, USA* gives a longitude of *-122.1282593* and a latitude of *47.6393782*. You can then use this location to get the weather forecast for that address.

#### Retrieve a daily weather forecast

Azure Maps has an API called [Weather - Get Daily Forecast](https://docs.microsoft.com/rest/api/maps/weather/getdailyforecastpreview?azure-portal=true). If a geospatial location is specified as longitude and latitude, you can receive the forecast for that location for a specified number of days. We'll use five days as the standard forecast period to help farmers make decisions for the next few days.

#### Check the forecast every 12 hours

Azure Functions is an event-based service that runs code when it's triggered. A function in Azure Functions can be triggered by various actions, including web requests, timers, and items that are added to queues or databases. Your application can use a time trigger to check the weather every 12 hours.

When you send a text message to Twilio to subscribe to temperature notifications, Twilio can make a web request to another function that uses an HTTP trigger.

In this unit, we looked at the features of the application. Next, you'll create an Azure Maps account and set it up to get geocoding and location information for your application.
