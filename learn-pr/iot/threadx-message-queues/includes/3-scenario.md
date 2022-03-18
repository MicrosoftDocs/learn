## Introduction

For this project, we'll again use the messaging scenario, but with a variation. We'll again have the `Urgent` thread and the `Routine` thread, but we'll add a `Dispatcher` thread that sends messages to the `Urgent` queue and to the `Routine` queue as shown below.

:::image type="content" source="../media/project-scenario.svg" alt-text="Illustration of the project scenario." border="false":::

When `Urgent` thread and `Routine` thread receive their messages, they process them but they do nothing more with the messages.
