The bus-catching scenario requires Azure Functions to process and analyze bus data. In this unit, you'll review the architecture of the solution that you'll implement in the next exercise (in the language of your choice).

## Catching the bus with Azure Functions

In the bus-catching scenario, Azure Functions can be used with a timer trigger. Since you want real-time data and results, you can set the function to run every 15 seconds. The Azure Function should then ideally perform the following tasks:

1. Determine what the monitored routes are
1. Get the latest bus data
1. Identify buses in monitored routes and activating a geofence
1. Send an email notification for each activated bus

### Determine monitored routes with Azure Functions inputs

In the bus-catching scenario, a user of the solution probably doesn't want to monitor every single bus route from the real-time bus data feed. A user is probably only interested in a few routes that will help them get from where they're to where they're going.

The first task for the Azure Function is to connect to Azure SQL Database and run a stored procedure to understand what the monitored routes are. In the previous exercise, you created a table in Azure SQL Database called `dbo.MonitoredRoutes` and inserted a single route `100113`. In production, users might have multiple or different routes that need to be monitored. In order to access this data from your Azure Function App, you must create a connection to Azure SQL Database and execute a stored procedure `web.GetMonitoredRoutes`. This stored procedure simply returns the monitored routes from the table. The Azure Function App will store it in a variable called `routes`.

### Get the latest bus data with Azure Functions

Next, the Azure Function needs to make an HTTP request to pull in the latest bus data from the King County Metro site (see an example here: <https://s3.amazonaws.com/kcm-alerts-realtime-prod/vehiclepositions_enhanced.json>). This task can be done easily in any language by making a simple REST call from the function. The function then brings in the JSON results and stores it in a variable called `busData`. An example below is shown in Python and would vary slightly depending on the function language selected.

```python
def GetRealTimeFeed():
    response = requests.get(GTFS_RT_FEED)
    entities = json.loads(response.text)['entity']
    busData = []
    for entity in entities:
        v = entity['vehicle']
        busDetails = {
            "DirectionId": v['trip']['direction_id'],
            "RouteId": v['trip']['route_id'],
            "VehicleId": v['vehicle']['id'],
            "Position": {
                "Latitude": v['position']['latitude'],
                "Longitude": v['position']['longitude']
            },
            "TimestampUTC": dt.utcFROMtimestamp(v['timestamp']).isoformat(sep=' ')
        }
        busData.append(busDetails)    
    return busData
```

### Identify buses in monitored routes and activating a geofence using Azure SQL Database

Next, you need to connect to Azure SQL Database and run a stored procedure to take that JSON data `busData` and store it in a table. Azure SQL Database supports JSON so this step is straightforward. The result of the stored procedure contains information about the buses that are activating a geofence, meaning they've entered or exited a geofence.

### Send an email notification for each activated bus using Azure Logic Apps

Finally, for each bus that is activating a geofence, the Azure Function should call an Azure Logic App with the bus route number and the activation status (for example, `Enter` or `Exit`). This Azure Logic App should then do something to notify the user that their bus is entering or exiting the geofence. More on this piece of the solution will be covered later in the module.
