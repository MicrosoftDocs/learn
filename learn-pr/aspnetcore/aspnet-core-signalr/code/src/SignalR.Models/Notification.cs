namespace SignalR.Models;

public record Notification(
    string Message,
    DateTime IssuedAt,
    DateOnly DueDate,
    TimeOnly ExpectedTime)
{
    public Guid Id { get; init; } = Guid.NewGuid();
}
