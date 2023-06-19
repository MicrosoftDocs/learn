## Introduction

The following diagram illustrates the typical activities of a message queue.

:::image type="content" source="../media/message-queue-example.svg" alt-text="Illustration of the activities of a message queue." border="false":::

Message queues generally operate using a first-in, first-out (FIFO) protocol. However, a front-send feature for urgent messages can alter this protocol. As illustrated in the following diagram.

:::image type="content" source="../media/front-send-feature-example.svg" alt-text="Illustration of the front-send feature." border="false":::

The front-send feature should be used sparingly, and only for important messages that need to be processed quickly.

Each message queue is a public resource. ThreadX places no constraints on how message queues are used.

Applications can create message queues either during initialization or during runtime. There's no limit to the number of message queues an application may use.

Message queues can be created to support various message sizes. The available message sizes are 1, 2, 4, 8, and 16 32-bit words. The message size is specified when the queue is created. If your application messages exceed 16 words, you must send your messages by pointer. To send messages by pointer, create a queue with a message size of one word (enough to hold a pointer), and then send and receive message pointers instead of the entire message.

The number of messages a queue can hold depends on its message size and the size of the memory area supplied during creation. To calculate the total message capacity of the queue, divide the number of bytes in each message into the total number of bytes in the supplied memory area.

For example, A message queue with a 100-byte available memory area that supports a message size of one 32-bit word (4 bytes), has a capacity of 25 messages.

The memory area for buffering messages is specified during queue creation. It can be located anywhere in the target’s address space. This feature is important because it gives the application considerable flexibility. For example, an application might locate the memory area of an important queue in high-speed RAM to improve performance.

Application threads can suspend while attempting to send or receive a message from a queue. Typically, thread suspension involves waiting either for a message from an empty queue, or trying to send a message to a full queue.

After the condition for suspension is resolved, the request completes and the waiting thread is resumed. If multiple threads are suspended on the same queue, they're resumed in the order they occur on the suspended list (usually FIFO). However, an application can cause a higher-priority thread to resume first by calling the `tx_queue_prioritize` service prior to the queue service that lifts thread suspension. The `tx_queue_prioritize` service places the highest-priority thread at the front of the suspension list, while leaving all other suspended threads in the same FIFO order.

Queue suspensions can also time out. Essentially, a time-out specifies the maximum number of timer-ticks that the thread stays suspended. If a time-out occurs, the thread resumes and the service returns with the appropriate error code.

The following diagram shows the attributes of a message queue:

:::image type="content" source="../media/figure-3-message-queue-attributes-diagram.png" alt-text="List of the attributes of a message queue." border="false":::

The following code example shows how to create a message queue with the total size of 2000 bytes. The queue starts at address 0x300000 and each message in the queue is four 32-bit words long.

```c
TX_QUEUE my_queue
UINT status;

/* Create a message queue whose total size is 2000 bytes starting at address 0x300000. Each message in this queue is defined to be four 32-bit words long. */
:
:
status = tx_queue_create(&my_queue, "my_queue", TX_4_ULONG, (VOID *) 0x300000, 2000):

/* If status equals TX_SUCCESS, my_queue contains space for storing 125 messages: (2000 bytes / 16 bytes per message). */
```

The `tx_queue_send` service sends a message to the specified message queue. This service copies the message to be sent to the rear of the queue from the memory area specified by the source pointer. The following code shows how this service could be used to send a message to a queue.

```c
TX_QUEUE my_queue
UINT status;
ULONG my_messages[4];
:
:
/* Send a message to "my_queue." Return immediately, regardless of success. The NO_WAIT option must be used for calls from initialization, timers, and ISRs. */

status = tx_queue_send(&my_queue, my_message, TX_NO_WAIT);

/* If status equals TX_SUCCESS, the message has been sent to the queue. */
```

The `tx_queue_receive` service retrieves a message from a message queue. This service copies the retrieved message from the front of the queue into the memory area specified by the destination pointer. That message is then removed from the queue. The specified destination memory area must be large enough to hold the message, that is, the destination pointed to by `destination_ptr` must be at least as large as this queue’s defined message size. Otherwise, memory corruption occurs in the memory area following the destination. The following code shows how this service can be used to receive a message from a queue.

```c
TX_QUEUE my_queue
UINT status;
ULONG my_messages[4];
:
:

/* Retrieve a message from "my_queue." If the queue is empty, suspend until a message is present. Note that this suspension is only possible from application threads. */

status = tx_queue_receive(&my_queue, my_message, TX_WAIT_FOREVER);

/* If status equals TX_SUCCESS, the message was received and is located in the parameter my_message. */
```

Each ThreadX resource has three services that enable you to retrieve vital information about that resource, and that's also true for message queues. The first such service for message queues—`tx_queue_info_get`, retrieves a subset of information from the Message Queue Control Block. This information provides a "snapshot" at a particular instant in time, that is, when the service is invoked. The other two services provide summary information that's based on the gathering of run-time performance data.

One service—`tx_queue_performance_info_get`, provides an information summary for a particular queue up to the time the service is invoked. By contrast, the `tx_queue_performance_system_info_get` service retrieves an information summary for all message queues in the system up to the time the service is invoked. These services are useful in analyzing the behavior of the system and determining whether there are potential problem areas.

The `tx_queue_info_get` service retrieves several useful items of information about a message queue, including:

- The name of the message queue.
- The number of messages currently in the queue.
- The queue’s total available storage (in bytes).
- The number of threads suspended for this queue.
- A pointer to the first suspended thread.
- A pointer to the next created message queue.

Two of the most commonly used items are `enqueued` (the number of messages in the queue) and `available_storage` (the number of messages that could be stored in the queue).

> [!NOTE]
> TX_NULL can be used in place of parameters that are not needed.

The following code shows how `tx_queue_info_get` can be used.

```c
TX_QUEUE my_queue;
CHAR *queue_name;
ULONG enqueued;
TX_THREAD *first_suspended;
ULONG suspended_count;
ULONG available_storage;
TX_QUEUE *next_queue;
UINT status;
:
:

/* Retrieve information about the previously created message queue my_queue. */

status = tx_queue_info_get(&my_queue, &queue_name, &enqueued, &available_storage, &first_suspended, &suspended_count, &next_queue);

/* If status equals TX_SUCCESS, the information requested is valid. */
```

Threads suspended on a message queue are stored in a suspension list in FIFO order based on when the thread was suspended. The priority of the thread doesn't matter after it's placed in the suspension list. However, ThreadX provides a method that allows you to make certain that the highest priority thread in the suspension list can either read a message or send a message. The following diagram describes this action:

:::image type="content" source="../media/prioritize-for-message-queue.svg" alt-text="Illustration of using prioritize for a message queue." border="false":::

In the previous diagram, there's a thread with priority 5 that is fourth from the front of the suspension list. There's also a thread with priority 30 that is at the front of the suspension list. If the `Prioritize` service wasn't used, then the thread with priority 30 would be the first thread to resume. However, if we use the `Prioritize` service, the thread with Priority 5 is inserted at the front of the suspension list and becomes the first thread to resume.

All the ThreadX resources except `Event Flags Groups` have the `Prioritize` service, but in all the other cases, there's only one action that can happen when the suspended thread resumes. However, there are two possible actions that can happen with a message queue:

- A thread can send a message to a queue.
- A thread can receive a message from a queue. 

This table contains a description of those two actions.

|Status of queue |Effect of prioritization|
|---|---|
|Queue is empty  |The highest priority thread suspended for this queue will receive the next message placed on the queue. |
|Queue is full   |The highest priority thread suspended for this queue will send the next message to this queue when space becomes available. |
