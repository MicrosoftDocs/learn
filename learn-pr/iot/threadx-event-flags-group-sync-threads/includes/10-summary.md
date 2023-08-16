## Key points

We discussed several important terms and concepts in this module, as they're related to ThreadX. Here are brief definitions of some key points:

- **Event flags group**: A ThreadX resource that provides a powerful tool for thread synchronization. Threads can operate on all 32 event flags in a group at the same time. There are two ThreadX services that deal with event flags groups, `tx_event_flags_set` and `tx_event_flags_get`.
- **Clearing event flags**: Event flags that satisfy a get request are consumed (set to zero) if the request specifies either of the options `TX_OR_CLEAR` or `TX_AND_CLEAR`.
- **Thread suspension**: Threads can suspend while attempting to get a logical combination of event flags from a group. When the get request is satisfied, all the threads that have the required event flags are resumed.

You can use an event flags group to synchronize a group of threads based on a condition you specify in a get service. When that condition is met, then all threads waiting for that condition are resumed. This ThreadX service is the only  one that allows multiple threads to simultaneously leave suspension based on a specified condition.
