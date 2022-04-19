## Introduction

A counting semaphore is a public resource, and there's no concept of ownership as there is with a mutex. The primary purposes of a counting semaphore are event notification, thread synchronization, and mutual exclusion. ThreadX provides 32-bit counting semaphores where the count must be in the range from 0 to 4,294,967,295 or 2<sup>32</sup>–1 (inclusive). When a counting semaphore is created, the count must be initialized to a value within that range. Each value in the semaphore is an instance of that semaphore. Thus, if the semaphore count is five, then there are five instances of that semaphore.

The following image lists the attributes of a counting semaphore:

:::image type="content" alt-text="Diagram that illustrates the attributes of a counting semaphore." source="../media/attributes.svg" border="false" loc-scope="Azure":::

Every counting semaphore must have a control block that contains essential system information. Every counting semaphore is assigned a name, which is used primarily for identification purposes. Every counting semaphore must have a semaphore count that indicates the number of instances available. As noted before, the value of the count must be in the range from 0x00000000 to 0xFFFFFFFF (inclusive). A counting semaphore can be created either during initialization or during run-time by a thread. There's no limit to the number of counting semaphores that can be created.

The following image is an illustration of a counting semaphore:

:::image type="content" alt-text="Diagram that illustrates the make-up of a counting semaphore." source="../media/counting-semaphore.svg" loc-scope="Azure":::

In this example, we have M shared resources and N threads. When a thread needs a shared resource, it must first get an instance of the counting semaphore. If there are no instances of the counting semaphore available, the thread will have to take action depending on its wait condition. When a thread finishes using a shared resource, it puts an instance on the counting semaphore. Getting an instance of a semaphore is analogous to decrementing the count of the semaphore, but the count may never be less than zero. Similarly, putting an instance on the semaphore is analogous to incrementing the count of the semaphore. It's possible for several threads to use the shared resources of the counting semaphore simultaneously.

Following is an example of a thread attempting to get an instance of a semaphore called `my_semaphore`:

```c
tx_semaphore_get (&my_semaphore, TX_WAIT_FOREVER);
```

If an instance of the semaphore is available, the thread gets it and proceeds. If an instance of the semaphore isn't available, the thread may wait indefinitely until an instance become available, depending on the wait option. The wait option `TX_WAIT_FOREVER` is one of three options for a thread in most blocking situations that can result in suspension. Another option is `TX_NO_WAIT` where the thread immediately returns if an instance isn't available. The third option is a numeric value (1-0xFFFFFFFE) that specifies the maximum number of timer ticks that the thread is willing to stay suspended while waiting for an instance of the semaphore.
