Monitoring is important. Depending on your architecture, it can be even a bit tricky. It might be even more challenging but also important for distributed systems.

## Monitor real-time applications

We learned that in real-time systems tasks fulfill their function within prescribed deadlines. So let's

1. Define every individual task of the system.
2. Predefine the deadlines for each functionality of our application.
3. Monitor and check the deadlines regularly.
4. Have alarms specified and strategies set up if the tasks miss the deadlines.
5. Try to automate!

> [!IMPORTANT]
> Make sure to define the individual tasks as modular as possible.

> [!NOTE]
> It's important to have a reliable system at any time. Automation is key to not be dependant on someones sleeping or holiday's schedule.

## Monitor event-driven application stacks

Most event-driven architectures operate with _Fire and Forget_. Given a specific situation such as high traffic, or another event, or something scheduled. The task will be processed, and the event will be sent towards the next service. The next instance can be another function in our application, a message broker, or an event hub or stream.

If your event-driven application stack is a distributed system, don't forget to monitor each of infrastructure peace and the whole system properly.
