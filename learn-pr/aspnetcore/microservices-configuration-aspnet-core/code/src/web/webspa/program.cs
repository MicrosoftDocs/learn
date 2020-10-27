public class Program
{
    public static Task Main(string[] args) =>
        CreateHostBuilder(args).Build().RunAsync();

    public static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureWebHostDefaults(webBuilder => webBuilder.UseStartup<Startup>())
            .UseContentRoot(Directory.GetCurrentDirectory())
            .ConfigureAppConfiguration((_, configBuilder) =>
            {
                configBuilder.AddEnvironmentVariables();
                var settings = configBuilder.Build();

                if (settings.GetValue<bool>("UseFeatureManagement") && !string.IsNullOrEmpty(settings["AppConfig:Endpoint"]))
                {
                    configBuilder.AddAzureAppConfiguration(options =>
                    {
                        options.Connect(settings["AppConfig:Endpoint"])
                            .UseFeatureFlags()
                            .ConfigureRefresh(refresh =>
                            {
                                refresh.Register("AppConfig:Sentinel", refreshAll: true)
                                    .SetCacheExpiration(new TimeSpan(0, 0, 10));
                            });
                    });
                }
            })
            .ConfigureLogging((hostingContext, logBuilder) =>
            {
                logBuilder.AddConfiguration(hostingContext.Configuration.GetSection("Logging"));
                logBuilder.AddConsole();
                logBuilder.AddDebug();
                logBuilder.AddAzureWebAppDiagnostics();
            })
            .UseSerilog((builderContext, config) =>
            {
                config
                    .MinimumLevel.Information()
                    .Enrich.FromLogContext()
                    .WriteTo.Seq("http://seq")
                    .ReadFrom.Configuration(builderContext.Configuration)
                    .WriteTo.Console();
            });
}