public void ConfigureServices(IServiceCollection services)
{
    // code omitted for brevity

    services.AddCustomMvc(Configuration)
        .AddCustomAuthentication(Configuration)
        .AddApplicationServices();
}