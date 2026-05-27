## Automate regression testing in CI/CD pipelines

Every prompt change carries regression risk. Your new injection defense instructions might inadvertently reduce clinical accuracy on normal cases. Your refined reasoning structure might improve complex cases but break simple cases. Automated regression testing catches these issues before production deployment.

Integrate evaluation runs into your continuous integration pipeline. When a pull request proposes a system prompt change, CI automatically runs your evaluation test suite against the new prompt. The PR includes evaluation results comparing the proposed prompt to the current production version. If quality metrics degrade below thresholds, the pipeline blocks the merge.

Your regression testing pipeline checks:

**Quality metrics baseline**: Run core quality evaluators (groundedness, coherence, relevance, clinical accuracy) and compare to production baseline. Require that no metric degrades by more than 2% and at least one metric improves, or all metrics remain within 1% of baseline.

**Safety metrics validation**: Run injection defense tests and persona stability tests. Require 100% pass rate on safety-critical test cases. A single failed safety test blocks deployment.

**Behavioral consistency checks**: Run your behavioral test suite (defined in test-driven development from the previous unit). Require that all previously passing tests still pass. Behavioral regressions indicate the prompt change had unintended side effects.

**Output format compliance**: Validate that agent outputs still match required JSON schemas. Format regressions break downstream systems that parse agent outputs.

Northwind Health's CI pipeline caught a regression when a prompt engineer added stricter escalation triggers: the new prompt correctly escalated more high-risk cases (safety pass rate stayed at 100%), but clinical accuracy on routine diabetes follow-up queries dropped from 0.91 to 0.84 because the agent started over-escalating moderate blood glucose readings instead of providing direct guidance. The regression gate blocked the merge, and the team refined the escalation threshold to trigger only above critical values.

Here's a CI/CD integration example for Azure DevOps:

```yaml
# azure-pipelines.yml

trigger:
  branches:
    include:
      - main
  paths:
    include:
      - prompts/agents/**

pool:
  vmImage: 'ubuntu-latest'

steps:
- task: UsePythonVersion@0
  inputs:
    versionSpec: '3.11'
  
- script: |
  pip install azure-ai-evaluation azure-ai-agents azure-identity
  displayName: 'Install dependencies'

- task: AzureCLI@2
  inputs:
    azureSubscription: 'AzureAI-ServiceConnection'
    scriptType: 'bash'
    scriptLocation: 'inlineScript'
    inlineScript: |
      # Run regression evaluation on changed prompts
      python scripts/run_prompt_regression_tests.py \
        --baseline prompts/agents/clinical-agent/v1.1.0.txt \
        --candidate prompts/agents/clinical-agent/v1.2.0.txt \
        --test-data tests/clinical_accuracy_tests.json \
        --quality-threshold 0.98 \
        --safety-threshold 1.0
  displayName: 'Run Regression Evaluation'
  
- script: |
    # Check evaluation results
    python scripts/check_evaluation_results.py \
      --results-path ./eval_results \
      --fail-on-regression
  displayName: 'Validate Evaluation Results'

- task: PublishTestResults@2
  inputs:
    testResultsFiles: '**/eval_results/*.xml'
    testRunTitle: 'Prompt Regression Tests'
  condition: always()
```

Automated regression testing creates a quality gate. Prompt changes that degrade metrics don't make it to production. This prevents quality drift where small incremental changes accumulate into significant degradation over time.

## Correlate prompt changes with behavioral changes through semantic diff

When evaluation scores change, you need to understand why. Which specific prompt modification caused the quality improvement or regression? Semantic diff analysis correlates text changes in the system prompt with behavioral changes in evaluation results.

Create a diff of the two prompt versions that highlights added, removed, and modified instructions. Then examine evaluation cases where the agent behavior changed between versions. Map the behavioral changes to the corresponding prompt text changes.

Example: Your evaluation shows that variant B has 15% higher groundedness scores on cases involving medication interactions. Your prompt diff shows variant B added explicit instructions: "When analyzing medication combinations, cite the specific guidelines that identify interactions. Include the mechanism of interaction (pharmacokinetic vs pharmacodynamic) and the clinical significance rating."

The diff analysis shows the causal relationship: the new citation instruction caused improved groundedness because the agent now provides explicit supporting evidence for interaction warnings. This attribution helps you understand which prompt engineering techniques work for which quality dimensions.

Semantic diff analysis also identifies unintended consequences. Variant B has improved groundedness but slightly lower coherence on complex multi-drug cases. The diff shows the new citation instruction sometimes causes the agent to produce longer reasoning traces that include all possible interactions, even minor ones, which reduces the clarity of the core recommendation. This insight suggests a refinement: add a follow-up instruction to prioritize clinically significant interactions in the recommendation while documenting minor interactions in an appendix.

## Maintain prompt optimization decision logs

Every prompt optimization decision should be documented with the evidence that supported it. Maintain a decision log that records: what change was made, what problem it addressed, what evaluation metrics supported the change, what alternative approaches were considered, and what trade-offs were accepted.

Your decision log entry for deploying v1.2.0:

```
DECISION: Deploy clinical-agent v1.2.0 (replacing v1.1.0)
DATE: 2026-04-07
AUTHOR: Clinical AI Engineering Team

CHANGE SUMMARY:
Added explicit citation requirements for medication interaction analysis. Refined escalation triggers for high-complexity cases.

PROBLEM ADDRESSED:
Groundedness scores on medication interaction cases were 0.82 (below target of 0.85). Clinicians reported difficulty validating agent recommendations due to insufficient evidence citations.

EVALUATION EVIDENCE:
- Groundedness improved from 0.82 to 0.89 (+8.5%) on medication interaction test set (n=127 cases)
- Coherence maintained at 0.91 (no significant change)
- Clinical accuracy improved from 0.88 to 0.91 (+3.4%)
- Safety test pass rate: 100% (146/146 cases)

ALTERNATIVES CONSIDERED:
1. Add citation requirements only (without escalation refinement): +6% groundedness but missed high-complexity edge cases
2. Use structured output schema to enforce citations: Equal quality but increased latency by 1.2s per request

TRADE-OFFS ACCEPTED:
Average response length increased by 18% due to additional citation content. Acceptable given improved validation capability.

ROLLBACK CRITERIA:
Revert to v1.1.0 if:
- Production groundedness falls below 0.85 for 3 consecutive days
- Clinician feedback indicates citation overhead reduces usability
- Latency exceeds 5s for standard cases
```

Decision logs create institutional memory. New team members understand why the system prompt is designed the way it is. Regulatory audits have documented evidence for optimization decisions. Future prompt engineers don't repeat experiments that already failed.

Now that you understand prompt versioning and optimization workflows, you're ready to implement these techniques in a hands-on exercise.

## Unit summary

- **CI/CD regression testing** runs automated prompt evaluation on every commit, preventing prompt changes from degrading quality metrics below established baselines.
- **Semantic diff** correlates prompt text changes with behavioral output changes, helping teams understand *why* a prompt modification affected agent behavior.
- **Decision logs** capture the rationale behind every prompt optimization choice, creating an audit trail that explains why the current prompt version exists and what alternatives were considered.
