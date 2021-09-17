namespace SignalR.Server.Hubs;

public class NotificationHub : Hub
{
    public Task SendNotification(Notification notification) =>
        Clients.Others.SendAsync("ReceiveNotification", notification);
}
