public static IWebHost BuildWebHost(string[] args) =>
    WebHost.CreateDefaultBuilder(args)
        .UseStartup<Startup>()
        .UseContentRoot(Directory.GetCurrentDirectory())
        .ConfigureAppConfiguration((builderContext, configBuilder) =>
        {
            configBuilder.AddEnvironmentVariables();
            var settings = configBuilder.Build();

            if (settings.UseFeatureManagement() && !string.IsNullOrEmpty(settings["AppConfig:Endpoint"]))
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
        .ConfigureLogging((hostingContext, builder) =>
        {
            builder.AddConfiguration(hostingContext.Configuration.GetSection("Logging"));
            builder.AddConsole();
            builder.AddDebug();
            builder.AddAzureWebAppDiagnostics();
        })
        .UseSerilog((builderContext, config) =>
        {
            config
                .MinimumLevel.Information()
                .Enrich.FromLogContext()
                .WriteTo.Seq("http://seq")
                .ReadFrom.Configuration(builderContext.Configuration)
                .WriteTo.Console();
        })
        .Build();