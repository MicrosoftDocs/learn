The key to using event-chaining is registering the notification callback function(s). There are several possible notification registrations as follows: 

- tx_queue_send_notify (&my_queue, my_queue_notify); (registers the my_queue_send_notify notification function) 
- tx_event_flags_set_notify (&my_group, my_event_flags_set_notify); (registers the my_event_flags_set_notify notification function) 
- tx_semaphore_put_notify (&my_semaphore, my_semaphore_put_notify); (registers the my_semaphore_put_notify notification function) 
- tx_thread_entry_exit_notify (&my_thread, my_entry_exit_notify); (registers the my_entry_exit_notify notification function) 
- tx_thread_stack_error_notify (my_stack_error_handler); (registers the my_stack_error_handler notification function; note that TX_ENABLE_STACK_CHECKING must be defined) 

We will limit our discussion to the queue send notification. When we register a queue send notification, ThreadX monitors that queue, and when a message arrives, it invokes the notification entry function specified in the registration. Consider the following queue send registration where my_queue has been defined, and my_queue_notify is the name of a notification entry function that we have already written. 

```
tx_queue_send_notify (&my_queue, my_queue_notify);`
```

This queue send notification appears in application define and causes ThreadX to monitor messages being sent to my_queue. Whenever a message is sent to my_queue, ThreadX automatically invokes the my_queue_notify function, which typically contains one semaphore put service call, which in turn causes the resumption of the thread that was suspended on that semaphore. For example, suppose that a thread is suspended on semaphore Gatekeeper, and following is a typical semaphore put service call that would be placed in the my_queue_notify notification entry function. 

```
tx_semaphore_put (&Gatekeeper);`
```

Thus, when a message is sent to my_queue, an instance is placed on the semaphore Gatekeeper, and the thread suspended on it is resumed. 

Following is a three-step illustration for an application where a thread needs to get a message from any one of three queues. The thread suspends on counting semaphore Gatekeeper, waiting for a message. If the count of Gatekeeper is zero, this means that there are no messages on any of the three queues. Each time an instance is placed on Gatekeeper, the count increases. Consequently, the count in Gatekeeper is exactly the number of messages that are on all three queues combined. 

The following figure illustrates that the thread is waiting for a message for any of the now-empty queues:

:::image type="content" alt-text="Diagram that illustrates the thread waiting for a message for any of the queues." source="../media/thread-waits-for-message.png" loc-scope="Azure":::

The next figure illustrates that a message has arrived on a queue, and because of the notification entry function, an instance is placed on the counting semaphore, so the semaphore count is now one (1). 

:::image type="content" alt-text="Diagram that illustrates that a message arrived and is placed on the counting semaphore." source="../media/message-arrives.png" loc-scope="Azure":::

The following figure illustrates that the thread has read the message from the queue, so the queues are empty, the count of the semaphore is zero, the thread has processed the message, and the thread is again suspended waiting for another message. 

:::image type="content" alt-text="Diagram that illustrates that the thread reads the message from the queue." source="../media/thread-reads-message.png" loc-scope="Azure":::
