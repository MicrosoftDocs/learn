Monitoring is important. Depending on your architecture, it can be even a bit tricky. It might be even more challenging but also important for distributed systems.

## Monitor real-time applications

We learned that in real-time systems, tasks fulfill their function within prescribed time frames. So let's go through a list of five steps to monitor a typical real-time application stack:

1. Define each and every individual task of the system.
2. For each task, estimate its time-frame for completion.
3. Monitor and check the performance for each task, its dependencies, and the overall system regularlity.
4. Have alerts specified, and strategies set up, if a task misses its time frame.
5. Try to automate!

> [!IMPORTANT]
> Make sure to define the individual tasks as decoupled to other tasks as possible.
A failure of one task should not cause the failure of others.

> [!NOTE]
> A reliable system is key. Automation will help your system to become more reliable.

## Monitor event-driven application stacks

Most event-driven architectures use _Fire and Forget_. With Fire-and-Forget the originator sends a message, and does not expect any response from the recipient. The originator is the producer in our scenario which sends an event towards the next service. The next service can be another function in our application, a message broker, or an event hub or stream.

If your event-driven application stack is a distributed system, don't forget to monitor each of infrastructure peace and the whole system properly.
