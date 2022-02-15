The table below compares several performance measures of mutexes and counting semaphores. The reference processor for these performance measures is the Cortex-A9 400MHz.

<!--figure 1-->

|Item   |Mutex    |Counting semaphore |
|---|---|---|
|**Instruction Area Size** |1,134 bytes |322 bytes |
|**RAM Size (Control Block)** |52 bytes |28 bytes |
|**Get--Immediate Response** |0.06__ |0.04__ |
|**Put--Immediate Response** |0.08__ |0.05__ |
|**Put--Resume Only** |0.28__ |0.19__|
|**Put--Resume & Context Switch** |0.44__ |0.35__|

*Immediate Response* for both the *Get* and *Put* services is the time required to process the request immediately, that is, there is no thread suspension or thread resumption. 

*Resume only* for the *Put* service is the time required to process the request when a previously suspended thread (of the same or lower priority) is resumed as a result of the request. 

*Resume and Context Switch* for the *Put* service is the time required to process the request when a previously suspended higher-priority thread is resumed as a result of the request. Since the resumed thread is higher-priority, a context switch to the resumed thread is also performed from within the request.

For each performance item, the mutex requires more memory and requires more processor time. However, a mutex provides robust support for ensuring the mutual exclusion property.

The table below contains a comparison of the features for mutexes and counting semaphores. Following is a feature-by-feature comparison of mutexes and counting semaphores:

- **Speed** - as noted in the table above a counting semaphore is somewhat faster
- **Thread ownership** - the mutex is the only resource that has ownership capabilities
- **Priority inheritance** - we'll discuss this feature later, but the mutex is the resource that has priority inheritance
- **Mutual exclusion** - the name mutex is derived from the words mutual exclusion, and a mutex should only be used for this feature; a binary semaphore can provide a weak form of mutual exclusion
- **Inter-thread synchronization** - we'll discuss this feature later, but neither a mutex nor a counting semaphore is a good choice for this feature, although a counting semaphore may be used in a limited capacity
- **Event notification** - this is a great strength of the counting semaphore
- **Thread suspension** - suspension for the mutex depends on whether the mutex is owned, and suspension for the counting semaphore depends on its count

<!--figure 2-->

|Feature  |Mutex   |Counting semaphore |
|---|---|---|
|**Speed**    |Somewhat slower than a semaphore |A semaphore is generally faster and requires fewer system resources |
|**Thread ownership** |Only one thread can own a mutex |There is no concept of thread ownership for a semaphore - any thread can get an instance of a counting semaphore if its current count is greater than zero |
|**Priority inheritance** |Only available with a mutex |Not available with a counting semaphore |
|**Mutual exclusion** |The primary purpose of a mutex - a mutex should be used only for mutual exclusion |Can be accomplished with the use of a binary semaphore, but there may be pitfalls |
|**Inter-thread synchronization** |Should not be done with a mutex |Can be performed with a semaphore, but an event flags group is the best choice |
|**Event notification** |Should not be done with a mutex |The primary purpose of a counting semaphore |
|**Thread suspension** |Thread can suspend if another thread already owns the mutex (also depends on wait option) |Thread can suspend if the value of a counting semaphore is zero (also depends on wait option) |

