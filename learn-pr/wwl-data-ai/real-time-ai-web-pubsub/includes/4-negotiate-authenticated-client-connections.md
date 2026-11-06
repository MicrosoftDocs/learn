::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=036027c4-6b1a-4bbe-a67c-3d9dd4b379ac]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

AI investigation updates can reveal log excerpts, affected resource names, or generated findings that belong to a particular incident or tenant. Before a browser connects to Azure Web PubSub, your backend must verify who the caller is and which operation the caller can observe. Negotiation is the application step that turns those decisions into a scoped client connection.

> [!NOTE]
> The code examples in this unit are patterns to adapt to your application. They use the Python service and client libraries. The Python client represents the connection algorithm for teaching purposes; it doesn't run in the browser. Authentication middleware, HTTP handling, and browser interactions remain outside these fragments.

## Authorize the operation before generating a token

A [client access URL](/azure/azure-web-pubsub/howto-generate-client-access-url) contains the WebSocket endpoint and a bearer token that permits a connection to the service. Anyone who obtains a valid URL can attempt to use that connection authorization. The backend must therefore apply application access checks before returning the URL.

The negotiation endpoint verifies the signed-in user and checks the target operation's tenant and access policy. Only then does the backend derive the user ID and permitted group.

Access might include the assigned on-call developer, incident commander, and database specialist, not every user in the tenant. Status and result endpoints enforce the same policy.

Identity comes from trusted middleware or a validated access token. Browser-supplied user IDs, tenant IDs, and group names aren't identity assertions.

## Choose the smallest useful recipient scope

A Web PubSub user can have several connections, including multiple browser tabs. A group collects connections that should receive a particular stream of updates. Choose group membership from application relationships rather than from whatever group string the browser requests.

Common scopes have different consequences:

- **User scope:** A notification reaches connections associated with one application user. Use an opaque, tenant-qualified identity if the same local user identifier can appear in different tenants.
- **Incident scope:** Several authorized responders observe updates across an incident. Membership must reflect current incident access rather than possession of its ID.
- **Operation scope:** Connections observe one background investigation within the incident. This scope limits the audience for progress, generated findings, and completion.

For an operation group, a backend can derive a stable, opaque name by hashing an unambiguous encoding of the tenant and operation IDs. This approach avoids collisions when IDs contain delimiters and avoids exposing those IDs in routing names. Avoid credentials, access tokens, personal details, and forward slashes in group names or user IDs. Group names are routing identifiers, not secrets.

For a browser that only observes updates, a group-specific role such as `webpubsub.joinLeaveGroup.operation-<opaque-id>` permits joining and leaving that group. The role doesn't permit publishing messages to the group. Don't add `webpubsub.sendToGroup` or unrestricted `webpubsub.joinLeaveGroup` just because a sample chat application uses those roles.

