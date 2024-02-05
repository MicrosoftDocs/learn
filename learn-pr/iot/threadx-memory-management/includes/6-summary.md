## Key points

We discussed several important terms and concepts in this module, as they're related to ThreadX. Here are some brief definitions of these key points.

### Data types

ThreadX uses special primitive data types that map directly to data types of the underlying C compiler. Mapping is done to ensure portability between different C compilers. These primitive data types are `UINT`, `ULONG`, `VOID`, and `CHAR`. ThreadX also uses system data types to define and declare system resources, such as threads and mutexes. These system data types are `TX_TIMER`, `TX_QUEUE`, `TX_THREAD`, `TX_SEMAPHORE`, `TX_EVENT_FLAGS_GROUP`, `TX_BLOCK_POOL`, `TX_BYTE_POOL`, and `TX_MUTEX`.

### Memory byte pools

The memory byte pool is a sequential collection of bytes that may be used for any of the resources. There's no limit on the number of memory byte pools that can be created. Threads can suspend on a memory byte pool until the requested memory is available. Memory byte pools are easy to use, but frequent allocates and releases can result in fragmentation, which can lead to nondeterminism.

### Memory block pools

A memory block pool consists of fixed-size memory blocks, so there's never a fragmentation problem. There's a lack of flexibility because the same amount of memory is allocated each time. However, there's no limit as to how many memory block pools can be created, and each memory block pool can have a different memory block size. In general, memory block pools are preferred over memory byte pools. The fragmentation problem is eliminated and access to the memory block pool is faster.

### Thread stacks

Each thread must have its own stack; the developer determines the stack size and the manner in which memory is allocated for the stack. The stack size is crucial; it must be large enough to accommodate worst-case function call nesting, local variable allocation, and saving the thread’s last execution context. ThreadX provides a `tx_thread_stack_error_notify` service that monitors the stack, and the corresponding callback function is invoked if a stack error occurs.
