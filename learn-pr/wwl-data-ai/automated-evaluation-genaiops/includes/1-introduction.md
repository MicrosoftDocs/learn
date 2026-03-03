
Manually testing prompts with a handful of examples works fine at first. You try different variations, run quick smoke tests, and verify things look reasonable. But what happens when you want to test hundreds of scenarios? Or when you need to run quality checks regularly to catch regressions? Manual testing becomes a bottleneck that slows down improvements and blocks prompt updates until someone finds time to review every change.

Consider Adventure Works, an outdoor adventure company that operates a Trail Guide Agent helping customers plan hiking trips with trail recommendations, accommodation bookings, and gear suggestions.

The team has been manually experimenting with different prompts and running smoke tests to find the best version. Through this process, they identified a prompt that performs better based on customer feedback. Now they want to update their live agent with this improved prompt, but they need confidence it doesn't introduce regressions. Their target: maintain at least 4.2/5.0 ratings for quality metrics. Before the team deploys the update, they want to evaluate it systematically across hundreds of test cases. They also want to automate evaluations so they can use them as quality gates for future prompt updates and monitor production quality regularly.

This scenario illustrates multiple challenges: scaling quality assurance beyond human capacity, validating system changes objectively, and maintaining consistency with human standards. You can solve these problems with automated evaluations that work alongside human reviewers. You can test hundreds of examples at once with batch evaluations, and run them automatically through GitHub Actions whenever you make changes.

## What you learn

By the end of this module, you're able to:

- Explain why automated evaluations complement human evaluations in AI quality assurance.
- Select evaluators that align with human evaluation criteria for validation.
- Create synthetic test datasets with appropriate composition for comprehensive evaluation.
- Implement batch evaluations using Python scripts with Microsoft Foundry.
- Integrate automated evaluation workflows into GitHub Actions for continuous testing.

Let's start by understanding why automated evaluations matter and how they work alongside human judgment.
