<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
The bus-catching scenario requires Azure Functions to process and analyze bus data, in this unit you'll dive into how.
<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->

## Catching the bus with Azure Functions

In the bus-catching scenario, Azure Functions can be used with a timer trigger (for example, every 15 seconds). The Azure Function should then ideally perform the following tasks:

1. Determine what the monitored routes are
1. Get the latest bus data
1. Identify buses in monitored routes and activating a GeoFence
1. Send an email notification for each activated bus

Let's dive deeper into how each of these tasks is completed. In the next exercise, you'll get to look closely at the code (in the language of your choice).

### Determine what the monitored routes are

The first step is to connect to Azure SQL Database and run a stored procedure to understand what the monitored routes are. In the previous exercise, you created a table in Azure SQL Database called `dbo.MonitoredRoutes` and inserted a single route `100113`. In production, users might have multiple or different routes than what was entered. In order to access this data from your Azure Function App, you must create a connection to Azure SQL Database and execute a stored procedure `web.GetMonitoredRoutes`. This stored procedure simply returns the monitored routes from the table. The Azure Function App will store it in a variable called `routes`.

```sql
CREATE PROCEDURE [web].[GetMonitoredRoutes]
AS
BEGIN
    SELECT 
    ((
        SELECT RouteId FROM dbo.[MonitoredRoutes] FOR JSON AUTO
    )) AS MonitoredRoutes
END
GO
```

### Get the latest bus data

Next, the Azure Function needs to make an HTTP request to pull in the latest bus data from the King County Metro site (see an example here: <https://s3.amazonaws.com/kcm-alerts-realtime-prod/vehiclepositions_enhanced.json>). This can be done easily in any language by making a simple REST call. The function then brings in the JSON and stores it in a variable called `busData`. An example below is shown in Python and would vary slightly depending on the function language selected.

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
            "TimestampUTC": dt.utcfromtimestamp(v['timestamp']).isoformat(sep=' ')
        }
        busData.append(busDetails)    
    return busData
```

### Identify buses in monitored routes and activating a GeoFence

Next, you need to connect to Azure SQL Database and run a stored procedure to take that JSON data `busData`, import it into Azure SQL Database, and turn it into a table. Azure SQL Database supports JSON so this is not an arduous task. The result of the stored procedure contains information about the buses that are activating a GeoFence, meaning they have entered or exited a GeoFence.

You can review the stored procedure `web.AddBusData` in your `bus-db`which performs all the heavy lifting.

<!--
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

    DECLARE @ids AS TABLE (id INT);

    -- insert bus data
    insert into dbo.[BusData] 
        ([DirectionId], [RouteId], [VehicleId], [Location], [TimestampUTC])
    output
        [Inserted].Id into @ids
    select
        [DirectionId], 
        [RouteId], 
        [VehicleId], 
        geography::Point([Latitude], [Longitude], 4326) as [Location], 
        [TimestampUTC]
    from
        openjson(@payload) with (
            [DirectionId] int,
            [RouteId] int,
            [VehicleId] int,
            [Latitude] decimal(10,6) '$.Position.Latitude',
            [Longitude] decimal(10,6) '$.Position.Longitude',
            [TimestampUTC] datetime2(7)
        )

    -- Get details of inserted data
    select * into #t from dbo.[BusData] where id  in (select i.id from @ids i);

    -- Find geofences in which the vehicle is in
    select 
        t.[Id] as BusDataId,
        t.[VehicleId],
        t.[DirectionId],
        t.[TimestampUTC],
        t.[RouteId],
        g.Id as GeoFenceId
    into
        #g
    from 
        dbo.GeoFences g 
    right join
        #t t on g.GeoFence.STContains(t.[Location]) = 1;

    -- Calculate status
    select
        c.BusDataId,
        coalesce(a.[GeoFenceId], c.[GeoFenceId]) as GeoFenceId,
        coalesce(a.[DirectionId], c.[DirectionId]) as DirectionId,
        coalesce(a.[VehicleId], c.[VehicleId]) as VehicleId,
        c.[RouteId],
        c.[TimestampUTC],
        case 
            when a.GeoFenceId is null and c.GeoFenceId is not null then 'Enter'
            when a.GeoFenceId is not null and c.GeoFenceId is null then 'Exit'  
        end as [Status]
    into
        #s 
    from
        #g c
    full outer join
        dbo.GeoFencesActive a on c.DirectionId = a.DirectionId and c.VehicleId = a.VehicleId;
 
    -- Delete exited geofences
    delete 
        a
    from
        dbo.GeoFencesActive a
    inner join
        #s s on a.VehicleId = s.VehicleId and s.DirectionId = a.DirectionId and s.[Status] = 'Exit';

    -- Insert entered geofences
    insert into dbo.GeoFencesActive 
        ([GeoFenceId], [DirectionId], [VehicleId])
    select
        [GeoFenceId], [DirectionId], [VehicleId]
    from
        #s s
    where 
        s.[Status] = 'Enter';

    -- Insert Log
    insert into dbo.GeoFenceLog 
        (GeoFenceId, BusDataId, [RouteId], [VehicleId], [TimestampUTC], [Status])
    select
        GeoFenceId, BusDataId, [RouteId], [VehicleId], [TimestampUTC], isnull([Status], 'In')
    from
        #s s
    where
        s.[GeoFenceId] is not null
    and
        s.[BusDataId] is not null

    -- Return Entered or Exited geofences
    select
        ((
        select
            s.[BusDataId],  
            s.[VehicleId],
            s.[DirectionId],  
            s.[RouteId], 
            r.[ShortName] as RouteName,
            s.[GeoFenceId], 
            gf.[Name] as GeoFence,
            s.[Status] as GeoFenceStatus,
            s.[TimestampUTC]
        from
            #s s
        inner join
            dbo.[GeoFences] gf on s.[GeoFenceId] = gf.[Id]
        inner join
            dbo.[Routes] r on s.[RouteId] = r.[Id]
        where
            s.[Status] is not null and s.[GeoFenceId] is not null
        for 
            json path
    )) as ActivatedGeoFences
    commit
end
GO
```-->

### Send an email notification for each activated bus

Finally, for each bus that is activating a GeoFence, call an Azure Logic App with the bus route number and the activation status (for example, "Enter" or "Exit"). This Azure Logic App should then do something to notify the user that their bus is entering or exiting the GeoFence. More on this in a future unit.
<!-- Do not add a unit summary or references/links -->