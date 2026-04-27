In this workshop, you used Azure AI Content Safety to moderate text and images, inspect prompts and documents for prompt attacks, and evaluate whether model output is grounded in source material. You also saw where protected material detection fits into an end-to-end guardrail workflow.

As you continue building AI responsibly, keep in mind that Azure AI Content Safety is only one part of a broader safety architecture. Effective guardrails usually combine model instructions, retrieval design, moderation thresholds, prompt-attack detection, output validation, and human review where appropriate.

After completing the project, you might wish to clean up your development environment or return it to its typical state.

###### [Develop in browser](#tab/github-codespaces)

Deleting the GitHub Codespaces environment helps avoid consuming compute and storage from your included Codespaces usage.

1. Sign into the GitHub Codespaces dashboard (<https://github.com/codespaces>).

1. Locate your currently running Codespace in the list of Codespaces.

1. Open the context menu for the Codespace (**...**) and select **Delete**.

1. Select **Delete** to confirm deletion.

###### [Develop locally](#tab/visual-studio-code)

You aren't necessarily required to clean up your local environment, but you can stop the running development container and return to running Visual Studio Code in the context of a local workspace.

1. Open the **Command Palette**.

1. Search for and select **Dev Containers: Reopen Folder Locally**.

> [!TIP]
> Visual Studio Code will stop the running development container, but the container still exists in Docker in a stopped state. You always have the option to delete the container instance, container image, and volumes from Docker to free up more space on your local machine.

---

## Clean up Azure resources

If you no longer need the Azure AI Content Safety resource that you created for this workshop, delete the resource or delete the resource group that contains it. Deleting the resource group also deletes any other resources in that group, so verify that it doesn't contain resources you want to keep. For cleanup guidance, see [Clean up resources for Azure AI services](/azure/ai-services/multi-service-resource?pivots=azportal#clean-up-resources).

---

### Learn more

- [Azure AI Content Safety overview](/azure/ai-services/content-safety/overview)
- [Harm categories in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/harm-categories)
- [Quickstart: Analyze text content](/azure/ai-services/content-safety/quickstart-text)
- [Quickstart: Analyze image content](/azure/ai-services/content-safety/quickstart-image)
- [Prompt Shields](/azure/ai-services/content-safety/concepts/jailbreak-detection)
- [Quickstart: Detect prompt attacks with Prompt Shields](/azure/ai-services/content-safety/quickstart-jailbreak)
- [Groundedness detection](/azure/ai-services/content-safety/concepts/groundedness)
- [Quickstart: Use Groundedness detection](/azure/ai-services/content-safety/quickstart-groundedness)
- [Protected material detection](/azure/ai-services/content-safety/concepts/protected-material)
- [Quickstart: Protected material detection for text](/azure/ai-services/content-safety/quickstart-protected-material)
- [Authenticate requests to Azure AI services](/azure/ai-services/authentication)
