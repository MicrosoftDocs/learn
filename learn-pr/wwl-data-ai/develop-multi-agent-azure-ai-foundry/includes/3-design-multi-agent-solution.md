In a connected agent solution, success depends on clearly defining the responsibilities of each agent. The central agent is also responsible for how the agents will collaborate. Let's explore how to design a multi-agent program using Azure AI Foundry Agent Service.

**Main agent responsibilities**

The main agent acts as the orchestrator. It interprets the intent behind a request and determines which connected agent is best suited to handle it. The main agent is responsible for:

- Interpreting user input
- Selecting the appropriate connected agent
- Forwarding relevant context and instructions
- Aggregating or summarize results

**Connected agent responsibilities**

Connected agents designed to focus on a single domain of responsibility. A connected agent is responsible for:

- Completing a specific action based on a clear prompt
- Using tools (if needed) to complete their task
- Returning the results to the main agent

Connected agents should be designed with a single responsibility in mind. This makes your system easier to debug, extend, and reuse.

## Set up a multi-agent solution with connected agents

1. **Initialize the agents client**

    First, you create a client that connects to your Azure AI Foundry project.

1. **Create an agent to connect to the main agent**

   Define an agent you want to connect to the main agent. You can do this using the `create_agent` method on the `AgentsClient` object. 
   
   For example, your connected agent might retrieve stock prices, summarize documents, or validate compliance. Give the agent clear instructions that define its purpose.

1. **Initialize the connected agent tool**

    Use your agent definition to create a `ConnectedAgentTool`. Assign it a name and description so the main agent knows when and how to use it.

1. **Create the main agent**

    Create the main agent using the `create_agent` method. Add your connected agents using the `tools` property and assign the `ConnectedAgentTool` definitions to the main agent.

1. **Create a thread and send a message**

    Create the agent thread that is used to manage the conversation context. Then create a message on the thread that contains the request you want the agent to fulfill.

1. **Run the agent workflow**

    Once the message is added, create a run to process the request. The main agent uses its tools to delegate tasks as needed and compile a final response for the user.

1. **Handle the results**

    When the run completes, you can review the main agent's response. The final output may incorporate insights from one or more connected agents. Only the main agent's response is visible to the end user.

Designing a connected agent system involves defining focused agents, registering them as tools, and configuring a main agent to route tasks intelligently. This modular approach gives you a flexible foundation for building collaborative AI solution that scale as your needs grow.