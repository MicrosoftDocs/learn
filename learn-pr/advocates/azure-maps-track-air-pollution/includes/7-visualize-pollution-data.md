In this unit, you'll retrieve air quality data from an API and convert it to GeoJSON ready to show on the map as a bubble layer.

## Get air quality data

The [World Air Quality Index](https://waqi.info) aggregates air quality data from around the world, and makes this data available through a free API you can use in your app. The data is available as the current AQI (Air Quality Index) reading for multiple recording stations around the world. When you request data, you can do it for either:

* A single location to get the nearest reading for a city or location
* All the stations within a rectangle defined using the north-east and south-west coordinates of the rectangle.

The map should plot as much data as possible based on the visible area of the map. AQI data can be requested for just those stations within the visible area. This makes the API call faster, as only the data needed is requested.

### AQI data format

The AQI data is in the following JSON format:

```json
{
    "status": "ok",
    "data": [
        {
            "lat": 42.290094,
            "lon": -123.2321,
            "uid": 68,
            "aqi": "12",
            "station": {
                "name": "Applegate Valley, Oregon, USA",
                "time": "2020-04-21T17:00:00-07:00"
            }
        },
        ...
    ]
}
```

The `data` property contains an array of JSON objects for all the measuring stations requested. These object have a location as longitude and latitude, and the AQI measurement. This data can't be plotted on the map as is, it first needs to be converted to a GeoJSON feature collection.

The following steps will convert the data to a feature collection, and these steps will be implemented in code later in this unit.

1. Create a blank feature collection
1. For each item in the `data` array, create a new feature:
    1. The `geometry` of the feature is a `Point`, with the `coordinates` set to the `lon` and `lat`
    1. Rather than plot the AQI measurement directly, it's easier to visualize with a colored bubble. Convert the AQI measurement to a color value as an RGB hex string, and add to the features property array

For example, for the data above, the GeoJSON would be:

```json
{
    "type": "FeatureCollection",
    "features": [{
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [-123.2321, 42.290094]
            },
            "properties": {
                "color": "#009966"
            }
        }
    ]
}
```

### Get an API token

To use the WAQI API, you'll need to register for an API key from the [WAQI Data Platform page](https://aqicn.org/data-platform/token/#/). You'll need to provide and verify an email address to get the token.

Once you have the API token, it needs to be added to the environment variables ready for the app to use

1. Open the `.env` file

1. Add a new line to this file:

    ```sh
    WAQI_API_KEY=<your waqi key>
    ```

    Replace `<your waqi key>` with the value of your API key from the World Air Quality Index.

1. Save the file

1. Open the `app.py` file

1. Load this API key, and define a constant for the API URL by adding the following code after the `MAP_KEY` is loaded:

    ```python
    WAQI_API_KEY = os.environ["WAQI_API_KEY"]
    WAQI_API_URL = "https://api.waqi.info/map/bounds/?latlng={},{},{},{}&token={}"
    ```

    The API URL defines the call to get all the air quality readings for a rectangle.

1. Save the file

### Load the air quality data

The Flask app will need to call the API to load the data for the visible portion of the map.

1. Open the `app.py` file

1. Add the following code to the bottom of this file:

    ```python
    def get_color(aqi):
        # Convert the AQI value to a color
        if aqi <= 50: return "#009966"
        if aqi <= 100: return "#ffde33"
        if aqi <= 150: return "#ff9933"
        if aqi <= 200: return "#cc0033"
        if aqi <= 300: return "#660099"
        return "#7e0023"

    def load_aqi_data(lon1, lat1, lon2, lat2):
        # Load the air quality data
        url = WAQI_API_URL.format(lat1, lon1, lat2, lon2, WAQI_API_KEY)
        aqi_data = requests.get(url)

        # Create a GeoJSON feature collection from the data
        feature_collection = {
            "type" : "FeatureCollection",
            "features" : []
        }

        for value in aqi_data.json()["data"]:
            # Filter out empty values
            if value["aqi"] != "-":
                feature_collection["features"].append({
                    "type" : "Feature",
                    "properties" : {
                        "color" : get_color(int(value["aqi"]))
                    },
                    "geometry" : {
                        "type":"Point",
                        "coordinates":[value['lon'], value['lat']]
                    }
                    })

        return feature_collection

    @app.route("/aqi", methods = ["GET"])
    def get_aqi():
        # Get the bounds from the request
        bounds = request.args["bounds"].split(",")

        # Load the AQI data and create the GeoJSON for the given bounds
        return json.dumps(load_aqi_data(bounds[0], bounds[1], bounds[2], bounds[3]))
    ```

1. Save the file

This code implements an API call inside the Flask app that will load the AQI data from the API for a given set of coordinates. The AQI data will then be converted to a feature collection and returned as a JSON string. This API can then be called from the webpage.

### Show the air quality data on the map

The feature collection created from the AQI data is ready to be shown on a map. Azure Maps uses data sources to plot layers, and these data sources can source their data from GeoJSON feature collections.

1. Open the `home.html` file in the `templates` directory

1. Find the code that handles the `ready` event for the map. It will be from line 47 to line 52:

    ```js
    // when the map is ready, center the map on the users location
    map.events.add('ready', function () {
        map.setCamera({
            center: map_center,
            zoom: 5
        })
    })
    ```

1. Replace this code with the following:

    ```js
    // when the map is ready, center the map on the users location
    map.events.add('ready', function () {
        // Declare a data source for the AQI data
        var datasource = new atlas.source.DataSource();
        map.sources.add(datasource);

        // Declare a function to update the AQI data
        function updateAQIData(e) {
            // Get the current bounds on screen
            bounds = map.getCamera().bounds

            // Set the data source data to results of the aqi call
            // This is a feature collection with the AQI measurements
            fetch('./aqi?bounds=' + bounds)
                .then(res => {
                    return res.json()
                }).then(response => {
                    datasource.clear()
                    datasource.setShapes(response)
                })
        }

        // Add a bubble layer
        map.layers.add(new atlas.layer.BubbleLayer(datasource, null, {
            radius: 10,
            opacity: 0.5,
            strokeOpacity: 0,
            // Get the color from the color property
            color: ['get', 'color']
        }));

        // Handle any events that change the bounds of the map
        map.events.add('zoomend', updateAQIData)
        map.events.add('dragend', updateAQIData)
        map.events.add('pitchend', updateAQIData)

        map.setCamera({
            center: map_center,
            zoom: 5
        })
    })
    ```

    This code will add a data source to the map that can be used to render the AQI data. This data source is used to create a bubble layer that shows circles on the map. This layer will show one bubble for each feature in the feature collection, using the coordinates on the geometry. The bubbles have a fixed size and opacity, but the color isn't fixed, instead the `['get', 'color']` code tells the map to load the color from a property on the feature called `color`.

    The `updateAQIData` function is added to three map events that are fired when the map is zoomed, moved or the pitch is changed, so every time the user moves the map, the function is called. This function gets the current bounds from the maps camera, so the north-west and south-east coordinates of the map piece that is visible on screen. The function then passes these bounds to a call to the `api` route, calling into the Python code to load the AQI data. Finally this feature collection is added to the data source.

1. Save the file

1. Run the Flask app and open it in a browser. You'll see colored circles showing the AQI data.

    ![A map showing air quality as colored circles](../media/final-output.png)

    Navigate around the map and you'll see the bubbles update to match the area you are viewing.

1. Have a look at the different colors to see the areas of bad or hazardous air quality. Think about why the air quality is so poor in these areas. Some are obvious, such as areas with large numbers of fossil fuel burning power stations or factories, others are not so obvious. Find ones near to you, and think about the cause of the pollution.
