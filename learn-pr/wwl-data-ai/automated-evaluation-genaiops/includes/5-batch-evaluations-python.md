Batch evaluation enables systematic quality assessment by running multiple evaluators across entire test datasets, providing comprehensive metrics and identifying patterns in system performance.

In the Adventure Works scenario, the team needs to evaluate 500 test examples against multiple criteria (trail accuracy, safety information, response helpfulness) to compare GPT-4 and GPT-4 mini performance. Running evaluations manually or individually takes hours. Batch evaluation with Python scripts completes this work in minutes, enabling quick, objective model comparison.

Here, you learn how to implement batch evaluations using Python scripts with Microsoft Foundry, process evaluation results systematically, and interpret metrics to guide quality improvements.

| Batch Evaluation Component | Purpose | Implementation |
|----------------------------|---------|----------------|
| Test data loading | Prepare inputs for evaluation | Read JSONL, CSV, or Parquet files |
| Model inference | Generate responses to evaluate | Azure AI Foundry SDK batch inference |
| Evaluator execution | Score generated responses | Apply multiple evaluators in parallel |
| Results aggregation | Summarize evaluation metrics | Calculate statistics, identify patterns |

## Set up the Azure AI Foundry SDK for evaluation

Microsoft Foundry provides Python SDK capabilities for both generating responses and running evaluations programmatically. Setting up the SDK requires authentication and configuration of your Foundry project.

**Install required packages**:

```bash
pip install azure-ai-inference azure-ai-evaluation azure-identity
```

**Configure authentication and project connection**:

```python
from azure.ai.inference import ChatCompletionsClient
from azure.ai.evaluation import evaluate
from azure.identity import DefaultAzureCredential
import os

# Set up authentication
credential = DefaultAzureCredential()

# Configure Foundry project
project_config = {
    'subscription_id': os.getenv('AZURE_SUBSCRIPTION_ID'),
    'resource_group': os.getenv('AZURE_RESOURCE_GROUP'),
    'project_name': os.getenv('FOUNDRY_PROJECT_NAME')
}

# Initialize inference client
inference_client = ChatCompletionsClient(
    endpoint=os.getenv('AZURE_INFERENCE_ENDPOINT'),
    credential=credential
)
```

> [!NOTE]
> Use environment variables or Azure Key Vault for credentials rather than hardcoding values. This keeps secrets secure and enables configuration across environments.

## Load and prepare test datasets

Batch evaluation requires loading your test dataset and structuring it for systematic processing. Common formats include JSONL (JSON Lines), CSV, or Parquet.

**Load test data from JSONL**:

```python
import json
import pandas as pd

def load_test_data(file_path: str) -> pd.DataFrame:
    """Load test dataset from JSONL file"""
    test_examples = []
    
    with open(file_path, 'r') as f:
        for line in f:
            example = json.loads(line)
            test_examples.append(example)
    
    return pd.DataFrame(test_examples)

# Load test dataset
test_df = load_test_data('data/test_dataset_v1.1.jsonl')
print(f"Loaded {len(test_df)} test examples")
```

**Prepare data structure for evaluation**:

```python
# Ensure required fields exist
required_fields = ['id', 'query', 'category']
missing_fields = [field for field in required_fields if field not in test_df.columns]

if missing_fields:
    raise ValueError(f"Test data missing required fields: {missing_fields}")

# Add optional fields with defaults
if 'context' not in test_df.columns:
    test_df['context'] = None

if 'ground_truth' not in test_df.columns:
    test_df['ground_truth'] = None

print(test_df.head())
```

**Example test data structure**:

```json
{"id": "trail_001", "query": "What are good day hikes for beginners?", "context": "Customer is new to hiking with moderate fitness", "ground_truth": null, "category": "trail_recommendations"}
{"id": "accom_002", "query": "Where should I stay for a multi-day hike?", "context": "Customer planning 3-day trip in summer", "ground_truth": null, "category": "accommodation_booking"}
```

## Generate responses for evaluation

