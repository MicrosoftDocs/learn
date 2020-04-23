GeoJSON is an Internet standard geospatial data format based on JavaScript Object Notation, or JSON. To add layers to an Azure Maps control, you need to define a data source that contains GeoJSON data to indicate the locations to use to show different overlays, for example to define the location of bubbles in a bubble layer.

> [!NOTE]
> GeoJSON was defined in the Internet Engineering Task Force RfC7946 - [https://tools.ietf.org/html/rfc7946](https://tools.ietf.org/html/rfc7946). This way it is a known standard for use across the internet.

## GeoJSON objects

The GeoJSON format defines three different objects:

* Geometry
* Feature
* Feature collection

### Geometry

A **Geometry** is a region in space, and can either be a single point defined by a longitude and latitude, multiple points in a line, or multiple points that describe the outline of a polygon. It can also contain multiple geometries.

The JSON object has two properties:

* `type` - this property specifies the type of geometry, such as a `Point` or a `Polygon`
* `coordinates` - this property contains the coordinates as longitude and latitude values in a two item array, with the first item the longitude, and the second the latitude. Points have a single value for a point, lines and polygons have multiple values in an array.

    For polygons, the shape must be closed, so the last coordinate must be the same as the first.

An example geometry object containing a single point on the Microsoft Campus in Redmond, Washington, USA is:

```json
{
    "type": "Point",
    "coordinates": [-122.136866, 47.642472]
}
```

An example polygon for a square around Paris is:

```json
{
    "type": "Polygon",
    "coordinates": [
        [
            [2.2580337524414062, 48.81251594581751],
            [2.4262619018554688, 48.81251594581751],
            [2.4262619018554688, 48.90377176147872],
            [2.2580337524414062, 48.90377176147872],
            [2.2580337524414062, 48.81251594581751]
        ]
    ]
}
```

This square has 5 coordinates, the 4 corners and the last coordinate the same as the first to close the square.

### Feature

A **Feature** is a spatially bounded entity, so a geometry with a set of properties that describe what is in that location. These properties can be data such as a place name, or the temperature.

This JSON object has three properties:

* `type` - this property specifies the type of object, and is always `Feature` for a feature
* `geometry` - this property is a GeoJSON geometry object that defines the location of this feature
* `properties` - this property is any valid JSON object and defines the properties of this feature

An example feature for Paris would be:

```json
{
    "type": "Feature",
    "geometry": {
        "type": "Polygon",
        "coordinates": [
            [
                [2.2580337524414062, 48.81251594581751],
                [2.4262619018554688, 48.81251594581751],
                [2.4262619018554688, 48.90377176147872],
                [2.2580337524414062, 48.90377176147872],
                [2.2580337524414062, 48.81251594581751]
            ]
        ]
    },
    "properties": {
        "city_name": "Paris",
        "population": 2148271
    }
}
```

### Feature collection

A **Feature collection**, as its name suggests, is a collection of features.

This JSON object has two properties:

* `type` - this property specifies the type of object, and is always `FeatureCollection` for a feature collection
* `features` - this property is an array of GeoJSON feature objects

An example for two european cities is:

```json
{
    "type": "FeatureCollection",
    "features": [{
            "type": "Feature",
            "geometry": {
                "type": "Polygon",
                "coordinates": [
                    [
                        [2.2580337524414062, 48.81251594581751],
                        [2.4262619018554688, 48.81251594581751],
                        [2.4262619018554688, 48.90377176147872],
                        [2.2580337524414062, 48.90377176147872],
                        [2.2580337524414062, 48.81251594581751]
                    ]
                ]
            },
            "properties": {
                "city_name": "Paris",
                "population": 2148271
            }
        },
        {
            "type": "Feature",
            "geometry": {
                "type": "Polygon",
                "coordinates": [
                    [
                        [-0.5287170410156249, 51.26019611626714],
                        [0.26641845703125, 51.26019611626714],
                        [0.26641845703125, 51.70916142932303],
                        [-0.5287170410156249, 51.70916142932303],
                        [-0.5287170410156249, 51.26019611626714]
                    ]
                ]
            },
            "properties": {
                "city_name": "London",
                "population": 8908081
            }
        }
    ]
}
```

In this unit, you learned about the GeoJSON format for storing spatial data, along with it's three object types. Next, you'll use an API to get air quality data, convert it to GeoJSON and show it on a map.
