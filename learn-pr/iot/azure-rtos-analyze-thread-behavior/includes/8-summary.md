We discussed several important terms and concepts in this module, as they are related to Azure ThreadX RTOS. Following are brief definitions of some key points.

### Application timer

Application timers are similar to ISRs, but are used by applications to perform operations at scheduled times. Both one-shot timers and recurring timers may be used.

### Internal system clock

The service `tx_time_get()` obtains the contents of the internal system clock. The internal system clock is set to zero during initialization and can be changed to a specific value by the service `tx_time_set`.

### Thread cumulative performance information

The `tx_thread_performance_info_get` service obtains cumulative information about a specific thread from time zero. This service retrieves performance information about the following:
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
