## Key points

We discussed several important terms and concepts in this module, as they're related to ThreadX. Following are brief definitions of some key points:

- **Event flags group**: ThreadX resource that provides a powerful tool for thread synchronization. Threads can operate on all 32 event flags in a group at the same time. There are two ThreadX services that deal with event flags groups, and they are set flags and get flags.
- **Clearing event flags**: Event flags that satisfy a get request are consumed (set to zero) if either of the options `TX_OR_CLEAR` or `TX_AND_CLEAR` are specified by the request.
- **Thread suspension**: Threads can suspend while attempting to get a logical combination of event flags from a group. When the get request is satisfied, all the threads that have the required event flags are resumed.

You can use an event flags group to synchronize a group of threads based on a condition you specify in a get service. When that condition is met, then all threads waiting for that condition are resumed. This is the only ThreadX service that allows multiple threads to simultaneously leave suspension based on a specified condition.
