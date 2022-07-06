## Overview

You have studied many ThreadX concepts and techniques, but there's much more to learn. In this unit, we'll concentrate on a useful and authoritative source of information. That source is the ThreadX user guide, and it covers every aspect of ThreadX in detail.

## Organization of the user guide

Following is the organization of the ThreadX user guide.

|Chapter|Description|
|-------------|-----|
|`1` | Provides a basic overview of ThreadX and its relationship to real-time embedded development|
|`2` | Gives the basic steps to install and use ThreadX in your application right out of the box|
|`3` | Describes in detail the functional operation of ThreadX, the high performance real-time kernel|
|`4` | Details the application's interface to ThreadX|
|`5` | Describes writing I/O drivers for ThreadX applications|
|`6` | Describes the demonstration application that is supplied with every ThreadX processor support package|

We'll concentrate on Chapter 4 because that chapter contains details about ThreadX services.

## Groups of ThreadX services

Each ThreadX service has a prefix that indicates the service group. There are nine groups of services, and following are the prefixes for these groups.

- tx_block_
- tx_byte_
- tx_event_flags_
- tx_mutex_
- tx_queue_
- tx_semaphore_
- tx_thread_
- tx_time_
- tx_timer_

For example, the service that would cause a thread to sleep 20 timer ticks is `tx_thread_sleep (20)`.

## Example of a ThreadX service description

All ThreadX service descriptions are organized using the same format. For this example, we'll restrict our attention to the `tx_thread_sleep` service. For reference, you should access the [ThreadX user guide](https://docs.microsoft.com/azure/rtos/threadx/about-this-guide), go to Chapter 4, and then go to the `tx_thread_sleep` service. Following are the components of the `tx_thread_sleep` service.

|Component|Description|
|-------------|-----|
|`tx_thread_sleep` | The name of the service|
|`Suspend current thread for specified time` | One line description of the service|
|`Prototype` | UINT tx_thread_sleep(ULONG timer_ticks);|
|`Description` | This service causes the calling thread to suspend for the specified number of timer ticks. The amount of physical time associated with a timer tick is application specific. This service can be called only from an application thread.|
|`Parameters` | timer_ticks: The number of timer ticks to suspend the calling application thread, ranging from 0 through 0xFFFFFFFF. If 0 is specified, the service returns immediately.|
|`Return Values` | TX_SUCCESS (0x00) Successful thread sleep; TX_WAIT_ABORTED (0x1A) Suspension was aborted by another thread, timer, or ISR; TX_CALLER_ERROR (0x13) Service called from a non-thread|
|`Allowed from `| Threads|
|`Preemption possible` | Yes|
|`Example` | A short coded example showing the correct use of the service|
|`See Also` | tx_thread_create, tx_thread_delete, tx_thread_entry_exit_notify, tx_thread_identify, tx_thread_info_get, etc.|

A typical method of invoking the `tx_thread_sleep` service is: `status = tx_thread_sleep (20)` where status is a UINT variable. If the service call was successfully completed, the value of status would be `TX_SUCCESS`. You could also check for other possibilities for this service call.

The ThreadX user guide provides much information, and it's a valuable resource that you should use. In the next unit, we'll study another resource for you to use.
