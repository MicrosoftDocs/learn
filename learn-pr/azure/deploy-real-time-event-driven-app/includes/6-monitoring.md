Monitoring is important. Depending on your architecture, it can be a little tricky. It might be even more challenging but also important for distributed systems.

## Monitor real-time applications

We learned that in real-time systems, tasks fulfill their function within prescribed time frames. Let's go through a list of five steps to monitor a typical real-time application stack:

1. Define every individual task of the system.
1. Estimate the time frame for completion for each task.
1. Monitor and check the performance for each task, its dependencies, and the overall system regularity.
1. Have alerts specified, and strategies set up, if a task misses its time frame.
1. Try to automate!

> [!IMPORTANT]
> Make sure to define the individual tasks as decoupled from other tasks. A failure of one task shouldn't cause the failure of others.

> [!NOTE]
> A reliable system is key. Automation will help your system to become more reliable.

## Monitor event-driven application stacks

Most event-driven architectures use _fire and forget_. With fire and forget, the originator sends a message and doesn't expect any response from the recipient. The originator is the producer in our scenario and sends an event toward the next service. The next service can be another function, a message broker, or an event hub or stream. This service must not be the recipient of the message. Like in the given scenario, the consuming function that receives the message from the event hub is the recipient of the message.

If your event-driven application stack is a distributed system, don't forget to monitor each piece of the infrastructure and the whole system properly.
