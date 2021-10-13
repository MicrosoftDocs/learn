using Microsoft.Azure.Cosmos.Fluent;

CosmosClientBuilder builder = new (connectionString);

CosmosClientBuilder builder = new (endpoint, key);

builder.AddCustomHandlers(new LogHandler());

CosmosClient client = builder.Build();

Database result = await client.CreateDatabaseIfNotExistsAsync("cosmicworks");

public class LogHandler : RequestHandler
{    
    public override async Task<ResponseMessage> SendAsync(RequestMessage request, CancellationToken cancellationToken)
    {
        Console.WriteLine($"[{request.Method.Method}]\t{request.RequestUri}");

        ResponseMessage response = await base.SendAsync(request, cancellationToken);
        
        Console.WriteLine($"[{Convert.ToInt32(response.StatusCode)}]\t{response.StatusCode}");
        
        return response;
    }
}