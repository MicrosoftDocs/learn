
Your solution may contain several front- and back-end services. In this scenario, how does a client know what endpoints to call? What happens when new services are introduced, or existing services are refactored? How do services handle SSL termination, authentication, and other concerns? An *API gateway* can help to address these challenges.

:::image type="content" source="../media/api-gateway.png" alt-text="Diagram of an API gateway.":::

An API gateway sits between clients and services. It acts as a reverse proxy, routing requests from clients to services. It may also perform various cross-cutting tasks such as authentication, SSL termination, and rate limiting. If you don't deploy a gateway, clients must send requests directly to front-end services. However, there are some potential problems with exposing services directly to clients:

* It can result in complex client code. The client must keep track of multiple endpoints, and handle failures in a resilient way.
* It creates coupling between the client and the backend. The client needs to know how the individual services are decomposed. That makes it harder to maintain the client and also harder to refactor services.
* A single operation might require calls to multiple services. That can result in multiple network round trips between the client and the server, adding significant latency.
* Each public-facing service must handle concerns such as authentication, SSL, and client rate limiting.
* Services must expose a client-friendly protocol such as HTTP or WebSocket. This limits the choice of communication protocols.
* Services with public endpoints are a potential attack surface, and must be hardened.

A gateway helps to address these issues by decoupling clients from services. Gateways can perform a number of different functions, and you may not need all of them. The functions can be grouped into the following design patterns:

* **Gateway routing**: Use the gateway as a reverse proxy to route requests to one or more backend services, using layer 7 routing. The gateway provides a single endpoint for clients, and helps to decouple clients from services.

* **Gateway aggregation**: Use the gateway to aggregate multiple individual requests into a single request. This pattern applies when a single operation requires calls to multiple backend services. The client sends one request to the gateway. The gateway dispatches requests to the various backend services, and then aggregates the results and sends them back to the client. This helps to reduce chattiness between the client and the backend.

* **Gateway Offloading**: Use the gateway to offload functionality from individual services to the gateway, particularly cross-cutting concerns. It can be useful to consolidate these functions into one place, rather than making every service responsible for implementing them.

Here are some examples of functionality that could be offloaded to a gateway:

* SSL termination
* Authentication
* IP allow/block list
* Client rate limiting (throttling)
* Logging and monitoring
* Response caching
* GZIP compression
* Servicing static content
