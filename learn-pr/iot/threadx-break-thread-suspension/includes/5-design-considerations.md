## Introduction

There are two primary considerations for this project, which deals with the variable processing times for the Urgent thread and the other deals with the role of the Monitor thread. The processing times for the Urgent thread are 5 timer ticks (90% of the time) or 75 timer ticks (10% of the time). We'll accomplish this task by using the C library function `rand()`, which returns a pseudo-random integer number from 0 to a specified maximum (that is, `RAND_MAX`). We use the remainder operator (that is, `%`) in the expression `rand() % 100` that returns a value in the range 0 to 89. Thus, the following statement returns a `sleep_time` value of 5 about 90% of the time and a value of 75 about 10% of the time:

```c
if (rand() % 100 < 90) sleep_time = 5;

         else sleep_time = 75;
```

The second consideration for this project is the use of the Monitor thread. The only purpose of this thread is to check the status of the Urgent thread and the Routine thread to determine whether they're waiting for an unacceptable length of time. Making this check requires that we inspect the `run_count` of a thread. If the value of `run_count` hasn't changed since the last time it was inspected, we regard this as excessive wait time, and then we'll abort the suspension for the thread. Following is how the value of `run_count` can be obtained from the Urgent thread.

```c
tx_thread_info_get(&Urgent, TX_NULL, TX_NULL, &run_count, 

                            TX_NULL, TX_NULL, TX_NULL, 

                            TX_NULL, TX_NULL); 
```
