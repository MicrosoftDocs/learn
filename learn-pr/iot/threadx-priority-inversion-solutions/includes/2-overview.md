## Introduction

First, we'll investigate what priority inversion is, and how it can cause your system to crash. Then, we'll investigate both priority inheritance and preemption threshold and observe how these solutions can help you to avoid priority inversion. We'll conduct three tests illustrating priority inversion, priority inheritance, and preemption threshold. Finally, we'll study the results of our three tests and compare the effectiveness of the two solutions. The name of this project is ProjectPriorityInversion.

Priority inversion is a problem that typically occurs in a priority-based system involving three threads with unique priorities, and where the highest priority thread and the lowest priority thread require access to the same resource, such as a mutex. It may be possible for the medium priority thread to preempt the lowest priority thread for an indeterminate time period. The medium priority thread is blocking the higher priority thread, and thus, the priorities are inverted. We may not know how long the medium priority thread will block the higher priority, leading to a non-deterministic situation that may cause system failure.

The following figure contains an illustration of a typical priority inversion problem. Following is the sequence of numbered events that lead to priority inversion:

1. Thread-1 and Thread-3 both need the mutex, but Thread-1 acquires it first
1. Thread-2 preempts Thread-1 and runs for an unknown time
1. Thread-3 has the highest priority, so it briefly preempts Thread-2, but then suspends on the mutex because it's owned by Thread-1
1. Thread-3 is blocked by Thread-2, and we now have a case of priority inversion
1. Thread-2 resumes and runs for an unknown period of time

:::image type="content" alt-text="Diagram that illustrates the priority inversion problem." source="../media/priority-inversion-problem.svg" loc-scope="Azure":::
