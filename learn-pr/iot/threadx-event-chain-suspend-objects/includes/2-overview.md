Event-chaining is a technique that enables the linking (or chaining) of several objects based on the occurrence of independent events. This is particularly useful in activating a thread that is suspended on two or more resources. Implementing this technique is a three-step process as follows: 

Register one or more notification callback functions (one-time only). 

The registered notification callback function is automatically invoked when an indicated event occurs. Each such function typically contains a `tx_semaphore_put` service call, which communicates to a waiting thread that a particular event has occurred. However, many other service calls could be used. 

A thread suspends on the semaphore mentioned above. Getting this semaphore signifies that the event in question has occurred, and then the thread continues through the system. 

We will first investigate the basics of event-chaining and study a project that uses this concept. The name of this project is ProjectEventChaining. 

The following figure illustrates an event-chaining application:

:::image type="content" alt-text="Diagram that illustrates an event-chaining application." source="../media/event-chaining-application-example.svg" loc-scope="Azure":::

A thread needs to get access to one of three different resources. The thread will wait until any one of the three resources becomes available. Ordinarily, this would be a very difficult problem to solve, but with event-chaining, it is relatively easy, as we will see in this module. 
