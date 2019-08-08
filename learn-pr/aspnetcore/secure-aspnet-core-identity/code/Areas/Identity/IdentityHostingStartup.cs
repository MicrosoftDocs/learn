#region snippet_ConfigureAddDefaultIdentity
services.AddDefaultIdentity<ContosoPetsUser>()
    .AddDefaultUI(UIFramework.Bootstrap4)
    .AddEntityFrameworkStores<ContosoPetsAuth>();
#endregion

#region snippet_ConfigureAddClaims
public void Configure(IWebHostBuilder builder)
{
    builder.ConfigureServices((context, services) => {
        var sqlConnBuilder = new SqlConnectionStringBuilder(
            context.Configuration.GetConnectionString("ContosoPetsAuthConnection"));
        sqlConnBuilder.UserID = context.Configuration["DbUsername"];
        sqlConnBuilder.Password = context.Configuration["DbPassword"];

        services.AddDbContext<ContosoPetsAuth>(options =>
            options.UseSqlServer(sqlConnBuilder.ConnectionString));

        services.AddDefaultIdentity<ContosoPetsUser>()
            .AddDefaultUI(UIFramework.Bootstrap4)
            .AddEntityFrameworkStores<ContosoPetsAuth>()
            .AddClaimsPrincipalFactory<ClaimsPrincipalFactory>();
    });
}
#endregion
