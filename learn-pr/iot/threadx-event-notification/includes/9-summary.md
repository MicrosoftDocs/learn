## Introduction

We discussed several important terms and concepts in this module, as they're related to ThreadX. Here are some brief definitions of the key points.

### Producer-consumer problem

A classic multi-thread synchronization problem that is also known as the *bounded-buffer* problem.

### Counting semaphore

A ThreadX resource that contains a non-negative integer with two operations. The `put` operation increments the semaphore, and the `get` operation decrements the semaphore only if the semaphore count is greater than one. The semaphore count can never be less than zero. The counting semaphore is most often used for event notification.

### Binary semaphore

A counting semaphore that is initialized to zero, and the semaphore count must never exceed one. A binary semaphore is sometimes used to provide mutual exclusion.

### Sleep

A ThreadX service that self-suspends for a specified number of timer ticks.

### Mutex

A ThreadX resource used only for mutual exclusion. The `get` operation attempts to own the mutex if a different thread doesn't own it already. The `put` operation gives up ownership of the mutex.
