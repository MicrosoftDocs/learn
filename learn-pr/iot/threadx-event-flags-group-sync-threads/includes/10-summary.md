We discussed several important terms and concepts in this module, as they are related to Azure ThreadX RTOS. Following are brief definitions of some key points:

- **Event flags group**: ThreadX resource that provides a powerful tool for thread synchronization. Threads can operate on all 32 event flags in a group at the same time. There are two operations: set flags and get flags. 
- **Clearing event flags**: Event flags that satisfy a get request are consumed (set to zero) if TX_OR_CLEAR or TX_AND_CLEAR are specified by the request. 
- **Thread suspension**: Threads can suspend while attempting to get a logical combination of event flags from a group. When the get request is satisfied, all the threads that have the required event flags are resumed.


