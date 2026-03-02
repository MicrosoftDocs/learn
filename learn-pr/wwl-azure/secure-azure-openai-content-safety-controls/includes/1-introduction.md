## Learning objectives

Your customer service team deployed an Azure OpenAI-powered chatbot last month to handle routine inquiries. Within the first week, users discovered they could bypass the bot's guidelines by crafting specific prompts, leading to inappropriate responses that violated company policies. Your security team flagged three incidents where the chatbot generated content that could expose the organization to compliance risks and reputational damage. As the Azure administrator responsible for AI infrastructure, you need to implement content safety controls that protect both customers and your organization while maintaining the chatbot's usefulness.

Azure AI Content Safety provides layered protection for Azure OpenAI deployments by analyzing prompts and responses in real-time. The service detects harmful content across four categories—hate and fairness, explicit content, violence, and self-harm—and assigns severity scores from 0 (safe) to 6 (high risk). You configure threshold levels that match your organization's risk tolerance, blocking requests or responses that exceed acceptable severity. Custom block lists complement these automated filters by preventing specific terms, competitor names, or regulated phrases from appearing in model interactions. This combination of automated detection and organization-specific controls enables you to deploy generative AI with confidence.

In this module, you configure Azure AI Content Safety for your Azure OpenAI deployment, create custom content filters aligned with organizational policies, and validate that harmful content is blocked before reaching users. You deploy content safety resources, adjust severity thresholds for each content category, build custom block lists for competitor terms, and test your configuration with sample prompts that demonstrate both blocking and approval scenarios.

## Learning objectives

By the end of this module, you are able to:

- Configure Azure AI Content Safety to detect harmful content in Azure OpenAI requests and responses
- Implement content filters and custom block lists to enforce organizational content policies
- Validate Azure OpenAI model outputs against security and compliance requirements
- Apply responsible AI governance patterns for production AI infrastructure

## Prerequisites

- Active Azure subscription with permissions to create Azure OpenAI and AI Services resources
- Familiarity with Azure portal and Azure Resource Manager
- Basic understanding of Azure OpenAI Service and generative AI concepts

## More resources

- [Azure AI Content Safety documentation](/azure/ai-services/content-safety/) - Official reference for content safety capabilities and configuration
- [Azure OpenAI Service content filtering](/azure/ai-services/openai/concepts/content-filter) - Detailed guidance on configuring content filters for Azure OpenAI deployments

