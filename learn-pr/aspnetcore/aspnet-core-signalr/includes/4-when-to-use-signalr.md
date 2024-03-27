SignalR provides real-time web functionality. Recall that Contoso Pizza requires a live map for tracking the status and delivery of orders. The loss of sales during peak hours is driving the team to investigate a better solution than client-side polling.

## Decision criteria

Knowing when *not* to choose SignalR is as important as knowing when to choose it. With real-time web functionality, the users' experience of an app relies on its responsiveness. It's best to understand which portions of an application require real-time updates.

### When *not* to use SignalR

SignalR is only as durable as its underlying connection. That is, if there's cause for concern with the *connectivity* of a client application, SignalR isn't the best choice.

Another consideration is the scalability of SignalR. Depending on the number of concurrently connected clients, your web server could experience *resource contention* when it reaches its limits. In situations like this, you would likely need to deploy the application to a server farm and use a backplane. Implementing this on your own can be tedious.

Alternatively, you could resolve this problem by using the [Azure SignalR Service](/azure/azure-signalr). Or you could help alleviate it by taking advantage of various [resiliency and disaster recovery](/azure/azure-signalr/signalr-concept-disaster-recovery) mechanisms.

#### Example SignalR modalities

You can use SignalR on-premises, in the cloud, or with Azure SignalR Service.

- On-premises:

  :::image type="content" source="../media/on-prem-signalr.png" lightbox="../media/on-prem-signalr-large.png" alt-text="Diagram of ASP.NET Core SignalR being used on-premises.":::

- In the cloud:

  :::image type="content" source="../media/cloud-signalr.png" lightbox="../media/cloud-signalr-large.png" alt-text="Diagram of ASP.NET Core SignalR being used in the cloud.":::

- With Azure SignalR Service:

  :::image type="content" source="../media/service-signalr.png" lightbox="../media/service-signalr-large.png" alt-text="Diagram of using Azure SignalR Service.":::

### Valid use cases

SignalR isn't a replacement for traditional HTTP requests. Applications could use SignalR to know when to make specific HTTP requests. In this way, they complement each other.

There are many valid use cases for SignalR. The following list represents good candidates for SignalR:

- Apps that require high-frequency updates from the server:
  - Gaming
  - Social networks
  - Voting
  - Auctions
  - GPS apps
- Dashboards and monitoring apps:
  - Company dashboards
  - Live maps
  - Instant sales updates
  - Travel alerts
  - Continuous integration/continuous delivery (CI/CD) pipeline pages
- Collaborative and multi-user interactive apps:
  - Whiteboard apps
  - Team meeting apps
  - Document sharing apps
  - Visual Studio Live Share
- Apps that require instant notifications:
  - Email apps
  - Chat apps
  - Turn-based games
  - Time series reporting
  - GitHub Actions, issue and pull request systems

## Contoso Pizza scenario

If you're considering a client-side polling solution in the Contoso Pizza live orders map, SignalR could be a viable alternative. As with all programming and architectural decisions, it's critically important to weigh SignalR's advantages and disadvantages.
