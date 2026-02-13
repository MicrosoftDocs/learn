Testing, deploying, and integrating agents are critical steps in moving from development to production. Microsoft Foundry provides comprehensive capabilities for validating agent behavior, deploying to production environments, and connecting agents to your applications. These final steps transform prototypes into reliable automation that delivers business value.

## Testing strategies for agents

Thorough testing ensures your agents behave reliably across diverse scenarios before reaching users. Testing should cover expected interactions, edge cases, and error conditions.

### Testing with integrated playgrounds

Both the Foundry portal and Visual Studio Code extension provide playgrounds for interactive testing. These environments simulate real user interactions while providing visibility into agent decision-making.

**Using the playground effectively:**

Start with **happy path testing** - Verify the agent handles common, expected requests correctly. Test typical user questions and workflows to confirm basic functionality works as intended.

Move to **edge case testing** - Try ambiguous inputs, incomplete information, and unusual requests. Edge cases reveal how agents handle uncertainty and unexpected situations.

Perform **boundary testing** - Test the limits of what your agent should and shouldn't do. Confirm the agent respects boundaries defined in its instructions.

Conduct **multi-turn conversation testing** - Verify the agent maintains context across multiple exchanges. Test whether the agent remembers prior information and builds on previous responses appropriately.

Execute **tool invocation testing** - When agents use tools, verify they call the right tools at the right times and incorporate results correctly.

### Testing scenarios to validate

For a customer service agent, test these scenarios:

**Expected requests:**
- "I need to schedule an appointment"
- "What are your hours?"
- "Can I reschedule my appointment?"

**Out-of-scope requests:**
- "What medication should I take?" (should decline and suggest consulting a provider)
- "Can you access my medical records?" (should explain privacy boundaries)

**Ambiguous inputs:**
- "I need help" (should ask clarifying questions)
- "appointment" (should gather more context)

**Error conditions:**
- Tool failures or timeouts
- Requests requiring unavailable information
- System errors during processing

Recording test results helps you track improvements over time and ensures regressions don't reintroduce old issues.

## Working with conversations

Understanding how the Responses API manages conversations helps you design better agent experiences and troubleshoot issues effectively.

### Conversation lifecycle

**Conversation creation** - A new conversation starts when a user interacts with your agent. Each conversation maintains its own message history, separate from other users' interactions.

**Message exchange** - As users send messages, the Responses API processes them with your agent's configuration and generates responses based on conversation context.

**Context preservation** - Conversations preserve the full message history, enabling agents to reference earlier exchanges and maintain continuity.

**Conversation completion** - Conversations can be explicitly ended or allowed to expire based on inactivity. Completed conversations preserve their history for review.

### Managing conversations in production

When deploying agents, consider conversation management strategies:

**Session boundaries** - Decide when new conversations should start. Customer service agents might create new conversations for each support case, while productivity assistants might maintain longer conversations.

**Context limits** - Conversations can grow large over extended interactions. Monitor conversation length and implement strategies for summarizing or archiving old context when needed.

**Privacy and retention** - Define retention policies for conversation data. Determine how long message histories should be preserved and when they should be deleted.

You can view and manage conversations through the Foundry portal or programmatically through the Responses API, providing visibility into how users interact with your deployed agents.

## Deployment approaches

Microsoft Foundry supports multiple deployment approaches to match different operational needs and team workflows.

### Deploying from the Foundry portal

Portal deployment provides a visual, guided experience:

1. Navigate to your agent in the Foundry portal
1. Verify configuration and test results are satisfactory
1. Select **Deploy** from the agent's page
1. Confirm deployment settings
1. Wait for deployment to complete

Deployed agents appear in your project's resource list with active status indicators.

### Deploying from Visual Studio Code

VS Code deployment integrates with your development workflow:

1. Open your agent in the Agent Designer
1. Select **Create on Microsoft Foundry** (for new agents) or **Update on Microsoft Foundry** (for changes)
1. Wait for deployment confirmation
1. Refresh the Azure Resources view to see the deployed agent

This streamlined process keeps you in your development environment, eliminating context switches during deployment.

### Deployment considerations

When deploying agents, consider:

**Model availability** - Ensure your selected model deployment has sufficient capacity for expected load. Monitor usage and scale as needed.

**Tool dependencies** - Verify all tools your agent uses are properly configured. File Search requires vector stores with uploaded documents, API tools need valid credentials.

**Instruction clarity** - Double-check instructions before deployment. Changes after deployment require redeployment and may affect user experiences.

**Testing validation** - Confirm comprehensive testing is complete. Deploying untested changes risks production issues.

## Generating integration code

