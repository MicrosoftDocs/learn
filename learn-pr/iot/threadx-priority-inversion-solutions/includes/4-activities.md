## Overview

The following image contains a description of the activities for this project. The Urgent thread and the Routine thread interact with each other by sharing the mutex. The Important thread doesn't need the mutex, but it has a higher priority than the Routine thread. It's likely that there are situations when Important will preempt Routine. When this scenario occurs, it's also possible that Urgent will need the mutex, but Routine already owns it, and Routine has been preempted by Important. Thus, we have a priority inversion problem.

:::image type="content" alt-text="Diagram that illustrates activities for a priority inheritance scenario." source="../media/project-activities.png" loc-scope="Azure":::
