The *web_search* tool enables your model to retrieve fresh information from the web while generating a response.

## What is the web_search tool?

The web_search tool gives a generative AI model access to current, external information at runtime. Instead of relying only on training data, the model can issue a search query, review relevant sources, and produce an answer grounded in up-to-date content.

This is especially useful when facts may change frequently, such as pricing, product releases, policy updates, or current events.

Key features include:

- **Live information retrieval** - Get recent information not available in static model training data
- **Source-grounded responses** - Build answers from retrieved web content
- **Reduced hallucination risk** - Improve reliability by checking external sources
- **Automatic query generation** - The model decides when and how to search based on user intent
- **Seamless user experience** - Search and response generation happen in one flow

## Common Use Cases

| Use Case | Example |
|----------|---------|
| **Current Events** | Summarize key updates on a breaking technology announcement |
| **Market Research** | Compare recent product features or pricing across vendors |
| **Policy Monitoring** | Check whether regulations or guidance have changed |
| **Fact Verification** | Validate claims against reputable public sources |

## A simple example

Here's a minimal example using the OpenAI Responses API with web search enabled:

```python
from openai import OpenAI

client = OpenAI(
    base_url={openai_endpoint},
    api_key={auth_key_or_token}
)

# Get response using the web_search tool
response = client.responses.create(
    model={model_deployment},
    instructions="You are an AI assistant. Use web search when current information is required.",
    input="What are three major announcements from Microsoft Build this week?",
    tools=[{"type": "web_search_preview"}]
)

print(response.output_text)
```

The output will vary based on current web results, but it should include a concise answer grounded in recent sources.

> [!NOTE]
> When using the web_search tool with Microsoft Foundry, use the name *web_search_preview*.

## How the web_search tool works

The general process for using the web_search tool is:

1. **You send a request** - Include a web search tool in the tools array.
2. **Model evaluates the question** - It decides whether fresh web data is needed.
3. **Search is performed** - The model issues one or more search queries.
4. **Results are reviewed** - Relevant pages are selected and summarized.
5. **Response is generated** - The model combines search findings into the final answer.

## Best Practices

- **Ask time-aware questions clearly** - Include words like "latest", "current", or date ranges when needed
- **Set expectations for sources** - Prompt for reputable or official sources when accuracy matters
- **Request concise outputs** - Ask for short summaries with key points to reduce noise
- **Verify critical facts** - For high-stakes scenarios, independently validate important claims
- **Track usage and latency** - Web retrieval can increase response time and token usage

## Limitations to know about

- Results depend on what is publicly available and indexable at query time
- Source quality can vary, so output may still require human review
- Retrieved content may change over time, so repeated runs can produce different answers
- Some environments may apply regional, policy, or network restrictions to web access

Used well, web_search helps your model move from static knowledge to timely, source-aware answers that are more useful in real-world workflows.
