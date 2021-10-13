CosmosClientOptions options = new ()
{
    ConnectionMode = ConnectionMode.Direct
};

CosmosClientOptions options = new ()
{
    ConnectionMode = ConnectionMode.Gateway
};

CosmosClientOptions options = new ()
{
    ConsistencyLevel = ConsistencyLevel.Eventual
};

CosmosClientOptions options = new ()
{
    ApplicationRegion = "westus"
};

CosmosClientOptions options = new CosmosClientOptions()
{
    ApplicationPreferredRegions = new List<string> { "westus", "eastus" }
};

CosmosClientOptions options = new ();

CosmosClient client = new (endpoint, key, options);

CosmosClient client = new (connectionString, options);