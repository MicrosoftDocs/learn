## Introduction

ThreadX provides several services to extract cumulative performance data for various ThreadX resources. We wish to analyze the performance of our system, so we need cumulative performance data for our two threads, which we can obtain with the `tx_timer_performance_info_get` service.

Here's what we'll use to obtain cumulative performance information for the Routine thread:

```c
ULONG Routine_resumptions, Routine_suspensions,
         Routine_solicited_preemptions;
:
tx_thread_performance_info_get(&Routine, &Routine_resumptions,
         &Routine_suspensions, &Routine_solicited_preemptions,
         TX_NULL, TX_NULL, TX_NULL, TX_NULL, TX_NULL,
         TX_NULL, TX_NULL);
```

### Key to parameters

Here are the parameter meanings of this `tx_thread_performance_info_get` service:

- `&Routine`: Pointer to the Routine thread control block structure
- `&Routine_resumptions`: Pointer to destination for the number of resumptions of this thread
- `&Routine_suspensions`: Pointer to destination for the number of suspensions of this thread
- `&Routine_solicited_preemptions`: Pointer to the number of preemptions that occurred as a result of ThreadX API service calls executed by this thread

There are other parameters for this service that we don't need, so we enter `TX_NULL` to ignore them.
