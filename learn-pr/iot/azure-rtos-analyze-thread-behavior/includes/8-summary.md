## Introduction

We discussed several important terms and concepts in this module as they relate to ThreadX. Following are brief definitions of some key points.

### Application timer

Application timers are similar to ISRs, but applications use them to perform operations at scheduled times. You can use either one-shot timers or recurring timers.

### Internal system clock

The service `tx_time_get()` obtains the contents of the internal system clock. The internal system clock is set to zero during initialization and can be changed to a specific value by the service `tx_time_set`. Note that the internal system clock is only for your use; ThreadX doesn't use it to schedule threads.

### Thread cumulative performance information

The `tx_thread_performance_info_get` service obtains cumulative information about a specific thread from time zero. This service retrieves performance information about the following items:

:::row:::
   :::column span="":::
      - resumptions
      - suspensions
      - solicited_preemptions
      - interrupt_preemptions
      - priority_inversions
   :::column-end:::
   :::column span="":::
      - time_slices
      - relinquishes
      - timeouts
      - wait_aborts
      - last_preempted_by
   :::column-end:::
:::row-end:::
