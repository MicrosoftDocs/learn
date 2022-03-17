## Introduction

For this project, we'll again use the messaging scenario, but with a variation. We'll again have the Urgent thread and the Routine thread, but we'll add a condition to their operation. We'll synchronize the activities of these threads by using an event flags group. 

The following figure illustrates an event flags group scenario:

:::image type="content" alt-text="Diagram that illustrates an event flags group scenario." source="../media/event-flags-group-scenario.svg" loc-scope="Azure":::

Each time the messaging threads finish processing a message, they'll wait for a signal to proceed. When that signal arrives, both threads proceed. Of course, that signal is an event flags group, and the threads wait for the specified event flags 0xFFF to appear in the event flags group. This synchronization technique can be used with as few or as many threads as needed, and with relatively little modification.
