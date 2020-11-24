A mistake that many people make when first exploring dedicated SQL Pools are to use the service administrator account as the one used for loading data. This account is limited to using the smallrc dynamic resource class that can use between 3% and 25% of the resources depending on the performance level of the provisioned SQL Pools.

Instead, it’s better to create specific accounts assigned to different resource classes dependent on the anticipated task. This will optimize load performance and maintain concurrency as required by managing the available resource slots available within the dedicated SQL Pool.

This example creates a loading user classified to a specific workload group.

1. The first step is to connect to master and create a login.

    ```sql
    -- Connect to master
    CREATE LOGIN loader WITH PASSWORD = 'a123STRONGpassword!';
    ```

2. Next, connect to the dedicated SQL pool and create a user. 

    The following code assumes you're connected to the database called mySampleDataWarehouse. It shows how to create a user called loader and gives the user permissions to create tables and load using the COPY statement. Then it classifies the user to the DataLoads workload group with maximum resources.

    ```sql
    -- Connect to the SQL pool
    CREATE USER loader FOR LOGIN loader;
    GRANT ADMINISTER DATABASE BULK OPERATIONS TO loader;
    GRANT INSERT ON <yourtablename> TO loader;
    GRANT SELECT ON <yourtablename> TO loader;
    GRANT CREATE TABLE TO loader;
    GRANT ALTER ON SCHEMA::dbo TO loader;
    
    CREATE WORKLOAD GROUP DataLoads
    WITH ( 
        MIN_PERCENTAGE_RESOURCE = 100
        ,CAP_PERCENTAGE_RESOURCE = 100
        ,REQUEST_MIN_RESOURCE_GRANT_PERCENT = 100
        );

    CREATE WORKLOAD CLASSIFIER [wgcELTLogin]
    WITH (
            WORKLOAD_GROUP = 'DataLoads'
        ,MEMBERNAME = 'loader'
    );
    ```
