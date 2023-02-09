Azure Static Web Apps provides the ability of unified hosting of an application and the associated API(s). Often, a database is required to obtain, process, and serve data related to the application.

In the bus-catching scenario, Azure SQL Database is used from Functions to execute stored procedures that add data to the database, process data to identify when buses enter or exit geofence(s), and serve data to be displayed on the website. Azure SQL Database is a great option since it supports many modern database capabilities such as: geospatial, JSON, versionless, serverless, and more.

In this unit, you'll look closely at the solution design as relates to accessing the data from Azure SQL Database. In the exercise that follows, you'll configure the connection to Azure SQL Database and monitor the solution.

## Access data for the front end using a jQuery application

The front end, a static web page, has been created using the well-known jQuery and the OpenLayers libraries. It's a simple application with goals to display a map, real-time bus data points, and geofence(s).

> [!NOTE]
> The code created was inspired by https://github.com/clydedacruz/openstreetmap-wkt-playground

In this application, an important part is getting the route ID and the geofence ID parameters that will be passed through the URL via the `rid` and `gid` URL parameters. These parameters tell the application the routes and geofence(s) a user wants to monitor. This step is important, because a user doesn't want to monitor all of the possible bus routes and geofences. A user just wants to know about bus routes that go from where they're to where they want to go.

```html
    const params = new URLSearchParams(location.search);
    const rid = params.get('rid');
    const gid = params.get('gid');
    const apiUrl = `/api/bus-data?rid=${rid}&gid=${gid}`;
```

After that, it's easy to call the `apiUrl` that calls the Azure Function that fetches the corresponding bus and geofence data from Azure SQL Database to be displayed in real time.

```html
$.getJSON(apiUrl, function (data) {
                plotWKT(data);                
            });
        }
```

Once the data is returned in Well-Known Text (WKT) format, the function `plotWKT` simply gathers `data.geoFence` and `data.busData` and plots them accordingly. Part of that function is shown in the following code.

```html
function plotWKT(data) {
    var f1, f2;

    if (data.busData == [] || data.geoFence == [])
        return;
    try {
        f1 = format.readFeature(data.geoFence);
        f2 = format.readFeature(data.busData);
    } catch (err) { }

    features.clear();

    // geoFence
    if (f1)
    {
        f1.getGeometry().transform('EPSG:4326', 'EPSG:3857');
        features.push(f1);
    }
    // busData
    if (f2)
    {
        f2.getGeometry().transform('EPSG:4326', 'EPSG:3857');
        features.push(f2);
    }
...
```

## Access data for the back end using Azure SQL Database

The front end essentially calls the API to return all the necessary data. Let's explore how Azure Functions does this task for the back end.

If you completed the previous module in the learning path (not required), you may remember that the Azure Function used to periodically fetch the latest bus data, process it, and add it to an Azure SQL Database is a *Timer Trigger*. That function is needed to fill the database with the relevant data. In this module, you'll instead use some sample bus data points that were inserted in an earlier exercise.

The Azure Function surfaced through the API in the Azure Static Web App is slightly different from the Timer Trigger. It's called when triggered by the client application (called an *HTTP Trigger*) and returns recent bus data relative to the route `rid` and geofence `gid` parameters received. The HTTP Trigger ensures that anytime the website is accessed, the data surfaced is updated. The code is simple across .NET, Node.js, and Python; let's break it down.

### Create a connection to Azure SQL Database

In .NET, you can use the **Microsoft.Data.SqlClient** library and grab the connection string from an environment variable with `private static readonly string AZURE_CONN_STRING = Environment.GetEnvironmentVariable("AzureSQLConnectionString");`. Then, you can use `var conn = new SqlConnection(AZURE_CONN_STRING)` to create a connection. This library makes it easy to connect and implement best practices, like retry logic. When we're working with cloud applications, retry logic ensures that if connectivity is briefly lost, your application doesn't break, but instead tries to connect again.

For Node.js, you can use the **mssql** package and grab the connection string from an environment variable with `const AZURE_CONN_STRING = process.env["AzureSQLConnectionString"];`. Then, you can use `const pool = await sql.connect(AZURE_CONN_STRING);` to create a connection. This package makes it easy to connect and query, among other things.

For Python, you can use the **pyodbc** library and grab the connection string from an environment variable with `AZURE_CONN_STRING = str(os.environ["AzureSQLConnectionString"])`. Then, you can use `conn = pyodbc.connect(AZURE_CONN_STRING)` to create a connection. This library makes accessing ODBC databases like Azure SQL Database simple, plus it's packed with Pythonic convenience.

As you can see, the process is the same, but the code and format is slightly different depending on the language and library used. Azure SQL Database's support of all languages makes using your language of choice simple. Once you're connected, there are different ways available in each language to execute the stored procedure `web.GetMonitoredBusData` with the `routeId` and `geofenceId` parameters.

### Return the real-time bus data to the application

The stored procedure `web.GetMonitoredBusData` returns the real-time bus data in the format of a table. Depending on language used, Node.js, .NET, or Python, the code, `JSON.parse`, `JObject.Parse`, and `json.dumps()` respectively, is used to convert the resulting objects into JSON. This JSON is then what is served to the client application to be plotted on the map.
