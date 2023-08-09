## Introduction

We use a scenario for this project that is different from the scenario used in the previous modules. Here's an illustration of the scenario:

:::image type="content" source="../media/producer-consumer-scenario.svg" alt-text="Illustration of the Producer-Consumer scenario." border="false":::

For this scenario, we have two threads, one counting semaphore, and one application timer that displays a periodic statistical summary. We call the threads Producer and Consumer. The Producer thread puts an instance on the counting semaphore that we call StorageFacility. The Consumer thread gets an instance from StorageFacility, and if StorageFacility doesn't have any instances, it waits indefinitely until an instance is available. Your assignment for this project is to add a second consumer.
