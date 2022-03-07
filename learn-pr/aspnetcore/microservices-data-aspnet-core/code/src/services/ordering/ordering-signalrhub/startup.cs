public IServiceProvider ConfigureServices(IServiceCollection services)
{
    // code omitted for brevity

    if (Configuration["IsClusterEnv"] == bool.TrueString)
    {
        services
            .AddSignalR()
            .AddStackExchangeRedis(Configuration["SignalrStoreConnectionString"]);
    }
    else
    {
        services.AddSignalR();
    }

    // code omitted for brevity
}