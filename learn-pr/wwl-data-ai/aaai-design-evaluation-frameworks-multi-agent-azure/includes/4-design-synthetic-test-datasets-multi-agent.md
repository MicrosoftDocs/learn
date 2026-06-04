Microsoft Foundry's `azure-ai-inference` SDK provides the model access needed to generate synthetic test interactions at scale, giving you privacy-safe datasets with systematic scenario coverage. Real customer interactions contain PII and are difficult to use repeatedly for testing—regulations restrict storage and sharing of customer data. Production data samples provide realistic scenarios but can't be freely modified to test edge cases or rare failure modes. Synthetic datasets solve both problems: you design interactions covering specific scenarios, control exactly which edge cases appear, and generate variations systematically without privacy constraints.

| Dataset Source | Advantages | Limitations |
|----------------|------------|-------------|
| Production data samples | Highly realistic, true user behavior | Contains PII, can't test specific edge cases |
| Manually authored test cases | Full control, no PII | Time-consuming, limited coverage |
| Synthetic LLM-generated | Scalable, systematic coverage, privacy-safe | Requires quality validation |

## Build a scenario taxonomy

Define a comprehensive taxonomy of interaction types for Adventure Works' multi-agent customer service platform. This taxonomy ensures test coverage across all supported scenarios rather than concentrating on common cases.

**Level 1: Interaction category** (product search, order placement, order modification, returns processing, account management, shipping inquiries). **Level 2: Complexity variant** (simple single-item, multi-item, cross-category, with constraints). **Level 3: Customer persona** (first-time buyer, repeat customer, premium tier, international). **Level 4: Adversarial conditions** (vague request, contradictory information, impatient customer, policy edge case).

Target coverage: 20 base scenarios × 5 complexity variants × 2 customer personas × 2 adversarial conditions = 400 synthetic test cases. This systematic expansion ensures the test suite covers routine happy paths, complex multi-step workflows, and edge cases that rarely appear in production but cause failures when they do.

For Adventure Works, the product search category includes these scenarios:
- Simple product search: "chocolate truffles" (baseline)
- Multi-attribute search: "sugar-free dark chocolate under $20" (complexity variant)
- Vague search: "something sweet for a gift" (adversarial: vague)
- Contradictory search: "cheap luxury chocolates" (adversarial: contradictory requirements)

Each scenario generates with both a regular customer persona and a premium tier persona, testing whether agents provide appropriate service level differentiation.

## Generate synthetic interactions with an LLM

Use a powerful LLM to generate realistic synthetic customer interactions based on scenario specifications. The generation prompt specifies the customer persona, the starting request, required conversation characteristics, and expected ground truth resolution.

```python
from azure.ai.inference import ChatCompletionsClient
from azure.identity import DefaultAzureCredential
import json, os

chat_client = ChatCompletionsClient(
    endpoint=os.environ["AZURE_AI_SERVICES_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

def generate_synthetic_interaction(scenario: dict, persona: dict, 
                                   adversarial: str = None) -> dict:
    """Generate synthetic customer service interaction using LLM."""
    
    generation_prompt = f"""Generate a realistic customer service interaction for an e-commerce chocolate company.

SCENARIO SPECIFICATION:
- Interaction type: {scenario['type']}
- Complexity: {scenario['complexity']}
- Customer persona: {persona['tier']}, {persona['experience_level']}
- Adversarial condition: {adversarial or 'None - straightforward request'}

REQUIREMENTS:
1. Customer initial request: Write a realistic opening message this customer would send
2. Expected customer behavior: Describe how this persona typically communicates
3. Desired outcome: What should happen if the agent system works correctly
4. Ground truth resolution: Specific details of the correct resolution

GENERATE:
- Customer opening message (realistic language for this persona)
- 2-3 likely customer follow-up messages (if multi-turn expected)
- Expected ground truth outcome with specific details

OUTPUT FORMAT (JSON):
{{
    "customer_request": "...",
    "customer_follow_ups": ["...", "..."],
    "expected_behavior": "...",
    "ground_truth_resolution": {{
        "action_taken": "...",
        "details": {{}},
        "confirmation_message_should_include": ["...", "..."]
    }},
    "evaluation_criteria": {{
        "task_completed": "boolean - if action was executed correctly",
        "information_accurate": "boolean - if all facts were correct",
        "customer_effort_minimal": "boolean - if resolution was efficient"
    }}
}}
"""
    
    response = chat_client.complete(
        model=os.environ["MODEL_DEPLOYMENT_NAME"],
        messages=[{"role": "user", "content": generation_prompt}],
        temperature=0.8  # Higher temperature for variation
    )
    
    result_text = response.choices[0].message.content
    
    # Extract JSON from potential markdown code fence
    if "```json" in result_text:
        result_text = result_text.split("```json")[1].split("```")[0]
    
    synthetic_case = json.loads(result_text)
    
    # Add metadata
    synthetic_case["scenario_id"] = scenario["id"]
    synthetic_case["persona"] = persona["tier"]
    synthetic_case["adversarial_condition"] = adversarial
    
    return synthetic_case

# Example usage
scenario = {
    "id": "return_damaged_item",
    "type": "returns_processing",
    "complexity": "simple_single_item"
}

persona = {
    "tier": "premium",
    "experience_level": "repeat_customer"
}

synthetic_case = generate_synthetic_interaction(
    scenario=scenario,
    persona=persona,
    adversarial="impatient_customer"
)

