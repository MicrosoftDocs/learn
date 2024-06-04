**Idempotence** is a mathematical term that can be used in Infrastructure as Code and Configuration as Code. It can apply one or more operations against a resource, resulting in the same outcome.

For example, running a script on a system should have the same outcome despite the number of times you execute the script. It shouldn't error out or do the same actions irrespective of the environment's starting state.

In essence, if you apply a deployment to a set of resources 1,000 times, you should end up with the same result after each application of the script or template.

:::image type="content" source="../media/idempotency-8f385c83.png" alt-text="A circle has two simultaneously repeating icons of a script and an application in its final state, demonstrating the repeating pattern of idempotence.":::


You can achieve idempotency by:

 -  Automatically configuring and reconfiguring an existing set of resources.<br>
 -  Discarding the existing resources and recreating a new environment.

When defining Infrastructure as Code and Configuration as Code, as a best practice, build the scripts and templates in such a way as to embrace idempotency.

It's essential when working with cloud services because resources and applications can be scaled in and out regularly. New instances of services can be started up to provide service elasticity.

> [!NOTE]
> You can read more about idempotence at [Idempotency for Windows Azure Message Queues](https://www.atmosera.com/blog/idempotency-for-windows-azure-message-queues/).
