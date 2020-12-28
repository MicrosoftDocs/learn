If we think about it, we can identify many event-driven scenarios. Plenty of them require a reaction in real time.

## What do we mean by real time?

A reaction in real time can be seen as an immediate answer - not only in the offline but also in the online world. If a server asks me what I want to drink, an instant answer is expected or at least an answer very soon. Otherwise, the server might rephrase the question or suspect I'd be rude. A quick answer isn't only requested but also appropriate. The time to answer varies a bit but can still be seen as "in real time". So returning a greeting should happen quickly whereas it's fine to think shortly about your order, to answer the servers question at a coffee shop.

If you translate that to software systems, all you care about are timings: Response Time, Completion Time, Access Time, StartUp Times, and so on. Those ones are defined by the user or the accessing application.

> [!NOTE]
> In real time systems tasks perform their function within prescribed deadlines.

Not to forget, you should always be aware what is happening in your system. So make sure you don't forget the obvious, which is logging, monitoring and the measuring of your timings.

> [!IMPORTANT]
> Make sure you specify the deadlines and timings beforehand and set up a non-blocking monitoring solution for checkup.

In summary, we agree that real time means super fast, in an instant. How fast exactly is specified by your given scenario.

## Event-driven applications

If you think about a Click-event, you think about something else. Event-driven applications use the _fire and forget_ principle. So the event gets send or _fired_ towards the next system which can be a event hub, stream or a message broker like Kafka. To identify the nature of event-driven applications, let's have a look at its main architecture patterns.

### Event Notification

### Event Carried State Transfer

### Event Sourcing

### CQRS
