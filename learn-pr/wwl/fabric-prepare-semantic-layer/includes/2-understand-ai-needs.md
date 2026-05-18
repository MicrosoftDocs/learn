Before you can prepare your data for AI, you need to understand how AI tools consume it. Copilot in Power BI and Fabric data agents don't have inherent knowledge of your business. They rely entirely on the structure, metadata, and context you provide in your semantic models and data layers.

## How AI tools consume your data

When a user asks Copilot a question like "What were total sales last quarter?", it doesn't query your data the way a SQL developer would. Instead, Copilot follows a process called retrieval augmented generation (RAG). RAG combines two steps: first, the AI retrieves relevant context from your data environment, and then it generates a natural language response based on that context.

During the retrieval step, Copilot collects **grounding data** from your semantic model. Grounding data is the contextual information that helps the AI interpret the user's question and map it to the right tables, columns, and measures. Without good grounding data, Copilot guesses, and guesses lead to inaccurate answers.

The grounding process works as follows:

1. The user submits a prompt (written question or button selection).
1. Copilot preprocesses the prompt by collecting grounding data from the semantic model schema, linguistic schema, descriptions, and other metadata.
1. Copilot sends the augmented prompt and grounding data to Azure OpenAI.
1. Azure OpenAI generates a response based on the provided context.
1. Copilot postprocesses the response, applies responsible AI filters, and returns the output to the user.

This process means that the quality of AI output depends on the quality of the grounding data you provide. If your model has clear names, complete descriptions, and well-defined relationships, the AI has strong context. If your model has cryptic abbreviations and missing metadata, the AI lacks the context it needs.

> [!NOTE]
> Copilot in Fabric is nondeterministic. It doesn't always produce the exact same response, even with the same input or prompt. Preparing your data reduces ambiguity but can't guarantee a specific output every time.

## What AI consumes from your semantic model

During the grounding step, Copilot and other AI tools collect specific elements from your semantic model. Understanding what gets consumed helps you prioritize what to improve.

| Element | What AI uses it for |
|---------|-------------------|
| **Table names** | Identifies which business entities are available (Customers, Products, Sales) |
| **Column names** | Maps user questions to specific data fields |
| **Relationships** | Understands how tables connect so it can join data correctly |
| **Measure definitions** | Identifies calculated metrics like Total Sales or Profit Margin |
| **Descriptions** | Gains business context for tables, columns, and measures |
| **Data types and format strings** | Understands how to display and interpret values |
| **Linguistic schema** | Uses synonyms and relationships to interpret varied user terminology |
| **Data category** | Identifies geographic, URL, or image data for appropriate handling |

Hidden columns and measures are **excluded** from what Copilot sees. Tables marked as private are also excluded. This means hiding a field removes it from AI consideration entirely.

Copilot also performs **schema reduction** during preprocessing. When a model has many tables and columns, Copilot tries to restrict the context to what's most relevant to the user's question. A model with fewer, well-organized tables and clearly named fields makes schema reduction more effective. A cluttered model with dozens of technical columns forces Copilot to make more assumptions about which fields matter.

## How model complexity affects AI

The more complex your model is, the more likely Copilot experiences difficulties. Complex patterns like currency conversion tables, disconnected tables (such as field parameters), and calculation groups can produce unexpected results when users reference them in prompts.

Common complexity issues include:

- **Duplicate field names.** If `Name` exists in both the `Customer` table and the `Store` table, Copilot might choose the wrong one. Always qualify field names to avoid ambiguity.
- **Complex DAX patterns.** Measures with deeply nested calculations or uncommon patterns are harder for AI to interpret and explain correctly.
- **Implicit measures.** Copilot might create its own aggregations when a user asks about a column that doesn't have an explicit measure. These implicit calculations might not match your business logic.

For models with high complexity, test thoroughly with Copilot to identify specific areas where AI responses are inconsistent. You might need to simplify certain patterns or provide additional AI instructions to guide interpretation.

## Why metadata matters for AI

AI doesn't "know" your business. It can only work with what you explicitly provide. Consider these two measure names:

- `SM_Rev_Q` — What does this mean? The AI can't determine this is "Sales Margin Revenue Quarterly."
- `Sales margin (quarterly)` — Clear, self-describing, and immediately interpretable.

The same principle applies to descriptions. A measure called `Total Sales` with no description leaves the AI to infer meaning from the name alone. A measure called `Total Sales` with the description "Sum of all completed transactions in USD, excluding returns and refunds" gives the AI precise business context.

Every piece of metadata you add reduces ambiguity for the AI. Naming conventions, descriptions, and relationships together form the **grounding surface** that AI tools use to interpret questions and generate accurate answers.

## Where your work fits in the AI value chain

Your semantic model sits at a critical point in the AI value chain. Upstream, data engineers ingest and transform raw data. Downstream, Copilot and AI agents serve business users with natural language answers. The semantic model provides the structure and context that connects these layers.

Clear table structures, descriptive measure definitions, and consistent naming improve the quality of AI interactions. Effective semantic model design supports both traditional reporting requirements and AI consumption patterns.

The following units help you apply this understanding to specific design and configuration tasks that make your semantic models AI-ready.
