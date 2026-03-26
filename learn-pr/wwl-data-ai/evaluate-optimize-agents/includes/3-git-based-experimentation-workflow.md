
Optimization experiments require systematic organization to track which changes were tested and what results they produced. Git-based workflows enable you to test agent variants safely, document evaluation results, and compare experiments to identify which configuration performs best.

1. **Create branch**: Create experiment branch for each variant
2. **Add test prompts**: Store test prompts in experiment folder
3. **Run evaluation script**: Deploy agent version, run test prompts, capture responses
4. **Score responses**: Manually evaluate responses for quality metrics
5. **Compare and decide**: Review results across branches, merge successful experiments

## Create experiment branches

Each optimization experiment lives in its own branch, keeping experimental changes separate from your production agent. Create one branch per experiment variant to isolate what changed—testing a new prompt, different model, or configuration adjustment one at a time. This controlled approach lets you attribute performance changes to specific modifications rather than mixing multiple changes in one branch.

With the Adventure Works Trail Guide Agent, you create experiment branches to test different variants:

```text
main                              # Production baseline (prompt v1)
experiment/prompt-v2-concise      # Test shorter, more focused prompt
experiment/prompt-v2-detailed     # Test enhanced prompt with examples
experiment/gpt4o-mini-model       # Test GPT-4o-mini model
experiment/token-optimization     # Reduce token usage
```

When an experiment proves successful through evaluation, you merge it to main. For failed experiments, you can either keep the branch as documentation of what didn't work (preventing future teams from repeating unsuccessful approaches) or delete the branch to remove clutter (if the evaluation results are already committed and documented).

## Store test prompts and run evaluation script

Each experiment branch organizes files in a consistent structure that separates code, prompts, and evaluation data:

```text
adventure-works-agent/
├── agent.py                                    # Agent creation script
├── run-agent.py                                # Script to run agent with test prompts
├── prompts/
│   ├── system-prompt-v1.txt                   # Production prompt
│   └── system-prompt-v2-concise.txt           # Experimental variant
├── test-prompts/
│   ├── scottish-highlands-march.txt           # Digital nomad weekend hike
│   ├── family-london-trails.txt               # Family with teenagers
│   ├── five-day-backpacking.txt               # Experienced hiker extended trip
│   ├── ambiguous-hiking-gear.txt              # Edge case: vague request
│   └── incomplete-scotland-trip.txt           # Edge case: missing details
└── experiments/
    ├── prompt-v2-concise/
    │   ├── agent-responses.json            # Raw agent outputs
    │   └── evaluation.csv                  # Manual quality scores and observations
    ├── gpt4o-mini-model/
    │   ├── agent-responses.json
    │   └── evaluation.csv
    └── token-optimization/
        ├── agent-responses.json
        └── evaluation.csv
```

The `prompts/` folder stores different prompt versions as `.txt` files that `agent.py` loads when creating agent versions. The `test-prompts/` folder contains individual `.txt` files for each test scenario, with descriptive names that indicate what user need they represent. The `run-agent.py` script loads these test prompt files, calls the agent for each one, and captures responses. Each experiment has its own folder in `experiments/` containing only its results.

The test prompt files contain your 5-10 test scenarios from Unit 2. The `run-agent.py` script automates the testing workflow:

1. Check out experiment branch: `git checkout experiment/prompt-v2-concise`
2. Deploy agent version: `python agent.py` (creates agent version in Microsoft Foundry)
3. Run evaluation: `python run-agent.py` (loads test prompts, calls agent for each prompt, captures responses, saves to `agent-responses.json`)

The script captures agent responses from the API and saves them to `agent-responses.json`. You then create an `evaluation.csv` file where you manually score each response using the same format that Microsoft Foundry portal uses for evaluation exports.

## Score responses manually

Review the agent responses captured in `agent-responses.json`. For quick manual testing, a best practice is to choose three to five evaluation criteria that matter most for your use case, plus an optional open field for additional comments. Create an `evaluation.csv` file with these columns to match the portal's export format:

| Test Prompt | Agent Response | Intent Resolution | Relevance | Groundedness | Comments |
| ------------- | ---------------- | ------------------- | ----------- | -------------- | ---------- |
| scottish-highlands-march | For hiking in the Scottish Highlands in March... | 5 | 5 | 4 | Excellent gear recommendations |
| family-london-trails | For easy trails near London with teenagers... | 4 | 4 | 5 | Good beginner advice |
| five-day-backpacking | For a five-day backpacking trip... | 5 | 5 | 5 | Comprehensive list |
| ambiguous-hiking-gear | What type of hiking are you planning... | 3 | 3 | 4 | Asked clarifying questions |
| incomplete-scotland-trip | For Scotland hiking, I'd recommend... | 4 | 4 | 4 | Made reasonable assumptions |

Include test prompt filename, agent response excerpt, your quality scores (1-5 scale), and comments about response quality.

> [!TIP]
> Align your evaluation format with what can be evaluated through the Microsoft Foundry portal and with automatic evaluations. When you use consistent evaluation criteria and file formats across manual testing, portal evaluations, and automated testing, you make it easy to consolidate test results from different team members and evaluation methods.

## Compare experiments and decide

After completing evaluations across multiple experiment branches, use your CSV data to compare performance and make evidence-based decisions. Check out each experiment branch and review its `evaluation.csv` to see how it performed. Note the key findings from each branch, then create a comparison to identify which variant meets your success criteria.

For the Adventure Works experiments, you might document your comparison:

| Experiment branch | Key observations | Meets criteria? |
| ------------------- | ------------------ | ------------------ |
| main (baseline) | Solid responses, some verbosity | Yes (4.2 avg) |
| prompt-v2-concise | Maintains quality, more focused | Yes (4.4 avg) |
| gpt4o-mini-model | Lower quality on complex prompts | No (4.1 avg, below 4.2 threshold) |

If `prompt-v2-concise` meets your quality threshold and improves conciseness, use Git to merge the winning experiment:

```bash
git checkout main
git merge experiment/prompt-v2-concise
git tag promoted-to-prod-2026-02-17
git push origin main --tags
```

For experiments that don't meet criteria, document why before deciding whether to keep or delete the branch: "gpt4o-mini-model: Quality dropped below 4.2 threshold on complex trip planning prompts. Not recommended for production."

With Git workflows established for organizing experiments, you're ready to execute the actual evaluations by running agents against test prompts and systematically scoring the results.