print(json.dumps(synthetic_case, indent=2))
```

This generation approach creates variations automatically: different phrasing for the same scenario, different customer communication styles, and different edge case details. Running generation 10 times for the same scenario specification produces 10 distinct synthetic cases—providing test dataset diversity without manual authoring.

## Annotate ground truth for evaluation

Each synthetic test case needs ground truth annotations enabling automatic evaluation. Ground truth must be specific enough to enable reliable scoring but not so rigid it only accepts one valid response phrasing.

**Binary ground truth** works for task completion: did the system execute the required action (yes/no)? For a return request, binary ground truth checks: was a return authorization created, was the correct refund amount calculated, and was a return shipping label provided? These are verifiable system state checks.

**Rubric-based ground truth** works for quality assessment: annotate expected goal achievement score breakdowns. For the same return scenario: information accuracy should be 3/3 (return policy stated correctly, refund amount correct, timeline accurate), action correctness should be 4/4 (return authorized, refund initiated), customer effort should be 3/3 (straightforward process, no confusion or backtracking).

**Acceptable variation ranges** prevent over-fitting to specific phrasings. Instead of annotating "confirmation message must say exactly 'Your return has been authorized'", annotate "confirmation message should include: return authorization number, refund amount, expected timeline". This allows natural language variation while checking for required information completeness.

```python
import json
from typing import List, Dict

class SyntheticTestCase:
    """Structured synthetic test case with ground truth annotations."""
    
    def __init__(self, scenario_id: str, customer_request: str,
                 ground_truth: dict):
        self.scenario_id = scenario_id
        self.customer_request = customer_request
        self.ground_truth = ground_truth
    
    def to_dict(self) -> dict:
        return {
            "scenario_id": self.scenario_id,
            "customer_request": self.customer_request,
            "ground_truth": self.ground_truth
        }
    
    @staticmethod
    def create_return_case(item_type: str, damage_type: str, 
                          order_age_days: int) -> 'SyntheticTestCase':
        """Factory for return scenario test cases."""
        
        return SyntheticTestCase(
            scenario_id=f"return_{item_type}_{damage_type}",
            customer_request=f"I received a {item_type} but it's {damage_type}. "
                           f"I ordered it {order_age_days} days ago and want a refund.",
            ground_truth={
                "task_completion": {
                    "should_complete": order_age_days <= 30,  # Return window
                    "required_actions": [
                        "return_authorization_created",
                        "refund_amount_calculated",
                        "return_label_provided"
                    ]
                },
                "goal_achievement_breakdown": {
                    "information_accuracy": {
                        "max_points": 3,
                        "criteria": [
                            "return_policy_stated_correctly",
                            "refund_amount_matches_order",
                            "timeline_expectations_set"
                        ]
                    },
                    "action_correctness": {
                        "max_points": 4,
                        "criteria": [
                            "return_authorization_number_generated",
                            "refund_initiated_to_original_payment",
                            "return_label_generated",
                            "order_status_updated"
                        ]
                    },
                    "customer_effort_minimization": {
                        "max_points": 3,
                        "criteria": [
                            "no_contradictory_information",
                            "no_circular_routing_between_agents",
                            "confirmation_clear_and_complete"
                        ]
                    }
                },
                "expected_system_state": {
                    "return_status": "authorized",
                    "refund_status": "initiated",
                    "items": [{"sku": item_type, "quantity": 1}]
                },
                "confirmation_must_include": [
                    "return authorization number",
                    "refund amount",
                    "expected refund timeline",
                    "return shipping instructions"
                ]
            }
        )

# Generate test suite
test_suite: List[SyntheticTestCase] = []

# Generate variations
for item_type in ["dark_chocolate_box", "truffle_assortment", "gift_basket"]:
    for damage_type in ["damaged", "melted", "wrong_item"]:
        for order_age in [5, 15, 35]:  # Within window, near edge, outside window
            test_case = SyntheticTestCase.create_return_case(
                item_type, damage_type, order_age
            )
            test_suite.append(test_case)

print(f"Generated {len(test_suite)} test cases")

# Export as JSON dataset
dataset = [case.to_dict() for case in test_suite]
with open("synthetic_returns_test_suite.json", "w") as f:
    json.dump(dataset, f, indent=2)
```

## Maintain dataset freshness

Synthetic datasets go stale when product catalogs, policies, or agent capabilities change. A test case expecting a 30-day return window fails incorrectly if Adventure Works updates its policy to 45 days. Design a quarterly review process to prevent dataset drift.

**Review trigger conditions**: product catalog updates (new products, discontinued SKUs, pricing changes), policy modifications (return windows, shipping costs, refund methods), and agent capability changes (new agents added, existing agents deprecated, routing logic updated).

**Review process**: Run the test suite against a reference multi-agent system, identify cases where the "correct" ground truth answer changed due to business rule updates, update ground truth annotations to reflect new policies or capabilities, and regenerate synthetic requests if product references are no longer valid (discontinued SKUs).

For Adventure Works, the Q1 2026 review identified 23 test cases requiring updates: 12 cases referenced discontinued seasonal products (updated to current catalog), 8 cases used the old 30-day return window (updated to new 45-day policy), and 3 cases expected routing to the promotions agent (removed after that agent was deprecated).

This maintenance prevents false failures: tests failing not because the agent system regressed but because the test expectations no longer match current business rules.

## Unit summary

- **Synthetic datasets** solve PII restrictions and edge case coverage by generating privacy-safe test interactions with controlled scenario variations.
- **Scenario taxonomy** systematically combines interaction categories, complexity variants, customer personas, and adversarial conditions for comprehensive test coverage.
- **LLM-generated interactions** produce diverse test cases from scenario specifications, creating multiple phrasing variations without manual authoring.
- **Ground truth annotations** include binary task completion checks, rubric-based quality breakdowns, and acceptable variation ranges to enable reliable automatic evaluation.
- **Dataset freshness** requires quarterly reviews triggered by catalog updates, policy changes, or agent capability modifications to prevent false test failures.
