public static IServiceCollection AddApplicationServices(this IServiceCollection services)
{
    //register delegating handlers
    services.AddTransient<HttpClientAuthorizationDelegatingHandler>();
    services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

    //register HTTP services
    services.AddHttpClient<ICouponService, CouponService>()
        .AddHttpMessageHandler<HttpClientAuthorizationDelegatingHandler>()
        .AddPolicyHandler(GetRetryPolicy())
        .AddPolicyHandler(GetCircuitBreakerPolicy());

    //code omitted for brevity

    return services;
}
