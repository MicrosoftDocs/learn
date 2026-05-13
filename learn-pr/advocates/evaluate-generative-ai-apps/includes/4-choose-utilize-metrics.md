To carry out useful evaluations, choose evaluators that match the behavior you want to measure. A single score rarely tells the whole story. In the Foundry portal, you choose from **Agent**, **Quality**, and **Safety**. In the full built-in catalog, those groups expand into more specific evaluator families so you can combine the right signals for writing quality, ground-truth comparison, retrieval quality, safety, and agent behavior.

When you analyze the right evaluator set, you gain actionable insight into where the system is succeeding and where it is failing. The interpretation of a "good" result depends on the task, the evaluator category, and the cost of the failure.

## Built-in evaluator families

| Portal group | Evaluator family | Representative evaluators | Use when | Important notes |
|---------|---------|---------|---------|---------|
|Quality|General purpose|Coherence, Fluency|You want to judge readability and logical flow independent of domain-specific ground truth|These are AI-assisted judge evaluators and require a GPT model deployment|
|Quality|Textual similarity|Similarity, F1, BLEU, GLEU, ROUGE, METEOR|You have expected answers and want to compare responses to a reference|These usually require ground truth; `Similarity` is AI-assisted, while overlap metrics are algorithmic|
|Quality|RAG|Retrieval, Document Retrieval, Groundedness, Groundedness Pro, Relevance, Response Completeness|You need to measure retrieval quality and whether the response is faithful to retrieved context|These often require context and sometimes ground truth. `Document Retrieval` uses `retrieval_ground_truth` and `retrieved_documents` and returns multiple search-quality metrics (Fidelity, NDCG, XDCG, Max Relevance, and Holes) rather than one score. `Groundedness Pro` and `Response Completeness` are preview, and `Groundedness Pro` doesn't require a judge model deployment because it uses the Azure AI Content Safety service|
|Safety|Risk and safety|Hate and Unfairness, Sexual, Violence, Self-Harm, Protected Materials, Indirect Attack (XPIA), Code Vulnerability, Ungrounded Attributes|You need to surface harmful content or security-related failure modes|These use Microsoft's hosted evaluation service and don't require a judge model deployment. The four core harm evaluators (Hate and Unfairness, Sexual, Violence, Self-Harm) return a 0-7 severity score (Very Low 0-1, Low 2-3, Medium 4-5, High 6-7) and use a default pass threshold of 3, while the remaining evaluators return a pass/fail or detected/not-detected result. Indirect Attack is supported for model targets only. Agent-specific safety evaluators such as Prohibited Actions and Sensitive Data Leakage are preview and agent-target only|
|Agent|Agent evaluators|Task Adherence, Task Completion, Intent Resolution, Task Navigation Efficiency, Tool Call Accuracy, Tool Selection, Tool Input Accuracy, Tool Output Utilization, Tool Call Success|You are evaluating tool-using agents rather than a simple prompt/response flow|These often require `tool_definitions`, tool-call traces, or an agent target. `Task Navigation Efficiency` uses `actions` and `expected_actions` instead of a normal query/response pair. Task Adherence, Task Completion, and Intent Resolution are currently preview|

In SDK workflows, Foundry also supports Azure OpenAI graders through the OpenAI Evals API. The graders are surfaced in the evaluator catalog as **Model Labeler**, **Model Scorer**, **String Checker**, and **Text Similarity**, and use the SDK type names `label_model` (LLM-based classification into predefined labels), `score_model` (LLM-based numeric scoring on a configurable range), `string_check` (deterministic exact or pattern string matching), and `text_similarity` (algorithmic similarity such as BLEU, GLEU, METEOR, ROUGE, fuzzy match, or cosine). Use these graders when you need full control over the judge prompt or deterministic string checks instead of the standard `azure_ai_evaluator` types. For details, see [Azure OpenAI graders](/azure/foundry/concepts/evaluation-evaluators/azure-openai-graders).

Before you finalize an evaluator set, verify four things: the required input fields, whether the evaluator works for dataset, model, or agent targets, whether the evaluator is preview, and whether the evaluator documentation lists language or tool-support limitations.

### General-purpose evaluators

Use coherence and fluency to check whether responses are readable and logically structured. These evaluators are useful across many scenarios, but they don't tell you whether the answer is factually correct or grounded.

### Textual similarity evaluators

Use these evaluators when you have ground-truth answers. `Similarity` is AI-assisted and is useful when paraphrases should still score well because it focuses on meaning. F1, BLEU, GLEU, METEOR, and ROUGE are algorithmic overlap metrics, which makes them better for benchmarking tasks such as translation, summarization, or fixed-answer Q&A.

### RAG evaluators

