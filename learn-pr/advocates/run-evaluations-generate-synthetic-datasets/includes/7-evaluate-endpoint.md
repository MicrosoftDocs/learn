If you have a dataset of user queries but not precomputed responses, `evaluate()` also accepts a `target` callable. The SDK sends each row to that callable, captures the application's output, and then runs the selected evaluators on the generated query/response pair. A target can be a regular Python function or any object that implements `__call__`. Use the `evaluator_config` parameter to map the target's output columns (for example, `${target.response}`) to the inputs each evaluator expects.

## Scenario

An Ask Wiki app is provided that uses the Wikipedia API to answer questions by using information available in Wikipedia articles.

## Instructions

In this exercise, you assess the relevance of the chatbot's responses given a query. Open the `evaluate-target.ipynb` file to get started.

For more information about target-based evaluation and column mapping, see [Evaluate your generative AI application locally with the Azure AI Evaluation SDK](/azure/foundry-classic/how-to/develop/evaluate-sdk#local-evaluation-on-a-target).
