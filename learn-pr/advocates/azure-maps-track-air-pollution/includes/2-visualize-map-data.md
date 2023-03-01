The Azure Maps web SDK has a wide variety of tools you can use to visualize spatial data on an interactive map on a webpage. Before we get started adding a map to a webpage, let's look at some of the capabilities of the SDK.

## Render a map

The Azure Maps web SDK has an interactive JavaScript map control that you can add to a webpage. Maps are drawn (*rendered*) by using the *Spherical Mercator projection coordinate system*, a standard for web-based mapping applications. This system stretches the map at both the North Pole and the South Pole to create a square map that can be drawn on-screen. A result of the stretching is that the further away from the equator you move, the more stretched the map appears. On the map, a country or region, like Greenland, for example, appears substantially larger than it actually is.

Maps can be rendered in different styles. These styles include:

- **Road**: A standard map style that displays roads and natural and artificial features, with feature labels.

    :::image type="content" source="../media/road.png" alt-text="Image of a road map of Seattle." border="false":::

- **Satellite**: A combination of satellite and aerial imagery.

    :::image type="content" source="../media/satellite.png" alt-text="Image of a satellite map of Seattle." border="false":::

- **Satellite with road labels**: A combination of satellite and aerial imagery, with an overlay of roads and labels.

    :::image type="content" source="../media/satellite-road-labels.png" alt-text="Image of a satellite and road map of Seattle." border="false":::

- **High contrast**: A dark road map with higher contrast than other map styles.

    :::image type="content" source="../media/high-contrast-dark.png" alt-text="Image of a high-contrast map of Seattle." border="false":::

More styles are described in [Azure Maps supported map styles](/azure/azure-maps/supported-map-styles?azure-portal=true).

## Move around the map

You can configure Azure Maps controls to be fully interactive, so the user can zoom, move, rotate, and tilt the map view. When zoomed in and tilted, the map can show 3D representations of the shape of buildings. Move around the map by using a mouse, trackpad, or touchscreen. The map control supports pinching to zoom and dragging to reposition the map. The map control has zoom, compass, pitch, and style picker controls that you can enable and show on the map.

You can set map navigation in your app code. For example, you can set the view to a specific location. You can disable or enable user navigation capabilities in settings for the map control.

## Layers

You can augment maps by adding layers. A layer visualizes a data object on top of a map. In the app you create, you'll use a layer on a map to visualize air quality data.

When you create an app that uses a map control, you can choose from different layer types. All layer types render data sources that contain either GeoJSON data or [Mapbox vector tiles](https://github.com/mapbox/vector-tile-spec?azure-portal=true). We'll talk about GeoJSON later in this module.

Here are some of the layer types you can use with a map:

- **Symbol layer**:  Symbol layers place either a pin icon or a custom icon that's loaded from an image file at a specific location on a map. For example, different icons might show the locations of various types of social support in a city, such as food banks or homeless shelters.

- **Bubble layer**: Bubble layers place circular bubbles at locations on a map. You can configure bubbles to represent data by changing their appearance, like size and color. For example, during a pandemic, different bubble sizes might indicate the number of people who have contracted an illness, with colors that reflect different mortality rates.

- **Heat map**: Heat map layers represent data density. A heat map uses a range of colors to show "hot spot" areas on a map. For example, you might use a heat map to show the relative risk of an earthquake occurring at a location based on the number and strength of earthquakes at that location in the past.

A data source defines the feature locations in a layer. The data source might also provide data that you can use to configure controls on the layer. For example, what image to display or how large to make a bubble.

In this unit, you learned about the Azure Maps web SDK, including styles, navigation, and layers. Next, you'll create an Azure Maps account, so you can use the web SDK in a web app.
