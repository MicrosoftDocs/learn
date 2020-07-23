#region snippet_AddApplicationServices
public static IServiceCollection AddApplicationServices(this IServiceCollection services)
{
    //code omitted for brevity

    services.AddHttpClient<ICouponService, CouponService>()
        .AddHttpMessageHandler<HttpClientAuthorizationDelegatingHandler>()
        .AddPolicyHandler(GetRetryPolicy())
        .AddPolicyHandler(GetCircuitBreakerPolicy());

    return services;
}
#endregion
