var app = WebApplication.Create(args);
app.UseEndpoints(endpoints => endpoints.MapHub<NotificationHub>("/notifications"));
app.Run();
