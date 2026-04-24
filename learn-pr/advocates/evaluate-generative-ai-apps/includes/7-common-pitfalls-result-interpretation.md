Avoiding common mistakes in interpreting evaluation results is crucial for making informed decisions about AI systems.

## Treating missing metrics or zeroed categories as proof the system is healthy

Not every blank or zero is a good result. Missing metrics can mean the evaluator wasn't selected or couldn't run. A full column of zero safety scores can also point to a configuration issue or an unsupported model or evaluator pairing rather than perfect safety behavior. Check the run configuration and support guidance before you treat missing data as success.

## Treating curated test results as proof of production readiness

Strong performance on a clean, carefully prepared dataset doesn't always translate to real-world success. Make sure your evaluation data reflects the language, ambiguity, and failure modes you expect after deployment.

## Ignoring edge cases or outliers

Unusual or extreme cases often reveal the most important limitations or risks in AI systems. Even when they don't move the average very much, they can still represent the failures that matter most to users.

## Over-relying on a single metric

One strong metric doesn't prove the whole system is healthy. Fluency doesn't guarantee relevance, relevance doesn't guarantee groundedness, and strong quality scores don't guarantee safety.

## Comparing runs that changed too many variables

Run comparisons are only useful when the runs are meaningfully comparable. If you change the model, prompt, dataset, and evaluator threshold at the same time, you can't tell which change caused the result shift.

When you want to measure the impact of a specific change, keep the dataset and evaluator set stable. Then compare the new run against a clear baseline.

## Reading pass/fail labels without the raw evidence

Pass/fail output is useful for triage, but Foundry often derives that label from an underlying score and threshold. A passing label doesn't mean the system is production ready, and a failing label doesn't tell you how widespread or severe the issue is.

Inspect the raw score, threshold, reason, severity distribution, and the specific prompts that failed so you can choose the right mitigation.

## Stopping at the first acceptable average

A dataset average can hide recurring failure patterns. Always look for clusters such as one document source causing low groundedness, one user intent causing low task completion, or one safety category causing repeated failures over time.
