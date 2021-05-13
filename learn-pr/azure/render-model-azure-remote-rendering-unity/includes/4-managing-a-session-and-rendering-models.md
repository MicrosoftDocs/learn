Remote rendering requires a session which manages the tasks involved for interacting with the cloud server. In the truck engine design example, a session would be created to enable viewing the engine model and query information about the scene. Here, you'll learn how to manage a session.

## Create a session

Only a single device may connect to a session at a time. The following command creates a new session:

```csharp
Invoke-WebRequest -Uri "$endPoint/v1/accounts/$accountId/sessions/create" -Method Post -ContentType "application/json" -Body "{ 'maxLeaseTime': '4:0:0', 'models': [], 'size': 'standard' }" -Headers @{ Authorization = "Bearer $token" }
```

The response from the request returns a **sessionID**. The **sessionID** persists for 30 days and is used to query information about the session. When you create a new session, you can specify a maximum lease time, typically in the range of one to eight hours. The maximum release time is reflected in the **maxLeaseTime** value. **maxLeaseTime** is the duration during which the host will accept your input. If necessary, you can extend the lease time of an active session.

## Connect to a session

Once the session is ready, you can connect to it. While connected, the device can send commands to load and modify models. Every Azure Remote Rendering host only ever serves one client device at a time, so when a client connects to a session, it has exclusive control over the rendered content. That also means that rendering performance will never vary for reasons outside of your control.

You can create, observe, and shut down as many sessions as you like from a single application. Given that only one device can connect to a session at a time, attempts by other devices to connect will fail. Only after a session stop can another device connect to the session.

## Stop a session

The session can be stopped either manually or when the maximum lease time expires. To manually stop a session, ``RenderingSession.StopAsync`` must be called. The session may also be stopped because of some failure. In any case, once the session stops, you're no longer billed for the service. Furthermore, when a session stops, all previous state (loaded models and such) is discarded.

However, after a session stops the persistent **sessionID** can be queried via ``RenderingSession.SessionUuid()`` and cached locally. With this ID, an application can call ``RemoteRenderingClient.OpenRenderingSessionAsync`` to bind to that session. When ``RenderingSession.IsConnected`` is ``true``, ``RenderingSession.Connection`` returns an instance of ``RenderingConnection``, which contains the functions to load models, manipulate entities, and query information about the rendered scene.