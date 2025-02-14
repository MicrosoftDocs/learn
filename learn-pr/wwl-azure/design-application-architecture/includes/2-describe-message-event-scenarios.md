Your first decision in your application architecture design is to plan how the application components communicate. Defining your component strategy helps you choose the appropriate Azure service.

Suppose you're designing the architecture for a home improvement video-sharing application for Tailwind Traders. You want your application to be as reliable and scalable as possible. You're planning to use Azure technologies to build a robust communication infrastructure. Before you can choose the appropriate Azure services, you need to design how each application component communicates with the other components. For each type of communication, you might choose a different Azure technology.

### Things to know about messages and events

Most application components communicate by sending messages or events. Azure offers various services to support the different communication strategies.

#### Messages

Let's examine the characteristics of [messages](/azure/event-grid/compare-messaging-services#message).

- Messages contain raw data produced by one component and consumed by another component.

- A message contains the data itself, not just a reference to that data.

In a message communication, the sending component expects the destination to process the data in a certain way. The integrity of the overall system might depend on both the sender and receiver doing a specific job.

Suppose a user uploads a new video by using your mobile video-sharing app. Your mobile app must send the video to the web API that runs in Azure. The video file must be sent, not just an alert that indicates there's a new video. The mobile app expects that the web API stores the new video in the database and makes the video available to other users.

#### Events

Now let's take a closer look at [events](/azure/event-grid/compare-messaging-services#event).

- Events are lighter weight than messages and are most often used for broadcast communications.

- An event has two components, a _publisher_ and _subscribers_. The event publisher sends the event. The event subscribers receive events.

With events, receiving components generally decide the communications in which they're interested and then subscribe to those events. An intermediary manages the subscription process. The intermediary uses services like Azure Event Grid or Azure Event Hubs. When publishers send an event, the intermediary routes that event to any interested parties. This pattern is known as a _publish-subscribe_ architecture and is the most used. 

Events have the following characteristics:

- An event is a lightweight notification that indicates something occurred.

- An event can be sent to multiple receivers or to none.

- An event publisher has no expectations about actions by a receiving component.

- An event is often intended to "fan out" or have many subscribers for each publisher.

- An event is a discrete unit that's unrelated to other events, but an event might be part of a related and ordered series.

### Things to consider when choosing messages or events

Review the following scenarios regarding when to choose message or event communication for your application architecture for Tailwind Traders.

- **Consider messages and events**. It's not uncommon for an application to implement both events and messages. An app can use events for some components and functions and messages for other components. Choose each Azure service to meet the specific needs of each component of your app.

- **Consider sender expectations**. If the sending component in your application expects the destination to process the component in a specific way, consider implementing messages. If the sender component in your application has no requirements for the destination component, you might implement events rather than messages.

- **Consider guaranteed communication**. If you're building a distributed application and want to guarantee all communication is processed, consider using messages. In a message communication, there's an expectation that both the message sender and receiver complete their tasks.

- **Consider ephemeral communication**. Ephemeral means the communication is dropped if there are no subscribing receivers. If your application doesn't require subscribers or actions from any receiver, consider using events. 