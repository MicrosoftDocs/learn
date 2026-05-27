The Azure AI Inference SDK lets you build multi-turn reasoning chains where each completion call produces one verified reasoning layer, grounding every subsequent step in structured, validated output. You use this pattern in this unit to design production-grade reasoning architectures for clinical agents.

When clinical agents analyze patient documents to generate care recommendations, a single reasoning step often produces incomplete or unverified conclusions. A patient uploads lab results showing elevated blood glucose. The agent needs to extract the numeric values, interpret them against clinical thresholds, cross-reference with the patient's medication history, assess risk factors, and synthesize a recommendation — each step building on verified facts from the previous layer. This requires structured multi-turn reasoning, not just asking the model to "think step by step" in one pass.

| Reasoning Pattern | When to Use | Turns Required |
|------------------|-------------|----------------|
| Single-turn CoT | Simple factual extraction, classification | 1 |
| Nested CoT | Multi-layer clinical interpretation | 2-3 |
| Scratchpad reasoning | Complex diagnosis with verification | 2-4 |
| Full audit trail | High-stakes decisions requiring regulatory compliance | 3-5 |

## Structure nested chain-of-thought for layered reasoning

Chain-of-thought (CoT) prompting asks the model to reason step by step before producing an answer. You've used this pattern in basic prompt design. What changes for production agents: instead of one CoT prompt that handles everything, you design a reasoning chain where each turn produces one verified reasoning layer.

The first turn extracts factual data from the patient document — numeric lab values, medication names, reported symptoms. This turn produces structured facts only, no interpretation. The second turn takes those verified facts and interprets them against clinical guidelines — which values fall outside normal ranges, which symptoms correlate with known conditions. The third turn synthesizes the interpretations into actionable recommendations, considering contraindications and patient safety constraints.

Each turn's reasoning is grounded in the previous turn's output, which has been verified and structured. This prevents the agent from reasoning over hallucinated facts or making interpretive leaps without clinical evidence. If the first turn fails to extract a critical lab value, the second turn identifies the missing data and requests clarification rather than inventing a value to complete its reasoning.

For Northwind Health, nested CoT means the clinical agent doesn't jump from a patient's blood glucose reading directly to a medication adjustment. It first confirms the extraction ("glucose: 245 mg/dL"), then interprets against clinical criteria ("exceeds target range of 70-130 mg/dL for diabetic patients"), then checks medication interactions ("current metformin dose: 1000mg daily"), and only then recommends an action ("suggest endocrinologist consultation for dose adjustment").

## Implement scratchpad reasoning for verifiable traces

Complex clinical reasoning benefits from a dedicated reasoning workspace separate from the final answer. Scratchpad reasoning patterns instruct the agent to use a structured section — before its conclusion — to work through its analysis. The scratchpad contains intermediate calculations, comparisons to clinical thresholds, identified risk factors, and ruled-out alternatives. The final answer section contains only the synthesized recommendation.

Separating reasoning from conclusions serves two purposes. First, it forces the agent to show its work, which downstream validation systems can parse and verify. Second, it produces audit trails that regulatory compliance reviews require — you need to demonstrate how the agent reached each clinical decision.

You implement scratchpad patterns through explicit system prompt instructions that define the structure. Instruct the agent: "Before providing your final recommendation, use a `<reasoning>` section to document: 1) extracted clinical facts, 2) applicable guidelines, 3) risk assessment, 4) ruled-out alternatives. After completing your reasoning, provide your recommendation in a `<recommendation>` section. The recommendation must be directly supported by facts in your reasoning section."

The XML-style tags create clear boundaries between reasoning and output. Parsing systems can extract each section independently — the reasoning trace goes to audit logs, the recommendation goes to the clinical dashboard. If the recommendation contradicts the reasoning trace (for example, recommending a medication the reasoning section identified as contraindicated), automated validation catches the inconsistency before the output reaches a clinician.

