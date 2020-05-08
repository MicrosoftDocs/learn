Our application will involve a number of different components to implement the different features. Let's review these features.

- Have a standardized way to request weather alerts for a location via an SMS message if the temperature goes outside a given range
- For each location, retrieve the low and high temperature of the upcoming daily weather forecast
- The forecast is checked every 12 hours
- If the temperature forecast for a given location is outside the given range, a notification should be sent via SMS

## Receiving SMS messages

To support the most users around the world, text messaging is all that is required as the interface to our application. Twilio is a third-party service that can create programmable phone numbers to send and receive SMS messages. Custom code in Azure can be triggered using Azure Functions every time an SMS is sent to our number. This code will track all the locations and temperature ranges farmers want to know about in table storage.

The code will set up alerts from text messages in the following format:

```output
location maxTemp minTemp
```

For example, send `1 Microsoft Way, Redmond, WA 5C 25C` to set up alerts for the Microsoft Campus.

## Normalizing the location to coordinates (Geocoding)

The Azure Maps API [*Search - Get Search Address*](https://docs.microsoft.com/rest/api/maps/search/getsearchaddress) does address geocoding. Geocoding is converting from a street address to a geospatial location as longitude and latitude. For example, **1 Microsoft Way, Redmond, WA, USA** will give a longitude of `-122.1282593` and a latitude of `47.6393782`. This location can then be used to get the weather forecast.

## Retrieving Daily Weather Forecast

Azure Maps offers an API called [*Weather - Get Daily Forecast*](https://docs.microsoft.com/rest/api/maps/weather/getdailyforecastpreview).  Given a geospatial location as longitude and latitude, you can receive the forecast for a given number of days. We'll be using five days to allow farmers to make decisions for the next few days.

## Check the forecast every 12 hours

Azure Functions is an event-based service that can run code. These events can be triggered by a number of different things, from web requests, to timers, to items added to queues or databases. This app can use a time trigger to run every 12 hours to check the weather.

When an SMS is sent to Twilio to subscribe to temperature notifications, Twilio can make a web request to another Azure Function that uses an HTTP trigger.

In this unit, you looked at the features of the application. Next, you'll create an Azure Maps account.