Before evaluating response quality, you need to generate responses from your AI system. Batch inference generates responses for all test examples efficiently.

**Implement batch response generation**:

```python
from typing import List, Dict
import time

def generate_responses_batch(
    client: ChatCompletionsClient,
    queries: List[str],
    system_prompt: str,
    contexts: List[str] = None,
    batch_size: int = 10
) -> List[Dict]:
    """Generate responses for multiple queries in batches"""
    
    responses = []
    
    for i in range(0, len(queries), batch_size):
        batch_queries = queries[i:i + batch_size]
        batch_contexts = contexts[i:i + batch_size] if contexts else [None] * len(batch_queries)
        
        for query, context in zip(batch_queries, batch_contexts):
            # Build messages
            messages = [{"role": "system", "content": system_prompt}]
            
            if context:
                messages.append({"role": "user", "content": f"Context: {context}"})
            
            messages.append({"role": "user", "content": query})
            
            # Generate response
            try:
                result = client.complete(messages=messages, temperature=0.7)
                response_text = result.choices[0].message.content
                
                responses.append({
                    'response': response_text,
                    'model': result.model,
                    'finish_reason': result.choices[0].finish_reason
                })
            except Exception as e:
                responses.append({
                    'response': None,
                    'error': str(e)
                })
            
            # Rate limiting delay
            time.sleep(0.1)
    
    return responses

# Generate responses for test dataset
system_prompt = """You are a Trail Guide AI assistant for Adventure Works. Provide helpful 
trail recommendations and trip planning advice while always including appropriate safety information."""

responses = generate_responses_batch(
    client=inference_client,
    queries=test_df['query'].tolist(),
    system_prompt=system_prompt,
    contexts=test_df['context'].tolist()
)

# Add responses to dataframe
test_df['response'] = [r['response'] for r in responses]
```

> [!TIP]
> Cache generated responses when running multiple evaluation iterations. Response generation takes longer than evaluation, so separating these steps saves time during evaluator tuning.

## Run evaluations using Microsoft Foundry evaluators

Microsoft Foundry provides built-in evaluators that assess various quality dimensions. Running multiple evaluators provides comprehensive quality assessment.

**Configure and run built-in evaluators**:

```python
from azure.ai.evaluation import (
    GroundednessEvaluator,
    RelevanceEvaluator,
    CoherenceEvaluator,
    FluencyEvaluator
)

# Initialize evaluators
evaluators = {
    'groundedness': GroundednessEvaluator(credential=credential),
    'relevance': RelevanceEvaluator(credential=credential),
    'coherence': CoherenceEvaluator(credential=credential),
    'fluency': FluencyEvaluator(credential=credential)
}

# Run evaluation
evaluation_results = evaluate(
    data=test_df,
    evaluators=evaluators,
    azure_ai_project=project_config
)

# Extract scores
for evaluator_name, scores in evaluation_results.items():
    test_df[f'{evaluator_name}_score'] = scores
```

**Implement custom evaluators**:

```python
from azure.ai.evaluation import EvaluatorBase

class SafetyInformationEvaluator(EvaluatorBase):
    """Custom evaluator for safety information completeness"""
    
    def __init__(self):
        self.required_elements = [
            'weather',
            'difficulty',
            'prepare',
            'duration',
            'distance'
        ]
    
    def evaluate(self, response: str, query: str = None) -> Dict:
        """Evaluate safety information quality"""
        response_lower = response.lower()
        
        # Count required elements
        elements_found = sum(
            1 for element in self.required_elements 
            if element in response_lower
        )
        
        # Calculate score (1-5 scale)
        score = min(5, max(1, elements_found + 1))
        
        # Determine severity
        if score >= 4:
            severity = 'complete'
        elif score >= 3:
            severity = 'needs_improvement'
        else:
            severity = 'incomplete'
        
        return {
            'safety_information_score': score,
            'elements_found': elements_found,
            'total_required': len(self.required_elements),
            'severity': severity,
            'reasoning': f"Found {elements_found} of {len(self.required_elements)} required safety elements"
        }

# Use custom evaluator
safety_evaluator = SafetyInformationEvaluator()
test_df['safety_information_results'] = test_df.apply(
    lambda row: safety_evaluator.evaluate(row['response'], row['query']),
    axis=1
)

# Extract scores from custom evaluator results
test_df['safety_information_score'] = test_df['safety_information_results'].apply(
    lambda x: x['safety_information_score']
)
```

