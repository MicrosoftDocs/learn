## Introduction

ThreadX uses a priority-based preemptive scheduling system as a means of establishing the relative importance of threads. There are two classes of priorities: static and dynamic.

- A static priority is one that you assign when a thread is created. Furthermore, it remains constant during runtime.
- A dynamic priority is one that you assign when a thread is created. However, you can change it during runtime.

There's no limit to the number of priority changes that can occur. As an extreme case, all threads could be assigned the same priority that would never change. However, in most cases, priority values are carefully assigned and don't change. When you modify a priority value, it should reflect the change of importance in the processing of that thread. You can have priority ranges of 0-31, 0-63, 0-95, and even 0-1023. Most applications don't need more than 32 priorities, which is the default.

The default priority range is from 0 to 31, where the value 0 represents the highest priority, and the value 31 represents the lowest priority. The following table illustrates this priority range.

Priority Value | Meaning
:---: | :---:
0 | Highest priority
1 | Second highest priority
: |
31 | Lowest priority
