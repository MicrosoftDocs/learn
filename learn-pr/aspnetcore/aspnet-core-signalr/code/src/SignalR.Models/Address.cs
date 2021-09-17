namespace SignalR.Models;

public record Address(
    string To,
    string StreetAddress,
    string City,
    string State,
    string Zip,
    string Country);
