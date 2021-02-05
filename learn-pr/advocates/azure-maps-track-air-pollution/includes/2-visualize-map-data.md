The Azure Maps web SDK has a wide variety of tools you can use to visualize spatial data on an interactive map on a webpage. Before we get started adding the map to a webpage, let's look at some of the capabilities.

## Render a map

The Azure Maps web SDK has an interactive JavaScript map control that you can add to a webpage. Maps are drawn (*rendered*) by using the *Spherical Mercator projection coordinate system*, a standard for web-based mapping applications. This system stretches the map at both the North Pole and the South Pole to create a square map that can be drawn on-screen. A result of the stretching is that the further away from the equator you are, the more stretched the map is. Countries like Greenland appear substantially larger than they actually are.

Maps can be rendered in different styles. These styles include:

- **Road**: A standard map style that displays roads and natural and artificial features, with feature labels.

    :::image type="content" source="../media/road.png" alt-text="Image of a road map of Seattle." border="false":::

- **Satellite**: A combination of satellite and aerial imagery.

    :::image type="content" source="../media/satellite.png" alt-text="Image of a satellite map of Seattle." border="false":::

- **Satellite with road labels**: A combination of satellite and aerial imagery, with an overlay of roads and labels.

    :::image type="content" source="../media/satellite-road-labels.png" alt-text="Image of a satellite and road map of Seattle." border="false":::

- **High-contrast**: A dark road map with higher contrast than other styles.

    :::image type="content" source="../media/high-contrast-dark.png" alt-text="Image of a high-contrast map of Seattle." border="false":::

More styles are described in [Azure Maps supported map styles](/azure/azure-maps/supported-map-styles?azure-portal=true).

## Move around the map

You can configure Azure Maps controls to be fully interactive, so the user can zoom, move, rotate, and tilt the map view. When zoomed in and tilted, the map can show 3D representations of the shape of buildings. Move around the map by using a mouse, trackpad, or touchscreen. The map control supports pinching to zoom and dragging to reposition the map. The map control has zoom, compass, pitch, and style picker controls that you can enable and show on the map.

You can set map navigation in your app code. For example, you can set the view to a specific location. You can disable or enable user navigation capabilities in settings for the map control.

## Layers

You can augment maps by adding layers. A layer visualizes data on top of a map. In a later unit in this module, you'll use a layer on a map to visualize air quality data.

When you create an app that uses a map control, you can choose from different layer types. All layer types render data sources that contain either GeoJSON data or [MapBox vector tiles](https://github.com/mapbox/vector-tile-spec?azure-portal=true). We'll cover GeoJSON later in this module.

The different layer types include:

- **Symbol layer**:  Symbol layers place either a pin icon or a custom icon that's loaded from an image file at a specific location on a map. For example, different icons might show the location of various types of social support in a city, such as food banks, homeless shelters, or refuges.

- **Bubble layer**: Bubble layers place circular bubbles at locations on a map. You can configure bubbles to show the data they represent, like setting the size or color of a bubble. For example, during a pandemic, different bubble sizes might show the number of people who have contracted an illness, with the color reflecting the mortality rate.

- **Heat map**: Heat map layers represent data density. A heat map uses a range of colors to show "hot spot" areas on a map. For example, a heat map might be used to show the relative risk of earthquakes at a location based on the number and strength of previous earthquakes at that location.

The locations of features in a layer are defined by a data source. The data source might also provide data that you can use to configure controls on the layer, like what image to display or how large to make a bubble.

In this unit, you learned about the Azure Maps web SDK, including styles, navigation, and layers. Next, you'll create an Azure Maps account, so you can use the web SDK in a web app.
