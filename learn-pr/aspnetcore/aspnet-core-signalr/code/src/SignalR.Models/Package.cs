namespace SignalR.Models;

public record Package(
    string PackageId,
    string Type,
    Address ShipToAddress,
    Address ShipFromAddress);
