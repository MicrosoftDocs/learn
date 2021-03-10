If we think about it, we can identify many event-driven scenarios. Plenty of them require a reaction in real time.

## What do we mean by real time?

A reaction in real time can be seen as an immediate answer - not only in the offline but also in the online world. If a cashier asks me what I want to drink, an instant answer is expected or at least an answer very soon. Otherwise, the cashier might rephrase the question or suspect I'd be rude. A quick answer isn't only requested but also appropriate. The time to answer varies a bit but can still be seen as "in real time". So returning a greeting should happen quickly whereas it's fine to think shortly about your order, to answer the cashiers question at a coffee shop.

If you translate that to software systems, all you care about are timings: Response Time, Completion Time, Access Time, StartUp Times, and so on. Those ones are defined by the user or the accessing application.

> [!NOTE]
> In real time systems tasks perform their function within prescribed deadlines.

Not to forget, you should always be aware what is happening in your system. So make sure you don't forget the obvious, which is logging, monitoring and the measuring of your timings.

> [!IMPORTANT]
> Make sure you specify the deadlines and timings beforehand and set up a non-blocking monitoring solution for checkup.

In summary, we agree that real time means super fast, in an instant. How fast exactly is specified by your given scenario.

## Event-driven applications

If you think about a Click-event, you think about something else. Event-driven applications use the _fire and forget_ principle. So the event gets send or _fired_ towards the next system, which can be another service, an event hub, stream, or a message broker like Kafka. We don't wait necessarily for a response of the next one in the system. _Loose coupling_ is achieved for the price of eventual consistency, which needs to be taken care of at another level.

To identify the nature of event-driven applications, let's have a look at its main architecture patterns by the example of a customer, named Alex, buying a coffee and a cappuccino.

### Event Notification

Event Notification is as the name says simply the notification of a specific happening or event. Each event is seen separately. The example of a customer, named Alex, buying a coffee and a cappuccino can look like this:

_1. Event: Alex buys a coffee._

_2. Event Alex buys a cappuccino._

One Barista would have to listen carefully to all events to get the whole order of Alex. But two Baristas could also prepare and serve the beverages independently.

### Event Carried State Transfer

With Event Carried State Transfer, all the needed information is stored in the single event. That comes handy, if an event got lost or your service is not listening to all the events. For our example, the events would look like this:

_1. Event: Alex buys a coffee._

_2. Event Alex buys, additionally to the coffee, a cappuccino._

For one Barista listening only to the second event, could already be enough. For two Baristas, the second one would have look at the first one, which would allow to serve the order together but might lead into a longer process than doing it completely decoupled.

### Event Sourcing

With Event Souring, the event storage comes into focus. As you can see, the events are the same as in the first example. But the Barista is important for this concept. In the moment, when the Barista receives an event, and then thinks about all corresponding events, to get the current state. So for us, all the orders "Alex" has made. Getting the second order, the Barista would know, that Alex' order consists of a coffee, from remembering the first order, and a cappuccino, as this one just got ordered. Working in parallel with a second Barista isn't as easily possible. But when we add a cashier to receive the orders and serve the beverages, we can let all Baristas work independently preparing the drinks without having to know anything about the customers. The cashier is the so called Event Store, persisting the events, in that scenario. In summary, Event Sourcing adds another layer of complexity but also decoupling.

_1. Event: Alex buys a coffee._

_Cashier: (First) order (for Alex): Coffee_

_2. Event Alex buys a cappuccino._

_Cashier: (Second) order (for Alex): Cappuccino_

![Event Sourcing for buying a coffee](../media/2-event-sourcing.png)

## Telemetry Data are real-time events

But there are also other examples we can think of.
Imagine running a refrigeration system, for instance for food or drug manufactures. You'd need at any time to control the temperature and other relevant data in your system. Being aware of the telemetry data and controlling them automatically is critical to your success. Measuring the telemetry every two seconds and then send it towards the control system where the data gets analyzed, processed, and handled should be seen as an event-driven system. Also, the data should be processed in real time as it is critical to react as soon as possible to avoid tragic consequences for the business.
