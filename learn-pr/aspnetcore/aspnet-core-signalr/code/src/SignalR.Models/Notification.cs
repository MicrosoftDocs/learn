namespace SignalR.Models;

public record Notification(
    string Text,
    DateTime IssuedOn,
    Package Package)
{
    public Guid Id { get; init; } = Guid.NewGuid();
}
