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
