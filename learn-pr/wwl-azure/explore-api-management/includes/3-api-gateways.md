
Your solution may contain several front- and back-end services. In this scenario, how does a client know what endpoints to call? What happens when new services are introduced, or existing services are refactored? How do services handle SSL termination, authentication, and other concerns? 

The API Management gateway (also called data plane or runtime) is the service component that's responsible for proxying API requests, applying policies, and collecting telemetry.

An API gateway sits between clients and services. It acts as a reverse proxy, routing requests from clients to services. It may also perform various cross-cutting tasks such as authentication, SSL termination, and rate limiting. If you don't deploy a gateway, clients must send requests directly to back-end services. However, there are some potential problems with exposing services directly to clients:

* It can result in complex client code. The client must keep track of multiple endpoints, and handle failures in a resilient way.
* It creates coupling between the client and the backend. The client needs to know how the individual services are decomposed. That makes it harder to maintain the client and also harder to refactor services.
* A single operation might require calls to multiple services. 
* Each public-facing service must handle concerns such as authentication, SSL, and client rate limiting.
* Services must expose a client-friendly protocol such as HTTP or WebSocket. This limits the choice of communication protocols.
* Services with public endpoints are a potential attack surface, and must be hardened.

A gateway helps to address these issues by decoupling clients from services.

## Managed and self-hosted

API Management offers both managed and self-hosted gateways:

* **Managed** - The managed gateway is the default gateway component that is deployed in Azure for every API Management instance in every service tier. With the managed gateway, all API traffic flows through Azure regardless of where backends implementing the APIs are hosted.

* **Self-hosted** - The self-hosted gateway is an optional, containerized version of the default managed gateway. It's useful for hybrid and multicloud scenarios where there's a requirement to run the gateways off of Azure in the same environments where API backends are hosted. The self-hosted gateway enables customers with hybrid IT infrastructure to manage APIs hosted on-premises and across clouds from a single API Management service in Azure.