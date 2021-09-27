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

SignalR is as durable as the underlying connection. In other words, if there's cause for concern with the connectivity of a client application &mdash; SignalR is *not* the best choice.

Another consideration is the scalability of SignalR. Depending on the number of concurrent connected clients, your web server could experience contention when reaching its limits. In situations like this, you'd likely need to deploy the application to a server farm and use a backplane. Implementing this on your own can be tedious. Alternatively, you could leverage the [**Azure SignalR Service**](https://docs.microsoft.com/azure/azure-signalr). In addition to having solved most of the networking challenges you might face when trying to implement this yourself, there are various [resiliency and disaster recovery](https://docs.microsoft.com/azure/azure-signalr/signalr-concept-disaster-recovery) mechanisms in place to help alleviate problems.

### Valid use cases

SignalR is not a replacement for traditional HTTP requests. Applications could leverage SignalR to know when to make specific HTTP requests, in this way they compliment each other. There are many valid use cases for SignalR.

Good candidates for SignalR:

- Apps that require high frequency updates from the server. Examples are gaming, social networks, voting, auction, maps, and GPS apps.
- Dashboards and monitoring apps. Examples include company dashboards, live maps, instant sales updates, or travel alerts.
- Collaborative apps. Whiteboard apps and team meeting software are examples of collaborative apps.
Apps that require notifications. Social networks, email, chat, games, travel alerts, and many other apps use notifications.

## Parts working together



## Apply to scenario