RAG applications usually need more than one evaluator. `Retrieval` and `Document Retrieval` both focus on the retrieval step, but they don't use the same schema. `Retrieval` judges whether retrieved context is relevant when you don't have search ground-truth labels. `Document Retrieval` is the evaluator for human-labeled search quality and uses `retrieval_ground_truth` plus `retrieved_documents`. `Groundedness` and `Groundedness Pro` focus on whether the response stays faithful to context; for the best `Groundedness` results, Microsoft Learn recommends providing `query`, `response`, and `context` together. `Relevance` checks whether the answer addresses the user's question, and `Response Completeness` checks whether important ground-truth information is missing.

### Risk and safety evaluators

Risk and safety evaluators measure harmful content and security-related failure modes. The core harm evaluators assign severity for hate and unfairness, sexual content, violence, and self-harm. Other evaluators detect risks such as protected material, indirect prompt injection, code vulnerabilities, and ungrounded personal attributes. If you're evaluating agents, the catalog also includes agent-specific safety evaluators such as prohibited actions and sensitive data leakage.

### Agent evaluators

Use agent evaluators when the system has to decide what task to perform, which tool to call, what parameters to send, and how to use the returned result. These evaluators help you inspect execution quality, not just answer quality. Most tool-oriented agent evaluators also need `tool_definitions`, and `Task Navigation Efficiency` needs `actions` and `expected_actions` rather than a simple query/response pair. Microsoft Learn also documents limited support for some tool types, so check the current agent evaluators article before you treat those scores as authoritative.

## Choose evaluator combinations that match your scenario

- **General chat or Q&A**: Start with coherence, fluency, and core safety evaluators.
- **Ground-truth tasks**: Add similarity or other textual similarity evaluators when you have expected answers.
- **RAG applications**: Combine retrieval, groundedness, and relevance. Add response completeness if you also have a trusted ground truth, and consider indirect attack testing (model-target evaluations only) when retrieved content could contain malicious instructions.
- **Agentic systems**: Layer agent evaluators on top of quality and safety evaluators. For agent-specific safety risks, also consider the preview `Prohibited Actions` and `Sensitive Data Leakage` evaluators, which are agent-target only.

## Read each result in the right scale

A helpful rule is to read both the normalized label and the natural score:

- **Per-item results** commonly include `label`, `score`, `threshold`, and often `reason`.
- **Judge-based quality evaluators** typically use a 1-5 scale and a pass threshold.
- **Algorithmic similarity evaluators** usually return 0-1 floats.
- **ROUGE** returns multiple values (precision, recall, and F1) rather than a single score.
- **Document Retrieval** returns multiple search-quality metrics such as Fidelity, NDCG, XDCG, Max Relevance, and Holes instead of a single score.
- **Agent evaluators** are mixed: some are pass/fail only, `Intent Resolution` and `Tool Call Accuracy` also expose 1-5 scores, and `Task Navigation Efficiency` adds precision/recall/F1-style details.
- **Core safety evaluators** (Hate and Unfairness, Sexual, Violence, Self-Harm) use a 0-7 severity scale with a default pass threshold of 3, while other safety evaluators (such as Indirect Attack, Protected Materials, Code Vulnerability, and Ungrounded Attributes) typically return a pass/fail or Boolean detected/not-detected result. Groundedness Pro, although it lives in the RAG evaluator family, also returns a binary pass/fail because it uses the Azure AI Content Safety service rather than a judge model.

Don't convert all of these into a single "quality percentage." Use the `label` for quick comparison across evaluators, but use the raw `score`, `threshold`, and `reason` to understand what the result actually means.

## Use results to drive mitigations

Once you identify a problem, use the result to guide the mitigation. For example:

- Low groundedness or relevance often points to retrieval, context construction, or prompt-instruction issues.
- High safety severity suggests you should tighten system instructions, add or revise filtering, and rerun the same dataset to confirm improvement.
- Poor similarity or response completeness might indicate missing information, weak task instructions, or an unreliable ground truth.
- Poor tool accuracy or task completion suggests the agent needs better tool descriptions, clearer instructions, or different orchestration logic.

> [!NOTE]
> Safety system messages are only one layer of protection. Microsoft Learn recommends combining them with other mitigations such as content filtering, AI red teaming where appropriate, and repeated evaluation. See [Built-in evaluators reference](/azure/foundry/concepts/built-in-evaluators), [Retrieval-Augmented Generation (RAG) evaluators](/azure/foundry/concepts/evaluation-evaluators/rag-evaluators), [Agent evaluators](/azure/foundry/concepts/evaluation-evaluators/agent-evaluators), [Risk and safety evaluators](/azure/foundry/concepts/evaluation-evaluators/risk-safety-evaluators), [Run AI Red Teaming Agent in the cloud](/azure/foundry/how-to/develop/run-ai-red-teaming-cloud), and [Safety system message templates](/azure/foundry/openai/concepts/safety-system-message-templates).
