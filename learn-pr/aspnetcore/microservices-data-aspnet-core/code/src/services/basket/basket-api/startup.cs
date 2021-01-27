#region snippet_ConfigureServices
public virtual IServiceProvider ConfigureServices(IServiceCollection services)
{
    services.AddCustomHealthCheck(Configuration);
    services.Configure<BasketSettings>(Configuration);
    services.AddSingleton<ConnectionMultiplexer>(sp =>
    {
        var settings = sp.GetRequiredService<IOptions<BasketSettings>>().Value;
        return ConnectionMultiplexer.Connect(settings.ConnectionString);
    });
}
#endregion snippet_ConfigureServices

#region snippet_AddCustomHealthCheck
public static IServiceCollection AddCustomHealthCheck(
    this IServiceCollection services, IConfiguration configuration)
{
    var hcBuilder = services.AddHealthChecks();

    hcBuilder.AddCheck("self", () => HealthCheckResult.Healthy())
             .AddRedis(
                 configuration["ConnectionString"],
                 name: "redis-check",
                 tags: new string[] { "redis" });

    // code omitted for brevity

    return services;
}
#endregion snippet_AddCustomHealthCheck
