When human evaluation is too time-consuming or expensive, you can use another LLM to evaluate your model's outputs. This approach is called **LLM-as-a-judge**, where one large language model evaluates the quality and performance of another LLM or AI system.

LLM-as-a-judge provides consistent and scalable evaluations. Unlike human evaluators who may have different opinions, an LLM judge applies the same criteria consistently across all evaluations.

## Create effective prompts for LLM-as-a-judge

LLM-as-a-judge works by giving the evaluator LLM specific instructions through a prompt template. Here's an example template that evaluates how well a system answers a user's question:

```md
You will be given a `user_question` and `system_answer` pair. Your task is to provide a 'total rating' scoring how well the `system_answer` answers the user concerns expressed in the `user_question`.

Give your answer as a float on a scale of 0 to 10, where 0 means that the `system_answer` is not helpful at all, and 10 means that the answer completely and helpfully addresses the question. 

Provide your feedback as follows: 

*Feedback*
Total rating: (your rating, as a float between 0 and 10)

Now here are the question and answer to evaluate. 

Question: {question} 
Answer: {answer} 

*Feedback* 
Total rating:
```

This template includes several key components:

- **Clear task definition**: The LLM judge knows it needs to rate how well the system answer addresses the user's question
- **Specific scoring scale**: A 0-10 float scale with clear endpoints (0 = not helpful, 10 = completely helpful)
- **Structured output format**: The "*Feedback*" and "Total rating:" format ensures consistent responses
- **Input placeholders**: {question} and {answer} variables for the actual content to evaluate

The structured approach ensures consistent evaluation and makes it easy to aggregate results across multiple samples.

To improve your LLM-as-a-judge evaluations, include few-shot examples with human-provided scores for guidance. Few-shot examples are sample question-answer pairs with their ideal scores that show the LLM judge what good evaluation looks like. Also define what "good" means for your specific metric and provide a detailed rubric or evaluation scale.

## Use MLflow for LLM-as-a-judge evaluation

MLflow provides built-in support for LLM-as-a-judge evaluation in Azure Databricks. You can use MLflow's evaluate module to implement this approach:

1. **Create evaluation records**: Define example inputs and expected outputs for your evaluation criteria
2. **Define a metric object**: Set up the evaluation framework with your examples, scoring criteria, the LLM judge, and aggregation methods
3. **Run the evaluation**: Apply your metric to evaluate models against your reference datasets

MLflow allows you to create custom metrics and run evaluations on your datasets, providing detailed performance assessments.

> [!Tip]
> Learn more about [creating custom LLM-evaluation metrics with MLflow](https://mlflow.org/docs/latest/llms/llm-evaluate/index.html#create-llm-as-judge-evaluation-metrics-category-1?azure-portal=true).

## Example LLM-as-a-judge metrics

Here are common metrics you can evaluate using LLM-as-a-judge. Each example shows how to structure the evaluation prompt with clear criteria and scoring scales:

|Metric|Definition|
|---|---|
|Relevance|Evaluate the relevance of the following response to the given query: [Query] - [Response]. Provide a score between 1 and 5, with 5 being highly relevant and 1 being not relevant at all.|
|Coherence|Assess the coherence of the following paragraph. Does it logically flow from one sentence to the next? Provide a score between 1 and 5, with 5 being highly coherent and 1 being not coherent at all.|
|Accuracy|Judge the accuracy of the following statement based on the provided context: [Context] - [Statement]. Provide a score between 1 and 5, with 5 being highly accurate and 1 being not accurate at all.|
|Fluency|Evaluate the fluency of the following text. Does it read naturally and smoothly? Provide a score between 1 and 5, with 5 being highly fluent and 1 being not fluent at all.|