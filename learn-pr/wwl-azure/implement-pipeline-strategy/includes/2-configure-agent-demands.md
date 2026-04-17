Azure Pipelines agents have different configurations and capabilities. Each agent runs on various operating systems and can have different software dependencies installed. Understanding how to configure agent demands ensures your pipeline jobs run on agents with the right capabilities.

Every agent has capabilities configured as name-value pairs that describe what the agent can do:

- **System capabilities**: Automatically discovered capabilities such as machine name, operating system type, and installed software
- **User-defined capabilities**: Custom capabilities you define to describe specific tools, applications, or configurations on the agent

## Viewing agent capabilities

You can view and manage agent capabilities in the Azure DevOps portal:

1. Navigate to **Organization Settings** > **Agent pools**
2. Select the agent pool, then choose a specific agent
3. Select the **Capabilities** tab to see available capabilities

The Capabilities tab shows both system and user-defined capabilities:

:::image type="content" source="../media/devops-ci-image-026-375e9237.png" alt-text="Screenshot of the Capabilities tab. User and system capabilities are shown.":::

## Configuring agent demands

When you configure a build pipeline, you can specify demands that agents must meet to run your job. This ensures your pipeline runs on agents with the required capabilities:

:::image type="content" source="../media/devops-ci-image-025-c0179f8d.png" alt-text="Screenshot of the Build job authorization and timeout settings.":::

## Types of demand conditions

You can configure two types of demand conditions:

- **Exists**: Requires that the agent has a specific capability (for example, `HasPaymentService` must exist)
- **Equals**: Requires that a capability matches a specific value (for example, `Agent.OS` equals `Windows_NT`)

These demands help ensure your pipeline jobs run on agents that meet your specific requirements, improving reliability and reducing build failures due to missing dependencies.

For more information, see [Capabilities](/azure/devops/pipelines/agents/agents).
