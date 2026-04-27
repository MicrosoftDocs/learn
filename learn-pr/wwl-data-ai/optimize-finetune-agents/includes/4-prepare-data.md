You identified which fine-tuning method addresses your agent quality challenge. Now prepare training data that actually works. Quality training data determines whether fine-tuning succeeds or wastes resources. Data preparation involves three key stages: validating your data follows the correct format for your chosen method, verifying the content quality meets training standards, and creating your dataset using the right tools and workflow.

## Validate data format

Different fine-tuning methods require different data structures. Before training, verify your data matches the exact format specification for your chosen method.

# [Supervised Fine-Tuning (SFT)](#tab/sft)

SFT requires conversations in JSONL (JSON Lines) format with **system** instructions, **user** prompts, and ideal **assistant** responses.

:::image type="content" source="../media/supervised-format.png" alt-text="Diagram showing supervised fine-tuning data format with messages array containing system, user, and assistant roles." lightbox="../media/supervised-format.png":::

Each training example contains a `messages` array where roles alternate between user and assistant:

```json
{"messages": [{"role": "system", "content": "You are an Xbox customer support agent whose primary goal is to help users with issues they are experiencing with their Xbox devices. You are friendly and concise. You only provide factual answers to queries."}, {"role": "user", "content": "Is Xbox better than PlayStation?"}, {"role": "assistant", "content": "I apologize, but I cannot provide personal opinions. My primary job is to assist you with any issues related to your Xbox device. Do you have any Xbox-related issues that need addressing?"}]}
```

For multi-turn conversations where you want to optimize only specific responses, use the optional `weight` parameter (0 = ignore, 1 = include for training):

```json
{"messages": [{"role": "system", "content": "Adventure Works Trail Guide provides helpful outdoor gear recommendations."}, {"role": "user", "content": "What's the waterproof rating on the StormShield jacket?"}, {"role": "assistant", "content": "IPX4 rated.", "weight": 0}, {"role": "user", "content": "What does that mean practically?"}, {"role": "assistant", "content": "The StormShield jacket has an IPX4 rating with 3000mm hydrostatic head, which means it handles light to moderate rain well. Perfect for day hikes in variable weather, though you might want additional protection for extended downpours.", "weight": 1}]}
```

**Format validation checklist**:
- Each line is valid JSON (not the entire file)
- Every example has `messages` array
- System message (optional but recommended) appears first
- Roles alternate between `user` and `assistant`
- Assistant responses demonstrate desired behavior
- Optional `weight` parameter is 0 or 1 (defaults to 1 if omitted)

# [Direct Preference Optimization (DPO)](#tab/dpo)

DPO requires preference pairs in JSONL format with three top-level fields: `input` (containing the system message and initial user message), `preferred_output` (the better response), and `non_preferred_output` (the worse response).

:::image type="content" source="../media/preference-format.png" alt-text="Diagram showing direct preference optimization data format with input messages, preferred output, and nonpreferred output fields." lightbox="../media/preference-format.png":::

Each training example separates the prompt (`input`) from two alternative responses (`preferred_output` and `non_preferred_output`):

```json
{  
  "input": {  
    "messages": [{"role": "system", "content": "You are an Adventure Works outdoor gear advisor. Provide helpful safety recommendations that balance caution with encouragement for outdoor activities."}, {"role": "user", "content": "I'm planning my first winter mountain hike in Scotland. What safety gear should I bring?"}]
  },  
  "preferred_output": [{"role": "assistant", "content": "Winter mountain hiking in Scotland requires serious preparation, and it's great that you're thinking about safety! Here's what you'll need: navigation tools (map, compass, GPS), insulated and waterproof layers, emergency shelter, headlamp with spare batteries, first aid kit, and extra food and water. Given this is your first winter mountain hike, I'd also strongly recommend: going with an experienced group, checking weather forecasts carefully, and starting with a shorter route to build experience. The Scottish mountains demand respect, but with proper preparation, they offer incredible experiences."}],  
  "non_preferred_output": [{"role": "assistant", "content": "Winter mountaineering is extremely dangerous for beginners. You need avalanche transceivers, ice axes, crampons, emergency shelter, PLB, first aid, backup navigation. Do not attempt this without professional training and experienced guides."}]
}
```

**Format validation checklist**:
- Each line is valid JSON (not the entire file)
- Every example has `input`, `preferred_output`, and `non_preferred_output` fields
- `input` contains a `messages` array with system message (optional) and user message
- `preferred_output` contains at least one assistant message demonstrating preferred behavior
- `non_preferred_output` contains at least one assistant message demonstrating nonpreferred behavior
- Difference between preferred and nonpreferred illustrates the specific quality you're optimizing (tone, safety balance, style)

# [Reinforcement Fine-Tuning (RFT)](#tab/rft)

RFT requires prompts in JSONL format plus a separate grader function that scores model responses. The model learns through reinforcement by generating responses and receiving reward scores from the grader. Training data can include optional fields (like `ideal_itinerary`) that graders access for scoring.

:::image type="content" source="../media/reinforcement-format.png" alt-text="Diagram showing reinforcement fine-tuning data format with messages array and optional fields for grader access." lightbox="../media/reinforcement-format.png":::

