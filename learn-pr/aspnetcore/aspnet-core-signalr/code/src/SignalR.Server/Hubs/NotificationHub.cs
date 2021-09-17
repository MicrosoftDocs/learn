namespace SignalR.Server.Hubs;

[Authorize, RequiredScope(new[] { "Notification.Access" })]
public class NotificationHub : Hub
{
}
