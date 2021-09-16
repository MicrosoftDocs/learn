namespace SignalR.Server.Hubs;

[Authorize, RequiredScope(new[] { "RealTime.Access" })]
public class NotificationHub : Hub
{
}
