using System
...
using Polly;
using Polly.Extensions.Http;
using Serilog;
...

public class Startup
{
    // code omitted for brevity
}

public static class ServiceCollectionExtensions
{
    ...
    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        ...
        services.AddHttpClient<ICouponService, CouponService>()
            .AddHttpMessageHandler<HttpClientAuthorizationDelegatingHandler>()
            .AddPolicyHandler(GetRetryPolicy())
            .AddPolicyHandler(GetCircuitBreakerPolicy());

        return services;
    }

    static IAsyncPolicy<HttpResponseMessage> GetRetryPolicy()
    {
        return HttpPolicyExtensions
            .HandleTransientHttpError()
            .WaitAndRetryAsync(5, retryAttempt => TimeSpan.FromMilliseconds(Math.Pow(1.5, retryAttempt) * 1000), (_, waitingTime) =>
            {
                Log.Logger.Information("----- Retrying in {WaitingTime}s", $"{ waitingTime.TotalSeconds:n1}");
            });
    }

    static IAsyncPolicy<HttpResponseMessage> GetCircuitBreakerPolicy()
    {
        return HttpPolicyExtensions
            .HandleTransientHttpError()
            .CircuitBreakerAsync(15, TimeSpan.FromSeconds(15));
    }
}