
One of the first requests many people have when working in a system that does asynchronous actions is to get notifications or alerts. Why?

Because they don't want to open the application, log in and see if things changed repeatedly.

The ability to receive Alerts and notifications is a powerful mechanism to get notified about certain events in your system when they happen.

For example, when a build takes a while to complete, you probably don't want to stare at the screen until it has finished. But you want to know when it does.

Getting an email or another kind of notification instead is powerful and convenient. Another example is a system that needs to be monitored.

You want to get notified by the system in real time. By implementing a successful alert mechanism, you can use alerts to react to situations proactively before anybody is bothered by them.

## Alerts

However, when you define alerts, you need to be careful. When you get alerts for every single event that happens in the system, your mailbox will quickly be flooded with numerous alerts.

The more alerts you get that aren't relevant, the more significant the change that people will never look at the alerts and notifications and will miss the important ones.

## Target audience and delivery mechanism

When defining alerts or notifications, you need to think about the target audience. Who needs to react to the alerts? Don't send messages to people for information only. They'll stop looking at it quickly.

Another thing to consider when defining alerts is the mechanism to deliver them. Do you want to send an email, or do you like to send a message in Slack for your team? Or do you want to call another system to do a particular action?

Within Azure DevOps, there are multiple ways to define your alerts. By using query and filter mechanisms, you can filter out specific alerts. For example, you only want to get notified for failed releases and not for successful ones.

Almost every action in the system raises an event to which you can subscribe. A subscription is personal or for your whole team. When you have made a subscription, you can select how you want the notification to be delivered.

For more information, see also:

 -  [About notifications](/azure/devops/notifications/index).
 -  [Events, subscriptions, and notifications](/azure/devops/notifications/concepts-events-and-notifications).
