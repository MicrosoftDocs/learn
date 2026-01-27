Prompts in Microsoft Foundry exist as part of agent definitions, where each agent combines a language model with system instructions that define its behavior.

In the customer service scenario, the team's agent prompt controlled how the system responded to customer inquiries. When they modified that prompt to sound more casual, they changed a core component of the agent definition, but without understanding how to version and track those changes properly.

Here, you learn how prompts integrate with Microsoft Foundry agent architecture, how to deploy agents programmatically with the Python SDK, and how to compare different agent versions in the portal.

## Understand Microsoft Foundry agents

Microsoft Foundry agents are AI-powered assistants that combine large language models with custom instructions to perform specific tasks. Each agent consists of several key components:

| Component | Purpose | Example |
|-----------|---------|---------|
| **Agent definition** | Identifies the agent with name and metadata | `trail-guide` with version number |
| **System instructions** | The prompt that defines agent behavior and capabilities | Instructions for trail recommendations and safety guidance |
| **Model selection** | The underlying AI model powering responses | GPT-4.1 or other available models |
| **Tool integrations** | Optional connections to external services or data | Weather APIs, trail databases |

The system instructions, your prompt, represent the most frequently changed component. While you rarely modify the model or tools, you continuously refine prompts to improve accuracy, add capabilities, or adjust tone.

## Recognize how prompts define agent behavior

Your prompt serves as the agent's operational manual. Consider how different prompts create different agent behaviors:

**Version 1 - Basic functionality:**
```
You are a trail guide assistant. Help users find hiking trails and provide basic safety advice.
```

**Version 2 - Enhanced capabilities:**
```
You are an experienced trail guide assistant. Help users discover hiking trails matched to their experience level. Provide personalized recommendations based on their preferences, fitness level, and available time. Include essential safety guidance and gear recommendations.
```

**Version 3 - Production-ready:**
```
You are an expert trail guide assistant with deep knowledge of hiking safety and trail conditions. When helping users plan hikes:

1. Assess their experience level and fitness
2. Consider weather and seasonal factors
3. Recommend appropriate trails with difficulty ratings
4. Provide comprehensive gear lists
5. Include safety protocols and emergency contacts
6. Suggest alternative options for different conditions

Always prioritize user safety and provide actionable, specific guidance.
```

> [!NOTE]
> Each version maintains the same agent name and configuration but delivers progressively enhanced user experiences through prompt refinement.

## Deploy agents programmatically

Microsoft Foundry creates a new agent version whenever you create or update an agent, whether through the portal interface or the Python SDK. The SDK approach enables better version control integration by storing prompts in files that Git can track:

```python
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential

# Initialize client
project_client = AIProjectClient.from_connection_string(
    conn_str=os.environ["PROJECT_CONNECTION_STRING"],
    credential=DefaultAzureCredential()
)

# Read prompt from version-controlled file
with open('prompts/v1_instructions.txt', 'r') as f:
    instructions = f.read().strip()

# Create agent with versioned prompt
agent = project_client.agents.create_agent(
    model=os.environ["MODEL_NAME"],
    name=os.environ["AGENT_NAME"],
    instructions=instructions
)

print(f"Agent created (id: {agent.id}, version: 1)")
```

This approach separates prompt content from deployment code:

- **Prompt files** (`v1_instructions.txt`, `v2_instructions.txt`) contain the system instructions
- **Deployment script** (`trail_guide_agent.py`) reads and deploys the prompt
- **Version control** tracks changes to both prompts and deployment configurations

> [!NOTE]
> This approach separates prompts into dedicated files, but organizations use different strategies based on their needs:
> - **Embedded prompts**: Store prompts directly in Python scripts as strings. Simple for small teams but harder to review prompt-only changes.
> - **Separate files**: Store prompts in `.txt` or `.md` files (shown here). Better for nontechnical reviewers and clearer version history.
> - **Configuration management**: Store prompts in YAML or JSON with metadata. Good for complex deployments with multiple environments.
> 
> Consider your team's technical expertise, review processes, and deployment complexity when choosing an approach.

## Evaluate version comparison workflows

When you deploy multiple agent versions, you gain powerful comparison capabilities:

- **Test identical scenarios** across versions to measure improvement
- **Compare responses** to the same user questions
- **Identify regressions** where newer versions perform worse
- **Document evolution** showing how prompts developed over time

You can switch between deployed agent versions through both the Microsoft Foundry portal and the Python SDK. In the portal, select different versions and observe how the same input produces different outputs. Through the SDK, list all agent versions programmatically to automate comparison workflows. This directly demonstrates prompt impact on behavior.

Now that you understand how Microsoft Foundry manages agent versions, you're ready to explore how to organize these prompts and deployment scripts in a GitHub repository.

