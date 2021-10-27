<!--
# When to use ASP.NET Core SignalR

Decision criteria
Parts working together
Apply to scenario

-->

SignalR provides real-time web functionality. Recall that Contoso Pizza requires a live map for tracking the status and delivery of orders. The loss of sales during peak hours was enough to investigate a better solution than client-side polling.

## Decision criteria

Knowing when *not* to choose SignalR is just as important as knowing when to choose it. With real-time web functionality, the user experience of an app relies on the ability to be responsive. It's best to understand which portions of an application require real-time updates.

### When not to use SignalR

SignalR is as durable as the underlying connection. In other words, if there's cause for concern with the **connectivity** of a client application &mdash; SignalR is *not* the best choice.

Another consideration is the scalability of SignalR. Depending on the number of concurrently connected clients, your web server could experience contention when reaching its limits. In situations like this, you'd likely need to deploy the application to a server farm and use a backplane. Implementing this on your own can be tedious. Alternatively, you could leverage the [**Azure SignalR Service**](/azure/azure-signalr). In addition to having solved most of the networking challenges you might face when trying to implement this yourself, there are various [resiliency and disaster recovery](/azure/azure-signalr/signalr-concept-disaster-recovery) mechanisms in place to help alleviate problems.

#### Example SignalR modalities

SignalR can be used on-premises, in the cloud, or with Azure SignalR Service.

##### On-premises

:::image type="content" source="../media/on-prem-signalr.png" lightbox="../media/on-prem-signalr.svg" alt-text="ASP.NET Core SignalR On-prem":::

##### Cloud

:::image type="content" source="../media/cloud-signalr.png" lightbox="../media/cloud-signalr.svg" alt-text="ASP.NET Core SignalR Cloud":::

##### Azure SignalR Service

:::image type="content" source="../media/service-signalr.png" lightbox="../media/service-signalr.svg" alt-text="Azure SignalR Service":::

### Valid use cases

SignalR is not a replacement for traditional HTTP requests. Applications could leverage SignalR to know when to make specific HTTP requests, in this way they complement each other. There are many valid use cases for SignalR.

The following list represents good candidates for SignalR:

- *Apps that require high-frequency updates from the server:*
  - Gaming
  - Social networks
  - Voting
  - Auction
  - GPS apps
- *Dashboards and monitoring apps:*
  - Company dashboards
  - Live maps
  - Instant sales updates
  - Travel alerts
  - CI/CD pipeline pages
- *Collaborative and multi-user interactive apps:*
  - Whiteboard apps
  - Team meeting apps
  - Document sharing apps
  - Live Share
- *Apps that require notifications:*
  - Email apps
  - Chat apps
  - Turn-based games
  - Time series reporting
  - GitHub Actions, issue and pull request systems

## Contoso Pizza scenario

Considering the client-side polling solution in the Contoso Pizza live orders map, SignalR could be a viable alternative approach. As with all programming and architectural decisions, it's your responsibility to weigh the advantages and disadvantages.
