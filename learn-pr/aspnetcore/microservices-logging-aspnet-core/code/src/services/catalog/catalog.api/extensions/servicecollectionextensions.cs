public static IServiceCollection AddAppInsights(
    this IServiceCollection services, IConfiguration configuration)
{
    services.AddApplicationInsightsTelemetry(configuration);
    services.AddApplicationInsightsKubernetesEnricher();

    return services;
}
