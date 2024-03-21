If we think about it, we can identify many event-driven scenarios. Plenty of them require a reaction in real time.

## What do we mean by real time?

A reaction in real time can be seen as an immediate answer. Let's take an example of a cashier in a coffee shop who asks you what you want to drink.

The cashier expects an instant answer, or at least an answer that's given very soon. Otherwise, the cashier might rephrase the question or suspect that you were rude. A quick answer is requested and also appropriate. The time to answer can vary slightly, but it's still seen as being "in real time." So, returning a greeting should happen quickly, but it's fine to think briefly about your order to answer the cashier's question.

If you translate that scenario to software systems, all you care about are timings: Response Time, Completion Time, Access Time, StartUp Times, and so on. The user or the accessing application defines those timings.

> [!NOTE]
> In real time, systems tasks perform their function within prescribed deadlines.

You should always be aware of what's happening in your system. So make sure you don't forget the obvious, which is the logging, monitoring, and measuring of your timings.

> [!IMPORTANT]
> Make sure you specify the deadlines and timings beforehand and set up a nonblocking monitoring solution for checkup.

In summary, we agree that real time means super-fast, in an instant. How fast exactly is specified by your given scenario.

## Event-driven applications

If you think about a click-event, you think about something else. Event-driven applications use the *fire and forget* principle. The event gets sent or *fired* toward the next system, which can be another service, an event hub, a stream, or a message broker like Kafka. We don't necessarily wait for a response from the next one in the system. *Loose coupling* is achieved for the price of eventual consistency, which needs to be taken care of at another level.

To identify the nature of event-driven applications, let's look at the main architecture patterns by using the example of a customer, named Alex, buying a coffee and a cappuccino.

### Event notification

Event notification is the notification of a specific happening or event. Each event is seen separately. The example of a customer named Alex buying a coffee and a cappuccino might look like this:

*1. Event: Alex buys a coffee.*

*2. Event: Alex buys a cappuccino.*

One barista would have to listen carefully to all events to get Alex's whole order. But two baristas could also prepare and serve the drinks independently.

### Event carried state transfer

With event carried state transfer, all the needed information is stored in a single event. That comes in handy if an event gets lost or your service isn't listening to all the events. For our example, the events would look like this:

*1. Event: Alex buys a coffee.*

*2. Event: Alex buys, in addition to the coffee, a cappuccino.*

With one barista, listening only to the second event might be enough. With two baristas, the second one would have to look at the first one. The order could be served together, but the process might take longer than doing it completely decoupled.

### Event sourcing

With event sourcing, the event storage comes into focus. As you can see, the events are the same as in the first example. But the barista is important for this concept at the moment when the barista receives an event and then thinks about all corresponding events to get the current state for all the orders made by Alex.

With the second order, the barista knows that Alex's order consists of a coffee, by remembering the first order, and a cappuccino, because this drink was just ordered. Working in parallel with a second barista isn't as easily possible.

When we add a cashier to receive the orders and serve the drinks, the baristas can work independently to prepare the drinks. They don't need to know anything about the customers. The cashier is the so-called event store, persisting the events, in that scenario. Event sourcing adds another layer of complexity, but it also adds decoupling.

*1. Event: Alex buys a coffee.*

*Cashier: (First) order (for Alex): Coffee*

*2. Event: Alex buys a cappuccino.*

*Cashier: (Second) order (for Alex): Cappuccino*

![Visualization that shows event sourcing for buying a coffee.](../media/2-event-sourcing.png)

## Telemetry data are real-time events

There are also other examples we can think of. Imagine the scenario of running a refrigeration system, for instance, for food or drug manufacturers. You need constant control of the temperature and other relevant data in your system. Awareness of the telemetry data and controlling it automatically would be critical to your success. Measuring the telemetry every two seconds and then sending it toward the control system where the data gets analyzed, processed, and handled is an event-driven system. Also, the data must be processed in real time because it's critical to react quickly to avoid tragic consequences for the business.
