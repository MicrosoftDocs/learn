## Introduction

One of the first considerations is deciding how large the queues should be.

We've decided to allow up to 100 messages for each queue. The next decision is how large each message should be. Recall that the allowable message sizes are 1, 2, 4, 8, and 16 32-bit words. We've decided that the size of each message is one 32-bit word. The following preprocessor directives define this size:

```c
#define    NUMBER_OF_MESSAGES    100
#define    MESSAGE_SIZE          TX_1_ULONG
#define    QUEUE_SIZE            NUMBER_OF_MESSAGES*MESSAGE_SIZE*sizeof(ULONG)
```

When we create the queues, we use both `MESSAGE_SIZE` and `QUEUE_SIZE` to specify the message size and how many bytes are required for each queue, respectively.
