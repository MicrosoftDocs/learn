public IServiceProvider ConfigureServices(IServiceCollection services)
{
    services.AddAppInsights(Configuration)
        .AddGrpc().Services
        .AddCustomMVC(Configuration)
        .AddCustomDbContext(Configuration)
        .AddCustomOptions(Configuration)
        .AddIntegrationServices(Configuration)
        .AddEventBus(Configuration)
        .AddSwagger(Configuration)
        .AddCustomHealthCheck(Configuration);

    var container = new ContainerBuilder();
    container.Populate(services);

    return new AutofacServiceProvider(container.Build());
}