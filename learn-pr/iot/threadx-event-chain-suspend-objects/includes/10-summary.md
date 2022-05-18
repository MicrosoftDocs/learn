## Key points

Event-chaining is a technique that enables the linking of several objects based on the occurrence of independent events. This technique is useful in activating a thread that is suspended on two or more resources. Implementing this technique is a three-step process:

1. Register one or more notification callback functions.
1. The registered notification callback function is automatically invoked when an indicated event occurs. Each such function typically contains a tx_semaphore_put service call, which communicates to a waiting thread that a particular event has occurred. However, many other service calls could be used.
1. A thread suspends on the semaphore mentioned above. Getting this semaphore signifies that the event in question has occurred and then the thread continues through the system.

In general, event-chaining results in fewer threads, less overhead, and smaller RAM requirements. It also provides a highly flexible mechanism to handle synchronization requirements of more complex systems.
