## Introduction

For this project, we'll again use the messaging scenario, but with a variation. We'll use the Urgent thread and the Routine thread that will read messages from two queues. The following image contains an illustration of the project scenario where the Urgent thread and the Routine thread suspend on the Gateway semaphore. Whenever a message appears on either of the two queues, an instance is placed on Gateway, and either thread will get that semaphore and read the message from one of the queues. The suspension list for Gatekeeper is in FIFO order, so whichever thread was suspended first will get an instance from Gatekeeper and resume.

:::image type="content" alt-text="Diagram that illustrates an event-chaining scenario." source="../media/project-scenario.svg" loc-scope="Azure":::
