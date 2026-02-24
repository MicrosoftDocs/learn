
You've built a knowledge base and optimized how content gets indexed. Now comes the critical step: configuring how agents retrieve and use that knowledge.

This is where many implementations fail. You can have perfectly indexed content with excellent semantic ranking, but if your agent doesn't know when or how to use the knowledge base, users get inconsistent results.

## The retrieval behavior problem

Consider what happens without proper configuration. You ask your agent "What's our vacation policy?" Three different behaviors might occur:

| Behavior | Example Response | Problem |
|----------|-----------------|---------|
| **Answers from training data** | "Most companies offer 2-3 weeks of vacation annually" | Generic information, not your actual policy |
| **Searches but doesn't cite** | "You get 15 days of PTO annually" | Correct but unverifiable, no accountability |
| **Searches, cites, and grounds** | "You receive 15 days of paid time off annually【doc_id:1†Employee Handbook 2024】" | ✓ This is what you want |

Only the third behavior is acceptable for enterprise agents. The first provides wrong information. The second lacks accountability. You need agents that consistently retrieve, cite, and stay grounded in your knowledge base.

## Controlling retrieval with instructions

Agent instructions determine retrieval behavior. Think of them as the contract between you and the agent about how it should use knowledge bases.

Here's a basic approach that produces inconsistent results:

```python
agent = project_client.agents.create_version(
    agent_name="hr-assistant",
    definition=PromptAgentDefinition(
        model="gpt-4o-mini",
        instructions="Answer HR questions using the knowledge base.",
        tools=[knowledge_tool]
    )
)
```

This instruction is too vague. "Using the knowledge base" doesn't specify *when* to use it or *how* to present results. The agent might search or might not. It might cite sources or might not.

### Writing effective retrieval instructions

Effective instructions specify three critical behaviors:

1. **When to retrieve**: Tell the agent to always use the knowledge base, never rely on training data
2. **How to cite**: Specify the exact format for source attribution
3. **What to do when unsure**: Define fallback behavior when information isn't found

Here's how this looks in practice:

```python
retrieval_instructions = """You are a helpful HR assistant.

CRITICAL RULES:
- You must ALWAYS search the knowledge base before answering any question
- You must NEVER answer from your own knowledge or training data
- Every answer must include citations in this format: 【doc_id:search_id†source_name】
- If the knowledge base doesn't contain the answer, respond with "I don't have that information in our current documentation. Please contact HR directly at hr@company.com"

Your role is to provide accurate, verifiable information from company documentation."""

agent = project_client.agents.create_version(
    agent_name="hr-assistant",
    definition=PromptAgentDefinition(
        model="gpt-4o-mini",
        instructions=retrieval_instructions,
        tools=[knowledge_tool]
    )
)
```

These instructions create consistent behavior. The agent knows exactly when to search, how to format responses, and what to do when information isn't available.

## Testing retrieval behavior

Instructions alone aren't enough. You need to verify that agents actually behave as configured. This requires systematic testing with different query types.

### Setting up a test conversation

Create a conversation session and send test queries:

```python
openai_client = project_client.get_openai_client()
conversation = openai_client.conversations.create()

# Test query that should trigger retrieval
response = openai_client.responses.create(
    conversation=conversation.id,
    input="How many vacation days do I get?",
    extra_body={"agent": {"name": agent.name, "type": "agent_reference"}}
)

print(response.output_text)
```

### What to test

Your test queries should cover different retrieval scenarios:

| Query Type | Example Questions | Expected Behavior |
|------------|------------------|-------------------|
| **Straightforward factual** | "What is our vacation policy?"<br>"Where can I find the security guidelines?" | Direct retrieval with citations |
| **Questions requiring synthesis** | "What are the differences between our leave types?"<br>"How do I request time off?" | Multiple document retrieval, synthesized answer with multiple citations |
| **Questions outside knowledge base** | "What's the weather like today?"<br>"Tell me about machine learning" | Graceful fallback ("I don't have that information...") |
| **Ambiguous questions** | "What about benefits?"<br>"Tell me more about that" | Clarifying questions or focused search on most relevant topic |

### Evaluating response quality

Good responses demonstrate four characteristics:

1. **Grounding** - Information comes from knowledge base, not training data
2. **Citation** - Every factual claim includes source references
3. **Relevance** - Retrieved content actually answers the question
4. **Completeness** - All necessary information is provided, not just fragments

When you find responses that don't meet these criteria, adjust your instructions. Add more specific rules. Clarify edge cases. Iterate until behavior becomes consistent.

## Retrieval strategies for different agent types

Different agent purposes require different retrieval approaches. A customer support agent needs different behavior than an internal research assistant.

### Customer-facing support agents

These agents need high accuracy and must never provide uncertain information:

```python
support_instructions = """You provide customer support using our product documentation.

Rules:
- Search the knowledge base for every product question
- Cite documentation for all technical answers
- If documentation doesn't cover a question, say "Let me connect you with a specialist" rather than guessing
- Focus on official product information, not general knowledge"""
```

### Internal research assistants

These agents can synthesize across documents and provide broader context:

```python
research_instructions = """You help employees research topics across company documentation.

Rules:
- Search all relevant knowledge bases for comprehensive answers
- Synthesize information from multiple sources when helpful
- Always cite all sources used
- Indicate confidence level when synthesizing across documents
- Suggest related topics that might be useful"""
```

### Specialized domain experts

These agents focus deeply on specific knowledge domains:

```python
compliance_instructions = """You are a compliance documentation assistant.

Rules:
- Only answer questions about compliance policies and procedures
- Always cite the specific policy document and section
- If a question involves interpretation or legal advice, refer to the compliance team
- Keep answers strictly factual based on written policies
- Note the effective date of any policy you reference"""
```

The pattern is consistent: define the agent's scope, specify retrieval requirements, establish citation standards, and handle edge cases explicitly.

## Moving from testing to production

Once your test queries produce consistent, high-quality results, you're ready to deploy. But production introduces new challenges.

Monitor actual usage patterns. Users ask questions differently than your test scenarios. Some questions hit edge cases you didn't anticipate. Others reveal gaps in your knowledge base content.

Track these patterns:

- **Citation frequency** - Are agents consistently citing sources?
- **Fallback frequency** - How often do agents say "I don't know"?
- **Query types** - What categories of questions appear most often?
- **Retrieval accuracy** - Do retrieved documents actually contain answers?

Use this data to refine instructions, improve knowledge base content, and adjust search configurations. Retrieval quality improves through iteration based on real-world usage.

The combination of clear instructions, systematic testing, and ongoing monitoring creates reliable knowledge retrieval that scales across your organization's agents.
