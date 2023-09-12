
Inspection of the release pipeline and release is something you should consider from the start.

When you run multiple deployments a day, you want to:

 -  Stay informed.
 -  Know whether a release passed or failed.
 -  Know the quality of the release.
 -  Know details about the release and how it has been done.
 -  Stop releases when you detect something suspicious.
 -  Visualize some of these things on a dashboard.<br>

You can do a few things to stay informed about your release pipeline. In the following chapters, we'll dive a bit deeper into these.

## Release gates

Release gates allow the automatic collection of health signals from external services and then promote the release when all the signs are booming simultaneously or stop the deployment on timeout.

Typically, gates are connected with incident management, problem management, change management, monitoring, and external approval systems. Release gates are discussed in an upcoming module.

## Events, subscriptions, and notifications

Events are raised when specific actions occur, like when a release is started or a build is completed.

A notification subscription is associated with a supported event type. The subscription ensures you get notified when a specific event occurs.

Notifications are usually emails that you receive when an event occurs to which you're subscribed.

## Service hooks

Service hooks enable you to do tasks on other services when events happen in your Azure DevOps Services projects.

For example, create a card in Trello when a work item is created or send a push notification to your team's Slack when a build fails.

Service hooks can also be used in custom apps and services as a more efficient way to drive activities when events happen in your projects.

## Reporting

Reporting is the most static approach to inspection but also the most evident in many cases.

Creating a dashboard that shows the status of your build and releases combined with team-specific information is, in many cases, a valuable asset to get insights.

Read more at [About dashboards, charts, reports, & widgets](/azure/devops/report/dashboards/overview).
