Azure Remote Rendering provides the [session management REST API](/azure/remote-rendering/how-tos/session-rest-api?azure-portal=true) to manage interactions with the cloud server and query information about Remote Rendering sessions. In C# and C++, you can create, update, and stop sessions through the `RemoteRenderingClient` and `RenderingSession` classes. This unit describes how to manage Remote Rendering sessions.

## Create a session

You can use PowerShell to request creation of a session.

```powershell
Invoke-WebRequest -Uri "$endPoint/v1/accounts/$accountId/sessions/create" -Method Post -ContentType "application/json" -Body "{ 'maxLeaseTime': '4:0:0', 'models': [], 'size': 'standard' }" -Headers @{ Authorization = "Bearer $token" }
```
When you create a new session, you use the `maxLeaseTime` parameter to specify a maximum lease time, typically in the range of one to eight hours. The maximum lease time is the duration during which the host accepts input. You can extend the lease time of an active session if necessary.

The response from the request returns a *session UUID*, which allows you to query information about the session. This UUID and some basic information about the session persist for 30 days, so you can query that information even after the session has stopped.

## Connect to a session

Once a session is ready, a client device can connect to it and can send commands to load and modify models. When `RenderingSession.IsConnected` is `true`, `RenderingSession.Connection` returns an instance of `RenderingConnection`, which contains the functions to load models, manipulate entities, and query information about the rendered scene.

You can create, observe, and shut down as many sessions as you want from a single application, but only one device can connect to a Remote Rendering session at a time. Attempts to connect to the session by other devices fail. Another device can connect only after the session stops.

Because a Remote Rendering host serves only one client device at a time, the client connected to a session has exclusive control over the rendered content. The single client connection also means that rendering performance never varies for reasons outside your control.

## Stop a session

The session stops when the maximum lease time expires or you stop the session manually. To manually stop a session, you can call `RenderingSession.StopAsync`. The session might also stop because of some failure. Once the session stops, you're no longer billed, and all previous states such as loaded models are discarded.

After a session stops, you can query the persistent session ID by using `RenderingSession.SessionUuid()`. An application can call `RemoteRenderingClient.OpenRenderingSessionAsync` with the session ID to bind to that session and cache it locally.

