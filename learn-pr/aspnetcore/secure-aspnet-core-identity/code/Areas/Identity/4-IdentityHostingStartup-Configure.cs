public void Configure(IWebHostBuilder builder)
{
    builder.ConfigureServices((context, services) => {
        var sqlConnBuilder = new SqlConnectionStringBuilder(
            context.Configuration.GetConnectionString("ContosoPetsAuthConnection"));
        sqlConnBuilder.UserID = context.Configuration["DbUsername"];
        sqlConnBuilder.Password = context.Configuration["DbPassword"];

        services.AddDbContext<ContosoPetsAuth>(options =>
            options.UseSqlServer(sqlConnBuilder.ConnectionString));

        services.AddDefaultIdentity<IdentityUser>()
            .AddDefaultUI(UIFramework.Bootstrap4)
            .AddEntityFrameworkStores<ContosoPetsAuth>();
    });
}
