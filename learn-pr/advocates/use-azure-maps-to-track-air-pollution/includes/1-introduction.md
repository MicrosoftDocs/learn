Azure Maps is a collection of geospatial services that use fresh mapping data to provide geographic context to web and mobile applications.

These services include APIs to render maps, routing for vehicles, weather, geofencing and a web SDK to visualize data on a web page.

In this module, you'll learn how to use the Azure Maps web SDK to visualize air pollution data.

## Learning objectives

In this module you'll:

- Create an Azure Maps account
- Access air quality data, and convert it to GeoJSON format
- Plot this data on a map

## Prerequisites

- Ability to use Python at a beginner level
- Experience using Visual Studio Code, at the beginner level

## The scenario

Air pollution can be incredibly harmful to human and animal health, and is caused by a variety of factors, both natural and man-made. Factory output, burning different types of fuel and natural wildfires all contribute to a rise in air pollution. This pollution, as the name suggests, is airborne, which means it will not stay where it was produced, but can be carried many kilometers across the globe on the wind, as seen recently with the smoke from wildfires in Australia reaching New Zealand, over 2,000 kilometers away.

Air pollution is measured using the Air Quality Index, a scale from 0-500 where the greater the level, the greater the health risk. Anything under 50 is little to no risk, anything above 300 is hazardous to everyone. The Air Quality index looks at a few different pollutants:

- ground-level ozone
- particulates
- Carbon monoxide
- Sulphur dioxide
- Nitrogen dioxide

> You can read more about the Air Quality index on the [AirNow AQI Basics page](https://www.airnow.gov/aqi/aqi-basics/).

In this module, you'll get air pollution data using a freely available API, and plot this data on an interactive map on a web page using Azure Maps. The end result will look like this:

[![A map of the world showing pollution data as colored circles](../media/final-output.png)](../media/final-output.png#lightbox)
