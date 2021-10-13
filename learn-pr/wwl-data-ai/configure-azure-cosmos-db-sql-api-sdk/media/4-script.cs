Database database = await client.CreateDatabaseIfNotExistsAsync("cosmicworks");

Database database = client.CreateDatabaseIfNotExistsAsync("cosmicworks").Result;

Container container = await database.CreateContainerIfNotExistsAsync("products", "/categoryId", 400);

container.GetItemLinqQueryable<T>()
    .Where(i => i.categoryId == 2)
    .ToList<T>();

container.GetItemLinqQueryable<T>()
    .Where(i => i.categoryId == 2)
    .ToFeedIterator<T>();

QueryRequestOptions options = new ()
{
    MaxItemCount = 500
};

QueryRequestOptions options = new ()
{
    MaxConcurrency = 5
};

QueryRequestOptions options = new ()
{
    MaxBufferedItemCount = 5000
};