The [client protocol permissions](/azure/azure-web-pubsub/concept-client-protocols#permissions) govern group operations. Any upstream application event handlers still need their own authorization checks. A connection token isn't proof that every command received over that connection is allowed.

## Keep backend credentials separate from client permissions

The backend service client authenticates to Azure using a trusted service credential, while the browser receives a scoped connection token. These are separate authorization boundaries. Browser token roles don't replace Azure RBAC permissions for the backend identity, and Azure RBAC assignments don't define which operations an application user can view.

You can use [Azure Identity with the service client](/azure/azure-web-pubsub/howto-use-azure-identity) instead of placing service keys in application code. For token generation with Microsoft Entra ID, the backend identity needs both `Microsoft.SignalRService/WebPubSub/clientConnection/generateToken/action` and `Microsoft.SignalRService/WebPubSub/clientConnection/write`. The built-in **Web PubSub Service Owner** role includes both but provides broader data-plane access. A custom role can restrict the identity to the required operations.

A publisher needs the relevant send permissions. Separate backend identities can receive different permissions. Assign deployed managed identities their own roles; developer assignments don't transfer.

The following fragment generates an operation-scoped URL in a Python business-logic function. The HTTP layer supplies an authenticated principal and the requested operation ID. The authorization helper raises an access error instead of returning a default operation; the HTTP layer translates that error into the appropriate response. A successful response serializes the returned dictionary as JSON with `Cache-Control: no-store`.

```python
# Code fragment - focus on authorized operation negotiation
import hashlib
import json
import os

from azure.identity import DefaultAzureCredential
from azure.messaging.webpubsubservice import WebPubSubServiceClient


def opaque_identity(prefix: str, *parts: str) -> str:
    encoded_parts = json.dumps(
        parts, ensure_ascii=False, separators=(",", ":")
    ).encode("utf-8")
    digest = hashlib.sha256(encoded_parts).hexdigest()
    return f"{prefix}-{digest}"


credential = DefaultAzureCredential()
service_client = WebPubSubServiceClient(
    endpoint=os.environ["WEBPUBSUB_ENDPOINT"],
    hub="incident_updates",
    credential=credential,
)


def negotiate_operation(principal, operation_id: str) -> dict:
    operation = load_authorized_operation(principal, operation_id)
    group = opaque_identity(
        "operation", str(operation.tenant_id), str(operation.id)
    )
    user_id = opaque_identity(
        "user", str(principal.tenant_id), str(principal.user_id)
    )

    access = service_client.get_client_access_token(
        user_id=user_id,
        minutes_to_expire=5,
        roles=[f"webpubsub.joinLeaveGroup.{group}"],
    )
    return {"url": access["url"], "group": group}
```

The five-minute lifetime is illustrative. Reuse the credential and service client within the process, then close them during application shutdown.

Keep service keys and connection strings out of browser bundles. Exclude access URLs, tokens, and credential-bearing query strings from logs and diagnostic captures.

## Connect through a fresh negotiation callback

The service client generates tokens on the backend, while a connection client uses the resulting URL. The next Python fragment illustrates that client-side decision without introducing browser code. In a web application, the provided browser client performs the equivalent operation.

The Python SDK's `WebPubSubClientCredential` accepts a function that supplies a fresh access URL. The application-defined `request_operation_access()` calls the authenticated negotiation endpoint for `operation_id`; HTTP authentication and failures belong to that helper. The fragment validates the response and remembers the authorized group for the later join.

```python
# Code fragment - focus on fresh negotiation for a connection
from azure.messaging.webpubsubclient import (
    WebPubSubClient,
    WebPubSubClientCredential,
)

connection_details = {}


def get_client_access_url() -> str:
    access = request_operation_access(operation_id)
    if (
        not isinstance(access, dict)
        or not isinstance(access.get("url"), str)
        or not access["url"].startswith("wss://")
        or not isinstance(access.get("group"), str)
        or not access["group"]
    ):
        raise ValueError("Invalid negotiation response")

    connection_details["group"] = access["group"]
    return access["url"]


client = WebPubSubClient(
    WebPubSubClientCredential(get_client_access_url)
)
```

Register handlers before `client.open()`. After connection, wait for the group join to succeed before declaring live delivery ready. Close the client when the application no longer needs it.

Denied negotiation requests must surface as authentication or authorization errors rather than retry indefinitely.

Cross-origin deployments need explicit allowed origins and credential behavior, not public negotiation with unrestricted group roles.

## Restore membership without assuming permanent access

Clients can join groups themselves, receive initial membership through the token's `groups` option, or be added by the server. Those alternatives differ in how a new connection reconstructs its memberships. Choose the mechanism with both authorization and recovery in mind.

With explicit client joins, the client SDK can remember groups joined by client code and attempt to rejoin them after a new connection. Those joins can still fail if the new token lacks permission. Membership assigned through server APIs isn't automatically restored by the SDK's client-join tracking. Token-assigned initial membership must be included again when the backend authorizes a new connection.

Token expiration limits use of the access token for new connections. It doesn't immediately revoke an active connection or invalidate an already-issued token. When application access changes, the backend denies future negotiation attempts. For each affected connection, the backend revokes group-join permission with `revoke_permission()` and removes the connection from the group with `remove_connection_from_group()`. Track active connection IDs so the backend can apply the change to every affected tab or device.

A token that already grants a group role can still be used to create another connection until it expires. Applications that require current authorization at each connection handshake need a [connect event handler](/azure/azure-web-pubsub/concept-service-internals#client-authentication). The handler checks current access, then rejects unauthorized handshakes or assigns only currently authorized roles. Otherwise, use short-lived tokens to limit the time that previously issued group permissions remain usable.

Brief reliable-session recovery can reuse session recovery credentials without calling the negotiation endpoint again. Include active sessions in the revocation policy, and don't rely on a new negotiation check to revoke a recovered connection.

::: zone-end

## Additional resources

These resources provide language-specific details for the two credential boundaries in this unit. You can use them to verify the exact APIs and connection lifecycle controls in your selected SDK version.

- [Python service client reference](/python/api/azure-messaging-webpubsubservice/azure.messaging.webpubsubservice.webpubsubserviceclient) documents token generation and connection management methods.
- [Python client credentials](/python/api/azure-messaging-webpubsubclient/azure.messaging.webpubsubclient.webpubsubclientcredential) describes the callback used to obtain a client access URL.
