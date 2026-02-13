Before deploying a model, you want to understand how it performs across different dimensions. Model benchmarks provide objective, measurable data to help you compare models and make informed selection decisions. The Microsoft Foundry portal offers comprehensive benchmarking tools organized into quality, safety, cost, and performance metrics.

## Access model benchmarks

You can explore benchmarks in two ways within the Microsoft Foundry portal:

From the **model catalog**, select **Browse leaderboards** to see comparative rankings across all available models. This view helps you identify top-performing models for specific metrics or scenarios.

For detailed benchmarks on a specific model, open its model card and select the **Benchmarks** tab. This view shows how the individual model performs across various metrics and datasets, with comparison charts placing it relative to similar models.

## Quality benchmarks

Quality benchmarks assess how well a model generates accurate, coherent, and contextually appropriate responses. These metrics use public datasets and standardized evaluation methods to ensure consistency.

**Accuracy** measures whether model-generated text matches correct answers according to the dataset. The result is binary: one if the generated text matches exactly, zero otherwise. High accuracy indicates the model reliably produces correct factual responses.

**Coherence** evaluates whether model output flows smoothly and resembles human-like language. A coherent response maintains logical structure and clear relationships between ideas, making it easy for users to follow and understand.

**Fluency** assesses grammatical correctness, syntactic structure, and appropriate vocabulary usage. Fluent responses sound natural and linguistically correct, avoiding awkward phrasing or grammatical errors.

**GPT similarity** quantifies semantic similarity between ground truth sentences and model predictions. This metric considers meaning rather than exact wording, allowing for paraphrasing while penalizing responses that miss key concepts.

Additional NLP metrics you might encounter include:
- **BLEU** (Bilingual Evaluation Understudy) - commonly used for translation tasks
- **METEOR** (Metric for Evaluation of Translation with Explicit Ordering) - accounts for synonyms and paraphrasing
- **ROUGE** (Recall-Oriented Understudy for Gisting Evaluation) - emphasizes recall for summarization tasks
- **F1-score** - measures shared words between generated and ground truth answers

:::image type="content" source="../media/model-benchmarks.png" alt-text="Screenshot of model benchmarks in Microsoft Foundry portal." lightbox="../media/model-benchmarks.png":::

## Safety and risk benchmarks

Safety metrics ensure models don't generate harmful, biased, or inappropriate content. These benchmarks are crucial for applications exposed to end users, especially in regulated industries or customer-facing scenarios.

Microsoft Foundry evaluates models across multiple safety dimensions:

**Content harm defect rate** measures the percentage of instances where output exceeds a severity threshold (default is Medium) for categories including:
- Self-harm-related content
- Hateful and unfair content
- Violent content
- Sexual content

**Protected material** detection identifies whether models reproduce copyrighted or proprietary content. The defect rate calculates the percentage of instances where output contains protected material.

**Indirect attack** (jailbreak) resistance measures how well models maintain safety guardrails when users attempt to manipulate them into generating harmful content through indirect prompting techniques.

## Cost benchmarks

Understanding the financial impact of model usage helps you balance quality requirements with budget constraints. Cost benchmarks in Microsoft Foundry display pricing for serverless API deployments and Azure OpenAI models.

**Cost per input tokens** shows the price for processing 1 million input tokens (the text you send to the model).

**Cost per output tokens** indicates the price for generating 1 million output tokens (the text the model produces).

**Estimated cost** combines input and output costs using a typical 3:1 ratio (three input tokens for every output token), giving you a single number for comparison. Lower values indicate more cost-effective models.

Cost benchmarks help you identify models that deliver the quality you need at a price point that fits your application's usage patterns and budget.

## Performance benchmarks

Performance metrics measure how quickly and efficiently models respond to requests. These benchmarks matter for real-time applications where user experience depends on responsiveness.

**Latency** measurements include:
- **Latency mean** - average time in seconds to process a request
- **Latency P50** (median) - 50% of requests complete faster than this time
- **Latency P90** - 90% of requests complete faster than this time
- **Latency P95** - 95% of requests complete faster than this time
- **Latency P99** - 99% of requests complete faster than this time
- **Time to first token (TTFT)** - time until the first token arrives when using streaming

**Throughput** measurements include:
- **Generated tokens per second (GTPS)** - output tokens generated per second
- **Total tokens per second (TTPS)** - combined input and output tokens processed per second
- **Time between tokens** - interval between receiving consecutive tokens

High-throughput, low-latency models provide better user experiences in interactive applications. For batch processing jobs where speed matters less than cost, you can prioritize other factors.

## Use leaderboards and comparison charts

The **Browse leaderboards** feature lets you view top models for specific metrics. You can filter leaderboards by scenario (such as question answering or summarization) to find models optimized for your use case.

**Trade-off charts** display two metrics simultaneously, such as quality versus cost or latency versus throughput. These visualizations help you find the optimal balance for your requirements. A model that's slightly less accurate but significantly faster or cheaper might better serve your needs.

**Comparison tables** show detailed results for each metric across multiple models, making it easy to see exact numbers and compare candidates side by side.

## Evaluate with your own data

While public benchmark results provide valuable guidance, you can also evaluate models using your own test data. From a model's **Benchmarks** tab, select **Try with your own data** to run evaluations on scenarios specific to your application.

This custom evaluation uses your own prompts, expected responses, and evaluation criteria. The results show how the model performs on your actual use case, complementing the public benchmark data with application-specific insights.

By combining public benchmarks with custom testing, you gather the evidence needed to select a model confidently. You understand not only how a model performs generally, but specifically how well it addresses your unique requirements for quality, safety, cost, and performance.
