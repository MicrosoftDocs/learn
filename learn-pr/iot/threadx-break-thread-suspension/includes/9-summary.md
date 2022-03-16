Introduction

We discussed several important terms and concepts in this module, as they're related to ThreadX.

Following are brief definitions of some key points.

- **wait abort**: ThreadX service that aborts sleep or any other object suspension of the specified thread. If the wait is aborted, a `TX_WAIT_ABORTED` value is returned.
- **rand()**: C library function that returns a pseudo-random number in the range of 0 to `RAND_MAX`.
- **sleep**: ThreadX service that causes the calling thread to suspend for a specified number of timer ticks.## 
- **counting semaphore**: ThreadX resource that can be used for event notification and mutual exclusion. There are two operations for counting semaphores. One operation is the get, which is sometimes called getting an instance from a semaphore. The other operation is the put, which is sometimes called putting an instance on a semaphore.