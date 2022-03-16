## Introduction

In some circumstances, a thread may be forced to wait an unacceptably long time (even forever!) for some resource. The wait abort suspension service assists the developer in preventing such an unwanted situation. This service aborts sleep or any wait-related suspension for a specified thread.

We'll investigate the concepts of the wait abort service, a counting semaphore, and a monitor thread, and then take a look at a project in the code editor.

If the wait is successfully aborted, a `TX_WAIT_ABORTED` value is returned from the service that the thread was waiting on. However, this service doesn't release suspension that's caused by the `tx_thread_suspend` service.

Here's an example that illustrates how this service can be used:

```c
status = tx_thread_wait_abort(&some_thread);
```

If the variable status contains the value `TX_SUCCESS` after this service has been executed, the sleep or suspension condition of thread *some_thread* has been aborted, and a return value of `TX_WAIT_ABORTED` becomes the value of status for the suspended thread. The previously suspended thread is then free to take whatever action it deems appropriate.

We'll investigate how to detect unacceptable delays and how to break the suspension of stalled threads. The name of this project is ProjectBreakSuspension.