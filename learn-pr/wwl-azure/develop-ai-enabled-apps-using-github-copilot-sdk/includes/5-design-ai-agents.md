Having explored what we might want an AI agent to do, we now turn to **how to design an AI agent system**. Regardless of the specific scenario, AI agents share a common set of architectural components and design considerations. In this unit, we discuss those foundational pieces: the AI model (brain), the tools/skills it can use (hands and eyes), the planner/controller (decision-making logic), memory (to remember context), and policies/guardrails (to keep it in check). Think of this like the blueprint for an AI agent. Understanding this blueprint will make it much easier to implement agents effectively using the Copilot SDK in the next unit.

**Core Components of an AI Agent System:**

- **AI Reasoning Engine (LLM "Brain"):** At the heart of the agent is typically a **Large Language Model or similar AI model** that can understand instructions and generate responses. This is the component that "reasons" and decides what to do next at each step. It's pre-trained on vast data (like GPT-4, etc.) so it has broad knowledge and language skills. The agent uses the LLM to interpret user queries or system events and to formulate plans and actions in textual form. The LLM is what allows the agent to handle flexible, ambiguous tasks (e.g., "help this customer with their problem" or "find why this server is slow"). In Copilot SDK, this is configured by choosing a model for your session (e.g., GPT-4 or Anthropic Claude, etc.).

- **Tools/Skills (Actions the Agent Can Take):** An AI agent extends its capabilities by using **external tools or APIs**. These are essentially predefined actions the agent is allowed to perform. A

- tool' could be as simple as a calculator or as powerful as calling an internal REST API or running a shell command. For example, in the scenarios we saw: the e-commerce agent had a tool to check order status, the IT ops agent had a tool to restart a server, the supply chain agent had a tool to fetch inventory levels. From the agent's perspective, a tool looks like a function it can invoke (often with some parameters). Tools are the mechanism by which the agent moves beyond just text and actually interacts with the world (databases, external systems, etc.)[57]. Designing the right set of tools for an agent is critical – you want to give it enough tools to be useful, but not too many to confuse or overly empower it. Tools can be thought of as the "verbs' the agent can use to act.

- **Planner/Controller Logic:** This component (often implicitly provided by an agent framework) is what orchestrates the agent's reasoning and tool use. It decides when the agent should **invoke a tool versus when it should ask a question or produce an answer**. Modern AI agents use techniques like the ReAct (Reason+Act) loop, where the agent alternates between thinking (the LLM proposes a step) and acting (calling a tool)[58]. In practice, the planner logic can be part of the LLM's prompt (e.g., instructions that tell it how to format a tool call) and part of the runtime that interprets the LLM output (e.g., the Copilot SDK will recognize when the LLM is trying to call a tool and execute it). As a designer, you need to set up this loop but you don't usually hardcode it ' frameworks like Copilot handle the heavy lifting. You mainly ensure the agent has a clear **goal** each time and possibly some intermediary directives. In essence, the planner is what breaks down the problem: "Goal -> step 1 -> (tool result) -> step 2 -> ... -> done'.

- **Memory/Context Store:** Unlike a stateless API call, agents carry **contextual memory** of what has happened so far. This could include conversational history (for a chat agent), or records of what data it has retrieved or actions taken (for a process-oriented agent). Memory is crucial for coherence. For example, if a user says "I need help with Order 12345" and later says "Actually, it was the wrong item,' the agent needs to remember that "it' refers to Order 12345's item. Memory can be short-term (within a single session or task) and potentially long-term (persisted knowledge across sessions). Copilot SDK, for instance, manages conversation history for you, ensuring the model's input includes relevant prior turns[59][60]. In more advanced setups, an agent might have a vector database to store and recall information over long periods or across related tasks (this is sometimes called semantic memory). When designing an agent, consider what information it needs to "carry' as it works on a task so that you can architect how that context is stored and accessed.

- **Policies and Guardrails:** Because AI agents are powerful, we need to put **constraints** on their behavior to ensure they operate safely and as intended. This includes:

    - **Scope Limits:** Define what the agent is and isn't allowed to do. E.g., the finance agent can create accounting entries up to $10,000 but not beyond without approval.

    - **Permissions:** Some actions might require a second check. The Copilot SDK supports permission hooks – for example, you could require a confirmation if the agent tries to run a destructive command[61][62].

    - **Safety Filters:** Ensuring the agent doesn't produce disallowed content (e.g., it shouldn't be answering questions outside its domain, or revealing confidential info). This can be handled by the model (OpenAI models have some built-in moderation) and by post-processing.

    - **Fallback and Escalation:** Design what the agent should do if it's not confident or encounters an error. Often the policy is to fail gracefully – e.g., the agent says "I'm sorry, I'll connect you with a specialist for this issue' (for a customer service agent), or in an automated process, it hands off the task to a human with a detailed log. This is important for building trust: humans need to know the agent won't stubbornly press on when it shouldn't.

    Essentially, guardrails are the rules of the road for the agent. When building with Copilot SDK, many guardrails come from how you implement the tools (you inherently limit what it can do by what tools you expose) and any explicit checks you code around its actions.

