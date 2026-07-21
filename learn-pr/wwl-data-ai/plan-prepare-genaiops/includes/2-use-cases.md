The Adventure Works team is tempted to open a chat playground and start writing prompts. But a vague idea like *"an agent that helps shoppers"* leads to endless rework: every reviewer imagines a different agent, and no one can agree on when it's *good enough* to launch.

Instead, they write an **agent specification** first. Think of it as the blueprint, or job description, for your agent. It captures what the agent does, how it behaves, and how you know it works, before a single line of code is written.

A complete specification answers five questions, each building on the one before.

:::image type="content" source="../media/agent-spec-five-elements-flow.png" alt-text="Diagram that shows an agent specification made up of five elements: user intent, suggested prompts, capabilities, evaluation, and test data.":::

The team works through them in order, from why the agent exists to how they'll prove it works. Consider how each applies to your own use case as you read.

## User intent

Start with *why the agent exists*: capture the agent's **job description**, its **target audience**, and the **pain points** it addresses.

:::image type="content" source="../media/user-intent.png" alt-text="Diagram that shows the three parts of user intent: job description, target audience, and pain points.":::

For Adventure Works, the agent's job is to recommend gear to website shoppers, who are often outdoor beginners overwhelmed by dozens of similar products. Naming the audience keeps the tone and reading level appropriate.

## Suggested prompts

Next, decide how people interact with the agent.

:::image type="content" source="../media/suggested-prompts.png" alt-text="Diagram that shows the two parts of suggested prompts: display prompt and command prompt.":::

The **display prompt** is the example question a shopper sees and can click, such as *"Which tent should I buy for winter camping?"* The **command prompt** is the underlying instruction that tells the agent how to behave. Writing these together keeps what the user expects aligned with what the agent actually does.

## Capabilities

Now define what the agent can and can't do.

:::image type="content" source="../media/capabilities.png" alt-text="Diagram that shows the three parts of capabilities: primary functions, tools and data, and restrictions.":::

List its **primary functions** (recommend products, compare two items), the **tools and data access** it needs (the product catalog through a Foundry IQ knowledge base, purchase history in Cosmos DB), and its **restrictions**. Restrictions matter: the Adventure Works agent must never invent discounts or give safety advice it can't ground in real data.

## Evaluation

Decide how you judge quality *before* you build.

:::image type="content" source="../media/evaluation.png" alt-text="Diagram that shows the two parts of evaluation: a rubric scoring relevance, groundedness, tone, and safety, and shadow rating.":::

A **rubric** is a scoring guide: a set of named criteria, each with a description of what a good answer looks like, so different reviewers grade the same response the same way. For the Adventure Works agent, the rubric scores each answer on relevance, groundedness, and friendly tone. **Shadow rating** runs the agent silently alongside human support staff so you can compare answers without risking a live customer.

## Test data

Finally, prepare the data that proves the agent works.

:::image type="content" source="../media/test-data.png" alt-text="Diagram that shows the three parts of test data: smoke tests, automated evaluation, and coverage mix.":::

**Smoke tests** are a short, quick check you run after every small update, like *"Do you sell waterproof jackets?"* with a known good answer. Because they're fast, you can run them constantly to catch obvious breakage right away. Before a bigger change, you run a full **automated evaluation** first: a larger dataset that scores the agent at scale.

To trust those scores, use a deliberate **coverage mix**. This means choosing test questions that reflect the full range of real use, not just the easy ones. Include the common questions shoppers ask every day, along with rare edge cases like ambiguous requests, out-of-stock items, or questions the agent should refuse. A good coverage mix keeps a high score from hiding failures that only show up in the situations you forgot to test.

With this specification in hand, the Adventure Works team can now make design choices, like which model to use, with clear targets to aim for.
