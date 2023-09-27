## Introduction

In this module, we first investigate what priority inversion is, and how it can cause your system to crash. Then, we investigate both priority inheritance and preemption threshold to observe how these solutions can help you to avoid priority inversion. We conduct three tests illustrating priority inversion, priority inheritance, and preemption threshold. Finally, we study the results of our three tests and compare the effectiveness of the two solutions. The name of the project in this module is *ProjectPriorityInversion*.

Priority inversion is a problem that typically occurs in a priority-based system involving three threads with unique priorities. When the highest priority thread and the lowest priority thread require access to the same resource, such as a mutex, it may be possible for the medium priority thread to preempt the lowest priority thread for an indeterminate time period. The medium priority thread is blocking the higher priority thread, and thus, the priorities are inverted. We may not know how long the medium priority thread can block the higher priority thread, leading to a nondeterministic situation that may cause system failure.

The following diagram illustrates a typical priority inversion problem by laying out the sequence of events that lead to priority inversion:

1. Thread-1 and Thread-3 both need the mutex, but Thread-1 acquires it first.
1. Thread-2 preempts Thread-1 and runs for an unknown time.
1. Thread-3 has the highest priority, so it briefly preempts Thread-2, but then suspends on the mutex because Thread-1 owns the mutex.
1. Thread-2 blocks Thread-3. Now we have a case of priority inversion.
1. Thread-2 resumes and runs for an unknown period of time.

:::image type="content" alt-text="Diagram that illustrates the priority inversion problem." source="../media/priority-inversion-problem.svg" loc-scope="Azure":::
