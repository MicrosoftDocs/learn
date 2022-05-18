Imagine you’re designing the architecture for a distributed music-sharing application. You want to ensure that the application is as reliable and scalable as possible. You want to use Azure technologies to build a robust communication infrastructure.

But before you can choose the Azure technology, you must understand how each individual component communicates with the other components of the application. For each communication, you can choose a different Azure technology.

## Select messages or events for your application

The first thing you must understand is whether an app sends messages or events. Knowing the difference helps you choose the appropriate Azure service.

## What is a message?

[Messages](/azure/event-grid/compare-messaging-services#message) have the following characteristics. 

- Contains raw data, produced by one component, that will be consumed by another component.

- Contains the data itself, not just a reference to that data.

The sending component expects the message content to be processed in a certain way by the destination component. The integrity of the overall system may depend on both sender and receiver doing a specific job.

**Example of a message**

Let’s suppose a user uploads a new song by using your mobile music-sharing app. The mobile app must send that song to the web API that runs in Azure. The song file must be sent, not just an alert that indicates that a new song has been added. The mobile app expects that the web API stores the new song in the database and makes it available to other users.

## What is an event?

[Events](/azure/event-grid/compare-messaging-services#event) are lighter weight than messages and are most often used for broadcast communications. There are two components involved with events:

- Publishers, which send the event. 

- Subscribers, which receive events.

With events, receiving components generally decide in which communications they’re interested and subscribe to those events. The subscription is managed by an intermediary. The intermediary can be provided by services such as Azure Event Grid or Azure Event Hubs. When publishers send an event, the intermediary routes that event to interested. This pattern is known as a publish-subscribe architecture and is the most used. 

Events have the following characteristics:

- Is a lightweight notification that indicates something occurred?

- May be sent to multiple receivers or to none.

- Is often intended to "fan out" or have many subscribers for each publisher.

- Publisher has no expectation about the action a receiving component takes.

- Is a discrete unit and unrelated to other events?

- Might be part of a related and ordered series.

## When should you choose messages or events?

A single application is likely to use events for some purposes and messages for others. The following table describes when to use which:

| **Event or message**| **When to use** |
| - | - |
| Event| More likely to be used for broadcasts and are often ephemeral. Ephemeral means the communication might not be handled by any receiver if none is currently subscribing. |
| Message| More likely to be used where the distributed application requires a guarantee that the communication will be processed. |


For each communication, consider the following question: Does the sending component expect the communication to be processed in a particular way by the destination component?

- If yes, choose to use a message. 

- If no, you might be able to use events.