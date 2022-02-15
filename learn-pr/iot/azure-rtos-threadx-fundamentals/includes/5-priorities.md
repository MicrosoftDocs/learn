ThreadX uses a priority system as a means of establishing the relative importance of threads in the system. There are two classes of priorities: static and dynamic. 

- A static priority is one that is assigned when a thread is created and remains constant throughout execution.
- A dynamic priority is one that is assigned when a thread is created but can be changed at any time during execution.

There is no limit to the number of priority changes that can occur. As an extreme case, all threads could be assigned the same priority that would never change. However, in most cases, priority values are carefully assigned and modified only to reflect the change of importance in the processing of threads. For example, you could have priority ranges of 0-31, 0-63, 0-95, and even 0-1023. Most applications do not need more than 32 priorities.

The default priority range is from 0 to 31, where the value 0 represents the highest priority, and the value 31 represents the lowest priority:

Priority Value | Meaning 
:---: | :---:
0 | Highest priority
1 | 
: | 
31 | Lowest priority  
