An **AI agent** is a goal-driven AI entity that can **reason, take actions, and adapt autonomously** in pursuit of an objective[1]. Unlike a simple chatbot that only responds to user queries with pre-scripted answers, an AI agent can **make decisions**, **use tools or APIs**, and **maintain memory of context** to achieve a goal without step-by-step human guidance[2][3]. In essence, *chatbots respond; AI agents act*.

## Compare Chatbots and AI Agents

A traditional **chatbot** might answer "What's my account balance?" with information from a database. An **AI agent**, on the other hand, could not only fetch your balance but also **proactively alert you** if it detects unusual spending, or even **execute tasks** like transferring funds or scheduling a meeting with your financial advisor – all based on reasoning about your goal (e.g., managing your finances) rather than just reacting to one question[4][5].

## Key Capabilities of AI Agents

Modern AI agents are powered by advanced AI models (often large language models, or LLMs) and are defined by a few core abilities that distinguish them from basic automation:

These capabilities let an AI agent operate with a degree of **independence**. The agent uses its AI **reasoning** to decide *what* needs to be done, it **acts** by calling tools or issuing commands to do it, and it **iterates** - checking outcomes and refining its plan as needed[6][7]. This loop continues until the agent's goal is accomplished or it reaches a stopping condition.

## Beyond Chatbots and Scripts

Early business automation took the form of **if/then scripts or workflows** – useful but rigid. AI agents are a step beyond: they can handle open-ended requests and unexpected situations by relying on AI planning rather than just hard-coded rules[8]. For example, if a user asks a chatbot, *'When is my next team meeting and can you book a room for it?"*, a basic bot might fail because that request spans multiple steps. An AI agent is designed to handle such multi-step goals: it could check the calendar, find the meeting time, then interface with a room-booking system to schedule a room, and confirm back – all without the user explicitly asking for each step.

In technical terms, frameworks like **ReAct** (which couples reasoning and acting) and **RAG** (Retrieval-Augmented Generation) have emerged to enable these behaviors in agents[9]. These allow an agent's LLM to both **'think' (reason internally)** and **'do' (use tools)** in a unified loop. The takeaway is that an AI agent is *not* limited to answering questions; it can be thought of as an intelligent assistant or "digital coworker" that can carry out tasks on your behalf within the scope it's given.

## When to Use AI Agents

AI agents shine in scenarios where tasks: (a) require integrating information from multiple sources or systems, (b) involve multiple steps or decisions, or (c) would benefit from automation with minimal oversight. We'll see concrete examples in a moment (customer service, sales, finance, etc.). If a task is straightforward and single-step (e.g., "show latest sales figures"), a simple query or bot may suffice. But if it's complex (e.g., "find all customers who overpaid and initiate refunds" or "monitor my servers and fix issues"), an agent is more suitable because it can handle the decision process and execution. Enterprises are increasingly looking to **autonomous digital agents** to drive productivity – indeed, industry leaders predict that by 2028, at least 15% of work decisions will be made by agentic AI systems, up from essentially 0% in 2024[10].

To summarize, AI agents combine the language understanding of chatbots with the action-oriented power of automation scripts, amplified by AI's ability to reason. In the next units, we'll explore how we can create such agents using the GitHub Copilot SDK – but first, let's introduce the SDK itself and why it's a game-changer for developers.

[1]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[2]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[3]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[4]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[5]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[6]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[7]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[8]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[9]https://www.knowi.com/blog/ai-agents-explained-how-they-differ-from-chatbots-and-workflows/
[10]https://aws.amazon.com/blogs/aws-insights/the-rise-of-autonomous-agents-what-enterprise-leaders-need-to-know-about-the-next-wave-of-ai/
