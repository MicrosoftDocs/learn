In this unit, we'll get hands-on and talk about **how to implement the core elements of an AI agent using the GitHub Copilot SDK**. We'll follow the structure from Unit 4 – covering how to set up the model and context, how to define and register tools, and how to enforce basic guardrails and error handling. These are the *common tasks* you'll need to do for virtually any agent scenario. By mastering these fundamental implementation patterns, you'll be equipped to build any of the agents from Unit 3 (or your own custom scenario). We'll use C#/.NET in some explanations (since our lab will be in C#), but the concepts apply in any language supported by the SDK.

**Note:** This unit focuses on the "skeleton' of an agent (the general code structure). In Unit 6, we'll discuss scenario-specific customizations on top of this skeleton.

**Setting Up the Copilot SDK Client and Session:** First, you'll initialize the SDK in your application and start an **agent session**.

- *Install and authenticate:* You need to add the Copilot SDK package to your project (for .NET, for example, it's the GitHub.Copilot.SDK NuGet package). Then you authenticate ' typically by logging in with your GitHub account or setting a token. After that, in code you create a CopilotClient instance.

- *Start the client:* Starting the client essentially launches the underlying Copilot agent runtime (it may spawn a subprocess that runs the agent core). For example:

- This corresponds to connecting to the Copilot service. The SDK handles contacting GitHub, verifying your credentials, etc. (Under the hood it might start the CLI server as mentioned earlier, but you don't see that directly.)[66]

- *Create a session:* A "session' is like a context for a conversation or task. When creating a session, you specify which AI model to use and any initial configuration. For instance:

- This asks for a session with GPT-4 (just an example model name) and maybe sets a token limit for responses. You could also indicate if you want streaming responses (so you can render as it types) ' e.g., Streaming = true. The session is now ready to take inputs and produce outputs.

- *Provide initial context:* Usually, the first thing after session creation is to send a **system prompt or initial message** to set the stage. The Copilot SDK might let you pass a "system message' in session options or you can send it as the first message. For example, you might do:

- This system instruction helps steer the agent's behavior throughout the session. (In Copilot SDK specifically, the mechanism might differ, but conceptually you give it a prompt defining its role.)

At this point, you have an active agent session – the AI model knows its role and is ready to interact. The next critical part is giving it the ability to **use tools**.

**Defining and Registering Tools (Skills):** In Copilot SDK, you explicitly define the tools the agent can use. A tool is typically defined by:

- A **name** (how the agent references it),

- A **description** (so the agent knows when to use it),

- A **parameter schema** (what inputs it takes),

- A **handler function** (the code that executes when the agent invokes the tool).

For example, suppose we want to give our agent a tool to get user info from a database. We might define a tool called "lookup_user' that takes a user ID and returns details.

In many frameworks, tools can be defined via a JSON schema or via code attributes. The Copilot SDK documentation indicates you can use a JSON schema to define the tool's interface[67]. For instance:

```json
{
  "name": "lookup_user",
  "description": "Retrieve user account info by user ID",
  "parameters": {
    "type": "object",
    "properties": {
      "user_id": { "type": "string", "description": "The ID of the user" }
    },
    "required": ["user_id"]
  }
}
```

This schema says: there's a lookup_user tool that expects a JSON object with a string field user_id. Once we have this definition, we need to **register a handler** for it in our application code – i.e., tell the SDK what function to call when the tool is invoked[68].

In C#, it might look like:

```csharp
client.RegisterTool(
  schema: lookupUserSchema,
  handler: (ToolInput input) => {
    string userId = input.Get<string>("user_id");
    var user = Database.GetUserById(userId);
    return user != null ? $"User {user.Name}, Email {user.Email}" : "User not found";
  }
);
```

What we did:

- We gave the SDK the JSON schema (lookupUserSchema) and a C# lambda function to execute.

- Now, whenever the agent (LLM) decides to use lookup_user, the SDK will recognize that and call our handler, passing in the arguments.

The result our handler returns (e.g., a text with the user's name and email) goes back to the agent's LLM context as if it "saw" that result. The agent can then use that info in its reasoning or in its reply.

From the agent's perspective, using a tool is like calling a function in a program. The SDK makes it seamless by exposing the tool via the **Model Context Protocol (MCP)** so that the LLM knows it's available and can invoke it with a specific JSON-like syntax[69]. This avoids the brittleness of the AI guessing how to call functions. Instead, the SDK coordinates it: the LLM outputs something like a structured command, and the SDK intercepts that and calls your code. (This is akin to the "function calling' feature in OpenAI's API, if you're familiar with that.)

**Best Practices for Tool Implementation:**

- Make sure to **describe the tool clearly**. The description should help the AI know *when* to use it. For example,

- Retrieve user account info by user ID' is clear. If a user asks - What is Alice's email?", the agent will see that lookup_user could be relevant (if it has Alice's user ID or can infer it).

- **Validate inputs** in the handler. Don't assume the AI will always send perfect data; e.g., if user_id is missing or invalid, handle that (maybe return an error message that the agent can use).

- Keep tools' scope narrow. Each tool should do one thing well. Complex operations can be a combination of tool calls via the agent's planning.

- Only expose what you're comfortable the agent doing on its own. For instance, a tool that deletes databases should probably require extra confirmation or not be given at all unless absolutely needed! This is part of putting guardrails – by limiting tools, you sandbox the agent's capabilities.

After registering tools, the **agent now has "hands and feet."** When you send a user query into the session (e.g., session.SendMessageAsync(new Message(Role.User, "What's Alice's email?"));), the agent's LLM will consider using a tool. The SDK will handle the loop: if the LLM says (in essence) "use lookup_user with user_id Alice", the SDK will run our handler, get the result, and feed it back to the LLM, which will then produce the final answer ("Alice's email is alice@example.com"). All this happens with the SDK's orchestration – as developers, we don't have to write the loop, just define the pieces.

**Maintaining Context and State:** The Copilot SDK automatically keeps track of the conversation or session state. That means it remembers previous messages and tool outputs within a session[70]. If you have a multi-turn conversation, you don't need to manually concatenate the entire history each time – the SDK does it (up to model limits; it will truncate or summarize if needed). It uses techniques like *'intelligent compaction"* to manage long interactions[71].

However, for longer-term memory beyond one session, you have to implement it. For example, if you want the agent to recall something from yesterday's conversation, you might persist key info somewhere and re-introduce it via system/user messages when starting a new session. This is more application logic than SDK specifics, but it's good to design if needed.

In implementation, usually you'll call session.SendMessageAsync(new Message(Role.User, "'")) for each new user query (or event), and receive the agent's answer. The session object keeps the history. You continue using the same session for a continuous interaction or task thread. If a new, unrelated task starts, you might create a new session (so it doesn't mix contexts).

**Error Handling and Safeguards:** Even with good design, things can go wrong – a tool might throw an exception (maybe the database is down), or the AI might be confused. We should code defensively:

- **Tool errors:** In our handler, if Database.GetUserById fails or times out, catch that in the handler and return a safe error message. For instance, return "ERROR: Database timeout" (the agent can be instructed to interpret such messages and perhaps tell the user "Sorry, I can't retrieve that right now."). The SDK might also allow throwing an exception; likely it will surface to the agent as a tool failure. You want the agent to handle it gracefully, not just stall. So plan in your prompt: e.g., tell the agent "If a tool returns an error, apologize and either try an alternative or ask for help."

- **Loop limits:** Agents could theoretically get into a loop of tool usage if something's off (though the SDK has some protections). It's wise to set a max loop count or max time per session. The SDK likely has defaults to prevent infinite loops (like it won't allow more than, say, 5 back-and-forth tool calls in one go). Still, be mindful of it. In mission-critical scenarios, having a watchdog ("if agent has not produced an answer in 2 minutes, abort") is a good practice.

- **Permission for risky actions:** The Copilot SDK provides a way to intercept a tool call and ask for permission. For example, if you had a deleteUserAccount tool, you might configure it such that whenever the agent tries to call it, a callback is triggered where you (the application or an admin) must approve. In code, this could be done via events or a "permission handler" for that tool[72]. If permission is denied, you might so inform the agent's LLM (so it knows that path is blocked). In many scenarios, though, you just wouldn't give the agent such a dangerous tool at all.

- **Logging and Monitoring:** Implement logging inside your tool handlers (e.g., log "lookup_user called with X by agent at 12:00"). Also log the agent's final outputs. This is invaluable for debugging and for audit trails (especially in finance or IT ops, where later you might ask: "why did the agent reboot Server 5 last night?" ' you want logs to explain that it saw CPU 100% etc.). The SDK might have event hooks for when the agent finishes a turn or uses a tool, which you can tie into your logging. Logging helps build trust too: you can review transcripts of the agent's decisions to ensure it's doing the right things, and use them to improve the prompts or tools if needed.

To put these ideas together, let's sketch the code structure in a pseudo-language for clarity:

```python
# Initialize CopilotClient with credentials
client.start()

session = client.createSession(model="gpt-4", system_message="""You are an IT Ops agent...
- Use the tools to troubleshoot server issues.
- If unsure or on error, escalate to human.""")
# Registered tools earlier: e.g. "get_logs", "restart_server", etc.

# Simulate an incoming alert event
alert = "Server123 high CPU"
session.send(user_message=alert)

# The agent will likely call get_logs tool -> our handler runs -> returns logs.
# Agent then might call restart_server if it deduces needed.
# Eventually, agent produces an answer:
answer = session.read()  # e.g., "I have restarted Server123's web service to resolve the CPU issue."

if answer.contains("ESCALATE"):
    notify_human_team(answer.details)
else:
    log("Agent response: " + answer)
```

In reality, the SDK might use an event-driven approach (where the response comes via a callback rather than polling read()), but the idea stands. You feed input, the agent may have a multi-turn internal dialogue with tool calls, then you get an output message.

**Verifying the Base Implementation:** Once you implement the basic structure, test it with controlled inputs. For example, test the IT ops agent on a known scenario: feed it an alert that you know should cause a restart, and see if it does it. Check that it doesn't do crazy things. Tweak the system prompt or tools if needed (maybe you forgot to give it a tool to check disk space, so it kept trying something else – you might add a check_disk tool).

The common implementation patterns we've covered – session management, tool setup, context, and basic error handling – will be used in any agent you build with Copilot SDK. Code-wise, a lot of it is initialization and configuration; the heavy-lifting of reasoning is done by the AI. The next unit will explore how we adjust or extend this base for the *unique needs of each scenario.* For instance, what extra steps do we need for a conversation agent versus a batch-processing agent? What additional tools or constraints might specific domains require? We'll address those, building on the solid foundation we now have.

[64]https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/
[65]https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/
[66]https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/
[67]https://ubos.tech/news/github-copilot-sdk-launches-ai-agent-runtime-with-multi%e2%80%91language-support-and-tool-integration-for-developers/
[68]https://ubos.tech/news/github-copilot-sdk-launches-ai-agent-runtime-with-multi%e2%80%91language-support-and-tool-integration-for-developers/
[69]https://ubos.tech/news/github-copilot-sdk-launches-ai-agent-runtime-with-multi%e2%80%91language-support-and-tool-integration-for-developers/
[70]https://ubos.tech/news/github-copilot-sdk-launches-ai-agent-runtime-with-multi%e2%80%91language-support-and-tool-integration-for-developers/
[71]https://github.blog/news-insights/company-news/build-an-agent-into-any-app-with-the-github-copilot-sdk/
[72]https://deepwiki.com/github/copilot-sdk/3-sdk-architecture
