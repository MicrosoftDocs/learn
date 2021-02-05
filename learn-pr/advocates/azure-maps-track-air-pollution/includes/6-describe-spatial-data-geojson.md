GeoJSON is an internet-standard geospatial data format that's based on JavaScript Object Notation (JSON). To add layers to a map control, you need to define a data source that contains GeoJSON data. The map control uses the data to create overlays based on locations. For example, you'd use a GeoJSON data source to define the placement of features in a bubble layer on a map.

> [!NOTE]
> GeoJSON is defined as a standard in Internet Engineering Task Force (IETF)) [RFC 7946](https://tools.ietf.org/html/rfc7946?azure-portal=true).

## GeoJSON objects

The GeoJSON format defines three objects:

* Geometry
* Feature
* Feature collection

### Geometry

A *geometry* is a region in space. A geometry can be:

* A single point that's defined by a longitude and a latitude
* Multiple points that describe a line
* Multiple points that describe the outline of a polygon
* A collection of multiple geometries

A geometry GeoJSON object has two properties:

* `type`: Specifies the type of geometry, like a `Point` or a `Polygon`.
* `coordinates`: Contains coordinates as longitude and latitude values in a two-item array. The first item is the longitude, and the second item is the latitude. Points have a single value in an array. Lines and polygons have multiple values in an array. For polygons, the shape must be closed, so the last coordinate must be the same as the first coordinate.

Here's an example geometry object that contains a single point on the Microsoft headquarters in Redmond, Washington, USA:

```json
{
    "type": "Point",
    "coordinates": [-122.136866, 47.642472]
}
```

Here's an example of a polygon for a square around Paris, France:

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

This square has five coordinates: four corners and the last coordinate, which is the same as the first coordinate, to close the square.

### Feature

A *feature* is a spatially bounded entity. So, it's a geometry that has a set of properties that describe what is in that location. The properties can be data, like a place name or the temperature.

A feature GeoJSON object has three properties:

* `type`:  Specifies the type of object and is always `Feature` for a feature.
* `geometry`: A GeoJSON geometry object that defines the location of the feature.
* `properties`:  Any valid GeoJSON object, and it defines the properties of the feature.

Here's an example feature for Paris, France:

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

A *feature collection*, as its name suggests, is a collection of features.

A feature collection GeoJSON object has two properties:

* `type`: Specifies the type of object and is always `FeatureCollection` for a feature collection.
* `features`: An array of GeoJSON feature objects.

Here's an example of a feature collection for two European cities:

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

In this unit, you learned about the GeoJSON format that's used to store spatial data and its three object types. Next, you'll use an API to get air quality data, convert the data to GeoJSON, and then show the data on a map.
