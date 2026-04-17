**Handoff orchestration** lets AI agents transfer control to one another based on the task context or user requests. Each agent can "handoff" the conversation to another agent with the right expertise, making sure the best-suited agent handles each part of the task. This pattern is ideal for customer support, expert systems, or any situation where dynamic delegation is needed.

![Diagram of handoff orchestration flow.](../media/multi-agent-handoff.png)

This pattern fits scenarios where the best agent isn't known upfront or where the task requirements become clearer during processing. Unlike parallel patterns, agents work one at a time, fully handing off control from one to the next.

## When to use handoff orchestration

You may want to consider using the handoff orchestration pattern in these scenarios:

- Tasks need specialized knowledge or tools, but the number or order of agents can't be determined in advance.  
- Expertise requirements emerge dynamically during processing, triggering task routing based on content analysis.  
- Multiple-domain problems require different specialists working sequentially.  
- You can define clear signals or rules indicating when an agent should transfer control and to whom.

## When to avoid handoff orchestration

You may want to avoid using the handoff orchestration pattern in these scenarios:

- The involved agents and their order are known upfront and fixed.  
- Task routing is simple and rule-based, not needing dynamic interpretation.  
- Poor routing decisions might frustrate users.  
- Multiple operations must run at the same time.  
- Avoiding infinite handoff loops or excessive bouncing between agents is difficult.

## Implementing handoff orchestration

The handoff orchestration pattern can be implemented in the Microsoft Agent Framework SDK using control workflows. In a control workflow, each agent processes the task in sequence, and based on its output, the workflow decides which agent to call next. This routing is done using a switch-case structure that routes the task to different agents based on classification results.

1. **Set up data models and chat client**
   - Create your chat client for connecting to AI services
   - Define Pydantic models for AI agents' structured JSON responses
   - Create simple data classes for passing information between workflow steps
   - Configure agents with specific instructions and `response_format` parameter for structured JSON output

1. **Create specialized executor functions**
   - **Input storage executor** - saves incoming data to shared state and forwards to classification agent
   - **Transformation executor** - converts agent's JSON response into typed routing object
   - **Handler executors** - separate executors for each classification outcome with guard conditions to verify correct message processing

1. **Build routing logic**
   - Create factory functions that generate condition checkers for each classification value
   - Design conditions to examine incoming messages and return true for specific classification results
   - Use conditions with Case objects in switch-case edge groups
   - Always include a Default case as fallback for unexpected scenarios

1. **Assemble the workflow**
   - Use WorkflowBuilder to connect executors with regular edges
   - Add switch-case edge group for routing based on classification results
   - Configure workflow to follow first matching case or fall back to default
   - Set up terminal executor to yield final output

Handoff orchestration provides a flexible way to route tasks dynamically among specialized AI agents, ensuring that each part of a workflow is handled by the best-suited expert. It works well for complex, evolving tasks like customer support or multi-domain problem solving where expertise needs change during the conversation. When you use the Microsoft Agent Framework SDK, you can build adaptable systems that seamlessly transfer control between agents—and include human input when needed—for smooth and efficient task completion.