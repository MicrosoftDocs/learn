## Introduction

For this project, we use the messaging scenario again, but with a variation. We have the Urgent thread and the Routine thread again, but we add a condition to their operation. We want to synchronize the activities of these threads by using an event flags group.

The following image illustrates an event flags group scenario:

:::image type="content" alt-text="Diagram that illustrates an event flags group scenario." source="../media/event-flags-group-scenario.svg" loc-scope="Azure":::

Each time the messaging threads finish processing a message, they wait for a signal to proceed. When that signal arrives, both threads proceed. Our signal is an event flags group, and the threads wait for the specified event flags 0xFFF to appear in the event flags group. This synchronization technique can be used with as few or as many threads as needed, and with relatively little modification.
