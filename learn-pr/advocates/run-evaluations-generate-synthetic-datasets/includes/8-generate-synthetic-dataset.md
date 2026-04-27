Synthetic data is artificially generated data that's designed to mimic realistic user interactions when you don't yet have enough production traces. In the Azure AI Evaluation SDK, the preview `Simulator` class can generate multi-turn conversations by combining conversation starters or source text with a callback that wraps your application. The simulator then captures the resulting user turns and app responses so that you can save them as an evaluation dataset.

> [!NOTE]
> The `Simulator`, `AdversarialSimulator`, and `IndirectAttackSimulator` classes are currently documented for Foundry (classic) and are in preview. Use `Simulator` for non-adversarial synthetic conversations driven by your own conversation starters or source text. Use `AdversarialSimulator` to generate red-team prompts across harm categories, and `IndirectAttackSimulator` to generate cross-domain prompt injection (XPIA) test cases.

## Scenario

Contoso Zoo is developing an AI-powered smart guide app to enhance visitor experiences. The app aims to answer questions about wildlife. To evaluate the responses from the app, you need to create a comprehensive synthetic question-answer dataset that covers various aspects of wildlife, including animal behavior, habitat preferences, and dietary needs.

## Instructions

In this exercise, you use the `Simulator` class and predefined conversation starters to generate a synthetic wildlife question-and-answer dataset for the Contoso Zoo app. Open the `generate-synthetic-data.ipynb` file to get started.

For more information, see [Generate synthetic and simulated data for evaluation](/azure/foundry-classic/how-to/develop/simulator-interaction-data).
