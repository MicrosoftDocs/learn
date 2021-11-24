Not all agents are the same. We've seen that they can be based on different operating systems, but they can also install different dependencies. To describe it, every agent has a set of capabilities configured as name-value pairs. The capabilities such as machine name and operating system type that are automatically discovered are referred to as **system capabilities**. The ones that you define are called **user capabilities**.

There's a tab for Capabilities on the Agent Pools page (at the Organization level) **when you select an agent**.

You can use it to see the available capabilities for an agent and to configure user capabilities.

For the self-hosted agent that I configured in the earlier demo, you can see the capabilities on that tab:

:::image type="content" source="../media/devops-ci-image-026-375e9237.png" alt-text="Screenshot of the Capabilities tab. User and system capabilities are shown.":::


When you configure a build pipeline and the agent pool to use, you can specify specific demands that the agent must meet on the Options tab.

:::image type="content" source="../media/devops-ci-image-025-c0179f8d.png" alt-text="Screenshot of the Build job authorization and timeout settings.":::


In the build job image, the HasPaymentService is required in the collection of capabilities. And an **exists** condition, you can choose that a capability **equals** a specific value.

For more information, see [Capabilities](/azure/devops/pipelines/agents/agents).
