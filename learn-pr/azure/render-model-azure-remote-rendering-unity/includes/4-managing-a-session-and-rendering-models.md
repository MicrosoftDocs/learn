Azure Remote Rendering uses a *session* to manage tasks involved in interacting with the cloud server. Remote Rendering provides the [session management REST API](/azure/remote-rendering/how-tos/session-rest-api) to manage and query information about Remote Rendering sessions.

## Create a session

The following example snippet uses the PowerShell [Invoke-WebRequest](/powershell/module/microsoft.powershell.utility/invoke-webrequestcommand) cmdlet to create a session.

```powershell
Invoke-WebRequest -Uri "$endPoint/v1/accounts/$accountId/sessions/create" -Method Post -ContentType "application/json" -Body "{ 'maxLeaseTime': '4:0:0', 'models': [], 'size': 'standard' }" -Headers @{ Authorization = "Bearer $token" }
```

When you create a new session, you use the `maxLeaseTime` parameter to specify a maximum lease time, typically in the range of one to eight hours. The maximum lease time is the duration during which the host accepts input. You can extend the lease time of an active session if necessary.

The response from the request returns a *sessionID*, which persists for 30 days and can be used to query information about the session. Only one device can connect to a Remote Rendering session at a time. 

For more PowerShell scripts that use the Remote Rendering API, see [Example PowerShell scripts](/azure/remote-rendering/samples/powershell-example-scripts).

## Connect to a session

Once a session is ready, you can connect to it. While connected, the client device can send commands to load and modify models. A Remote Rendering host only serves one client device at a time, so the client connected to a session has exclusive control over the rendered content. The single client connection also means that rendering performance never varies for reasons outside your control.

You can create, observe, and shut down as many sessions as you want from a single application. Because only one device can connect to a session at a time, attempts to connect to the session by other devices fail. Another device can connect only after the session stops.

## Stop a session

The session stops when the maximum lease time expires, or you can stop a session manually. To manually stop a session, you can call `RenderingSession.StopAsync`. The session might also stop because of some failure. Once the session stops, you're no longer billed, and all previous states such as loaded models are discarded.

After a session stops, you can query the persistent session ID by using `RenderingSession.SessionUuid()`. An application can call `RemoteRenderingClient.OpenRenderingSessionAsync` with the session ID to bind to that session and cache it locally.

When `RenderingSession.IsConnected` is `true`, `RenderingSession.Connection` returns an instance of `RenderingConnection`, which contains the functions to load models, manipulate entities, and query information about the rendered scene.