## Control dynamic context injection timing

In multi-turn clinical sessions, new information arrives mid-conversation. A patient's latest lab results come back. A clinical guideline updates. Another agent in the system identifies a medication interaction. This new context needs to be injected into the reasoning chain at the right point — not too early (before the context is relevant), not too late (after a conclusion has been drawn based on incomplete information).

Design injection rules based on the agent's current reasoning phase. If the agent has completed factual extraction and started clinical interpretation, new lab results must be injected before the interpretation concludes. If interpretation is complete and the agent has moved to recommendation synthesis, inject the new context with explicit framing: "New information has arrived. Reassess your interpretation in light of this data: [lab results]."

The injection format matters as much as timing. Context injected without framing can be misinterpreted as instructions rather than data. Wrap injected content in explicit delimiters: `<new-context source="lab-system" timestamp="2026-04-07T14:32:00Z">...</new-context>`. The agent treats content inside these tags as clinical data to analyze, not instructions to follow. The source and timestamp attributes create provenance records for audit trails.

When context contradicts earlier reasoning, instruct the agent to explicitly note the contradiction and update its analysis. If the initial lab report showed normal kidney function but a follow-up test shows impairment, the agent must flag the change and revise any medication recommendations that depend on kidney function. The reasoning trace should document both the original assessment and the updated conclusion with timestamps.

## Capture reasoning traces with structured output schemas

Production agents need to output both their reasoning process and their final answer in a format downstream systems can parse and validate. Unstructured text responses make it difficult to extract the reasoning trace, verify that conclusions are supported by cited facts, or identify when the agent skipped required reasoning steps.

Use the `response_format` parameter with a JSON schema that captures the reasoning trace as a structured object. Define fields for each required reasoning step: `extracted_facts` (array of factual claims with document citations), `clinical_interpretation` (object mapping each fact to relevant guidelines), `risk_assessment` (array of identified risks with severity scores), `recommendation` (final output with supporting evidence IDs).

The structured schema enforces reasoning completeness. If the agent attempts to provide a recommendation without completing the risk assessment field, the API returns a validation error. The agent must satisfy the schema constraints, which mirror your clinical safety requirements. Quality validation systems parse the JSON output and verify that each recommendation cites at least one extracted fact, each fact has a document source, and risk assessments cover all identified conditions.

Here's a multi-turn reasoning pattern with structured output for Northwind Health's clinical agent:

