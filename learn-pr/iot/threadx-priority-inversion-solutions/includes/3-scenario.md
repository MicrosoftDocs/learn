## Introduction

We use the messaging scenario again as we have in previous projects, but with a variation. For this project, we deliberately create a system with a priority inversion problem, run that system, and observe the results. We modify this project to incorporate priority inheritance, run it, and study the results. We then modify the project to incorporate preemption-threshold, run it, and study the results. Finally, we compare the three sets of results to gain an understanding of the problem, and two methods to solve it.

The following image contains an illustration of the project scenario. We have the Urgent thread, the Important thread, and the Routine thread. The Urgent thread has priority 1, the Important thread has priority 10, and the Routine thread has priority 15. The Urgent thread and Routine thread both need the mutex at various times, which is a reasonable situation. The Important thread doesn't need the mutex at all, but it has a higher priority than the Routine thread, so this problem can lead to a priority inversion problem.

:::image type="content" alt-text="Diagram that illustrates a priority inheritance scenario." source="../media/project-scenario.svg" loc-scope="Azure":::

## Design considerations

This project is substantially different from the earlier projects you might have completed. Our goal is to modify this project using two approaches that can avoid priority inversion. The two approaches that we use are priority inheritance and preemption-threshold, so let's start by investigating these techniques.
