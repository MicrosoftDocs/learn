var builder = WebApplication.CreateBuilder(args);

var (services, configuration) = (builder.Services, builder.Configuration);

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
app.MapHub<NotificationHub>("/notifications");

app.Run();
