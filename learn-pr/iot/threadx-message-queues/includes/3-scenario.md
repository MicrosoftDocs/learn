## Introduction

For this project, we use the messaging scenario again, but with a variation. We have the `Urgent` thread and the `Routine` thread again, but we add a `Dispatcher` thread that sends messages to the `Urgent` queue and to the `Routine` queue as shown in this diagram.

:::image type="content" source="../media/project-scenario.svg" alt-text="Illustration of the project scenario." border="false":::

When the `Urgent` thread and `Routine` thread receive their messages, they process them but they do nothing more with the messages.