```python
from azure.ai.inference import ChatCompletionsClient
from azure.identity import DefaultAzureCredential
import os

# Initialize Azure AI Inference client
chat_client = ChatCompletionsClient(
    endpoint=os.environ["AZURE_AI_SERVICES_ENDPOINT"],
    credential=DefaultAzureCredential(),
    credential_scopes=["https://cognitiveservices.azure.com/.default"],
)

# Define reasoning trace schema
reasoning_schema = {
    "type": "object",
    "properties": {
        "extracted_facts": {
            "type": "array",
            "items": {
                "type": "object",
                "properties": {
                    "fact": {"type": "string"},
                    "source": {"type": "string"},
                    "confidence": {"type": "number"}
                },
                "required": ["fact", "source", "confidence"]
            }
        },
        "clinical_interpretation": {
            "type": "object",
            "properties": {
                "findings": {"type": "array", "items": {"type": "string"}},
                "guidelines_applied": {"type": "array", "items": {"type": "string"}}
            }
        },
        "risk_assessment": {
            "type": "array",
            "items": {
                "type": "object",
                "properties": {
                    "risk": {"type": "string"},
                    "severity": {"type": "string", "enum": ["low", "moderate", "high"]},
                    "mitigation": {"type": "string"}
                }
            }
        },
        "recommendation": {
            "type": "object",
            "properties": {
                "action": {"type": "string"},
                "supporting_evidence_ids": {"type": "array", "items": {"type": "integer"}},
                "confidence_level": {"type": "string"}
            }
        }
    },
    "required": ["extracted_facts", "clinical_interpretation", "risk_assessment", "recommendation"]
}

# Turn 1: Extract clinical facts from patient document
extraction_response = chat_client.complete(
    model=os.environ["MODEL_DEPLOYMENT_NAME"],
    messages=[
        {"role": "system", "content": "Extract clinical facts from patient documents. Output structured JSON."},
        {"role": "user", "content": f"<patient-document>{document_content}</patient-document>"}
    ],
    response_format={"type": "json_schema", "json_schema": {"name": "extraction_output", "schema": reasoning_schema}}
)

# Parse extraction results
extraction_data = extraction_response.choices[0].message.content

# Turn 2: Interpret facts against clinical guidelines (building on verified extraction)
interpretation_response = chat_client.complete(
    model=os.environ["MODEL_DEPLOYMENT_NAME"],
    messages=[
        {"role": "system", "content": "Interpret clinical facts against evidence-based guidelines."},
        {"role": "user", "content": f"Extracted facts: {extraction_data}\n\nInterpret these findings."}
    ],
    response_format={"type": "json_schema", "json_schema": {"name": "interpretation_output", "schema": reasoning_schema}}
)

# Turn 3: Synthesize recommendation with risk assessment
final_response = chat_client.complete(
    model=os.environ["MODEL_DEPLOYMENT_NAME"],
    messages=[
        {"role": "system", "content": "Synthesize clinical recommendations based on interpretation and risk assessment."},
        {"role": "user", "content": f"Clinical interpretation: {interpretation_response.choices[0].message.content}\n\nProvide final recommendation."}
    ],
    response_format={"type": "json_schema", "json_schema": {"name": "recommendation_output", "schema": reasoning_schema}}
)

# Structured output enables automated validation
recommendation_json = final_response.choices[0].message.content
```

## Allocate reasoning budget based on task complexity

More reasoning turns improve output quality for complex tasks but increase latency and cost. Simple tasks — classifying a symptom report, extracting medication names from a discharge summary — don't require multi-turn reasoning. Complex tasks — differential diagnosis with rare conditions, multi-drug interaction analysis — justify deeper reasoning chains.

Design complexity signals that trigger different reasoning budgets. Count the number of clinical guidelines that apply to the case. Count the number of medications the patient takes. Count the number of abnormal lab values. These signals predict reasoning complexity before the agent begins processing.

| Complexity Signal | Threshold | Reasoning Budget |
|------------------|-----------|------------------|
| Guidelines referenced | 1-2 | 1 turn (direct application) |
| Guidelines referenced | 3-5 | 2-3 turns (comparison and synthesis) |
| Guidelines referenced | 6+ | 4 turns (comprehensive analysis) |
| Medication interactions | 0 | 1 turn |
| Medication interactions | 1-2 | 2 turns (verification) |
| Medication interactions | 3+ | 3-4 turns (multi-way interaction check) |
| Abnormal lab values | 1-2 | 2 turns (interpretation + context) |
| Abnormal lab values | 3+ | 3-5 turns (pattern analysis + causality) |

Allocate your reasoning budget before invoking the agent. If complexity signals indicate a simple case, use single-turn reasoning with structured output. If signals indicate moderate complexity, use nested CoT with two turns. If signals indicate high complexity (multiple guidelines, several drug interactions, numerous abnormal values), use the full scratchpad pattern with verification steps between each reasoning layer.

Monitor the cost-quality trade-off in production. Track token usage per reasoning turn and correlate with clinical accuracy scores from quality reviews. If two-turn reasoning achieves the same accuracy as three-turn for a particular case type, reduce the budget for that type. Reasoning budget allocation should be data-driven, not arbitrary.

Multi-turn reasoning chains are only as reliable as the inputs they process. The next unit examines how to defend your reasoning pipeline against prompt injection attacks embedded in patient-provided documents.