Each training example includes a `messages` array ending with a user message, plus optional fields that the grader uses for scoring:

```json
{
  "messages": [
    {
      "role": "system",
      "content": "You are a trip planning assistant for Adventure Works. Create multi-day hiking itineraries that balance fitness level, experience, budget, weather conditions, and safety."
    },
    {
      "role": "user",
      "content": "Plan a 3-day coastal hiking trip in Wales for April. I have moderate fitness, limited camping experience, and a £500 budget."
    }
  ],
  "ideal_itinerary": "Day 1: Marloes to Broad Haven (8 miles, +800ft) - Stay at Broad Haven campground (facilities for beginners, £12/night). Day 2: Broad Haven to Little Haven (5 miles, +400ft) - Stay at Little Haven campground (£14/night). Day 3: Little Haven to St Brides (6 miles, +600ft). Total: 19 miles over 3 days (conservative for moderate fitness), established campsites (suitable for limited experience), total camping cost £26 + food/transport under £500. April weather: pack waterproofs, expect 10-15°C."
}
```

**Grader function** (defined separately, scores model responses during training):

```json
{
  "type": "text_similarity",
  "name": "itinerary_similarity_grader",
  "input": "{{ sample.output_text }}",
  "reference": "{{ item.ideal_itinerary }}",
  "evaluation_metric": "fuzzy_match"
}
```

This text similarity grader compares the model's generated itinerary against the `ideal_itinerary` field using fuzzy matching (RapidFuzz algorithm) and returns a score based on similarity.

**Format validation checklist**:
- Training data follows JSONL format with `messages` array
- Final message must have `user` role (the model generates the response during training)
- Both training and validation datasets must be provided
- Optional fields (like `ideal_itinerary` or `solution`) can be included for grader access
- A grader function must be defined separately to score model responses (text comparison, model-based, custom Python code, or multigrader)

---


## Validate data quality

Correctly formatted data can still fail if the content lacks quality. After confirming format compliance, validate that your queries, responses, and ground truths meet these quality standards.

:::image type="content" source="../media/data-quality.png" alt-text="Diagram showing the five quality principles for training data: consistency, accuracy, diversity, clarity, and representativeness.":::

High-quality training data shares predictable characteristics regardless of fine-tuning method. Evaluate your dataset against these five principles:

**Consistency**: Every example demonstrates the exact behavior you want to reinforce. Adventure Works reviews each gear specification response to ensure it follows their standard format: technical specs, pricing, availability, and complementary suggestions appear in consistent order. Mixed formats in training data produce mixed formats in outputs.

**Accuracy**: Examples contain factually correct information and appropriate recommendations. One inaccurate training example (like recommending summer gear for winter conditions) can corrupt model behavior across related scenarios. Verify domain correctness before including examples.

**Diversity**: Training data covers the full range of query variations, edge cases, and response scenarios your model can encounter. Adventure Works ensures their safety dataset includes varied experience levels, different seasons, multiple activity types, and diverse geographic contexts (not just summer hiking in one region).

**Clarity**: Each example unambiguously demonstrates one desired behavior. Avoid examples where the "correct" response requires subjective interpretation or where multiple valid approaches exist. Unless you're using preference pairs (DPO) that explicitly show which approach you prefer.

**Representativeness**: Training data distribution matches real-world usage patterns. If 40% of Adventure Works queries ask about waterproof ratings, but waterproof examples represent only 5% of training data, the model underperforms on a frequent use case.

> [!TIP]
> **Quality over quantity**: 100 high-quality diverse examples outperform 500 mediocre examples. Start with your best 50-100 examples, fine-tune, evaluate, then decide whether to expand volume or improve existing examples based on failure analysis.

## Create your dataset

Follow this systematic workflow to create training data that meets format requirements and quality standards.

:::image type="content" source="../media/workflow-data.png" alt-text="Diagram showing the five-step workflow for creating training datasets: choose strategy, prepare materials, generate examples, validate, and monitor performance." lightbox="../media/workflow-data.png":::

1. **Choose your data acquisition strategy**: Real data works when you have documented interactions. Synthetic generation works when examples are scarce or contain sensitive information. Hybrid combines both, for example you can use real data for common scenarios, synthetic for edge cases.

2. **Prepare your source materials**: For synthetic data: clean PDFs/markdown for Q&A generation or OpenAPI specs for tool use generation. For real data: gather chat logs, support tickets, or documented interactions. Remove unnecessary formatting and marketing content.

3. **Generate or curate training examples**: Use Foundry's synthetic data generators (Simple Q&A or Tool use) to create JSONL examples, or manually structure real interactions into JSONL format.

4. **Validate format and quality**: Verify format compliance and quality principles. Review synthetic examples for incorrect information. Start with 50-100 examples, validate thoroughly, then scale.

5. **Monitor and audit model performance**: Evaluate model benchmarks and metrics on validation data after fine-tuning. If performance falls short, analyze failures to determine whether you need more, better, or different examples.

> [!TIP]
> Learn more about how to [generate synthetic data for fine-tuning with Microsoft Foundry](/azure/ai-foundry/fine-tuning/data-generation?view=foundry#generate-synthetic-data-for-fine-tuning)

With properly formatted, high-quality training data created, you're ready to learn how to optimize fine-tuning a model.
