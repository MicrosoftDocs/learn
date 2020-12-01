#region snippet_ConfigureServices
public void ConfigureServices(IServiceCollection services)
{
    if (Configuration.GetValue<bool>("UseFeatureManagement"))
    {
        services.AddFeatureManagement();
        services.AddAzureAppConfiguration();
    }
#endregion snippet_ConfigureServices

    services
        .AddHealthChecks()
        .AddCheck("self", () => HealthCheckResult.Healthy())
        .AddUrlGroup(new Uri(Configuration["IdentityUrlHC"]), 
            name: "identityapi-check", 
            tags: new string[] { "identityapi" });

    services.Configure<AppSettings>(Configuration);

    if (Configuration.GetValue<string>("IsClusterEnv") == bool.TrueString)
    {
        services.AddDataProtection(options =>
            options.ApplicationDiscriminator = "eshop.webspa")
        .PersistKeysToStackExchangeRedis(ConnectionMultiplexer.Connect(
            Configuration["DPConnectionString"]), "DataProtection-Keys");
    }

    services.AddAntiforgery(options => options.HeaderName = "X-XSRF-TOKEN");
    services.AddControllersWithViews(options =>
                options.Filters.Add(new AutoValidateAntiforgeryTokenAttribute()))
            .AddJsonOptions(options => 
                options.JsonSerializerOptions.PropertyNameCaseInsensitive = true);

    services.AddSpaStaticFiles(configuration => configuration.RootPath = "wwwroot");

}