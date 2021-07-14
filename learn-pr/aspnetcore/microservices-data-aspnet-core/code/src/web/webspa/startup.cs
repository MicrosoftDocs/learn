public void ConfigureServices(IServiceCollection services)
{
    // code omitted for brevity

    if (Configuration["IsClusterEnv"] == bool.TrueString)
    {
        services.AddDataProtection(opts =>
        {
            opts.ApplicationDiscriminator = "eshop.webspa";
        })
        .PersistKeysToStackExchangeRedis(ConnectionMultiplexer.Connect(
            Configuration["DPConnectionString"]), "DataProtection-Keys");
    }

    // code omitted for brevity
}