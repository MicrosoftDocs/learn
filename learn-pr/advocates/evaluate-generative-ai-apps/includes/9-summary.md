Evaluating generative AI applications requires more than a single score. You need representative data, the right evaluator mix, and a disciplined way to interpret the results. Microsoft Foundry supports portal and SDK-based evaluation workflows, while the built-in evaluator catalog helps you assess writing quality, similarity to ground truth, RAG behavior, safety, and agent behavior.

The most effective evaluation practice combines automated runs with targeted human review. Use real-world data when possible, supplement it with synthetic data when coverage is limited, use AI red teaming or other adversarial testing when you need to probe safety and security risks, and compare runs against a stable baseline before you decide a change improved the system.

Before you operationalize the workflow, confirm each evaluator's required inputs, target support, preview status, and region support in current Microsoft Learn guidance. That check matters most for cloud evaluation, safety and red-team workflows, custom evaluators, graders, and some agent-focused evaluators.

Once you have results, translate them into action. Improve retrieval when groundedness or relevance is weak, strengthen safety instructions and filtering when harm evaluators surface risk, and add custom evaluators when your business criteria go beyond the built-in catalog.

### Learn more

- [Run evaluations from the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-generative-ai-app)
- [Run evaluations in the cloud by using the Microsoft Foundry SDK](/azure/foundry/how-to/develop/cloud-evaluation)
- [Built-in evaluators reference](/azure/foundry/concepts/built-in-evaluators)
- [Retrieval-Augmented Generation (RAG) evaluators](/azure/foundry/concepts/evaluation-evaluators/rag-evaluators)
- [Agent evaluators](/azure/foundry/concepts/evaluation-evaluators/agent-evaluators)
- [Azure OpenAI graders](/azure/foundry/concepts/evaluation-evaluators/azure-openai-graders)
- [Custom evaluators](/azure/foundry/concepts/evaluation-evaluators/custom-evaluators)
- [Risk and safety evaluators](/azure/foundry/concepts/evaluation-evaluators/risk-safety-evaluators)
- [Run AI Red Teaming Agent in the cloud](/azure/foundry/how-to/develop/run-ai-red-teaming-cloud)
- [View evaluation results in the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-results)
- [Rate limits, region support, and enterprise features for evaluation](/azure/foundry/concepts/evaluation-regions-limits-virtual-network)
