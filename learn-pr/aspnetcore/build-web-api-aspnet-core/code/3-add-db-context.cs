public void ConfigureServices(IServiceCollection services)
{
    services.AddDbContext<ContosoPetsContext>(options =>
        options.UseInMemoryDatabase("ContosoPets"));
    services.AddControllers();
    // code omitted for brevity
}