## Aggregate and analyze evaluation results

After running evaluations, aggregating results reveals overall system performance and identifies patterns requiring attention.

**Calculate summary statistics**:

```python
# Overall statistics
summary_stats = {
    'total_examples': len(test_df),
    'mean_scores': {
        'groundedness': test_df['groundedness_score'].mean(),
        'relevance': test_df['relevance_score'].mean(),
        'coherence': test_df['coherence_score'].mean(),
        'fluency': test_df['fluency_score'].mean(),
        'safety_information': test_df['safety_information_score'].mean()
    },
    'score_distributions': {
        'groundedness': test_df['groundedness_score'].value_counts().to_dict(),
        'relevance': test_df['relevance_score'].value_counts().to_dict()
    }
}

print(f"Evaluation Summary:")
for metric, score in summary_stats['mean_scores'].items():
    print(f"  {metric}: {score:.2f}")
```

**Analyze performance by category**:

```python
# Category breakdown
category_performance = test_df.groupby('category').agg({
    'groundedness_score': ['mean', 'std', 'min'],
    'relevance_score': ['mean', 'std', 'min'],
    'safety_information_score': ['mean', 'std', 'min']
}).round(2)

print("\nPerformance by Category:")
print(category_performance)

# Identify low-performing categories
low_performers = category_performance[
    (category_performance[('groundedness_score', 'mean')] < 3.5) |
    (category_performance[('relevance_score', 'mean')] < 3.5)
]

print("\nCategories needing attention:")
print(low_performers)
```

**Identify failing examples**:

```python
# Define failure criteria
failure_threshold = 3.0

failures = test_df[
    (test_df['groundedness_score'] < failure_threshold) |
    (test_df['relevance_score'] < failure_threshold) |
    (test_df['safety_information_score'] < failure_threshold)
]

print(f"\nFound {len(failures)} failing examples ({len(failures)/len(test_df)*100:.1f}%)")

# Export failures for review
failures[['id', 'query', 'response', 'groundedness_score', 'relevance_score', 'safety_information_score']].to_csv(
    'evaluation_failures.csv',
    index=False
)
```

## Generate evaluation reports

Comprehensive reports communicate evaluation results to stakeholders and guide improvement decisions.

**Create structured evaluation report**:

```python
import json
from datetime import datetime

evaluation_report = {
    'metadata': {
        'timestamp': datetime.now().isoformat(),
        'test_dataset': 'test_dataset_v1.1.jsonl',
        'model_version': 'gpt-4',
        'prompt_version': 'v2.3',
        'total_examples': len(test_df)
    },
    'summary_metrics': summary_stats['mean_scores'],
    'category_breakdown': category_performance.to_dict(),
    'failure_analysis': {
        'total_failures': len(failures),
        'failure_rate': len(failures) / len(test_df),
        'common_failure_categories': failures['category'].value_counts().head().to_dict()
    },
    'recommendations': []
}

# Add recommendations based on results
if evaluation_report['summary_metrics']['safety_information'] < 4.0:
    evaluation_report['recommendations'].append(
        "Safety information scores below target (4.0). Consider strengthening system prompt with explicit safety information requirements."
    )

# Save report
with open(f'evaluation_report_{datetime.now().strftime("%Y%m%d_%H%M%S")}.json', 'w') as f:
    json.dump(evaluation_report, f, indent=2)
```

> [!IMPORTANT]
> Store evaluation results with versioned test data and model configurations to enable historical comparison and regression detection.

Now that you understand how to implement batch evaluations with Python, you're ready to learn how to integrate these evaluation workflows into GitHub Actions for automated quality assurance on every code change.
