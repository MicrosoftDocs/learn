using SignalR.Models;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.SignalR.Client;

namespace SignalR.Client.Pages;

internal record ConnectionStatus(
    string Message, bool IsConnected = false, string? ConnectionId = null);

public partial class Notifications : ComponentBase, IAsyncDisposable
{
    private readonly HashSet<Notification> _notifications = new();

    private HubConnection _hubConnection;
    private ConnectionStatus _connectionStatus = new("Initiating connection...");

    protected override async Task OnInitializedAsync()
    {
        _hubConnection = new HubConnectionBuilder()
            .WithUrl(new Uri("https://localhost:5001/notifications"))
            .WithAutomaticReconnect()
            .AddMessagePackProtocol()
            .Build();

        _hubConnection.On<Notification>(
            "ReceiveNotification", OnReceiveNotification);

        _hubConnection.Closed += OnConnectionStateChangedAsync;
        _hubConnection.Reconnected += OnConnectionStateChangedAsync;
        _hubConnection.Reconnecting += OnConnectionStateChangedAsync;

        await _hubConnection.StartAsync();

        _connectionStatus = _connectionStatus with
        {
            Message = _hubConnection.State.ToString(),
            IsConnected = _hubConnection.State is HubConnectionState.Connected,
            ConnectionId = _hubConnection.ConnectionId
        };
    }

    private Task OnReceiveNotification(Notification notification)
    {
        if (_notifications.Add(notification))
        {

        }

        return Task.CompletedTask;
    }

    private Task OnConnectionStateChangedAsync(string? connectionId) =>
        InvokeAsync(() =>
        {
            _connectionStatus = new(
                $"Reconnected: your new connection identifier is {connectionId}.", true, connectionId);

            StateHasChanged();
        });

    private Task OnConnectionStateChangedAsync(Exception? exception) =>
        InvokeAsync(() =>
        {
            if (exception is not null)
            {
                _connectionStatus = _connectionStatus with
                {
                    Message = exception.Message,
                    IsConnected = false,
                    ConnectionId = null
                };
            }
        });

    public async ValueTask DisposeAsync()
    {
        if (_hubConnection is not null)
        {
            _hubConnection.Closed -= OnConnectionStateChangedAsync;
            _hubConnection.Reconnected -= OnConnectionStateChangedAsync;
            _hubConnection.Reconnecting -= OnConnectionStateChangedAsync;

            await _hubConnection.StopAsync();
            await _hubConnection.DisposeAsync();
        }
    }
}
