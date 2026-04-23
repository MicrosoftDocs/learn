In this guided project, you created layered mitigations for the Contoso Camping Store chatbot by grounding the model with product data, refining the system message, applying a content filter, and reviewing the results with manual and automated evaluations.

While manual evaluation enables human reviewers to spot-check output quality, automated evaluation helps you measure quality and safety at scale. Use automated scores together with human review rather than as a replacement for it. Safeguarding your app with Azure AI Content Safety and well-designed system messages helps you reduce harmful or off-topic behavior before deployment.

The next step before deployment is to operationalize the application by creating a rollout and readiness plan. Operationalizing includes planning for phased delivery, defining incident response procedures, monitoring the system in production, and incorporating user feedback into future prompt, data, and guardrail updates.

Although the process applied today might look linear, it's an iterative process. As you introduce new features, monitor usage, and/or implement user feedback, you're encouraged to revisit each step in the generative AI development lifecycle.

> [!NOTE]
> After completing this guided project, if you've finished exploring Azure AI Foundry and related Azure resources, delete the resources that you created during the exercise to avoid ongoing charges.

### Learn more

- [Create a hub project for Microsoft Foundry (classic)](/azure/foundry-classic/how-to/hub-create-projects)
- [Migrate from the Foundry (classic) portal](/azure/foundry/how-to/navigate-from-classic)
- [Build and consume vector indexes in Microsoft Foundry portal (classic)](/azure/foundry-classic/how-to/index-add)
- [Safety system messages](/azure/ai-foundry/openai/concepts/system-message)
- [Configure content filters](/azure/ai-foundry/openai/how-to/content-filters)
- [Run evaluations from the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-generative-ai-app)
- [Rate limits, region support, and enterprise features for evaluation](/azure/ai-foundry/concepts/evaluation-regions-limits-virtual-network)
- [View evaluation results in the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-results)
