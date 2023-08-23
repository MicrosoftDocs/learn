## Introduction

The following image illustrates the activities for this project:

:::image type="content" alt-text="Diagram that illustrates activities in an event flags group scenario." source="../media/activities.svg" loc-scope="Azure":::

The Urgent thread has priority 5 and the Routine thread has priority 15. The Urgent thread requires five timer ticks to process each message, and then it suspends until the event flags group has the specified event flags value of 0xFFF. When that occurs, the specified event flags are cleared from the event flags group and Urgent thread proceeds. The Routine thread requires 15 timer ticks to process each message, and then it suspends until the event flags group has the specified events flags value of 0xFFF, and then Routine thread proceeds.
