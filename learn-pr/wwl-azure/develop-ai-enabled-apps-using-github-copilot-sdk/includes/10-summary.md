In this module, you learned about AI agents and how to build them using the GitHub Copilot SDK. You explored what makes AI agents different from chatbots and automation scripts—specifically their ability to reason about goals, use tools, and execute multi-step workflows autonomously. You examined the SDK's architecture, which provides a production-tested agent execution loop on top of the Copilot CLI, and you learned how its core concepts (client, session, tools, and events) work together.

You examined real-world scenarios where AI agents provide business value, from e-commerce customer support to IT operations incident response. You then learned how to design agent systems with appropriate components: an AI reasoning engine, custom tools, memory management, and guardrails. The implementation unit showed you how to configure a `CopilotClient`, define tools using `AIFunctionFactory.Create`, write system prompts, and handle responses through the SDK's event-driven model.

The main takeaway from this module is that the GitHub Copilot SDK handles the complex infrastructure of agent orchestration—session management, tool calling, context tracking, and model communication—so you can focus on defining the tools and business logic that make your agent useful.

You can apply this knowledge to build AI agents for your own applications. Start by identifying a workflow in your organization that involves multiple steps, data lookups, and decision making. Define the tools the agent would need, write a focused system prompt, and use the GitHub Copilot SDK to bring the agent to life.

## Learn more

- [GitHub Copilot SDK repository](https://github.com/github/copilot-sdk)
- [Build an agent into any app with the GitHub Copilot SDK (GitHub Blog)](https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/)
