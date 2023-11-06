## Introduction

Most modern RTOSes have a priority inheritance feature, as does ThreadX. As its name suggests, strategically inheriting a priority can eliminate the problem of priority inversion. The following image contains an illustration of how priority inheritance works. The following sequence of events demonstrates how priority inheritance can avoid priority inversion.

1. Thread-1 and Thread-3 both need the mutex, but Thread-1 acquires it first.
1. Thread-2 preempts Thread-1 and runs for an unknown time.
1. Thread-3 has the highest priority, so it briefly preempts Thread-2, but then suspends on the mutex because Thread-1 owns the mutex.
1. Because priority inheritance is enabled, Thread-1 immediately acquires the priority of Thread-3, and retains that priority as long as it owns the mutex. Thread-1 resumes and runs to completion. When Thread-1 gives up ownership of the mutex, it immediately loses its inherited priority.
1. Thread-3 resumes, preempts Thread-1, and runs to completion.

:::image type="content" alt-text="Diagram that illustrates an example of priority inheritance." source="../media/priority-inheritance-example.png" loc-scope="Azure":::
