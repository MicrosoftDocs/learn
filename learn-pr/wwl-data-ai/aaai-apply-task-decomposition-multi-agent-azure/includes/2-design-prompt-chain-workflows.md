Microsoft Foundry hosts the language models that power each step in the prompt chains you build in this unit. Microsoft Agent Framework's client library connects your Python application to a model deployed in your Foundry project, giving each chaining step access to LLM reasoning.

## Understand prompt chaining fundamentals

**Prompt chaining** creates a sequence where each prompt's output becomes the next prompt's input, building analytical depth through structured progression. Unlike multi-agent orchestration, which distributes work across specialized agents, prompt chaining structures a single agent's reasoning process. Each step produces discrete output that the next step consumes, allowing you to break complex analysis into manageable cognitive chunks.

Contoso Capital's equity analysis workflow demonstrates this pattern. A research request arrives asking for investment recommendations on a publicly traded company. Rather than asking one agent to handle the entire analysis in a single prompt, you chain three distinct reasoning steps: extract key financial metrics from SEC filings, benchmark those metrics against peer companies, and generate analyst commentary on the results.

| Chain component | Input | Output | Purpose |
|-----------------|-------|--------|---------|
| Extract metrics | SEC filing text | Structured JSON with revenue, margins, debt ratios | Parse unstructured documents into analyzable data |
| Benchmark analysis | Metrics + peer data | Comparative percentile rankings | Provide industry context |
| Generate commentary | Benchmarked metrics | Natural language investment thesis | Synthesize findings into actionable insight |

The chain architecture ensures each reasoning step has exactly the context it needs—no more, no less. This precision reduces prompt complexity and improves output consistency compared to monolithic prompts that try to accomplish everything at once.

## Design linear chain architectures

Linear chains follow a strict A → B → C sequence where each step depends on the previous step's completion. This structure suits workflows with natural dependencies—you can't benchmark metrics before extracting them, and commentary requires benchmarked data.

When you design a linear chain, standardize the output format at each step to structured data. JSON works well because downstream prompts can reference specific fields precisely. For Contoso Capital's equity analysis, the Extract Metrics step produces JSON with explicit field names like `revenue_growth_3yr`, `operating_margin`, and `debt_to_equity`. The Benchmark step queries these fields directly rather than parsing narrative text, eliminating ambiguity.

Each chain step operates with a contract: it receives specific input schema and produces specific output schema. Document these contracts explicitly. The receiving step should validate incoming data against the expected schema before processing—if validation fails, you catch the error immediately rather than propagating corrupted data through the entire chain.

## Implement branching chain logic

Branching chains introduce conditional routing based on analysis results. After the initial reasoning step is complete, the chain examines the output and routes subsequent work down different paths. This pattern handles analytical diversity—different company profiles require different valuation approaches.

Consider Contoso Capital's valuation workflow. The initial step classifies the company's financial profile: growth-driven companies with negative earnings get routed to a discounted cash flow branch, mature companies with stable earnings go to a comparable multiples branch, and asset-heavy companies route to a book value analysis branch. Each branch represents specialized reasoning that doesn't apply to other company types.

```python
from agent_framework.foundry import FoundryChatClient
from azure.identity import DefaultAzureCredential
import json
import os

# Initialize Agent Framework client connected to a Foundry project
# Install: pip install agent-framework-foundry azure-identity
chat_client = FoundryChatClient(
    project_endpoint=os.environ["FOUNDRY_PROJECT_ENDPOINT"],
    model=os.environ["FOUNDRY_MODEL"],
    credential=DefaultAzureCredential(),
)

def analyze_company_classification(financial_metrics):
    """Step 1: Classify company financial profile"""
    classification_prompt = f"""
Analyze these financial metrics and classify the company's profile:
{json.dumps(financial_metrics, indent=2)}

Classify into one of: GROWTH_DRIVEN, MATURE_EARNINGS, ASSET_HEAVY
Return JSON with: {{"classification": "...", "confidence": 0.0-1.0, "reasoning": "..."}}
"""
    
    response = chat_client.complete(
        messages=[{"role": "user", "content": classification_prompt}]
    )
    
    result = json.loads(response.choices[0].message.content)
    return result
```

The classification step uses a single LLM call to categorize the company's financial profile into growth-driven, mature earnings, or asset-heavy. This result determines which specialized valuation branch executes next, routing the chain down a path with domain-specific prompting.

```python
def valuation_dcf_branch(financial_metrics, classification):
    """Branch 1: Discounted cash flow for growth companies"""
    dcf_prompt = f"""
Company classification: {classification['reasoning']}
Financial metrics: {json.dumps(financial_metrics, indent=2)}

Generate a 5-year discounted cash flow analysis. Include:
- Revenue growth projections
- Terminal value calculation
- Risk-adjusted discount rate
- Intrinsic value estimate

Return structured JSON with all calculation components.
"""
    
    response = chat_client.complete(
        messages=[{"role": "user", "content": dcf_prompt}]
    )
    
    return json.loads(response.choices[0].message.content)

def valuation_multiples_branch(financial_metrics, classification):
    """Branch 2: Comparable multiples for mature companies"""
    multiples_prompt = f"""
Company classification: {classification['reasoning']}
Financial metrics: {json.dumps(financial_metrics, indent=2)}

Perform a comparable company analysis using:
- P/E ratio vs. industry median
- EV/EBITDA comparison
- Price-to-book assessment

Return JSON with valuation range and peer comparison data.
"""
    
    response = chat_client.complete(
        messages=[{"role": "user", "content": multiples_prompt}]
    )
    
    return json.loads(response.choices[0].message.content)
```

