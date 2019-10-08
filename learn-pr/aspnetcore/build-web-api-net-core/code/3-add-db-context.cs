public void ConfigureServices(IServiceCollection services)
{
    services.AddDbContext<ContosoPetsContext>(options =>
        options.UseInMemoryDatabase("ContosoPets"));
    services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);
}