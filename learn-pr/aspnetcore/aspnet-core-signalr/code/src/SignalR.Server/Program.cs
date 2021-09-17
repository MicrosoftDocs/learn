var builder = WebApplication.CreateBuilder(args);

var (services, configuration) = (builder.Services, builder.Configuration);

//services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
//        .AddMicrosoftIdentityWebApi(configuration.GetSection("AzureAdB2C"));

//services.Configure<JwtBearerOptions>(
//    JwtBearerDefaults.AuthenticationScheme,
//    options => options.TokenValidationParameters.NameClaimType = "name");

services.AddCors(
    options => options.AddDefaultPolicy(
        builder => builder.AllowAnyMethod()
            .AllowAnyHeader()
            .AllowCredentials()
            .SetIsOriginAllowed(origin => true)));

services.AddSignalR(options => options.EnableDetailedErrors = true)
    .AddMessagePackProtocol();

var app = builder.Build();

app.UseHttpsRedirection();
app.UseCors();
//app.UseAuthentication();
//app.UseAuthorization();
app.MapHub<NotificationHub>("/notifications");

app.Run();