Once deployed, agents need to connect to your applications. The Microsoft Foundry extension generates sample integration code that accelerates this process.

### Code generation process

To generate integration code:

1. Select your deployed agent in the Azure Resources view (VS Code)
1. Select **Open Code File** from the available actions
1. Choose your programming language from the dropdown
1. The extension generates sample code showing how to:
   - Authenticate with Microsoft Foundry
   - Connect to your specific agent
   - Send messages using the Responses API
   - Process agent responses

### Sample integration code structure

Generated code typically includes:

**Authentication setup** - Code for authenticating with Azure using service principals, managed identities, or interactive credentials.

**Client initialization** - Creating and configuring the Microsoft Foundry client with your project details.

**Message handling** - Sending messages using the Responses API and managing conversation state.

**Response handling** - Processing agent responses, including handling tool calls and error conditions.

Here's a simplified example of Python integration code using the Responses API:

```python
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential

# Initialize client
credential = DefaultAzureCredential()
project_client = AIProjectClient(
    credential=credential,
    subscription_id="your-subscription-id",
    resource_group_name="your-resource-group",
    project_name="your-project-name"
)

# Get agent
agent = project_client.agents.get_agent("your-agent-id")

# Send message using Responses API
response = project_client.agents.create_response(
    agent_id=agent.id,
    messages=[{
        "role": "user",
        "content": "Hello, I need help scheduling an appointment"
    }]
)

# Process response
if response.status == "completed":
    for message in response.messages:
        if message.role == "assistant":
            print(message.content)
```

This code provides a starting point you can adapt to your specific requirements.

## Production integration patterns

Different applications require different integration approaches. Common patterns include:

### Web application integration

Integrate agents into web applications to provide AI-powered features:
- Start conversations when users interact with your agent
- Send user messages to the agent through the Responses API
- Display agent responses in your UI
- Maintain conversation context across user sessions

### API-driven workflows

Use agents in backend workflows triggered by events or schedules:
- Send structured data as messages using the Responses API
- Process agent responses programmatically
- Use agent outputs to drive next steps in workflows

### Chatbot implementations

Build conversational interfaces powered by agents:
- Map user sessions to agent conversations
- Handle real-time message exchange through the Responses API
- Implement typing indicators while agents process requests
- Support rich media in responses

### Background automation

Deploy agents for automated tasks running without user interaction:
- Schedule agent executions for regular tasks
- Feed data from systems into agents using the Responses API
- Process agent outputs to update business systems
- Monitor agent performance and results

## Production considerations

Successfully running agents in production requires attention to operational aspects:

### Monitoring and observability

**Track key metrics:**
- Response times and latency
- Tool invocation success rates
- Error rates and failure patterns
- Conversation volume and message counts
- Model token consumption

These metrics help you identify performance issues and optimize agent behavior.

### Security and compliance

**Implement security best practices:**
- Use managed identities or service principals for authentication
- Apply least-privilege access controls
- Encrypt sensitive data in transit and at rest
- Audit agent actions and conversations
- Implement data retention policies compliant with regulations

### Cost management

**Monitor and optimize costs:**
- Track token usage across agents and conversations
- Set response length limits to control costs
- Choose appropriate models balancing capability and cost
- Implement rate limiting to prevent unexpected usage spikes
- Manage conversation history retention to reduce storage costs

### Performance optimization

**Optimize agent performance:**
- Cache frequently requested information
- Optimize instructions for clarity and conciseness
- Remove unnecessary tools that add latency
- Monitor model selection, as some models are faster than others
- Implement timeout handling for long-running operations

## Error handling and resilience

Robust agent implementations handle errors gracefully:

**Network failures** - Implement retry logic with exponential backoff when API calls fail due to transient network issues.

**Tool failures** - When tools timeout or error, ensure agents provide helpful fallback responses rather than failing silently.

**Rate limiting** - Handle rate limit responses from Azure by implementing backoff strategies and queueing mechanisms.

**Invalid inputs** - Validate user inputs before sending to agents, filtering malicious content or formatting issues.

## Updating production agents

As requirements evolve, you'll need to update deployed agents:

1. Make changes in your development environment
1. Test thoroughly before deploying updates
1. Deploy updates during low-traffic periods when possible
1. Monitor for issues after deployment
1. Have rollback plans if updates cause problems

The agent ID remains constant across updates, so existing integrations continue working with updated behavior.

Testing, deploying, and integrating agents transforms development efforts into production value. By following systematic testing approaches, leveraging integrated deployment tools, and implementing robust integration patterns, you can confidently deliver AI agents that enhance your applications and automate workflows while maintaining enterprise-grade reliability and security.
