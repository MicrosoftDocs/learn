Performance and quality metrics help you determine whether a response is well written, relevant to the user's request, grounded in retrieved context, or close to an expected answer. In the Azure AI Evaluation SDK, the metrics in this exercise span three groups: general-purpose evaluators, retrieval-augmented generation (RAG) evaluators, and textual-similarity evaluators.

## Scenario

Contoso Home Furnishings is developing an app that generates product descriptions for their selection of furniture. The app aims to generate engaging product descriptions based on the manufacturer's specification of the furniture.

## Instructions

In this exercise, you evaluate the model output for the generated product description using performance and quality metrics. Open the `evaluate-performance-quality.ipynb` file to get started. At the top-right of the notebook, for **Select Kernel** choose **Python 3.11** or newer.

## Metrics

> [!TIP]
> In this workshop, the AI-assisted evaluators use the Azure OpenAI deployment that you created in `model_config`. The algorithmic textual-similarity metrics (`F1Score`, `BLEU`, `GLEU`, `ROUGE`, and `METEOR`) don't require a judge model deployment.

### General-purpose evaluators

| Metric | What it measures | Typical inputs | Output |
|---------|---------|---------|---------|
| Coherence | Whether the response is logically organized and easy to follow. | `query`, `response` | 1-5 Likert score |
| Fluency | Grammar, readability, and how natural the text sounds. | `response` | 1-5 Likert score |

### RAG evaluators

| Metric | What it measures | Typical inputs | Output |
|---------|---------|---------|---------|
| Groundedness | Whether the response is supported by the supplied context instead of fabricating unsupported claims. | `response`, `context` (`query` is optional but helpful) | 1-5 Likert score |
| Groundedness Pro | A stricter, service-based groundedness check that uses the Azure AI Foundry Evaluation service (backed by Azure AI Content Safety) and a fine-tuned model. | `query`, `response`, `context` | Boolean (`True` = grounded). The aggregated metric is reported as `groundedness_pro_passing_rate`. |
| Relevance | Whether the response directly answers the user's query. | `query`, `response` | 1-5 Likert score |
| Retrieval | How relevant the retrieved context (typically the chunks returned from your RAG retriever) is to the query, judged independently of the final answer. | `query`, `context` | 1-5 Likert score |

### Textual-similarity evaluators

| Metric | What it measures | Typical inputs | Output |
|---------|---------|---------|---------|
| Similarity | Semantic similarity between the response and the ground truth, with the query used as context. | `query`, `response`, `ground_truth` | 1-5 Likert score |
| F1 Score | Shared-token precision and recall between the response and the ground truth. | `response`, `ground_truth` | 0-1 float |
| ROUGE | Recall-oriented n-gram overlap, often used for summarization. Requires a `rouge_type` parameter (set with the `RougeType` enum, for example `RougeType.ROUGE_1`, `RougeType.ROUGE_2`, `RougeType.ROUGE_L`) and returns three separate 0-1 float scores: precision, recall, and F1. | `response`, `ground_truth` | Three 0-1 floats (precision, recall, F1) |
| BLEU | N-gram overlap between the response and the ground truth, commonly used for translation-style tasks. | `response`, `ground_truth` | 0-1 float |
| METEOR | Text similarity that also considers stemming, synonyms, and paraphrase-friendly alignment. | `response`, `ground_truth` | 0-1 float |
| GLEU | Sentence-level BLEU variant that balances precision and recall across n-grams. | `response`, `ground_truth` | 0-1 float |

### Composite quality evaluator

If you want to run several quality evaluators together against the same query and response, the SDK also ships a composite evaluator:

| Evaluator | What it bundles |
|---------|---------|
| `QAEvaluator` | Runs `GroundednessEvaluator`, `RelevanceEvaluator`, `CoherenceEvaluator`, `FluencyEvaluator`, `SimilarityEvaluator`, and `F1ScoreEvaluator` and returns the combined quality metrics for one query/response/context/ground-truth row. Because it includes the AI-assisted evaluators, it also requires `model_config`. |

For the full reference, see [Built-in evaluators reference](/azure/foundry/concepts/built-in-evaluators), [General purpose evaluators](/azure/foundry/concepts/evaluation-evaluators/general-purpose-evaluators), [RAG evaluators](/azure/foundry/concepts/evaluation-evaluators/rag-evaluators), and [Textual similarity evaluators](/azure/foundry/concepts/evaluation-evaluators/textual-similarity-evaluators).