With these components in mind, let's visualize a typical **agent workflow** in operation:

**Common Workflow Explanation:** The above is a general template. For a conversational agent, Steps 1 and 5 correspond to turns in the conversation (user asks something -> agent eventually answers). For a background process agent (like the finance one), Step 5 might be posting an entry or sending a report. The key is that the agent can loop through reasoning and tool use multiple times if needed. For instance, it might fetch data (Step 3), then realize it needs another piece of data, fetch that too, and only then formulate an answer. This loop of *plan   act   check plan (repeat)* is what gives agents their flexibility and power[63].

**Example Walk-through:** Let's apply this to a concrete (simplified) example – the E-commerce Return Agent:

- **Input (Step 1):** User says, "I received the wrong item, order 12345. I want to return it."

- **Understand & Plan (Step 2):** The agent's LLM processes this. It identifies the goal: customer wants a return for order #12345 due to wrong item. It plans: "I should verify the order details and then initiate a return."

- **Invoke Tools (Step 3):** The agent calls getOrderDetails("12345") tool. This queries the order database.

- **Result:** The tool returns info (item, status delivered yesterday, etc.). Agent analyzes it (Step 4): it confirms item was "Red T-Shirt' but perhaps the inventory notes show a known issue (mislabeled item).

- **Iterate Plan:** With that data, the agent now decides to call the createReturn(orderId) tool. That processes the return in the system and might also arrange pickup.

- The createReturn tool responds, say, with a return confirmation number.

- **Outcome (Step 5):** The agent formulates a final answer to the user: "Sorry about that mix-up! I've created a return #RMA-1001 for Order 12345 and scheduled a pickup tomorrow. You'll be refunded in 3-5 days." That response is returned to the user and the issue is resolved.

During this, the agent used two tools and looped through the reasoning twice. From the user's perspective, it was a single smooth interaction. Under the hood, we (developers) gave the agent the capabilities (getOrderDetails, createReturn), and the agent's planning logic (provided by the SDK's execution loop) handled when to use them.

**Designing with the Copilot SDK:** The Copilot SDK essentially provides the Planner/Controller out-of-the-box – it will manage Steps 2–4 if you configure everything correctly[64]. What you need to design are:

- What **context** to give the agent at the start (e.g., a system prompt saying "You are a returns assistant for ContosoShop" and perhaps user-specific data like their order history if relevant).

- What **tools** to provide and implement (order lookup, return creation, etc., in our example).

- What **policies** to enforce (maybe don't allow return if outside 30-day window – the agent could be instructed about that policy or the tool could enforce it).

You also think through failure modes: e.g., if createReturn fails (perhaps the order is not returnable), the agent should apologize and escalate. Those would be either handled in the tool (return an error that the agent's LLM can detect and then respond appropriately) or encoded as instructions ("if return not allowed, say X").

**Ensuring Coherence and Goal Alignment:** Another part of design is making sure the agent's incentives align with the user/business goal. This is often done by how you prompt the agent. For example, you might give the agent a "system message' like: *'You are an AI assistant for an e-commerce company. Your goal is to help the customer resolve any order issues by either providing information or performing the necessary actions using the tools provided. Always respond in a polite and helpful tone. If the question is unrelated to the order or you lack a tool for it, politely decline."* Such instructions guide the agent's behavior and ensure it uses its tools correctly and stays on task[65]. With the Copilot SDK, you will typically supply such an initial prompt when creating a session.

In summary, designing an AI agent involves deciding *what it should be able to do* (tools & knowledge), *how it should behave* (policies & prompting), and understanding that an agent's lifecycle is a feedback loop of reasoning and acting until the job is done. The next unit will translate this design into concrete implementation steps, especially focusing on the common requirements (tools, context handling, error handling) using the Copilot SDK in practice.

[57]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[58]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[59]https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/
[60]https://ubos.tech/news/github-copilot-sdk-launches-ai-agent-runtime-with-multi%e2%80%91language-support-and-tool-integration-for-developers/
[61]https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/
[62]https://deepwiki.com/github/copilot-sdk/3-sdk-architecture
[63]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
