Building your own agents in Microsoft Security Copilot empowers organizations to create specialized AI-driven automation that addresses unique security challenges and operational requirements.

<br>

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=8722a80c-b941-43d6-9f28-57898ef436a1]

Custom agents use AI-driven automation to streamline tasks by combining the following components:

- **Tools (Skills)** - Functions or actions the agent can perform.
- **Triggers** - Conditions or events that initiate the agent.
- **Orchestrators** - Logic that determines how tasks are executed.
- **Instructions** - System-level directives that an agent must follow.
- **Feedback** - Store response in memory to guide subsequent runs.

Custom agents integrate with various security workflows, helping your organization maintain a proactive and adaptive security posture. The solution supports workflow-driven automation that responds to events or schedules, executing a series of actions based on the agent structure and guidance from Large Language Models (LLMs).

Developers can choose from different experiences to build agents.

| Feature    | Types  |
|----------- |----------|
| **Standalone experience** | The standalone experience supports three different ways of creating an agent: <br> **1. [NL2Agent](/copilot/security/developer/build-agent-natural-language)**: Build agents simply by describing what you want in natural language. <br> **2. [Create an agent from scratch using agent builder](/copilot/security/developer/create-agent-dev)**: Configure agents using the agent builder interface in the Security Copilot platform. <br> **3. [Upload YAML](/copilot/security/developer/build-agent-yaml-file)**: Build a YAML in your Integrated Development Environment (IDE) of choice and upload it to Security Copilot. |
| **Model Context Protocol (MCP)** | **[MCP tools](/copilot/security/developer/mcp-overview)**: Create agents using natural language in an MCP compatible IDE using MCP tools. |
| **Upload Plugins** | **[YAML Manifest](/copilot/security/developer/build-agent-manifest)**: Build and upload your agent manifest. |

Whatever experience you choose, natural language or the agent builder, the experience converges in a YAML manifest file that is deployed as an agent to Security Copilot or Security Store for partners. The agent development process follows a structured workflow: **Build**, **Test**, and **Publish**.

### Natural Language Agent Creation (NL2Agent)

The Natural Language Agent Creation method allows you to build agents simply by describing what you want in conversational language. Based on your description, Security Copilot understands your intent, suggests tools and instructions, and autogenerates the agent YAML file, which can be further customized.

**Key benefits:**

- No technical expertise required
- Quick and intuitive agent creation
- Guided experience with suggested prompts
- Seamless transition to the agent builder to finalize configuration, publish, and test

**What you do:**

- From the home page of the Security Copilot portal, select Build
- Describe your agent's purpose and functionality in natural language prompts
- Engage in a conversational workflow where Security Copilot asks clarifying questions
- Review and approve the automatically generated agent configuration
- Select **View agent configuration** to transition to the agent builder, where you finalize your agent
- Once the agent is configured, select **Publish**. You must publish your agent before you can test it.
- Once published, you **test** you agent.


# [Build agent](#tab/build-agent)
:::image type="content" source="../media/describe-agent-natural-language.png" lightbox="../media/describe-agent-natural-language.png" alt-text="Screenshot of the build screen, in Security Copilot, where you build your own agents.":::

# [Select agent configuration](#tab/select-agent-configuration)
:::image type="content" source="../media/select-view-agent-configuration.png" lightbox="../media/select-view-agent-configuration.png" alt-text="Screenshot of the natural language text used to create an agent.":::

# [Agent details](#tab/agent-details)
:::image type="content" source="../media/agent-details.png" lightbox="../media/agent-details.png" alt-text="Screenshot showing the details of the agent built using natural language.":::

# [Publish](#tab/publish)
:::image type="content" source="../media/agent-publish.png" lightbox="../media/agent-publish.png" alt-text="Screenshot showing the publish window for your agent.":::

# [Test](#tab/test)
:::image type="content" source="../media/test-agent.png" lightbox="../media/test-agent.png" alt-text="Screenshot showing the test window for your agent.":::

---

## Agent builder

The agent builder provides a comprehensive form-based experience for creating agents from scratch using the Security Copilot platform's graphical interface. On the top navigation bar, there are two tabs: **Build** and **Test**. Use the **Build** tab to define your agent and configure its tools. The **Test** tab lets you validate the agent's responses, but you must currently first publish your agent before you can test it.

You can configure the following sections in the agent builder:

