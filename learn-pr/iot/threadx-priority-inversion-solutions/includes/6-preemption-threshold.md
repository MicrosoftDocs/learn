## Overview

Preemption-threshold is an advanced feature that is unique to ThreadX. This concept has been studied extensively in published research papers and is sometimes called priority ceiling protocol. The following image contains an illustration of the concept of preemption-threshold. In this example, Thread N has priority 20 and preemption threshold 15. In this example, Thread N can preempt threads with priorities lower than 20, that is, priorities 21 through 31 (assuming 32 possible priorities). However, only threads with priorities greater than 15, that is, priorities 0 through 14, can preempt Thread N.

:::image type="content" alt-text="Diagram that illustrates the concept of preemption-threshold." source="../media/preemption-threshold-concept.svg" loc-scope="Azure":::

The next image contains an illustration of how preemption-threshold works. The following sequence of numbered events demonstrates how preemption-threshold can prevent priority inversion:

1. Thread-1 and Thread-3 both need the mutex, but Thread-1 acquires it first. The preemption threshold for Thread-1 equals the priority for Thread-3, so Thread-1 runs to completion and Thread-2 or Thread-3 doesn't preempt it.
1. Thread-2 becomes ready, but it can't preempt Thread-1 because of preemption-threshold.
1. Thread-3 becomes ready, but it can't preempt Thread-1, because of preemption-threshold. Thread-3 suspends on the mutex.
1. Thread-1 releases the mutex, Thread-3 gets the mutex, and runs to completion.

:::image type="content" alt-text="Diagram that illustrates an example of preemption-threshold." source="../media/preemption-threshold-example.svg" loc-scope="Azure":::

As illustrated in the preceding image, use of preemption-threshold has prevented priority inversion from occurring. It also diminished the amount of overhead by reducing the number of context switches, as a consequence of cutting down on the number of thread preemptions.
