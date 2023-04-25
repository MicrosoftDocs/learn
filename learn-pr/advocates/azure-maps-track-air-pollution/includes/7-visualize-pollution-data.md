In this unit, you retrieve air quality data from an API and convert it to GeoJSON. Then, you can use the data in your map app as a bubble layer of information for a location.

## Get air quality data

The [World Air Quality Index](https://waqi.info?azure-portal=true) aggregates air quality data from around the world. The data is available through a free API as the current Air Quality Index (AQI) reading from multiple recording stations around the world. You can use the data in your app.

When you request data, you have two options. You can:

* Request data for a single location, to get the nearest reading for a city or location.
* Request data for all stations within a rectangle that's defined by using the north-east and south-west coordinates of the rectangle.

The map should plot as much data as possible based on the visible area of a map. AQI data can be requested only for stations that are in the visible area of the map. Narrowing your request makes the API call faster because only the data that's needed is requested.

### AQI data format

AQI data is in the following JSON format:

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

The `data` property contains an array of JSON objects for all the measuring stations that are requested. Objects have locations defined by longitude, latitude, and the AQI measurement. The data can't be plotted on the map in the format that you receive it. Your app must first convert the data to a GeoJSON feature collection.

The following steps are an overview of the steps you take to convert AQI data to a feature collection. Later in this unit, you implement these steps in code.

To convert AQI data to a GeoJSON feature collection:

1. Create a blank feature collection.

1. For each item in the `data` array, create a new feature:

    1. The geometry of the feature is a location `Point`, with the coordinates set to the longitude `lon` and latitude `lat`.

    1. Instead of plotting the AQI measurement directly, it's easier to represent the data as a colored bubble. Convert the AQI measurement to a color value as an RGB hex string. Then, add the converted color value to the feature’s `properties` array.

    Here's the GeoJSON for the data in this example:

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

To use the WAQI API, register for an API key. Later, you add the key to the environment variables for the application.

To get the WAQI API key:

1. Go to the [Air Quality Open Data Platform](https://aqicn.org/data-platform/token/#/?azure-portal=true) token request page on the WAQI website.

1. Enter your email address and name.

1. Review and agree to the API usage terms of service.

1. Select **Submit**.

1. Check your email inbox for a confirmation message from the WAQI website. In the email message, select the **Confirm your email address** link.

1.	After you confirm your email address, you’re redirected to a new webpage that displays your token. Copy and save your token.

    The token is the WAQI API key value that you use in a later step.

### Update the app to use the API token 

When you have the WAQI API token, add the token key value to the environment variables for your app:

1. In Visual Studio Code, open the *.env* file in your application code folder.

1. Add the following statement to the end of the *.env* file: 

    ```console
    WAQI_API_KEY=<your waqi key>
    ```

    Replace `<your waqi key>` with the value of your WAQI API key.

1. Save the changes to the *.env* file.

1. In Visual Studio Code, open your <i>app.py</i> file.

1. In the <i>app.py</i> code, find the statement that loads the `MAP_KEY` value. After that statement, add the following statements to load the WAQI API key. The code defines the `WAQI_API_KEY` constant for the API URL:

    ```python
    # Load the World Air Quality Index key from the .env file.
    WAQI_API_KEY = os.environ["WAQI_API_KEY"]
    WAQI_API_URL = "https://api.waqi.info/map/bounds/?latlng={},{},{},{}&token={}"
    ```

    The `WAQI_API_URL` defines a call to get all the air quality readings for a rectangular region defined by the `lon` and `lat` coordinates.

1. Save the changes to the <i>app.py</i> file.

### Add a data source to the map

The last step is to add a data source to the map to render the AQI data. Azure Maps uses data sources to plot layers. A data source can get its data from a GeoJSON feature collection.

1. In Visual Studio Code, open the *home.html* file in the *templates* folder for your app.

1. In this file, find the statements that handle the `ready` event for the map. This code should appear on lines 46 through 52:

    ```javascript
    // When the map is ready, center the map on the user's location.
    map.events.add('ready', function () {
        map.setCamera({
            center: map_center,
            zoom: 5
        })
    })
    ```

1. Replace this section of code with the following statements, and then save the file:

    ```javascript
    // When the map is ready, center the map on the user's location.
    map.events.add('ready', function () {
        // Declare a data source for the AQI data.
        var datasource = new atlas.source.DataSource();
        map.sources.add(datasource);

        // Declare a function to update the AQI data.
        function updateAQIData(e) {
            // Get the current bounds on the screen.
            bounds = map.getCamera().bounds

            // Set the data source data to results of the AQI call.
            // This is a feature collection that contains the AQI measurements.
            fetch('./aqi?bounds=' + bounds)
                .then(res => {
                    return res.json()
                }).then(response => {
                    datasource.clear()
                    datasource.setShapes(response)
                })
        }

        // Add a bubble layer.
        map.layers.add(new atlas.layer.BubbleLayer(datasource, null, {
            radius: 10,
            opacity: 0.5,
            strokeOpacity: 0,
            // Get the color from the color property.
            color: ['get', 'color']
        }));

        // Handle any events that change the bounds of the map.
        map.events.add('zoomend', updateAQIData)
        map.events.add('dragend', updateAQIData)
        map.events.add('pitchend', updateAQIData)

        map.setCamera({
            center: map_center,
            zoom: 5
        })
    })
    ```

    This data source is used to create a bubble layer that shows circles on a map. This layer shows one bubble for each feature in the feature collection, using the coordinates of the geometry. The bubbles have a fixed size and opacity, but the color isn't fixed. Instead, the `['get', 'color']` code tells the map to load the color from a property of the feature called `color`.

    The `updateAQIData` function is added to three map events that fire when the map is zoomed or moved, or the pitch is changed. Every time the user moves the map, the function is called. The function gets the current bounds from the Maps camera; that is, from the north-west and south-east coordinates of the map piece that is visible on the screen. The function then passes these bounds to a call to the `api` route, calling into the Python code to load the AQI data. Finally, the feature collection is added to the data source.

### Load the air quality data

The Flask app needs to call the API to load the data for the visible portion of a map.

1. Open the <i>app.py</i> file.

1. Add the following code to the bottom of the file:

    ```python
    def get_color(aqi):
        # Convert the AQI value to a color.
        if aqi <= 50: return "#009966"
        if aqi <= 100: return "#ffde33"
        if aqi <= 150: return "#ff9933"
        if aqi <= 200: return "#cc0033"
        if aqi <= 300: return "#660099"
        return "#7e0023"

    def load_aqi_data(lon1, lat1, lon2, lat2):
        # Load the air quality data.
        url = WAQI_API_URL.format(lat1, lon1, lat2, lon2, WAQI_API_KEY)
        aqi_data = requests.get(url)

        # Create a GeoJSON feature collection from the data.
        feature_collection = {
            "type" : "FeatureCollection",
            "features" : []
        }

        for value in aqi_data.json()["data"]:
            # Filter out empty values.
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
        # Get the bounds from the request.
        bounds = request.args["bounds"].split(",")

        # Load the AQI data and create the GeoJSON for the specified bounds.
        return json.dumps(load_aqi_data(bounds[0], bounds[1], bounds[2], bounds[3]))
    ```

1. Save the file.

This code implements an API call inside the Flask app that loads the AQI data from the API for a specific set of coordinates. The AQI data is then converted to a feature collection and returned as a JSON string. Then, the API can be called from the webpage.

### Show the air quality data on the map

The feature collection that you created from the WAQI data is ready to show on a map.

In Visual Studio Code, make sure that your <i>app.py</i> file is open. Select the **Run** icon in the Activity Bar to open the **Run** view. Then, select the green arrow to run the Flask app and open it in a browser.

You should see colored circles (bubbles) on the map that show the WAQI data:

:::image type="content" source="../media/final-output.png" alt-text="Screenshot that shows a map with air quality shown as colored circles." lightbox="../media/final-output.png":::

Move around the map and see the bubbles update to match the area you're viewing.

Have a look at the different colors to see the areas of bad or hazardous air quality. Think about why the air quality is so poor in these areas. Some reasons are obvious, like in areas with large numbers of fossil fuel-burning power stations or factories. Others aren't so obvious. Find ones near you and think about what might cause the pollution.
