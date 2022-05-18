## Introduction

One of the first considerations is deciding how to read a message from a queue. When a thread gets an instance of the Gateway semaphore, it means that there's a message on one of the two queues. One way to get messages is to perform a queue read operation on Queue_1 as follows:

```c
status = tx_queue_receive(&Queue_1, receive_message_1, TX_NO_WAIT); 
```

If the value of status is equal to `TX_SUCCESS`, we have successfully read a message from Queue_1. If the value of status isn't equal to `TX_SUCCESS`, the message must be on Queue_2. The wait option must be `TX_NO_WAIT` for this to be true.
