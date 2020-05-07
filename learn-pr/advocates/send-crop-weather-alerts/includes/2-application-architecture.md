Our application will involve a variety of components. Let's review the application architecture.

- For a given location we want to retrieve the low and high temperature of the upcoming daily weather forecast.
- We need to standardize location naming to get our weather forecast.
- We want to enable alerts for temperature extremes at a particular location via text message (SMS).
- We want to receive alerts via text message (SMS) if the weather forecast for a given location exceeds the temperature we care about.
- We want to check the forecast every 12 hours.

## Retrieving Daily Weather Forecast

Azure Maps offers an API called *Weather - Get Daily Forecast*.  Given a location in decimal geographic coordinates format (e.g. Seattle corresponds to 47.6062,-122.3321) you can receive the forecast for 1, 5, 10, and 15 days when using the lowest Azure Maps tier. We will be choosing 5 days to allow farmers to make decisions for the next upcoming days.

## Normalizing Location to Coordinates (Geocoding)

The Azure Maps API *Search - Get Search Address* accepts arbitrary text for a location and returns the closest matching normalized location including its coordinates. This is is useful as the Weather Forecast requires the location to be specified in decimal coordinates.

## Sending and receiving text message (SMS)

To support the most users around the world text messaging is all that is required for our application. Twilio is a third party service that can create programmable phone number to send and receive SMS. We can trigger custom code we write abd host every time a SMS is sent to our number.

We will expect to handle text messages of the form `location maxTemp minTemp`, for example `1 Microsoft Way, Redmond, WA 5C 25C` to set up alerts.

## Azure Functions

Azure Functions allows triggering code when a certain period of time has passed. This is known as a Time Trigger. Using a Time Trigger we determine whether any location's weather forecast should result in a notification via SMS.
We will later configure Twilio to send incoming messages to Azure Functions. For this we are utilizing a HTTPTrigger.

## Storage

Under the hood we will be utilizing table storage to track all the locations and temperature ranges farmers want to know about. We will be using a queue to periodicially evaluate whether to send notification messages by SMS.
