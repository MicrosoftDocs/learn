During production, you want to optimize and deploy your flow. Finally, you want to monitor your flows to understand when improving your flows is necessary.

You can optimize your flow by using **variants**, you can deploy your flow to an **endpoint**, and you can monitor your flow by evaluating key metrics.

## Explore variants

Prompt flow **variants** are versions of a tool node with distinct settings. Currently, variants are only supported in the LLM tool, where a variant can represent a different prompt content or connection setting. Variants allow users to customize their approach for specific tasks, like, summarizing news articles.

Some benefits of using variants are:

- **Enhance the quality of your LLM generation**: Creating diverse variants of an LLM node helps find the best prompt and settings for high-quality content.
- **Save time and effort**: Variants allow for easy management and comparison of different prompt versions, streamlining historical tracking and reducing the effort in prompt tuning.
- **Boost productivity**: They simplify the optimization of LLM nodes, enabling quicker creation and management of variations, leading to better results in less time.
- **Facilitate easy comparison**: Variants enable side-by-side result comparisons, aiding in choosing the most effective variant based on data-driven decisions.

## Deploy your flow to an endpoint

When you're satisfied with the performance of your flow, you can choose to deploy it to an **online endpoint**. Endpoints are URLs that you can call from any application. When you make an API call to an online endpoint, you can expect (almost) immediate response.

When you deploy your flow to an online endpoint, prompt flow generates a URL and key so you can safely integrate your flow with other applications or business processes. When you invoke the endpoint, a flow is run and the output is returned in real-time. As a result, deploying flows to endpoints can for example generate chat or copilot responses that you want to return in another application.

## Monitor evaluation metrics

In prompt flow, monitoring evaluation metrics is key to understanding your LLM application's performance, ensuring they meet real-world expectations and deliver accurate results.

To understand whether your application is meeting practical needs, you can collect end-user feedback and assess the application's usefulness. Another approach to understanding whether your application is performing well, is by comparing LLM predictions with expected or *ground truth* responses to gauge accuracy and relevance. Evaluating the LLM's predictions is crucial for keeping LLM applications reliable and effective.

### Metrics

The key metrics used for monitoring evaluation in prompt flow each offer unique insight into the performance of LLMs:

- ***Groundedness***: Measures alignment of the LLM application's output with the input source or database.
- ***Relevance***: Assesses how pertinent the LLM application's output is to the given input.
- ***Coherence***: Evaluates the logical flow and readability of the LLM application's text.
- ***Fluency***: Assesses the grammatical and linguistic accuracy of the LLM application's output.
- ***Similarity***: Quantifies the contextual and semantic match between the LLM application's output and the ground truth.

Metrics like *groundedness*, *relevance*, *coherence*, *fluency*, and *similarity* are key for quality assurance, ensuring that interactions with your LLM applications are accurate and effective. Whenever your LLM application doesn't perform as expected, you need to revert back to experimentation to iteratively explore how to improve your flow.
