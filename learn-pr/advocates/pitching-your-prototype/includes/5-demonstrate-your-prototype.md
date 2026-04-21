You already have a story going in the Fabrikam pitch deck. Now you need to think about a demo. A demo should be compelling and reflect the story you’re telling, with an emphasis on the solution your product provides. It should hit points of innovation, disruption, and differentiation in your product.

## Have a plan

First, don't run through the prototype without a plan. You want to carefully map out each aspect of the prototype you want to demonstrate and prepare the technical conditions that make the flow reliable, such as demo accounts, seeded data, network access, and a fallback recording or screenshots.

Create a short runbook before the meeting. A good runbook answers these questions:

- Which account, environment, browser, and credentials will you use?
- Which exact demo inputs and records are already validated?
- What will you say or show if the AI output is uncertain or returns no useful match?
- What backup path will you use if the live flow fails?
- How will you reset the demo so the next run starts cleanly?

For Fabrikam, we might:

- Launch the app in a prepared demo environment with the right credentials, seeded data, and network access.
- Select a tested image that meets the published service requirements and reliably produces useful results.
- Search the image and show how the analysis becomes a set of catalog matches, including what happens if the service returns uncertain or incomplete signals.
- Select an item and complete a purchase, or show the handoff to a merchant checkout.

This path shows the typical journey of a user through the product.

> [!NOTE]
> Test the exact assets you plan to use. Azure Vision currently documents support for JPEG, PNG, GIF, and BMP images under 4 MB and larger than 50 x 50 pixels, and Microsoft recommends evaluating Image Analysis with real-world data so you understand failure modes before a live demo. If your prototype depends on Image Analysis 4.0, note that the service is deprecated and your production plan might need to change over time. See [What is Azure Vision in Foundry Tools?](/azure/ai-services/computer-vision/overview#image-requirements), [Transparency note: Image Analysis](/azure/foundry/responsible-ai/computer-vision/image-analysis-transparency-note#evaluating-and-integrating-image-analysis-for-your-use), and [Migrate from Azure Vision in Foundry Tools - Image Analysis](/azure/ai-services/computer-vision/migration-options).

## What to show

Make sure the demo shows the key user flows in your product. Coordinate what you demonstrate with the solution to the problem that you articulated. It should call out the unique features of your product or its differentiation from other products. If AI is part of the flow, narrate the limitation as well as the success. Explain what the model returns, what your application does with that output, how you handle uncertain or no-match results, and whether a human can correct the outcome. When possible, show at least one planned recovery path so the audience can see that the product behaves safely when the AI is uncertain.

It's also important to think about a live demo versus a "canned demo." A canned demo is prerecorded or staged. If your prototype is stable, a live demo can be a powerful way to show the real user experience. If you worry about the product crashing or failing, use a canned demo or keep one as a backup so you can still tell the story clearly and confidently. Many teams do both: start live, then fall back to the recording if latency, network, or AI output becomes unpredictable.

## What's next

Conclude your demonstration with a quick walkthrough of your product roadmap. The product roadmap is the list of future features you plan to develop for your app. For Fabrikam, this roadmap might include things like:

- Social sharing of matched fashions.
- Integration with more payments platforms.

The roadmap is especially important if your prototype lacks a key feature that represents product differentiation, such as if you didn't build it yet. In that case, be explicit about whether the gap is mostly engineering work, more partner integrations, more model training and evaluation, or a planned move away from a legacy AI service.