- **Agent details** - Define the agent's display name and description.
- **Instructions** - Provide clear directions to guide the agent on its goal and how it should execute tasks, written in natural language.
- **Inputs** - Define input parameters required for agent tools. You can reference input names in the Instructions field by wrapping them in double curly braces, for example, `{{skillInputName}}`.
- **Tools** - Add tools from the extensive Security Copilot tools catalog (including AGENT, GPT, KQL, API, and MCP tool types) or create new tools.
- **Automation** - Set up triggers to activate the agent on a schedule, and configure permissions including single-tenant constraints (Tenant, Workspace, or None).

You can also use the **Copilot** button to open a Chat interface that appears on the right side of the screen. The Chat interface lets you iteratively define your agent, add tools, and refine configurations through conversational input. You can toggle **View code** to see the autogenerated YAML, and copy or download it.

# [Start from scratch](#tab/start-from-scratch)
:::image type="content" source="../media/start-from-scratch.png" lightbox="../media/start-from-scratch.png" alt-text="Screenshot of the option to start from scratch using the agent builder.":::

# [Configure details](#tab/configure-details)
:::image type="content" source="../media/agent-builder-agent-details.png" lightbox="../media/agent-builder-agent-details.png" alt-text="Screenshot of the agent details form in the agent builder.":::

# [Configure instructions & tools](#tab/configure-instructions-tools)
:::image type="content" source="../media/agent-builder-agent-instructions-inputs.png" lightbox="../media/agent-builder-agent-instructions-inputs.png" alt-text="Screenshot of the agent instructions and inputs form in the agent builder.":::

# [Configure triggers & permissions](#tab/connfigure-triggers-permissions)
:::image type="content" source="../media/agent-builder-automation-triggers-permissions.png" lightbox="../media/agent-builder-automation-triggers-permissions.png" alt-text="Screenshot showing the section in the agent builder where you configure triggers and permissions.":::

---

Once you have completed the configuration of your agent, you must currently publish it before you can test it.

## YAML upload method

If you prefer not to use natural language prompts or the form-based agent builder, you can define your agent by uploading a YAML manifest. This approach gives developers the flexibility to build the agent YAML in their development environment of choice. This method is best suited for developers who want to reuse existing configurations, manage agent definitions through iterations, or work outside of UI-driven or conversational experiences.

**Key advantages:**

- Full programmatic control over agent definition
- Version control and iteration management capabilities
- Reusable configurations across multiple agents
- Integration with existing development workflows

**What you do:**

- Create agent manifest files in your preferred IDE using the YAML manifest schema
- Upload the completed YAML file to Security Copilot by selecting the **Upload a YAML manifest** card
- After upload, the agent builder displays the manifest components, including tools and agent overview
- Customize any parts of the agent, add tools from the tools catalog, or create new tools
- Toggle **View code** to switch between the YAML view and the form view
- Use the Chat interface to interact with and refine your agent

# [Upload YAML](#tab/upload-yaml)
:::image type="content" source="../media/upload-yaml-manifest.png" lightbox="../media/upload-yaml-manifest.png" alt-text="Screenshot of the option to upload a YAML manifest.":::

# [Agent YAML](#tab/agent-yaml)
:::image type="content" source="../media/build-agent-yaml-upload.png" lightbox="../media/build-agent-yaml-upload.png" alt-text="Screenshot of the code in the YAML manifest.":::

---

## Model Context Protocol (MCP) tools

Model Context Protocol (MCP) is an open protocol that enables seamless integration between LLM applications and external data sources and tools. The collection of Security Copilot agent creation MCP tools that are part of the [Microsoft Sentinel MCP server](/azure/sentinel/datalake/sentinel-mcp-overview) enables you to create agents using natural language directly within developer environments that host an MCP client, such as GitHub Copilot in Visual Studio Code.

The MCP tools support the following capabilities:

- Understand your intent to discover relevant tools (skills) within Security Copilot.
- Autogenerate an agent YAML file, which can be further customized.
- Deploy the agent to Security Copilot at user scope or workspace scope.

Developers can quickly begin building agents by prompting the MCP tools with a natural language request, such as "Build me an agent that can triage and respond to compromised accounts." The MCP tools generate an agent YAML file and support iterative development through conversational input with the AI assistant, and finally deploy the agent to Security Copilot.

**What you do:**

- Set up and authenticate to the Microsoft Sentinel MCP server from your IDE
- Use natural language prompts within your IDE to describe agent intent
- Use MCP tools to automatically discover relevant Security Copilot capabilities
- Generate and iterate on agent YAML files through conversational AI assistance
- Deploy agents directly to Security Copilot from your development environment
- Test agents in Security Copilot standalone
