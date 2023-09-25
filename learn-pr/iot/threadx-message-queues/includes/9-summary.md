## Overview

Message queues provide a powerful tool for inter-thread communication. Message queues don't support a concept of ownership, nor is there a limit to how many threads can access a queue. Any thread can send a message to a queue and any thread can receive a message from a queue.

If a thread attempts to send a message to a full queue, its behavior depends on the specified wait option. These options cause the thread to either abort the message transmission or to suspend. The suspension is either indefinitely or for a specific number of timer ticks, until adequate space is available in the queue.

Similarly, if a thread attempts to receive a message from an empty queue, it behaves according to the specified wait option.
Normally, messages on a queue behave in a FIFO manner, that is, the first messages sent to the rear of the queue are the first to be removed from the front. However, there's a service that permits a message to be sent to the front of the queue, rather than to the rear of the queue.

A message queue is one type of public resource, meaning that it's accessible by any thread. There are four such public resources, and each has features that are useful for certain applications. The following table contains a comparison of the uses of message queues, mutexes, counting semaphores, and event flags groups. As this comparison suggests, the message queue is ideally suited for inter-thread communication.

|Resource |Thread synchronization |Event notification |Mutual exclusion  | Inter-thread communication   |
|---|---|---|---|---|
|Mutex |  |  |*Preferred* |  |
|Counting semaphore | OK for one event |*Preferred* |OK |  |
|Event flags group | *Preferred* |OK |  |  |
|Message queue |OK |OK |  |*Preferred* |

The mutex is ideally suited for mutual exclusion, and it's limited to that function only. The counting semaphore is best suited for event notification, but has other uses as well. The event flags group is best employed for thread synchronization, and the message queue is the clear choice for inter-thread communication.