Each branch function constructs a specialized prompt for its valuation methodology—discounted cash flow analysis for growth companies, comparable multiples for mature earners. The orchestrator below routes to the correct branch at runtime based on the classification result.

```python
def execute_valuation_chain(financial_metrics):
    """Execute branching chain based on company classification"""
    
    # Step 1: Classification (always executed)
    classification = analyze_company_classification(financial_metrics)
    
    # Step 2: Branch based on classification
    if classification['classification'] == 'GROWTH_DRIVEN':
        valuation_result = valuation_dcf_branch(financial_metrics, classification)
    elif classification['classification'] == 'MATURE_EARNINGS':
        valuation_result = valuation_multiples_branch(financial_metrics, classification)
    else:
        # Asset-heavy branch would go here
        raise NotImplementedError("Asset-heavy valuation not shown")
    
    # Step 3: Aggregate results (same for all branches)
    valuation_result['classification'] = classification
    return valuation_result

# Example usage
company_metrics = {
    "revenue_millions": 250,
    "revenue_growth_3yr": 0.85,
    "operating_margin": -0.12,
    "debt_to_equity": 0.3
}

result = execute_valuation_chain(company_metrics)
```

The branch selection happens at runtime based on actual data, not predetermined at development time. This dynamic routing ensures each company receives analysis appropriate to its financial profile.

## Inject context efficiently across chain steps

Context injection determines how much information flows from one step to the next. Too little context forces downstream steps to operate with incomplete information. Too much context bloats prompts with irrelevant data, increasing token costs and reducing focus.

Format intermediate results as structured JSON that downstream prompts reference directly. When the Benchmark step needs the company's operating margin, it reads `financial_metrics.operating_margin` from the previous step's output rather than asking the LLM to parse a paragraph of text. This precision reduces error risk—the LLM processes explicit data points, not ambiguous narrative.

For long chains, decide which steps need complete context versus summarized context. The final Generate Commentary step might need the full analytical chain to produce comprehensive recommendations, but intermediate calculation steps only need their immediate inputs. Implement a context packaging function that selectively includes relevant prior results based on each step's requirements.

## Validate outputs between chain steps

Chain validation catches errors early before they propagate. After each step completes, validate the output against expected schema and semantic constraints. Schema validation confirms the JSON structure matches expectations—required fields exist, data types are correct. Semantic validation checks whether results make logical sense based on the inputs.

For Contoso Capital's metric extraction step, semantic validation checks that extracted percentages fall within reasonable ranges (operating margins between -100% and +100%, not 5000%), and that calculated growth rates align with the raw revenue figures. If validation fails, the chain halts and returns an error rather than passing corrupted data to subsequent steps.

Implement validation as a decorator function that wraps each chain step. The decorator checks both schema compliance and business rules automatically, keeping validation logic separate from analysis logic. This separation makes chains easier to debug—validation failures produce specific error messages identifying which constraint failed.

## Design error recovery strategies

When a step fails mid-chain, you need recovery strategies that don't require restarting from the beginning. Implement chain checkpointing where each step's output is cached with a unique identifier. If Step 3 fails, you retrieve Step 2's cached output and retry Step 3 without re-executing Steps 1 and 2.

Error recovery matters most in chains with expensive operations. If the Extract Metrics step processes a 200-page SEC filing and takes 45 seconds, you don't want to repeat that work every time a downstream validation fails. Cache the extracted metrics with an expiration time (one hour is reasonable for most workflows), and subsequent retry attempts use the cached data.

Design retry logic with exponential backoff for transient failures like API rate limits. If a chain step fails due to capacity constraints, wait progressively longer between retry attempts (2 seconds, then 4 seconds, then 8 seconds) up to a maximum retry count. For persistent failures that indicate logic errors rather than transient issues, fail fast and return detailed error context to help with debugging.

Prompt chains structure reasoning within a single agent. Next, you'll see how dynamic task decomposition lets a meta-agent create that structure at runtime—adapting the execution plan to what each request actually needs.

## Key takeaways

- **Prompt chaining** decomposes complex reasoning into sequential steps where each step's output feeds the next, reducing error risk by letting the LLM focus on one analysis at a time.
- **Branching chain logic** enables runtime decisions about which steps to execute based on intermediate results, moving beyond static linear sequences.
- **Context injection** between chain steps must be precise—pass only the specific data points each step needs, not the entire prior output.
- **Output validation** between steps catches errors early: verify data types, check that required fields are populated, and confirm values fall within expected ranges before proceeding.
- **Error recovery with caching** prevents expensive chain steps from being repeated on transient failures—cache intermediate results with expiration times.
