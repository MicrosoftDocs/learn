Once you've implemented comprehensive tracing in your AI application, the real value comes from making informed decisions based on the trace data you collect. The trace attributes from your advanced tracing patterns provide specific signals that guide improvement decisions.

In this section, you'll learn how to:

- Recognize problematic patterns in your trace data
- Make specific improvement decisions based on trace metrics
- Set appropriate monitoring thresholds
- Measure the impact of your improvements

## Making data-driven improvement decisions

Your trace data provides specific signals that indicate when and how to improve your application. Here's how to act on the most common patterns:

### Quality improvement decisions

**When you see parsing failures** (`parsing.success: false`):

:::image type="content" source="../media/model-call-attributes.png" alt-text="Screenshot of the model catalog in the Azure AI Studio.":::

1. **Prompt engineering**: Add more specific formatting instructions to your prompts
2. **Response validation**: Implement stricter output format validation before parsing
3. **Fallback strategies**: Create backup approaches for when parsing fails
4. **Model adjustment**: Test different models that may follow formatting instructions better

**When you see low business logic success rates** (`match.success_rate` below 70%):

:::image type="content" source="../media/model-call-attributes.png" alt-text="Screenshot of the model catalog in the Azure AI Studio.":::

1. **Algorithm improvements**: Enhance matching logic based on failure patterns
2. **Data expansion**: Add more items to catalogs or databases to improve coverage
3. **User guidance**: Provide better input validation or suggestions to users
4. **Threshold adjustment**: Review if your matching criteria are too strict

### Performance optimization decisions

**When you see slow response times** (high span duration values):

:::image type="content" source="../media/model-call-attributes.png" alt-text="Screenshot of the model catalog in the Azure AI Studio.":::

1. **Model selection**: Compare response times across different models for similar tasks
2. **Prompt optimization**: Test shorter, more focused prompts to reduce processing time
3. **Caching strategies**: Implement caching for repeated requests
4. **Parallel processing**: Identify operations that can run concurrently

**When you see high token usage** (monitor costs and efficiency):

:::image type="content" source="../media/model-call-attributes.png" alt-text="Screenshot of the model catalog in the Azure AI Studio.":::

1. **Token optimization**: Reduce prompt length while maintaining quality
2. **Model right-sizing**: Use smaller models for simpler tasks
3. **Request batching**: Combine multiple small requests where possible

**When you see frequent errors** (`error.type` appearing regularly):

:::image type="content" source="../media/model-call-attributes.png" alt-text="Screenshot of the model catalog in the Azure AI Studio.":::

1. **Error handling**: Improve error recovery and retry logic
2. **Input validation**: Add better validation before calling AI models
3. **Model stability**: Consider using different models with better reliability

## Setting monitoring thresholds

Establish clear targets for your trace metrics to know when action is needed:

**Reliability targets**:
- Parsing success rate: Target >90%
- Business logic success rate: Target >70%
- Overall error rate: Target <5%

**Performance targets**:
- Response time: Set based on user experience requirements
- Token usage: Monitor costs and set budgets per session

## Measuring improvement impact

After making changes based on trace data:

1. **Before/after comparisons**: Use trace metrics to measure improvement impact
2. **A/B testing**: Compare different approaches using the same trace attributes
3. **Long-term trends**: Track whether improvements sustain over time

With systematic trace-based decision making, you can continuously improve your AI application's performance and reliability. The key is moving from reactive debugging to proactive optimization based on the specific signals your trace data provides.
