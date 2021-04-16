The bus-catching scenario requires Azure Functions to process and analyze bus data.

## Catching the bus with Azure Functions

In the bus-catching scenario, Azure Functions can be used with a timer trigger (for example, every 15 seconds). The Azure Function should then ideally perform the following tasks:

1. Determine what the monitored routes are
1. Get the latest bus data
1. Identify buses in monitored routes and activating a geofence
1. Send an email notification for each activated bus

Let's dive deeper into how each of these tasks is completed. in the next exercise, you'll get to look closely at the code (in the language of your choice).

### Determine what the monitored routes are

The first step is to connect to Azure SQL Database and run a stored procedure to understand what the monitored routes are. In the previous exercise, you created a table in Azure SQL Database called `dbo.MonitoredRoutes` and inserted a single route `100113`. In production, users might have multiple or different routes that need to be monitored. In order to access this data from your Azure Function App, you must create a connection to Azure SQL Database and execute a stored procedure `web.GetMonitoredRoutes`. This stored procedure simply returns the monitored routes from the table. The Azure Function App will store it in a variable called `routes`.

```sql
CREATE PROCEDURE [web].[GetMonitoredRoutes]
AS
BEGIN
    SELECT 
    (
        SELECT RouteId FROM dbo.[MonitoredRoutes] FOR JSON AUTO
    ) AS MonitoredRoutes
END
GO
```

### Get the latest bus data

Next, the Azure Function needs to make an HTTP request to pull in the latest bus data from the King County Metro site (see an example here: <https://s3.amazonaws.com/kcm-alerts-realtime-prod/vehiclepositions_enhanced.json>). This task can be done easily in any language by making a simple REST call. The function then brings in the JSON and stores it in a variable called `busData`. An example below is shown in Python and would vary slightly depending on the function language selected.

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

### Identify buses in monitored routes and activating a geofence

Next, you need to connect to Azure SQL Database and run a stored procedure to take that JSON data `busData`, import it into Azure SQL Database, and store it in a table. Azure SQL Database supports JSON so this task isn't difficult. The result of the stored procedure contains information about the buses that are activating a geofence, meaning they have entered or exited a geofence.

You can optionally review the stored procedure `web.AddBusData` below which performs all the heavy lifting.

```sql
CREATE PROCEDURE [web].[AddBusData]
@payload NVARCHAR(max) 
AS
BEGIN
    SET NO COUNT ON
    SET XACT_ABORT ON
    SET TRAN ISOLATION LEVEL SERIALIZABLE
    BEGIN TRAN
    IF (isjson(@payload) != 1) BEGIN;
        THROW 50000, 'Payload is not a valid JSON document', 16;
    END;

    DECLARE @ids AS TABLE (id IN T);

    -- INSERT bus data
    INSERT INTO dbo.[BusData] 
        ([DirectionId], [RouteId], [VehicleId], [Location], [TimestampUTC])
    OUTPUT
        [Inserted].Id INTO @ids
    SELECT
        [DirectionId], 
        [RouteId], 
        [VehicleId], 
        geography::Point([Latitude], [Longitude], 4326) AS [Location], 
        [TimestampUTC]
    FROM
        openjson(@payload) WITH (
            [DirectionId] IN T,
            [RouteId] IN T,
            [VehicleId] IN T,
            [Latitude] DECIMAL(10,6) '$.Position.Latitude',
            [Longitude] DECIMAL(10,6) '$.Position.Longitude',
            [TimestampUTC] DATETIME2(7)
        )

    -- Get details of inserted data
    SELECT * INTO #t FROM dbo.[BusData] WHERE id IN (SELECT i.id FROM @ids i);

    -- Find geofences in which the vehicle is IN 
    SELECT 
        t.[Id] AS BusDataId,
        t.[VehicleId],
        t.[DirectionId],
        t.[TimestampUTC],
        t.[RouteId],
        g.Id AS geofenceId
    INTO
        #g
    FROM 
        dbo.geofences g 
    RIGHT JOIN
        #t t ON g.geofence.STContains(t.[Location]) = 1;

    -- Calculate status
    SELECT
        c.BusDataId,
        coalesce(a.[geofenceId], c.[geofenceId]) AS geofenceId,
        coalesce(a.[DirectionId], c.[DirectionId]) AS DirectionId,
        coalesce(a.[VehicleId], c.[VehicleId]) AS VehicleId,
        c.[RouteId],
        c.[TimestampUTC],
        CASE 
            WHEN a.geofenceId IS NULL AND c.geofenceId IS NOT NULL then 'Enter'
            WHEN a.geofenceId IS NOT NULL AND c.geofenceId IS NULL then 'Exit'  
        END AS [Status]
    INTO
        #s 
    FROM
        #g c
    FULL OUTER JOIN
        dbo.geofencesActive a ON c.DirectionId = a.DirectionId AND c.VehicleId = a.VehicleId;
 
    -- Delete exited geofences
    DELETE 
        a
    FROM
        dbo.geofencesActive a
    INNER JOIN
        #s s ON a.VehicleId = s.VehicleId AND s.DirectionId = a.DirectionId AND s.[Status] = 'Exit';

    -- INSERT entered geofences
    INSERT INTO dbo.geofencesActive 
        ([geofenceId], [DirectionId], [VehicleId])
    SELECT
        [geofenceId], [DirectionId], [VehicleId]
    FROM
        #s s
    WHERE 
        s.[Status] = 'Enter';

    -- INSERT Log
    INSERT INTO dbo.geofenceLog 
        (geofenceId, BusDataId, [RouteId], [VehicleId], [TimestampUTC], [Status])
    SELECT
        geofenceId, BusDataId, [RouteId], [VehicleId], [TimestampUTC], IS null([Status], 'In')
    FROM
        #s s
    WHERE
        s.[geofenceId] IS NOT NULL
    AND
        s.[BusDataId] IS NOT NULL

    -- Return Entered or Exited geofences
    SELECT
        ((
        SELECT
            s.[BusDataId],  
            s.[VehicleId],
            s.[DirectionId],  
            s.[RouteId], 
            r.[ShortName] AS RouteName,
            s.[geofenceId], 
            gf.[Name] AS geofence,
            s.[Status] AS geofenceStatus,
            s.[TimestampUTC]
        FROM
            #s s
        INNER JOIN
            dbo.[geofences] gf ON s.[geofenceId] = gf.[Id]
        INNER JOIN
            dbo.[Routes] r ON s.[RouteId] = r.[Id]
        WHERE
            s.[Status] IS NOT null AND s.[geofenceId] IS NOT NULL
        for 
            json path
    )) AS ActivatedGeofences
    COMMIT
END
GO
```

### Send an email notification for each activated bus

Finally, for each bus that is activating a geofence, call an Azure Logic App with the bus route number and the activation status (for example, `Enter` or `Exit`). This Azure Logic App should then do something to notify the user that their bus is entering or exiting the geofence. More on this piece of the solution will be covered in a future unit.
