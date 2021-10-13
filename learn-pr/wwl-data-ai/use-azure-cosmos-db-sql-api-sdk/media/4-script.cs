using Microsoft.Azure.Cosmos;

string endpoint = "https­://dp420.documents.azure.com:443/";
string key = "fDR2ci9QgkdkvERTQ==";

CosmosClient client = new (endpoint, key);

string connectionString = "AccountEndpoint=https­://dp420.documents.azure.com:443/;AccountKey=fDR2ci9QgkdkvERTQ==";

CosmosClient client = new (connectionString);

AccountProperties account = await client.ReadAccountAsync();

Database database = client.GetDatabase("cosmicworks");

Database database = await client.CreateDatabaseAsync("cosmicworks");

Database database = await client.CreateDatabaseIfNotExistsAsync("cosmicworks");

Container container = database.GetContainer("products");

Container container = await database.CreateContainerAsync(
    "cosmicworks", 
    "/categoryId", 
    400
);

Container container = await database.CreateContainerIfNotExistsAsync(
    "cosmicworks", 
    "/categoryId", 
    400
);